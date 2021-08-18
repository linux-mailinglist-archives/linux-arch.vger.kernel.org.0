Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECC3F03A4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhHRMTp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 08:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhHRMTn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Aug 2021 08:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9AA26103E;
        Wed, 18 Aug 2021 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629289149;
        bh=8ktxnAXgo0Y8fZiDQP9McWgd+yggDijrLt0O/GE7g4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Smy5CjjU8ZEY0tW7BAvTw//U/uF7nuT8moUBCzWyP4fw7jgQUVwkiA7zQ40j2Anfc
         ubu+AY8gZL6Oa+GP2iE3JR8v0rtRpQT2Hp9Z4brwznzhUpMOi/WdWOt3XWraDTfb7/
         FgfSVs4YYvIfnaqoucgUw/HLxyrGpaNQKHXS1pDQiOLQDWIAaENcmaDHS584Q1LiHN
         ShIjsMksXt4NCSlkQNMddKQoog+WABpmbSkew04Au4fg7P3+tFH7cr9viKwaXGpM5F
         ZeH467hUwi+gXgq6g8paJ0C90tZccOZx9Wgcynxfvqi07VIg0xnPKt4ETsogt637Te
         lVwFxPMMmgyyA==
Date:   Wed, 18 Aug 2021 13:19:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 08/16] sched: Allow task CPU affinity to be
 restricted on asymmetric systems
Message-ID: <20210818121900.GC14107@willie-the-truck>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
 <20210818104227.GA13828@willie-the-truck>
 <YRznaZBHXYEzCPt1@hirez.programming.kicks-ass.net>
 <YRz0uI6V58eGNL1C@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRz0uI6V58eGNL1C@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 01:53:28PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 18, 2021 at 12:56:41PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 18, 2021 at 11:42:28AM +0100, Will Deacon wrote:
> 
> > > I think the idea looks good, but perhaps we could wrap things up a bit:
> > > 
> > > /* Comment about why this is useful with RT */
> > > static cpumask_t *clear_user_cpus_ptr(struct task_struct *p)
> > > {
> > > 	struct cpumask *user_mask = NULL;
> > > 
> > > 	swap(user_mask, p->user_cpus_ptr);
> > > 	return user_mask;
> > > }
> > > 
> > > void release_user_cpus_ptr(struct task_struct *p)
> > > {
> > > 	kfree(clear_user_cpus_ptr(p));
> > > }
> > > 
> > > Then just use clear_user_cpus_ptr() in sched/core.c where we know what
> > > we're doing (well, at least one of us does!).
> > 
> > OK, I'll go make it like that.
> 
> Something like so then?

Looks good to me, thanks!

Will
