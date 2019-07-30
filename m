Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0179F7B5F1
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfG3W54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 18:57:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfG3W54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 18:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pv0SUEsw6SjeIqRni/ZcsaM+cHPlvjjJfUnxTICLn9s=; b=HvAlobxxRv/SlOSKo4be7YJqy
        SQ2QvN/5XP1cI+wQ4aab+/w9YXOVYmhpWW0OTm50p1QIMUwvCy5DsXNm3L8kZ9IV98S0v7QQStSXG
        e1u69hFEGaPEfNBYxCCK8jWPCATeCi5cbrhxYDdQi2gNqow8zzgnhIglHLlcYf0Obm7Tj3HhuCCg+
        DLWPeuKA9vwZbly3cixSSIAKn2OFOQwor7kezgqkLnQuuuWhr9+4U6MfILeF3ZKC1ILdXOvRmDQNr
        R2kmfpycJKsaq2tvED4bGv7wIx+60j+YxbfxAxZYazZ6ufOK970i4aa0UjBaLnYVnWMYw3jwOOf4j
        gpfUZy3Sg==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsb43-0006vq-Jt; Tue, 30 Jul 2019 22:57:52 +0000
Date:   Tue, 30 Jul 2019 19:57:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Message-ID: <20190730195744.3aef478e@coco.lan>
In-Reply-To: <20190730221701.GC254050@google.com>
References: <20190726180201.GE146401@google.com>
        <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
        <20190727141013.dpvjlcp3juja4see@penguin>
        <20190727123754.5d91d4a4@coco.lan>
        <20190730221701.GC254050@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue, 30 Jul 2019 18:17:01 -0400
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Sat, Jul 27, 2019 at 12:37:54PM -0300, Mauro Carvalho Chehab wrote:
> > Em Sat, 27 Jul 2019 14:14:53 +0000
> > Joel Fernandes <joel@joelfernandes.org> escreveu:
> >   
> > > On Fri, Jul 26, 2019 at 04:01:37PM -0300, Mauro Carvalho Chehab wrote:  
> > > > The books at tools/memory-model/Documentation are very well
> > > > formatted. Congrats to the ones that wrote them!
> > > > 
> > > > The manual conversion to ReST is really trivial:
> > > > 
> > > > 	- Add document titles;
> > > > 	- change the bullets on some lists;
> > > > 	- mark code blocks.    
> > > 
> > > Thanks so much, some feedback:  
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>    
> > > 
> > > (1)
> > > I could not find the table of contents appear in the HTML output for this.
> > > Basically this list in the beginning doesn't render:
> > >   1. INTRODUCTION
> > >   2. BACKGROUND
> > >   3. A SIMPLE EXAMPLE
> > >   4. A SELECTION OF MEMORY MODELS
> > >   5. ORDERING AND CYCLES  
> > 
> > Yes. It is written as a comment, like:
> > 
> > 	.. foo  This is a comment block
> > 
> > 	   Everything on this block
> > 
> > 	   won't be parsed.
> > 
> > So it won't be parsed, but having a TOC like this isn't need, as
> > Sphinx generates it automatically via "toctree" markup.   
> 
> Ok.
> 
> > > Could we add a proper TOC with sections? My motivation for ReST here would be
> > > to make the sections jumpable since it is a large document.  
> > 
> > Just change the toctree depth at index.rst to 2 and you'll see an index
> > produced by Sphinx with both levels 1 (doc name) and level 2 (chapters):
> > 
> > 	.. toctree::
> > 	   :maxdepth: 2  
> 
> Admittedly, I don't have much time at the moment to do these experiments :(
> 
> > > Also could we make the different sections appear as a tree in the left
> > > sidebar?  
> > 
> > The sidebar follows the maxdepth too.
> >   
> > > 
> > > (2) Arguably several function names in the document HTML output should appear
> > > in monospace fonting and/or referring to the documentation for real function
> > > names, but these can be fixed as we go, I guess.  
> > 
> > If you want monospaced fonts, just use: ``monospaced_symbol_foo`` within
> > any paragraph, or place the monospaced data inside a code-block:
> > 
> > 	::
> > 
> > 		This will be monospaced.
> >   
> > > 
> > > (3) Things like smp_load_acquire() and spin_lock() should probably refer to
> > > the documentation for those elsewhere..  
> > 
> > Jon added an automarkup extension on Kernel 5.2. So, all functions that
> > are defined elsewhere will automatically generate an hyperlink. For that to
> > happen, you need to add the kernel-doc markup at the *.h or *.c file where
> > the function is declared and use the kernel-doc markup somewhere within the
> > Kernel Documentation/.
> >   
> > > 
> > > (4) I would argue that every occurence of
> > > A ->(some dependency) B should be replaced with fixed size font in the HTML
> > > results.  
> > 
> > Just place those with ``A -> (some dependency)``. This will make them use
> > a fixed size font.  
> 
> Ok, understood all these. I guess my point was all of these will need to be
> done to make this document useful from a ReST conversion standpoint. Until
> then it is probably just better off being plain text - since there are so
> many of those ``A -> (dep) B`` things.
> 
> > > Arguably it is better IMO if the whole document is fixed size font in the
> > > HTML output because so many things need to be fixed size, but that my just be
> > > my opinion.  
> > 
> > Just my 2 cents here, but having the entire document using a fixed size
> > font makes it more boring to read. Having just the symbols with a fixed size
> > is a common convention used on technical books, and helps to make easier
> > to identify the symbols while reading the docs.
> > 
> > That's said, Sphinx doesn't have any tag to switch the font for the entire
> > document. All it can be done is to define a CSS and apply it for the
> > doc - or to place everything within a code-block, with will suppress all
> > markup tags, including cross-references for functions.  
> 
> Ok, got it.
> 
> > The problem with CSS is that you need to write both an html CSS file
> > and add LaTeX macros associated to this "CSS style" (technically, LaTeX
> > doesn't have a CSS concept, but Sphinx emulates it).  
> 
> Yeah I don't think we want to do CSS here. So the correct thing to do would
> be to place all fixed-width things within double backticks, if someone had
> the time to do it. I am currently spending time understanding the document's
> content itself..
> 
> thanks for the effort, it could probably serve as a good future reference,

On a very quick look, it seems that, if we replace:

	(\S+\s->\S*\s\w+)

by:
	``\1``


On an editor that would allow to manually replace the regex (like kate),
most of those can be get.

See patch enclosed.


Thanks,
Mauro

[PATCH] Use monotonic fonts for ``A -> (dep) B`` 

Manually replace:

	(\S+\s->\S*\s\w+)

by:
	``\1``

On their occurrences and fix a couple of places where it doesn't
hit well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/tools/memory-model/Documentation/explanation.rst b/tools/memory-model/Documentation/explanation.rst
index 227ec75f8dc4..9b5d10cef0c2 100644
--- a/tools/memory-model/Documentation/explanation.rst
+++ b/tools/memory-model/Documentation/explanation.rst
@@ -332,7 +332,7 @@ can think of it as the order in which statements occur in the source
 code after branches are taken into account and loops have been
 unrolled.  A better description might be the order in which
 instructions are presented to a CPU's execution unit.  Thus, we say
-that X is po-before Y (written as "X ->po Y" in formulas) if X occurs
+that X is po-before Y (written as ``X ->po Y`` in formulas) if X occurs
 before Y in the instruction stream.
 
 This is inherently a single-CPU relation; two instructions executing
@@ -485,9 +485,9 @@ which depends on the value obtained by the READ_ONCE(); hence there is
 a control dependency from the load to the store.
 
 It should be pretty obvious that events can only depend on reads that
-come earlier in program order.  Symbolically, if we have R ->data X,
-R ->addr X, or R ->ctrl X (where R is a read event), then we must also
-have R ->po X.  It wouldn't make sense for a computation to depend
+come earlier in program order.  Symbolically, if we have ``R ->data X``,
+``R ->addr X``, or ``R ->ctrl X`` (where R is a read event), then we must also
+have ``R ->po X``.  It wouldn't make sense for a computation to depend
 somehow on a value that doesn't get loaded from shared memory until
 later in the code!
 
@@ -498,7 +498,7 @@ THE READS-FROM RELATION: rf, rfi, and rfe
 The reads-from relation (rf) links a write event to a read event when
 the value loaded by the read is the value that was stored by the
 write.  In colloquial terms, the load "reads from" the store.  We
-write W ->rf R to indicate that the load R reads from the store W.  We
+write ``W ->rf R`` to indicate that the load R reads from the store W.  We
 further distinguish the cases where the load and the store occur on
 the same CPU (internal reads-from, or rfi) and where they occur on
 different CPUs (external reads-from, or rfe).
@@ -579,26 +579,26 @@ that value comes third, and so on.
 You can think of the coherence order as being the order in which the
 stores reach x's location in memory (or if you prefer a more
 hardware-centric view, the order in which the stores get written to
-x's cache line).  We write W ->co W' if W comes before W' in the
+x's cache line).  We write ``W ->co W'`` if W comes before W' in the
 coherence order, that is, if the value stored by W gets overwritten,
 directly or indirectly, by the value stored by W'.
 
 Coherence order is required to be consistent with program order.  This
 requirement takes the form of four coherency rules:
 
-	Write-write coherence: If W ->po-loc W' (i.e., W comes before
+	Write-write coherence: If ``W ->po-loc W'`` (i.e., W comes before
 	W' in program order and they access the same location), where W
-	and W' are two stores, then W ->co W'.
+	and W' are two stores, then ``W ->co W'``.
 
-	Write-read coherence: If W ->po-loc R, where W is a store and R
+	Write-read coherence: If ``W ->po-loc R``, where W is a store and R
 	is a load, then R must read from W or from some other store
 	which comes after W in the coherence order.
 
-	Read-write coherence: If R ->po-loc W, where R is a load and W
+	Read-write coherence: If ``R ->po-loc W``, where R is a load and W
 	is a store, then the store which R reads from must come before
 	W in the coherence order.
 
-	Read-read coherence: If R ->po-loc R', where R and R' are two
+	Read-read coherence: If ``R ->po-loc R'``, where R and R' are two
 	loads, then either they read from the same store or else the
 	store read by R comes before the store read by R' in the
 	coherence order.
@@ -694,7 +694,7 @@ THE FROM-READS RELATION: fr, fri, and fre
 
 The from-reads relation (fr) can be a little difficult for people to
 grok.  It describes the situation where a load reads a value that gets
-overwritten by a store.  In other words, we have R ->fr W when the
+overwritten by a store.  In other words, we have ``R ->fr W`` when the
 value that R reads is overwritten (directly or indirectly) by W, or
 equivalently, when R reads from a store which comes earlier than W in
 the coherence order.
@@ -723,7 +723,7 @@ different CPUs).
 
 Note that the fr relation is determined entirely by the rf and co
 relations; it is not independent.  Given a read event R and a write
-event W for the same location, we will have R ->fr W if and only if
+event W for the same location, we will have ``R ->fr W`` if and only if
 the write which R reads from is co-before W.  In symbols,
 
 ::
@@ -850,13 +850,13 @@ defined to link memory access events E and F whenever:
 	event occurs between them in program order; or
 
 	F is a release fence and some X comes before F in program order,
-	where either X = E or else E ->rf X; or
+	where either ``X = E`` or else ``E ->rf X``; or
 
 	A strong fence event occurs between some X and F in program
-	order, where either X = E or else E ->rf X.
+	order, where either ``X = E`` or else ``E ->rf X``.
 
 The operational model requires that whenever W and W' are both stores
-and W ->cumul-fence W', then W must propagate to any given CPU
+and ``W ->cumul-fence W'``, then W must propagate to any given CPU
 before W' does.  However, for different CPUs C and C', it does not
 require W to propagate to C before W' propagates to C'.
 
@@ -910,7 +910,7 @@ first for CPU 0, then CPU 1, etc.
 
 You can check that the four coherency rules imply that the rf, co, fr,
 and po-loc relations agree with this global ordering; in other words,
-whenever we have X ->rf Y or X ->co Y or X ->fr Y or X ->po-loc Y, the
+whenever we have ``X ->rf Y`` or ``X ->co Y`` or ``X ->fr Y`` or ``X ->po-loc Y``, the
 X event comes before the Y event in the global ordering.  The LKMM's
 "coherence" axiom expresses this by requiring the union of these
 relations not to have any cycles.  This means it must not be possible
@@ -977,7 +977,7 @@ po.
 
 The operational model already includes a description of one such
 situation: Fences are a source of ppo links.  Suppose X and Y are
-memory accesses with X ->po Y; then the CPU must execute X before Y if
+memory accesses with ``X ->po Y``; then the CPU must execute X before Y if
 any of the following hold:
 
 	A strong (smp_mb() or synchronize_rcu()) fence occurs between
@@ -996,7 +996,7 @@ any of the following hold:
 Another possibility, not mentioned earlier but discussed in the next
 section, is:
 
-	X and Y are both loads, X ->addr Y (i.e., there is an address
+	X and Y are both loads, ``X ->addr Y`` (i.e., there is an address
 	dependency from X to Y), and X is a READ_ONCE() or an atomic
 	access.
 
@@ -1176,25 +1176,25 @@ The happens-before relation (hb) links memory accesses that have to
 execute in a certain order.  hb includes the ppo relation and two
 others, one of which is rfe.
 
-W ->rfe R implies that W and R are on different CPUs.  It also means
+``W ->rfe R`` implies that W and R are on different CPUs.  It also means
 that W's store must have propagated to R's CPU before R executed;
 otherwise R could not have read the value stored by W.  Therefore W
-must have executed before R, and so we have W ->hb R.
+must have executed before R, and so we have ``W ->hb R``.
 
-The equivalent fact need not hold if W ->rfi R (i.e., W and R are on
+The equivalent fact need not hold if ``W ->rfi R`` (i.e., W and R are on
 the same CPU).  As we have already seen, the operational model allows
 W's value to be forwarded to R in such cases, meaning that R may well
 execute before W does.
 
 It's important to understand that neither coe nor fre is included in
 hb, despite their similarities to rfe.  For example, suppose we have
-W ->coe W'.  This means that W and W' are stores to the same location,
+``W ->coe W'``.  This means that W and W' are stores to the same location,
 they execute on different CPUs, and W comes before W' in the coherence
 order (i.e., W' overwrites W).  Nevertheless, it is possible for W' to
 execute before W, because the decision as to which store overwrites
 the other is made later by the memory subsystem.  When the stores are
 nearly simultaneous, either one can come out on top.  Similarly,
-R ->fre W means that W overwrites the value which R reads, but it
+``R ->fre W`` means that W overwrites the value which R reads, but it
 doesn't mean that W has to execute after R.  All that's necessary is
 for the memory subsystem not to propagate W to R's CPU until after R
 has executed, which is possible if W executes shortly before R.
@@ -1393,10 +1393,10 @@ The existence of a pb link from E to F implies that E must execute
 before F.  To see why, suppose that F executed first.  Then W would
 have propagated to E's CPU before E executed.  If E was a store, the
 memory subsystem would then be forced to make E come after W in the
-coherence order, contradicting the fact that E ->coe W.  If E was a
+coherence order, contradicting the fact that ``E ->coe W``.  If E was a
 load, the memory subsystem would then be forced to satisfy E's read
 request with the value stored by W or an even later store,
-contradicting the fact that E ->fre W.
+contradicting the fact that ``E ->fre W``.
 
 A good example illustrating how pb works is the SB pattern with strong
 fences::
@@ -1518,9 +1518,9 @@ entirely clear.  The LKMM formalizes this notion by means of the
 rcu-link relation.  rcu-link encompasses a very general notion of
 "before": If E and F are RCU fence events (i.e., rcu_read_lock(),
 rcu_read_unlock(), or synchronize_rcu()) then among other things,
-E ->rcu-link F includes cases where E is po-before some memory-access
+``E ->rcu-link F`` includes cases where E is po-before some memory-access
 event X, F is po-after some memory-access event Y, and we have any of
-X ->rfe Y, X ->co Y, or X ->fr Y.
+``X ->rfe Y``, ``X ->co Y``, or ``X ->fr Y``.
 
 The formal definition of the rcu-link relation is more than a little
 obscure, and we won't give it here.  It is closely related to the pb
@@ -1532,22 +1532,22 @@ The LKMM also defines the rcu-gp and rcu-rscsi relations.  They bring
 grace periods and read-side critical sections into the picture, in the
 following way:
 
-	E ->rcu-gp F means that E and F are in fact the same event,
+	``E ->rcu-gp F`` means that E and F are in fact the same event,
 	and that event is a synchronize_rcu() fence (i.e., a grace
 	period).
 
-	E ->rcu-rscsi F means that E and F are the rcu_read_unlock()
+	``E ->rcu-rscsi F`` means that E and F are the rcu_read_unlock()
 	and rcu_read_lock() fence events delimiting some read-side
 	critical section.  (The 'i' at the end of the name emphasizes
 	that this relation is "inverted": It links the end of the
 	critical section to the start.)
 
 If we think of the rcu-link relation as standing for an extended
-"before", then X ->rcu-gp Y ->rcu-link Z roughly says that X is a
+"before", then ``X ->rcu-gp Y ->rcu-link Z`` roughly says that X is a
 grace period which ends before Z begins.  (In fact it covers more than
 this, because it also includes cases where some store propagates to
 Z's CPU before Z begins but doesn't propagate to some other CPU until
-after X ends.)  Similarly, X ->rcu-rscsi Y ->rcu-link Z says that X is
+after X ends.)  Similarly, ``X ->rcu-rscsi Y ->rcu-link Z`` says that X is
 the end of a critical section which starts before Z begins.
 
 The LKMM goes on to define the rcu-fence relation as a sequence of
@@ -1557,18 +1557,18 @@ example::
 
 	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-would imply that X ->rcu-fence V, because this sequence contains two
+would imply that ``X ->rcu-fence V``, because this sequence contains two
 rcu-gp links and one rcu-rscsi link.  (It also implies that
-X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand::
+``X ->rcu-fence T`` and ``Z ->rcu-fence V``.)  On the other hand::
 
 	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-does not imply X ->rcu-fence V, because the sequence contains only
+does not imply ``X ->rcu-fence V``, because the sequence contains only
 one rcu-gp link but two rcu-rscsi links.
 
 The rcu-fence relation is important because the Grace Period Guarantee
 means that rcu-fence acts kind of like a strong fence.  In particular,
-E ->rcu-fence F implies not only that E begins before F ends, but also
+``E ->rcu-fence F`` implies not only that E begins before F ends, but also
 that any write po-before E will propagate to every CPU before any
 instruction po-after F can execute.  (However, it does not imply that
 E must execute before F; in fact, each synchronize_rcu() fence event
@@ -1604,13 +1604,13 @@ covered by rcu-fence.
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
 relation was defined in terms of strong-fence.  We will omit the
-details; the end result is that E ->rb F implies E must execute
-before F, just as E ->pb F does (and for much the same reasons).
+details; the end result is that ``E ->rb F`` implies E must execute
+before F, just as ``E ->pb F`` does (and for much the same reasons).
 
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that the rb relation does not contain a cycle.
 Equivalently, this "rcu" axiom requires that there are no events E
-and F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way,
+and F with ``E ->rcu-link F ->rcu-fence E``.  Or to put it a third way,
 the axiom requires that there are no cycles consisting of rcu-gp and
 rcu-rscsi alternating with rcu-link, where the number of rcu-gp links
 is >= the number of rcu-rscsi links.
@@ -1649,8 +1649,8 @@ by rcu-link::
 
 	S ->rcu-link U.
 
-Since S is a grace period we have S ->rcu-gp S, and since L and U are
-the start and end of the critical section C we have U ->rcu-rscsi L.
+Since S is a grace period we have ``S ->rcu-gp S``, and since L and U are
+the start and end of the critical section C we have ``U ->rcu-rscsi L``.
 From this we obtain::
 
 	S ->rcu-gp S ->rcu-link U ->rcu-rscsi L ->rcu-link S,
@@ -1683,16 +1683,16 @@ time with statement labels added::
 
 
 If r2 = 0 at the end then P0's store at Y overwrites the value that
-P1's load at W reads from, so we have W ->fre Y.  Since S ->po W and
-also Y ->po U, we get S ->rcu-link U.  In addition, S ->rcu-gp S
+P1's load at W reads from, so we have ``W ->fre Y``.  Since ``S ->po W`` and
+also ``Y ->po U``, we get ``S ->rcu-link U``.  In addition, ``S ->rcu-gp S``
 because S is a grace period.
 
 If r1 = 1 at the end then P1's load at Z reads from P0's store at X,
-so we have X ->rfe Z.  Together with L ->po X and Z ->po S, this
-yields L ->rcu-link S.  And since L and U are the start and end of a
-critical section, we have U ->rcu-rscsi L.
+so we have ``X ->rfe Z``.  Together with ``L ->po X`` and ``Z ->po S``, this
+yields ``L ->rcu-link S``.  And since L and U are the start and end of a
+critical section, we have ``U ->rcu-rscsi L``.
 
-Then U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U is a
+Then ``U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U`` is a
 forbidden cycle, violating the "rcu" axiom.  Hence the outcome is not
 allowed by the LKMM, as we would expect.
 
@@ -1729,9 +1729,9 @@ For contrast, let's see what can happen in a more complicated example::
 		U2: rcu_read_unlock();
 	}
 
-If r0 = r1 = r2 = 1 at the end, then similar reasoning to before shows
-that U0 ->rcu-rscsi L0 ->rcu-link S1 ->rcu-gp S1 ->rcu-link U2 ->rcu-rscsi
-L2 ->rcu-link U0.  However this cycle is not forbidden, because the
+If ``r0 = r1 = r2 = 1`` at the end, then similar reasoning to before shows
+that ``U0 ->rcu-rscsi L0 ->rcu-link S1 ->rcu-gp S1 ->rcu-link U2 ->rcu-rscsi
+L2 ->rcu-link U0``.  However this cycle is not forbidden, because the
 sequence of relations contains fewer instances of rcu-gp (one) than of
 rcu-rscsi (two).  Consequently the outcome is allowed by the LKMM.
 The following instruction timing diagram shows how it might actually

