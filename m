Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE10280413
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgJAQhE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgJAQhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 12:37:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF433C0613D0;
        Thu,  1 Oct 2020 09:37:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kO1ZW-009vym-B9; Thu, 01 Oct 2020 16:36:46 +0000
Date:   Thu, 1 Oct 2020 17:36:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201001163646.GG3421308@ZenIV.linux.org.uk>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001161529.GA251468@rowland.harvard.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 12:15:29PM -0400, Alan Stern wrote:
> > <viro> CPU1:
> > <viro>         to_free = NULL
> > <viro>         spin_lock(&LOCK)
> > <viro>         if (!smp_load_acquire(&V->B))
> > <viro>                 to_free = V
> > <viro>         V->A = 0
> > <viro>         spin_unlock(&LOCK)
> > <viro>         kfree(to_free)
> > <viro>
> > <viro> CPU2:
> > <viro>         to_free = V;
> > <viro>         if (READ_ONCE(V->A)) {
> > <viro>                 spin_lock(&LOCK)
> > <viro>                 if (V->A)
> > <viro>                         to_free = NULL
> > <viro>                 smp_store_release(&V->B, 0);
> > <viro>                 spin_unlock(&LOCK)
> > <viro>         }
> > <viro>         kfree(to_free);
> > <viro> 1) is it guaranteed that V will be freed exactly once and that
> > 	  no accesses to *V will happen after freeing it?
> > <viro> 2) do we need smp_store_release() there?  I.e. will anything
> > 	  break if it's replaced with plain V->B = 0?
> 
> Here are my answers to Al's questions:
> 
> 1) It is guaranteed that V will be freed exactly once.  It is not 
> guaranteed that no accesses to *V will occur after it is freed, because 
> the test contains a data race.  CPU1's plain "V->A = 0" write races with 
> CPU2's READ_ONCE;

What will that READ_ONCE() yield in that case?  If it's non-zero, we should
be fine - we won't get to kfree() until after we are done with the spinlock.
And if it's zero...  What will CPU1 do with *V accesses _after_ it has issued
the store to V->A?

Confused...

> if the plain write were replaced with 
> "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well, 
> CPU1's smp_load_acquire could be replaced with a plain read while the 
> plain write is replaced with smp_store_release.

Er...  Do you mean the write to ->A on CPU1?
