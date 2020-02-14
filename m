Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9259315EFD9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 18:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgBNP67 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 10:58:59 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39852 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388755AbgBNP66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 10:58:58 -0500
Received: (qmail 3236 invoked by uid 2102); 14 Feb 2020 10:58:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2020 10:58:57 -0500
Date:   Fri, 14 Feb 2020 10:58:57 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
In-Reply-To: <20200214040132.91934-4-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002141049310.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Feb 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe atomic RMW +
> smp_mb__after_atomic() is "strong acquire" (both the read and the write
> part is ordered).

"strong acquire" is not an appropriate description -- there is no such
thing as a strong acquire in the LKMM -- nor is it a good name for the
litmus test.  A better description would be "stronger than acquire", as
in the sentence preceding the litmus test in atomic_t.txt.

>  So make it a litmus test in memory-model litmus-tests
> directory, so that people can access the litmus easily.
> 
> Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> atomic_t.txt for the consistency with the processor numbers in the
> litmus test, which herd can handle.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/atomic_t.txt                    |  6 ++--
>  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
>  tools/memory-model/litmus-tests/README        |  5 ++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..e3ad4e4cd9ed 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
>    {
>    }
>  
> -  P1(int *x, atomic_t *y)
> +  P0(int *x, atomic_t *y)
>    {
>      r0 = READ_ONCE(*x);
>      smp_rmb();
>      r1 = atomic_read(y);
>    }
>  
> -  P2(int *x, atomic_t *y)
> +  P1(int *x, atomic_t *y)
>    {
>      atomic_inc(y);
>      smp_mb__after_atomic();
> @@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
>  because it would not order the W part of the RMW against the following
>  WRITE_ONCE.  Thus:
>  
> -  P1			P2
> +  P0			P1
>  
>  			t = LL.acq *y (0)
>  			t++;
> diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> new file mode 100644
> index 000000000000..e7216cf9d92a
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> @@ -0,0 +1,29 @@
> +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> +
> +(*
> + * Result: Never
> + *
> + * Test of an atomic RMW followed by a smp_mb__after_atomic() is

s/Test of/Test that/

> + * "strong-acquire": both the read and write part of the RMW is ordered before

This should say "stronger than a normal acquire".  And "part" should be
"parts", and "is ordered" should be "are ordered".

Also, please try to arrange the line breaks so that the comment lines
don't have vastly different lengths.

Similar changes should be made for the text added to README.

Alan Stern

