Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5C32F359
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCES7v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 13:59:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43749 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229687AbhCES7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 13:59:25 -0500
Received: (qmail 48402 invoked by uid 1000); 5 Mar 2021 13:59:24 -0500
Date:   Fri, 5 Mar 2021 13:59:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20210305185924.GA48113@rowland.harvard.edu>
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
 <20210305153655.GC38200@rowland.harvard.edu>
 <e90fee12-a29e-cddb-5db3-24d92d4e03f8@intel.com>
 <20210305182650.GA2713@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305182650.GA2713@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 10:26:50AM -0800, Paul E. McKenney wrote:
> On Fri, Mar 05, 2021 at 04:41:49PM +0100, Björn Töpel wrote:
> > On 2021-03-05 16:36, Alan Stern wrote:
> > > On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> > > > From: Björn Töpel <bjorn.topel@intel.com>
> > > > 
> > > > A misspelled invokation of git-grep, revealed that
> > > -------------------^
> > > 
> > > Smetimes my brain is a little slow...  Do you confirm that this is a
> > > joke?
> > > 
> > 
> > I wish, Alan. I wish.
> > 
> > Looks like I can only spel function names correctly.
> 
> Heh!  I missed that one completely.  Please see below for a wortschmied
> commit.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 1c737ce34715db9431f6b034f92dbf09d954126d
> Author: Björn Töpel <bjorn.topel@intel.com>
> Date:   Fri Mar 5 11:28:23 2021 +0100
> 
>     tools/memory-model: Fix smp_mb__after_spinlock() spelling
>     
>     A misspelled git-grep regex revealed that smp_mb__after_spinlock()
>     was misspelled in explanation.txt.
>     
>     This commit adds the missing "_" to smp_mb__after_spinlock().

Strictly speaking, the commit adds a missing "_" to 
smp_mb_after_spinlock().  If it added anything to 
smp_mb__after_spinlock(), the result would be incorrect.

How about just:

    A misspelled git-grep regex revealed that smp_mb__after_spinlock()
    was misspelled in explanation.txt.  This commit adds the missing "_".

Alan
