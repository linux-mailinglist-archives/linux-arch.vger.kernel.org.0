Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951A2176042
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBQrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 11:47:21 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33980 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727126AbgCBQrV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 11:47:21 -0500
Received: (qmail 3316 invoked by uid 2102); 2 Mar 2020 11:47:20 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2020 11:47:20 -0500
Date:   Mon, 2 Mar 2020 11:47:20 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Elver <elver@google.com>
cc:     linux-kernel@vger.kernel.org, <kasan-dev@googlegroups.com>,
        <parri.andrea@gmail.com>, <will@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <paulmck@kernel.org>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <joel@joelfernandes.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict"
 definition
In-Reply-To: <20200302141819.40270-1-elver@google.com>
Message-ID: <Pine.LNX.4.44L0.2003021134360.1555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2 Mar 2020, Marco Elver wrote:

> Alan: I think this needs your Signed-off-by, since I added you as
> Co-developed-by.

Here you go:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

> Let me know if this works for you.

See below.

> The definition of "conflict" should not include the type of access nor
> whether the accesses are concurrent or not, which this patch addresses.
> The definition of "data race" remains unchanged.
> 
> The definition of "conflict" as we know it and is cited by various
> papers on memory consistency models appeared in [1]: "Two accesses to
> the same variable conflict if at least one is a write; two operations
> conflict if they execute conflicting accesses."
> 
> The LKMM as well as the C11 memory model are adaptations of
> data-race-free, which are based on the work in [2]. Necessarily, we need
> both conflicting data operations (plain) and synchronization operations
> (marked). For example, C11's definition is based on [3], which defines a
> "data race" as: "Two memory operations conflict if they access the same
> memory location, and at least one of them is a store, atomic store, or
> atomic read-modify-write operation. In a sequentially consistent
> execution, two memory operations from different threads form a type 1
> data race if they conflict, at least one of them is a data operation,
> and they are adjacent in <T (i.e., they may be executed concurrently)."
> 
> [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
>     Programs that Share Memory", 1988.
> 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> 
> [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
>     Multiprocessors", 1993.
> 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> 
> [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
>     Model", 2008.
> 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> v2:
> * Apply Alan's suggested version.
>   - Move "from different CPUs (or threads)" from "conflict" to "data
>     race" definition. Update "race candidate" accordingly.
> * Add citations to commit message.
> 
> v1: http://lkml.kernel.org/r/20200228164621.87523-1-elver@google.com
> ---
>  .../Documentation/explanation.txt             | 77 +++++++++----------
>  1 file changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index e91a2eb19592a..7a59cadc2f4ca 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1987,28 +1987,28 @@ outcome undefined.
>  
>  In technical terms, the compiler is allowed to assume that when the
>  program executes, there will not be any data races.  A "data race"
> -occurs when two conflicting memory accesses execute concurrently;
> -two memory accesses "conflict" if:
> +occurs when two conflicting memory accesses from different CPUs (or
> +different threads on the same CPU) execute concurrently, and at least
> +one of them is plain.  Two memory accesses "conflict" if:
>  
>  	they access the same location,
>  
> -	they occur on different CPUs (or in different threads on the
> -	same CPU),
> -
> -	at least one of them is a plain access,
> -
>  	and at least one of them is a store.
>  
> -The LKMM tries to determine whether a program contains two conflicting
> -accesses which may execute concurrently; if it does then the LKMM says
> -there is a potential data race and makes no predictions about the
> -program's outcome.
> -
> -Determining whether two accesses conflict is easy; you can see that
> -all the concepts involved in the definition above are already part of
> -the memory model.  The hard part is telling whether they may execute
> -concurrently.  The LKMM takes a conservative attitude, assuming that
> -accesses may be concurrent unless it can prove they cannot.
> +We'll say that two accesses from different threads are "race
> +candidates" if they conflict and at least one of them is plain.
> +Whether or not two candidates actually do race in a given execution
> +then depends on whether they are concurrent.  The LKMM tries to
> +determine whether a program contains race candidates which may execute
> +concurrently; if it does then the LKMM says there is a potential data
> +race and makes no predictions about the program's outcome.

Hmmm.  Although the content is okay, I don't like the organization very
much.  What do you think of this for the above portion of the patch)?

Alan Stern



Index: usb-devel/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -1987,28 +1987,36 @@ outcome undefined.
 
 In technical terms, the compiler is allowed to assume that when the
 program executes, there will not be any data races.  A "data race"
-occurs when two conflicting memory accesses execute concurrently;
-two memory accesses "conflict" if:
+occurs when there are two memory accesses such that:
 
-	they access the same location,
+1.	they access the same location,
 
-	they occur on different CPUs (or in different threads on the
-	same CPU),
+2.	at least one of them is a store,
+
+3.	at least one of them is plain,
 
-	at least one of them is a plain access,
+4.	they occur on different CPUs (or in different threads on the
+	same CPU), and
 
-	and at least one of them is a store.
+5.	they execute concurrently.
 
-The LKMM tries to determine whether a program contains two conflicting
-accesses which may execute concurrently; if it does then the LKMM says
-there is a potential data race and makes no predictions about the
+In the literature, two accesses are said to "conflict" if they satisfy
+1 and 2 above.  We'll go a little farther and say that two accesses
+are "race candidates" if they satisfy 1 - 4.  Thus, whether or not two
+race candidates actually do race in a given execution depends on
+whether they are concurrent.
+
+The LKMM tries to determine whether a program contains two race
+candidates which may execute concurrently; if it does then the LKMM
+says there is a potential data race and makes no predictions about the
 program's outcome.
 
-Determining whether two accesses conflict is easy; you can see that
-all the concepts involved in the definition above are already part of
-the memory model.  The hard part is telling whether they may execute
-concurrently.  The LKMM takes a conservative attitude, assuming that
-accesses may be concurrent unless it can prove they cannot.
+Determining whether two accesses are race candidates is easy; you can
+see that all the concepts involved in the definition above are already
+part of the memory model.  The hard part is telling whether they may
+execute concurrently.  The LKMM takes a conservative attitude,
+assuming that accesses may be concurrent unless it can prove they
+are not.
 
 If two memory accesses aren't concurrent then one must execute before
 the other.  Therefore the LKMM decides two accesses aren't concurrent


