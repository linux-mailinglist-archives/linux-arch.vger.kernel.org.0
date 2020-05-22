Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149E01DE904
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgEVOcC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 10:32:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39221 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729868AbgEVOcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 10:32:02 -0400
Received: (qmail 1576 invoked by uid 1000); 22 May 2020 10:32:01 -0400
Date:   Fri, 22 May 2020 10:32:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200522143201.GB32434@rowland.harvard.edu>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522094407.GK325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Just wanted to call your attention to some pretty cool and pretty serious
> > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > 
> > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > 
> > Thoughts?
> 
> I find:
> 
> 	smp_wmb()
> 	smp_store_release()
> 
> a _very_ weird construct. What is that supposed to even do?

Indeed, it looks like one or the other of those is redundant (depending 
on the context).

Also, what use is a spinlock that is accessed in only one thread?

Finally, I doubt that these tests belong under tools/memory-model.  
Shouldn't they go under the new Documentation/ directory for litmus 
tests?  And shouldn't the patch update a README file?

Alan
