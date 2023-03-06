Notepad++ v8.5 bug-fixes and new features:

1.  Fix notepad replacement opening file name containing white space regression.
2.  Fix regression about visual glitch of Find in Files progress window & Document Switcher.
3.  Update to Scintilla 5.3.3 and Lexilla 5.2.2.
4.  Add new explorer context menu entry "Edit with Notepad++" for WINDOWS 11.
5.  Add show non-printable characters command.
6.  Apply tab colors to document list items, and add groups to document list.
7.  Add middle mouse click ability to close doc in Document List.
8.  Add Begin/End Select in Column Mode command.
9.  Add option to make auto-completion list brief.
10. Remove duplicate items in function/word list of Auto-completion.
11. Fix missing items in word autocomplete.
12. Fix autocomplete to sort case insensitive issue.
13. Fix wrong value set in Preferences->Performance->"Define Large File Size".
14. Change behaviour: make Select and Find (Next/Previous) always in normal search mode.
15. Change behaviour: make volatile Find uses least-strict option settings.
16. Change behaviour: don't populate in Find what if a stream selection more than 1024 characters.
17. Fix dock-able panels not restoring for mono instances when Notepad++ is in the tray.
18. Fix panels not restored from systemtray with "Edit with Notepad++" in admin mode.
19. Fix hit text in search results not being scrolled in the view issue.
20. Fix untitled document number jumping or repeated problem.
21. Add new notification NPPN_EXTERNALLEXERBUFFER for lexer plugin with buffer ID when a new lexer is applied to the buffer in question.
22. Fix Synch H/V Scrolling commands not sync with 2 views.
23. Add several GUI enhancement.
24. Make several GUI items translatable.

Get more info on
https://notepad-plus-plus.org/downloads/v8.5/


Included plugins:

1.  NppExport v0.4
2.  Converter v4.5
3.  Mime Tool v2.9


Updater (Installer only):

* WinGup (for Notepad++) v5.2.5

#!/usr/bin/perl 

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Date;
use File::Copy;

# Taxonomy identifier of top node for query, e.g. 2 for Bacteria, 2157 for Archea, etc.
# (see https://www.uniprot.org/taxonomy)
my $top_node = $ARGV[0];

my $agent = LWP::UserAgent->new;

# Get a list of all reference proteomes of organisms below the given taxonomy node.
my $query_list = "https://www.uniprot.org/proteomes/?query=reference:yes+taxonomy:$top_node&format=list";
my $response_list = $agent->get($query_list);
die 'Failed, got ' . $response_list->status_line .
  ' for ' . $response_list->request->uri . "\n"
  unless $response_list->is_success;

# For each proteome, mirror its set of UniProt entries in compressed FASTA format.
for my $proteome (split(/\n/, $response_list->content)) {
    my $file = $proteome . '.fasta.gz';
    next if (-s $file);
    my $query_proteome = "https://www.uniprot.org/uniprot/?query=proteome:$proteome&format=fasta&compress=yes";
    my $response_proteome = $agent->mirror($query_proteome, $file);
    
    if ($response_proteome->is_success) {
	
	my $results = $response_proteome->header('X-Total-Results');
	my $release = $response_proteome->header('X-UniProt-Release');
	my $date = 'Unknown';
	$date = sprintf("%4d-%02d-%02d", HTTP::Date::parse_date($response_proteome->header('Last-Modified'))) if( HTTP::Date::parse_date($response_proteome->header('Last-Modified')) );
	print "File $file: downloaded $results entries of UniProt release $release ($date)\n";
    }
    elsif ($response_proteome->code == HTTP::Status::RC_NOT_MODIFIED) {
	print "File $file: up-to-date\n";
    }
    else {
	die 'Failed, got ' . $response_proteome->status_line .
	    ' for ' . $response_proteome->request->uri . "\n";
    }
}