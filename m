Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF0282E51
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 01:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgJDXc3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 19:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgJDXc2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Oct 2020 19:32:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2B2206B6;
        Sun,  4 Oct 2020 23:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601854348;
        bh=YzpcxYAFA+eJp0cl8hwcxcJi+D+5TLeTPsAXUn92KwY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t2teay/JnQ5b19qQc0wEnqJMTZHhT/onkMM/QrCtYWDQE/9PoM6eOIpF5vAwMUlRd
         8Qi+lDP65X0DEbOm/D1CH8C7ZIeqIH85VLnsmwYPI5pHl1y2dETJdCnqun4WwvDr19
         kL8/uAyH2U5PBJmU9hSez81fpWJHtTviQ5/GK33M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C614035225F2; Sun,  4 Oct 2020 16:32:27 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:32:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201004233227.GQ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <17935342-e927-284c-9a2b-ca75dd2398ad@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17935342-e927-284c-9a2b-ca75dd2398ad@jonmasters.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 02, 2020 at 10:35:45PM -0400, Jon Masters wrote:
> On 10/1/20 12:15 PM, Alan Stern wrote:
> > On Wed, Sep 30, 2020 at 09:51:16PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Al Viro posted the following query:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > <viro> fun question regarding barriers, if you have time for that
> > > <viro>         V->A = V->B = 1;
> > > <viro>
> > > <viro> CPU1:
> > > <viro>         to_free = NULL
> > > <viro>         spin_lock(&LOCK)
> > > <viro>         if (!smp_load_acquire(&V->B))
> > > <viro>                 to_free = V
> > > <viro>         V->A = 0
> > > <viro>         spin_unlock(&LOCK)
> > > <viro>         kfree(to_free)
> > > <viro>
> > > <viro> CPU2:
> > > <viro>         to_free = V;
> > > <viro>         if (READ_ONCE(V->A)) {
> > > <viro>                 spin_lock(&LOCK)
> > > <viro>                 if (V->A)
> > > <viro>                         to_free = NULL
> > > <viro>                 smp_store_release(&V->B, 0);
> > > <viro>                 spin_unlock(&LOCK)
> > > <viro>         }
> > > <viro>         kfree(to_free);
> > > <viro> 1) is it guaranteed that V will be freed exactly once and that
> > > 	  no accesses to *V will happen after freeing it?
> > > <viro> 2) do we need smp_store_release() there?  I.e. will anything
> > > 	  break if it's replaced with plain V->B = 0?
> > 
> > Here are my answers to Al's questions:
> > 
> > 1) It is guaranteed that V will be freed exactly once.  It is not
> > guaranteed that no accesses to *V will occur after it is freed, because
> > the test contains a data race.  CPU1's plain "V->A = 0" write races with
> > CPU2's READ_ONCE; if the plain write were replaced with
> > "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well,
> > CPU1's smp_load_acquire could be replaced with a plain read while the
> > plain write is replaced with smp_store_release.
> > 
> > 2) The smp_store_release in CPU2 is not needed.  Replacing it with a
> > plain V->B = 0 will not break anything.
> 
> This was my interpretation also. I made the mistake of reading this right
> before trying to go to bed the other night and ended up tweeting at Paul
> that I'd regret it if he gave me scary dreams. Thought about it and read
> your write up and it is still exactly how I see it.

Should I have added a "read at your own risk" disclaimer?  ;-)

							Thanx, Paul
