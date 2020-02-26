Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC761701B2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 15:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBZO6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 09:58:13 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36455 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727249AbgBZO6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 09:58:13 -0500
Received: (qmail 5669 invoked by uid 500); 26 Feb 2020 09:58:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2020 09:58:12 -0500
Date:   Wed, 26 Feb 2020 09:58:12 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     linux-kernel@vger.kernel.org, <rcu@vger.kernel.org>,
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
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] tools/memory-model: Remove lock-final checking in lock.cat
In-Reply-To: <20200226032142.89424-1-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002260953110.3674-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 26 Feb 2020, Boqun Feng wrote:

> In commit 30b795df11a1 ("tools/memory-model: Improve mixed-access
> checking in lock.cat"), we have added the checking to disallow any
> normal memory access to lock variables, and this checking is stronger
> than lock-final. So remove the lock-final checking as it's unnecessary
> now.

I don't understand this description.  Why do you say that the
normal-access checking is stronger than the lock-final check?

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  tools/memory-model/lock.cat | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> index 6b52f365d73a..827a3646607c 100644
> --- a/tools/memory-model/lock.cat
> +++ b/tools/memory-model/lock.cat
> @@ -54,9 +54,6 @@ flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
>   *)
>  empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
>  
> -(* The final value of a spinlock should not be tested *)
> -flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
> -
>  (*
>   * Put lock operations in their appropriate classes, but leave UL out of W
>   * until after the co relation has been generated.

With this check removed, what will prevent people from writing litmus 
tests like this?

C test

{
	spinlock_t s;
}

...

exists (s=0)

Alan

