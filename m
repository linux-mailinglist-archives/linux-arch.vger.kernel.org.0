Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46E62B9093
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKSLD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSLD3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 06:03:29 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACBC0613D4
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 03:03:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so5929723wrw.10
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 03:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFamxyJgml0Q9lHKOib3+a+7JzEnrNZtCyqpmdEgFHY=;
        b=kqHAg9poMnjna6jkicJdxbX2pallignKnsZm7PQ3J7+Ievqg93epHWgtVUtyVeXpcN
         +dWCkcIlLGnmoH/IM64UFp7UdWFeLgTLKx52vuX/MHI/KwP13XQG2gFghMaFoTmqebdM
         wGfEw2BLqmPenDc5qhti9xHWOcyQNxJGEqBUzVWKmvluSFSqa8BEDWypBBpgaNDKyzKJ
         tjSng7pmL0bcMiWZL7m0Sy3fGUCIu3UAdP3qSRQuiPBJvbyl73ZxRL88w5vCHGzW1Cvc
         b0BUGDp4O6yx6G9f9FsZruoQcsz1tY02WsLSsX7nKzB3C072ukmtf0gg4H5zqr+fPCIf
         oQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFamxyJgml0Q9lHKOib3+a+7JzEnrNZtCyqpmdEgFHY=;
        b=RDXZj559Vo/LoiKBed4yeMSyCGCyRbSuhewnuUQ2w+ZrbFpoqLI2VA4HFlMjk/ObvC
         s8CRCn/4OPY/3AW56ZAn+9rQBQT3gQa+S88taEtUYcuDunjEfBcKpsTr3EqEtTXZ7kA4
         R/16BEMN0vyVNpbOe8BD3kXqFAgrCxQUsoXp+OGKLc+NP5L+tq2ExyOJfrtd2q82u714
         ZAJbq3RA1kqyC0FdXWHWB/QdiG3WaMF4HPCiYnP4ZRu47WIQYaOj5Jj5s6yBBqLtfakv
         X6sTQwlNV4ukxGTxtyDN4G1Cp1jVYckk+kYrNuq67W/tRuKqngZsKneJOICpgp/tJk0S
         OqEQ==
X-Gm-Message-State: AOAM531O0vKno7dSVtPc7FRZMqoO0ThnBU8FkmmBP1Nju8xpNI1Do3pL
        7SttsTiipF1j5RMbxSAuM9tuLA==
X-Google-Smtp-Source: ABdhPJxgfj9H8n3fel6QzaGF5nPAhtC4qg27fy9D1pg2d5UCDEatBq3WasqWdPx/X7TiE6RaHNO7oQ==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr9558362wru.80.1605783807260;
        Thu, 19 Nov 2020 03:03:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id o4sm5525797wmh.33.2020.11.19.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:03:26 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:03:23 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119110323.GA2432333@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <20201119091820.GA2416649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119091820.GA2416649@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday 19 Nov 2020 at 09:18:20 (+0000), Quentin Perret wrote:
> Hey Will,
> 
> On Friday 13 Nov 2020 at 09:37:12 (+0000), Will Deacon wrote:
> > -static int __set_cpus_allowed_ptr(struct task_struct *p,
> > -				  const struct cpumask *new_mask, bool check)
> > +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> > +					 const struct cpumask *new_mask,
> > +					 bool check,
> > +					 struct rq *rq,
> > +					 struct rq_flags *rf)
> >  {
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> >  	unsigned int dest_cpu;
> > -	struct rq_flags rf;
> > -	struct rq *rq;
> >  	int ret = 0;
> 
> Should we have a lockdep assertion here?
> 
> > -	rq = task_rq_lock(p, &rf);
> >  	update_rq_clock(rq);
> >  
> >  	if (p->flags & PF_KTHREAD) {
> > @@ -1929,7 +1923,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  	if (task_running(rq, p) || p->state == TASK_WAKING) {
> >  		struct migration_arg arg = { p, dest_cpu };
> >  		/* Need help from migration thread: drop lock and wait. */
> > -		task_rq_unlock(rq, p, &rf);
> > +		task_rq_unlock(rq, p, rf);
> >  		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> >  		return 0;
> >  	} else if (task_on_rq_queued(p)) {
> > @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  		 * OK, since we're going to drop the lock immediately
> >  		 * afterwards anyway.
> >  		 */
> > -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> > +		rq = move_queued_task(rq, rf, p, dest_cpu);
> >  	}
> >  out:
> > -	task_rq_unlock(rq, p, &rf);
> > +	task_rq_unlock(rq, p, rf);
> 
> And that's a little odd to have here no? Can we move it back on the
> caller's side?

Yeah, no, that obviously doesn't work for the stop_one_cpu() call above,
so feel free to ignore ...

Thanks,
Quentin
