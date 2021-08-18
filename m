Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594E03F0313
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhHRL40 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhHRL4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 07:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F40C061764;
        Wed, 18 Aug 2021 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D6iemufMr2b/qeAUmVa3U7ugTs+hnH9TTpLcRzXpGLw=; b=HNIGBYXuOLuf/lXvjO9O83UPQ7
        om2IyVQGCUigapiedkWriTOLxcCJ4qmBMuKWxY25raV2fYL2Bs6Crurp/aO02dc2oCrNvZ0ChNqGF
        a5n4TFrYp+8x+DWYzLn9UZNJosybpHXFOLIx9jCr4lpLZv3/Wc9+sAM+VO8/xEs7EIG7uBkJpxwBz
        BJs36qSbWjGrvl5gRZQ4zNeN4dDOAD2aB34KRCKmyYe7nXiGoZIkzi33NUNdZXXxQM3g/yuRyNCRq
        byD34aUA30Ac8t071fMzM7uD/y0YLKxlMdIi8FZPPusHizzK0pxg5EtjdKVYtqB5w/UXKZj9kmcJ5
        LPlLDiWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGK8P-003mac-LY; Wed, 18 Aug 2021 11:53:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 900E6300233;
        Wed, 18 Aug 2021 13:53:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7303F2027DC71; Wed, 18 Aug 2021 13:53:28 +0200 (CEST)
Date:   Wed, 18 Aug 2021 13:53:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <YRz0uI6V58eGNL1C@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
 <20210818104227.GA13828@willie-the-truck>
 <YRznaZBHXYEzCPt1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRznaZBHXYEzCPt1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 12:56:41PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 18, 2021 at 11:42:28AM +0100, Will Deacon wrote:

> > I think the idea looks good, but perhaps we could wrap things up a bit:
> > 
> > /* Comment about why this is useful with RT */
> > static cpumask_t *clear_user_cpus_ptr(struct task_struct *p)
> > {
> > 	struct cpumask *user_mask = NULL;
> > 
> > 	swap(user_mask, p->user_cpus_ptr);
> > 	return user_mask;
> > }
> > 
> > void release_user_cpus_ptr(struct task_struct *p)
> > {
> > 	kfree(clear_user_cpus_ptr(p));
> > }
> > 
> > Then just use clear_user_cpus_ptr() in sched/core.c where we know what
> > we're doing (well, at least one of us does!).
> 
> OK, I'll go make it like that.

Something like so then?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2497,10 +2497,18 @@ int dup_user_cpus_ptr(struct task_struct
 	return 0;
 }
 
+static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
+{
+	struct cpumask *user_mask = NULL;
+
+	swap(p->user_cpus_ptr, user_mask);
+
+	return user_mask;
+}
+
 void release_user_cpus_ptr(struct task_struct *p)
 {
-	kfree(p->user_cpus_ptr);
-	p->user_cpus_ptr = NULL;
+	kfree(clear_user_cpus_ptr(p));
 }
 
 /*
@@ -2733,6 +2741,7 @@ static int __set_cpus_allowed_ptr_locked
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
+	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2792,9 +2801,13 @@ static int __set_cpus_allowed_ptr_locked
 	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (flags & SCA_USER)
-		release_user_cpus_ptr(p);
+		user_mask = clear_user_cpus_ptr(p);
 
-	return affine_move_task(rq, p, rf, dest_cpu, flags);
+	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+
+	kfree(user_mask);
+
+	return ret;
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2941,20 +2954,22 @@ __sched_setaffinity(struct task_struct *
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
+	struct cpumask *user_mask = p->user_cpus_ptr;
 	unsigned long flags;
-	struct cpumask *mask = p->user_cpus_ptr;
 
 	/*
 	 * Try to restore the old affinity mask. If this fails, then
 	 * we free the mask explicitly to avoid it being inherited across
 	 * a subsequent fork().
 	 */
-	if (!mask || !__sched_setaffinity(p, mask))
+	if (!user_mask || !__sched_setaffinity(p, user_mask))
 		return;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	release_user_cpus_ptr(p);
+	user_mask = clear_user_cpus_ptr(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	kfree(user_mask);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)

