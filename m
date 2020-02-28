Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC5173E61
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1RYz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 12:24:55 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44932 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725900AbgB1RYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 12:24:55 -0500
Received: (qmail 4543 invoked by uid 2102); 28 Feb 2020 12:24:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2020 12:24:54 -0500
Date:   Fri, 28 Feb 2020 12:24:54 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Elver <elver@google.com>
cc:     paulmck@kernel.org, <andreyknvl@google.com>, <glider@google.com>,
        <dvyukov@google.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <parri.andrea@gmail.com>,
        <will@kernel.org>, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>, <dlustig@nvidia.com>,
        <joel@joelfernandes.org>, <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix "conflict" definition
In-Reply-To: <20200228164621.87523-1-elver@google.com>
Message-ID: <Pine.LNX.4.44L0.2002281202230.1599-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Feb 2020, Marco Elver wrote:

> For language-level memory consistency models that are adaptations of
> data-race-free, the definition of "data race" can be summarized as
> "concurrent conflicting accesses, where at least one is non-sync/plain".
> 
> The definition of "conflict" should not include the type of access nor
> whether the accesses are concurrent or not, which this patch addresses
> for explanation.txt.

Why shouldn't it?  Can you provide any references to justify this 
assertion?

Also, note two things: (1) The existing text does not include
concurrency in the definition of "conflict".  (2) Your new text does
include the type of access in the definition (you say that at least one
of the accesses must be a write).

> The definition of "data race" remains unchanged, but the informal
> definition for "conflict" is restored to what can be found in the
> literature.

It does not remain unchanged.  You removed the portion that talks about
accesses executing on different CPUs or threads.  Without that
restriction, you raise the nonsensical possibility that a single thread
may by definition have a data race with itself (since modern CPUs use
multiple-instruction dispatch, in which several instructions can
execute at the same time).

> Signed-by: Marco Elver <elver@google.com>
> ---
>  tools/memory-model/Documentation/explanation.txt | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index e91a2eb19592a..11cf89b5b85d9 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1986,18 +1986,15 @@ violates the compiler's assumptions, which would render the ultimate
>  outcome undefined.
>  
>  In technical terms, the compiler is allowed to assume that when the
> -program executes, there will not be any data races.  A "data race"
> -occurs when two conflicting memory accesses execute concurrently;
> -two memory accesses "conflict" if:
> +program executes, there will not be any data races. A "data race"

Unnecessary (and inconsistent with the rest of the document) whitespace 
change.

> +occurs if:
>  
> -	they access the same location,
> +	two concurrent memory accesses "conflict";
>  
> -	they occur on different CPUs (or in different threads on the
> -	same CPU),
> +	and at least one of the accesses is a plain access;
>  
> -	at least one of them is a plain access,
> -
> -	and at least one of them is a store.
> +	where two memory accesses "conflict" if they access the same
> +	memory location, and at least one performs a write;
>  
>  The LKMM tries to determine whether a program contains two conflicting
>  accesses which may execute concurrently; if it does then the LKMM says

To tell the truth, the only major change I can see here (apart from the
"differenct CPUs" restriction) is that you want to remove the "at least
one is plain" part from the definition of "conflict" and instead make
it a separate requirement for a data race.  That's fine with me in
principle, but there ought to be an easier way of doing it.

Furthermore, this section of explanation.txt goes on to use the words
"conflict" and "conflicting" in a way that your patch doesn't address.  
For example, shortly after this spot it says "Determining whether two
accesses conflict is easy"; you should change it to say "Determining
whether two accesses conflict and at least one of them is plain is
easy" -- but this looks pretty ungainly.  A better approach might be to
introduce a new term, define it to mean "conflicting accesses at least
one of which is plain", and then use it instead throughout.

Alternatively, you could simply leave the text as it stands and just
add a parenthetical disclaimer pointing out that in the CS literature,
the term "conflict" is used even when both accesses are marked, so the
usage here is somewhat non-standard.

Alan

