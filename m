Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBC1DEE77
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgEVRnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 13:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgEVRnx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 13:43:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E5620723;
        Fri, 22 May 2020 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169432;
        bh=t22SyB9/K0m7E486hZD+8n3eS0aL0e1D5tiaHegV7t4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FbvkIrVI+T2eCWT0T7gRxnb98/8VdBn4hzMhVK3rF9tB4lYEISVUrrayGEoSOG25L
         4BK+yKfkU4EyB9swUyvf9VivrR5ydvB7E5qmyVnKp5RM1l4MO88lptxGLiPYSbL1Mm
         H5mYORDCqyVUzKjzY3buBkk1ShuYVqCYoKDrX78Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AFA063522E41; Fri, 22 May 2020 10:43:52 -0700 (PDT)
Date:   Fri, 22 May 2020 10:43:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200522174352.GJ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522143201.GB32434@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Just wanted to call your attention to some pretty cool and pretty serious
> > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > 
> > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > 
> > > Thoughts?
> > 
> > I find:
> > 
> > 	smp_wmb()
> > 	smp_store_release()
> > 
> > a _very_ weird construct. What is that supposed to even do?
> 
> Indeed, it looks like one or the other of those is redundant (depending 
> on the context).

Probably.  Peter instead asked what it was supposed to even do.  ;-)

> Also, what use is a spinlock that is accessed in only one thread?

Multiple writers synchronize via the spinlock in this case.  I am
guessing that his larger 16-hour test contended this spinlock.

> Finally, I doubt that these tests belong under tools/memory-model.  
> Shouldn't they go under the new Documentation/ directory for litmus 
> tests?  And shouldn't the patch update a README file?

Agreed, and I responded to that effect to his original patch:

https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72/

							Thanx, Paul
