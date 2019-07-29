Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101E179A22
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfG2Ulf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 16:41:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44737 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729056AbfG2Ulf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 16:41:35 -0400
Received: (qmail 2507 invoked by uid 500); 29 Jul 2019 16:41:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jul 2019 16:41:34 -0400
Date:   Mon, 29 Jul 2019 16:41:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        <linux-arch@vger.kernel.org>, Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Use term cumul-fence instead of fence in ->prop ordering
 example
In-Reply-To: <20190729123605.150423-1-joel@joelfernandes.org>
Message-ID: <Pine.LNX.4.44L0.1907291641220.760-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Jul 2019, Joel Fernandes (Google) wrote:

> To reduce ambiguity in the more exotic ->prop ordering example, let us
> use the term cumul-fence instead fence for the 2 fences, so that the
> implict ->rfe on loads/stores to Y are covered by the description.
> 
> Link: https://lore.kernel.org/lkml/20190729121745.GA140682@google.com
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/memory-model/Documentation/explanation.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 68caa9a976d0..634dc6db26c4 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1302,7 +1302,7 @@ followed by an arbitrary number of cumul-fence links, ending with an
>  rfe link.  You can concoct more exotic examples, containing more than
>  one fence, although this quickly leads to diminishing returns in terms
>  of complexity.  For instance, here's an example containing a coe link
> -followed by two fences and an rfe link, utilizing the fact that
> +followed by two cumul-fences and an rfe link, utilizing the fact that
>  release fences are A-cumulative:
>  
>  	int x, y, z;
> @@ -1334,10 +1334,10 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
>  link from P0's store to its load.  This is because P0's store gets
>  overwritten by P1's store since x = 2 at the end (a coe link), the
>  smp_wmb() ensures that P1's store to x propagates to P2 before the
> -store to y does (the first fence), the store to y propagates to P2
> +store to y does (the first cumul-fence), the store to y propagates to P2
>  before P2's load and store execute, P2's smp_store_release()
>  guarantees that the stores to x and y both propagate to P0 before the
> -store to z does (the second fence), and P0's load executes after the
> +store to z does (the second cumul-fence), and P0's load executes after the
>  store to z has propagated to P0 (an rfe link).
>  
>  In summary, the fact that the hb relation links memory access events

Acked-by: Alan Stern <stern@rowland.harvard.edu>

