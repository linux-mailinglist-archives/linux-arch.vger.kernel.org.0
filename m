Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35923EEF50
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhHQPnb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhHQPnb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 11:43:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF0C061764;
        Tue, 17 Aug 2021 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u/XuR62QAH9RG+4+BVL2Z+k7nR2Ng6hmaSGa6V1RjgQ=; b=FLggYJ9XfdgVeZRfNay+7wu7ag
        BRtXZCR7sLgTM5q7OulUwosh8qQa0myP1MVJyArfzuCG5I4F5yln8R4b4KHoGQCYF3DmZVW32CSJW
        fP0wOFIcA7QvA6l0nCI0j5uCSP/qV9Sx1tVkFqZJo3sI2uNj0QQ26MRmuyFrfNiOCA1qSyQplYmnb
        vpQ9bGiNE4gt6levSc7RMaHZafrnbkW6bclTG2WZipa7Oiq51T7i9PNjYJ07PsGW3E37+IDg/c35g
        m49uzsili3Bw9q01gCB0AdOdoZhMIaD2WhjfMhF744iIvh9kp+7Gyw8NKUaGSQ5GoWBZZourIDynL
        9ymSbjiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mG1Dj-002fdj-4P; Tue, 17 Aug 2021 15:41:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 360E030009A;
        Tue, 17 Aug 2021 17:41:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 286282C8F5E25; Tue, 17 Aug 2021 17:41:42 +0200 (CEST)
Date:   Tue, 17 Aug 2021 17:41:42 +0200
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
Message-ID: <YRvYtlyhuRpFi/Th@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730112443.23245-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 12:24:35PM +0100, Will Deacon wrote:
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int err;
> +	struct cpumask *user_mask = NULL;

> +	cpumask_var_t new_mask;
> +	const struct cpumask *override_mask = task_cpu_possible_mask(p);

> +	unsigned long flags;
> +	struct cpumask *mask = p->user_cpus_ptr;

I've fixed all that up to be proper reverse x-mas trees; similar for
other patches.
