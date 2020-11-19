Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8AC2B8E88
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 10:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSJS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 04:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKSJS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 04:18:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B9C0613CF
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:18:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m6so5607097wrg.7
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdO73wPUtO91VkHNoPsos+au3LYwQYAXfz1yiydAPjw=;
        b=SiGcoM1Z7UHzA4JfGM1ADc64LSJObWD3rK3mEabHpVq+qsFkyqIgfWSUClkF7e3P0a
         mKFhGum+0JZb1YcCdG5O/7uy/cMY9n3BY4b9FtY9fAi/OUtd/2O9UfKfYNjDU3lfk1Vv
         CoNWUnbPdfiklG0Ba6yHoigcezvm5licw9EJO29W6jBElMQmLtDXKCS3blMZdf01ZrfY
         vqsf9SnELgTdAgJN6Ce32HjjQvSFCGOVbK81+ZgDWGGPvCxUiSuQNEcPZpyXeyUb/HxR
         xO/UDT0W53dW8agM2LrCrqtWsc6aG5p8xK6BGQr/Xj0LwEgvuha5uXQuwSA3mqO6k4J9
         ZKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IdO73wPUtO91VkHNoPsos+au3LYwQYAXfz1yiydAPjw=;
        b=OoSH7NzXxOqHLryxeIXdni0ZvT9NUr1lBaw/5CF2HP9Y3UzAc+QIEO1lHSdfn/jmZI
         0TXwxvlsFLQ0xDraT2Gn78WnSV55bkwXnXa7qWcBqoHTf9rkyM+r5jJ0URMIN/LKYZrd
         7VdXNNztNPmU5xxxc8ItExj/jVohhR6WHpXZNkDsPnYsUJPOMySKNtc9i/yeQDPeMwnG
         7EeNFdhcxgQFMg2MexptHOEcRrd9X01TefHdjwcjLoI1NoDeuzwHfhcgaJOgbZDzaACt
         ZZUjhwClLfBRyJR/xj7XnZd5u542kP+nTCf6hJTszQ1W1OcFFoZlOi87wcLKteB4PBLP
         rhdw==
X-Gm-Message-State: AOAM532P1kO0OzgHzuJUL0qrc6m4A6D3jjrEb1X5C76FZ0fBkDXQQb8H
        f5nWYRYaViI63g4h+baeLbQxjhmsok4ENA==
X-Google-Smtp-Source: ABdhPJy9KoqPyLqdoPK1EXUPy9/Ro5D0jFmed6OXcjS8SVZViEddXqKt96daQmNhCN5uascZH3UUww==
X-Received: by 2002:adf:d18a:: with SMTP id v10mr8830619wrc.325.1605777504496;
        Thu, 19 Nov 2020 01:18:24 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id a128sm8935236wmf.5.2020.11.19.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:18:23 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:18:20 +0000
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
Message-ID: <20201119091820.GA2416649@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Will,

On Friday 13 Nov 2020 at 09:37:12 (+0000), Will Deacon wrote:
> -static int __set_cpus_allowed_ptr(struct task_struct *p,
> -				  const struct cpumask *new_mask, bool check)
> +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> +					 const struct cpumask *new_mask,
> +					 bool check,
> +					 struct rq *rq,
> +					 struct rq_flags *rf)
>  {
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
>  	unsigned int dest_cpu;
> -	struct rq_flags rf;
> -	struct rq *rq;
>  	int ret = 0;

Should we have a lockdep assertion here?

> -	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
>  	if (p->flags & PF_KTHREAD) {
> @@ -1929,7 +1923,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	if (task_running(rq, p) || p->state == TASK_WAKING) {
>  		struct migration_arg arg = { p, dest_cpu };
>  		/* Need help from migration thread: drop lock and wait. */
> -		task_rq_unlock(rq, p, &rf);
> +		task_rq_unlock(rq, p, rf);
>  		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
>  		return 0;
>  	} else if (task_on_rq_queued(p)) {
> @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  		 * OK, since we're going to drop the lock immediately
>  		 * afterwards anyway.
>  		 */
> -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> +		rq = move_queued_task(rq, rf, p, dest_cpu);
>  	}
>  out:
> -	task_rq_unlock(rq, p, &rf);
> +	task_rq_unlock(rq, p, rf);

And that's a little odd to have here no? Can we move it back on the
caller's side?

>  	return ret;
>  }

Thanks,
Quentin
