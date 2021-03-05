Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2032F389
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCETKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 14:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhCETJ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 14:09:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12653650A1;
        Fri,  5 Mar 2021 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614971398;
        bh=cuKug+dm7eNzqdSen+voo2Z8E6BB2Gh6+BQHsew7zRQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r3dsaf+uWHXgpXj4Zl6sideUgpWjl/mPN438Afdo/QoEnuBF5mG2lLFFy7BxO/H5X
         oO0fYhVq4LSKYjorIQwKd1xTzQZPl1+jewp4KQ8KfwqPk0/5wegeK7BzLv1dvmHiOw
         TbGzUHg1qj2IWhFTw30PEViM6UQBnCVkIApJcWBaSMl/cl2kTuVU0yL3XteyHYZ1Gc
         nmQ+IY03jKcyG5nfag657Dub5KEh9CwO0H78Z6DOLsgglrybDcak1c1atmjj1blZC2
         kz2tgYhYXZEw3UeUKF3jhqhjpn9Gtcq7sJLg6izeTVqX9/QyGS+vqC2dRBSTlzKAtQ
         9cv0Dk9pJtvtQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ADBFE3523946; Fri,  5 Mar 2021 11:09:57 -0800 (PST)
Date:   Fri, 5 Mar 2021 11:09:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Message-ID: <20210305190957.GE2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
 <20210305153655.GC38200@rowland.harvard.edu>
 <e90fee12-a29e-cddb-5db3-24d92d4e03f8@intel.com>
 <20210305182650.GA2713@paulmck-ThinkPad-P72>
 <20210305185924.GA48113@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305185924.GA48113@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 01:59:24PM -0500, Alan Stern wrote:
> On Fri, Mar 05, 2021 at 10:26:50AM -0800, Paul E. McKenney wrote:
> > On Fri, Mar 05, 2021 at 04:41:49PM +0100, Björn Töpel wrote:
> > > On 2021-03-05 16:36, Alan Stern wrote:
> > > > On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> > > > > From: Björn Töpel <bjorn.topel@intel.com>
> > > > > 
> > > > > A misspelled invokation of git-grep, revealed that
> > > > -------------------^
> > > > 
> > > > Smetimes my brain is a little slow...  Do you confirm that this is a
> > > > joke?
> > > > 
> > > 
> > > I wish, Alan. I wish.
> > > 
> > > Looks like I can only spel function names correctly.
> > 
> > Heh!  I missed that one completely.  Please see below for a wortschmied
> > commit.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 1c737ce34715db9431f6b034f92dbf09d954126d
> > Author: Björn Töpel <bjorn.topel@intel.com>
> > Date:   Fri Mar 5 11:28:23 2021 +0100
> > 
> >     tools/memory-model: Fix smp_mb__after_spinlock() spelling
> >     
> >     A misspelled git-grep regex revealed that smp_mb__after_spinlock()
> >     was misspelled in explanation.txt.
> >     
> >     This commit adds the missing "_" to smp_mb__after_spinlock().
> 
> Strictly speaking, the commit adds a missing "_" to 
> smp_mb_after_spinlock().  If it added anything to 
> smp_mb__after_spinlock(), the result would be incorrect.
> 
> How about just:
> 
>     A misspelled git-grep regex revealed that smp_mb__after_spinlock()
>     was misspelled in explanation.txt.  This commit adds the missing "_".

Very good, updated as you suggest, thank you!

							Thanx, Paul
