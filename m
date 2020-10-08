Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCEB286CBB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 04:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgJHCZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 22:25:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56767 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727080AbgJHCZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 22:25:38 -0400
Received: (qmail 480496 invoked by uid 1000); 7 Oct 2020 22:25:37 -0400
Date:   Wed, 7 Oct 2020 22:25:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201008022537.GA480405@rowland.harvard.edu>
References: <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
 <20201007194050.GC468921@rowland.harvard.edu>
 <20201007223851.GV29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007223851.GV29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 03:38:51PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 07, 2020 at 03:40:50PM -0400, Alan Stern wrote:
> > On Wed, Oct 07, 2020 at 10:50:40AM -0700, Paul E. McKenney wrote:
> > > And here is the updated version.
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit b7cd60d4b41ad56b32b36b978488f509c4f7e228
> > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > Date:   Tue Oct 6 09:38:37 2020 -0700
> > > 
> > >     manual/kernel: Add LB+mb+data litmus test
> > 
> > Let's change this to:
> > 
> >       manual/kernel: Add LB data dependency test with no intermediate variable
> > 
> > Without that extra qualification, people reading just the title would
> > wonder why we need a simple LB litmus test in the archive.

> I might get this right sooner or later.  You never know.
> 
> Like this?
> 
> 							Thanx, Paul

Paul, I think you must need new reading glasses.  You completely missed 
the text above.

Alan

> ------------------------------------------------------------------------
> 
> commit 5b6a4ff2c8ad25fc77f4151e71e6cbd8f3268d7b
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Oct 6 09:38:37 2020 -0700
> 
>     manual/kernel: Add LB+mb+data litmus test
>     
>     Test whether herd7 can detect a data dependency when there is no
>     intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
>     Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
>     dependencies to be missed.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
