Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665F33D3E00
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGWQTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 12:19:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47601 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229492AbhGWQTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 12:19:15 -0400
Received: (qmail 46912 invoked by uid 1000); 23 Jul 2021 12:59:47 -0400
Date:   Fri, 23 Jul 2021 12:59:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210723165947.GA46562@rowland.harvard.edu>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <20210723162431.GF4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723162431.GF4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 09:24:31AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 22, 2021 at 10:08:46PM -0400, Alan Stern wrote:

> > > +	void do_something_locked(struct foo *fp)
> > > +	{
> > > +		bool gf = true;
> > > +
> > > +		/* IMPORTANT: Heuristic plus spin_lock()! */
> > > +		if (!data_race(global_flag)) {
> > > +			spin_lock(&fp->f_lock);
> > > +			if (!smp_load_acquire(&global_flag)) {

> > > +	void begin_global(void)
> > > +	{
> > > +		int i;
> > > +
> > > +		spin_lock(&global_lock);
> > > +		WRITE_ONCE(global_flag, true);
> > 
> > Why does this need to be WRITE_ONCE?  It still races with the first read 
> > of global_flag above.
> 
> But also with the smp_load_acquire() of global_flag, right?

What I'm curious about is why, given these two races, you notate one of 
them by changing a normal write to WRITE_ONCE and you notate the other 
by changing a normal read to a data_race() read.  Why not handle them 
both the same way?

Alan
