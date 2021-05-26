Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B430391CE2
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhEZQXE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEZQXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 12:23:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2354FC061574;
        Wed, 26 May 2021 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFoSjDHrMWdi2TUI6YK2jTs5l6DaG7NO6Wy5qFgfnvE=; b=be/ttzz5/pCXA47SCWWock3PTI
        wzzZsBgMcyifPb4Hx393/YedkBG5GLwrxlLXabX+PcaP/0rSIpGkb6ux8oQZYva3dmFaNNWNqtEmU
        9J44W1EaY3jTQVrPidw3BJNctAWEqZktD1ZoD/8Jte5WZqarslzP2Rlp86LHCdSXQB+Jk75ZpyqH9
        cAzzTKv9DnLccHODZI7trSIrX5vi/1H5tbLIO8fVqvTTQqh+inut9YsWh64rMqpfFH53q+n41Pvsl
        F5jj57KrXeI0eH13mr6tJmtqlwDyxlJp/vDz/Naj71P5mm62kReaeZ1xD8XEyaA9RCMXEeVOC1qb0
        seTZGBVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llwGg-004gxo-Vf; Wed, 26 May 2021 16:20:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A09FA300221;
        Wed, 26 May 2021 18:20:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B98A201D301D; Wed, 26 May 2021 18:20:25 +0200 (CEST)
Date:   Wed, 26 May 2021 18:20:25 +0200
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
        kernel-team@android.com
Subject: Re: [PATCH v7 13/22] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <YK51SSUvL2psb3OL@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-14-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525151432.16875-14-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 04:14:23PM +0100, Will Deacon wrote:
> +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> +				     struct cpumask *new_mask,
> +				     const struct cpumask *subset_mask)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int err;
> +	struct cpumask *user_mask = NULL;
> +
> +	if (!p->user_cpus_ptr) {
> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);

		if (!user_mask)
			return -ENOMEM;
	}

?

> +
> +	rq = task_rq_lock(p, &rf);
> +
> +	/*
> +	 * Forcefully restricting the affinity of a deadline task is
> +	 * likely to cause problems, so fail and noisily override the
> +	 * mask entirely.
> +	 */
> +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> +		err = -EPERM;
> +		goto err_unlock;
> +	}
> +
> +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> +		err = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * We're about to butcher the task affinity, so keep track of what
> +	 * the user asked for in case we're able to restore it later on.
> +	 */
> +	if (user_mask) {
> +		cpumask_copy(user_mask, p->cpus_ptr);
> +		p->user_cpus_ptr = user_mask;
> +	}
> +
> +	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
> +
> +err_unlock:
> +	task_rq_unlock(rq, p, &rf);
> +	kfree(user_mask);
> +	return err;
> +}
