Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21B777FE8
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2019 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfG1Osw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jul 2019 10:48:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45689 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726032AbfG1Osw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jul 2019 10:48:52 -0400
Received: (qmail 8593 invoked by uid 500); 28 Jul 2019 10:48:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2019 10:48:51 -0400
Date:   Sun, 28 Jul 2019 10:48:51 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        <linux-arch@vger.kernel.org>, Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] lkmm/docs: Correct ->prop example with additional
 rfe link
In-Reply-To: <20190728031303.164545-1-joel@joelfernandes.org>
Message-ID: <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 27 Jul 2019, Joel Fernandes (Google) wrote:

> The lkmm example about ->prop relation should describe an additional rfe
> link between P1's store to y and P2's load of y, which should be
> critical to establishing the ordering resulting in the ->prop ordering
> on P0. IOW, there are 2 rfe links, not one.
> 
> Correct these in the docs to make the ->prop ordering on P0 more clear.
> 
> Cc: kernel-team@android.com
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

This is not a good update.  See below...

>  .../memory-model/Documentation/explanation.txt  | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 68caa9a976d0..aa84fce854cc 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence links, ending with an
>  rfe link.  You can concoct more exotic examples, containing more than
>  one fence, although this quickly leads to diminishing returns in terms
>  of complexity.  For instance, here's an example containing a coe link
> -followed by two fences and an rfe link, utilizing the fact that
> -release fences are A-cumulative:
> +followed by a fence, an rfe link, another fence and and a final rfe link,
                                                   ^---^
> +utilizing the fact that release fences are A-cumulative:

I don't like this, for two reasons.  First is the repeated "and" typo.  
More importantly, it's not necessary to go into this level of detail; a
better revision would be:

+followed by two cumul-fences and an rfe link, utilizing the fact that

This is appropriate because the cumul-fence relation is defined to 
contain the rfe link which you noticed wasn't mentioned explicitly.

>  	int x, y, z;
>  
> @@ -1334,11 +1334,14 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
>  link from P0's store to its load.  This is because P0's store gets
>  overwritten by P1's store since x = 2 at the end (a coe link), the
>  smp_wmb() ensures that P1's store to x propagates to P2 before the
> -store to y does (the first fence), the store to y propagates to P2
> -before P2's load and store execute, P2's smp_store_release()
> -guarantees that the stores to x and y both propagate to P0 before the
> -store to z does (the second fence), and P0's load executes after the
> -store to z has propagated to P0 (an rfe link).
> +store to y does (the first fence), P2's store to y happens before P2's
---------------------------------------^

This makes no sense, since P2 doesn't store to y.  You meant P1's store
to y.  Also, the use of "happens before" is here unnecessarily
ambiguous (is it an informal usage or does it refer to the formal
happens-before relation?).  The original "propagates to" is better.

> +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> +of y executes before P2's store to z (second fence), which implies that
> +that stores to x and y propagate to P2 before the smp_store_release(), which
> +means that P2's smp_store_release() will propagate stores to x and y to all
> +CPUs before the store to z propagates (A-cumulative property of this fence).
> +Finally P0's load of z executes after P2's store to z has propagated to
> +P0 (rfe link).

Again, a better change would be simply to replace the two instances of
"fence" in the original text with "cumul-fence".

Alan

