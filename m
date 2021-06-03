Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A37399DF7
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCJo7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 05:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhFCJo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 05:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622713393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKMol+hh4H5zAjzMENNUa+8kH/VPxhGbEihDFShSPDw=;
        b=V0vTPqbPzVzkOPOjdqvAFferUItlga6G4SDHdy2E533o98ohooqm4kzmqY9G0JIXFo/Ks2
        TEMr5qAm83cmsdONjQ6uBBaCiWITJ+8xeC1s/cdO/NxDgbDunXbY6uSV1Omrgwmawmsu6f
        1MhMiwxN1YaZkjGM9H0BjJDexA4ULxU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-K1rypGRUNKe1vFM01R26Tw-1; Thu, 03 Jun 2021 05:43:12 -0400
X-MC-Unique: K1rypGRUNKe1vFM01R26Tw-1
Received: by mail-ed1-f70.google.com with SMTP id y7-20020aa7ce870000b029038fd7cdcf3bso2966859edv.15
        for <linux-arch@vger.kernel.org>; Thu, 03 Jun 2021 02:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mKMol+hh4H5zAjzMENNUa+8kH/VPxhGbEihDFShSPDw=;
        b=ViccJJkHXAZGJFUfkuMjypWmGeTks/L9xCLQxjpwTbqxHVQgMkigVAV3BLVfYhlUY5
         P/iWFDk/cpDiNICzj8QOjHREaIjXGbRKlm4QnufLNysy6SuyFGlRE5yu7Q1GSUmCkAwj
         83/rPx9E9A4+KSCR+uOtF37U73lCxYIUob9KeGm7p1X6kbg0BSsGbZ3Qw3cMKLXIOxCM
         PMjhTl07ENvnQSPnHEj1Qts1NqFF8UMln9enSV1NE218JD/cDBQhIxD7LI5IpJksMEss
         jEK7lDs/WaYh/CttA+4cjwQ1pXVa4viRRRPwGPPA7KdkqvMy77t1pRvgKL3jd4LjUPHU
         2Ymg==
X-Gm-Message-State: AOAM531jdmPCgI9nWQosfHHPr2QE+BB6Es+bek8otD7WWQwMzdJXxGdA
        ESs9Hgy5AtzoLfUBSQbYCxvXfW+HA3tPHXtdaoo+0AT7z9FMOE9W4A8CjjPbV1tZj04A9uRrRMo
        bCC6wcHrNJG0/26e9uAIuRQ==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr38690908ejg.110.1622713391374;
        Thu, 03 Jun 2021 02:43:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGGXhqOBJzJuRPfjz4w/AmB4eDpBp9mpU61CFg7DVKMZu78HrRGHPAh+vd/LwxWHThjtnZ9g==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr38690899ejg.110.1622713391203;
        Thu, 03 Jun 2021 02:43:11 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id a7sm1455529edr.15.2021.06.03.02.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 02:43:10 -0700 (PDT)
Subject: Re: [PATCH v8 12/19] sched: Introduce task_cpus_dl_admissible() to
 check proposed affinity
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-13-will@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <5ab65165-49e6-633f-d4a5-9538fb72cc36@redhat.com>
Date:   Thu, 3 Jun 2021 11:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602164719.31777-13-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/2/21 6:47 PM, Will Deacon wrote:
> In preparation for restricting the affinity of a task during execve()
> on arm64, introduce a new task_cpus_dl_admissible() helper function to
> give an indication as to whether the restricted mask is admissible for
> a deadline task.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/sched.h |  6 ++++++
>  kernel/sched/core.c   | 44 +++++++++++++++++++++++++++----------------
>  2 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 91a6cfeae242..9b17d8cfa6ef 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1691,6 +1691,7 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
>  extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
>  extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
>  extern void release_user_cpus_ptr(struct task_struct *p);
> +extern bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask);
>  extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
>  extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
>  #else
> @@ -1713,6 +1714,11 @@ static inline void release_user_cpus_ptr(struct task_struct *p)
>  {
>  	WARN_ON(p->user_cpus_ptr);
>  }
> +
> +static inline bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)
> +{
> +	return true;
> +}
>  #endif
>  
>  extern int yield_to(struct task_struct *p, bool preempt);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 58e2cf7520c0..b4f8dc18ae11 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6933,6 +6933,31 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	return retval;
>  }
>  
> +#ifdef CONFIG_SMP
> +bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)

Would you mind renaming it to dl_task_check_affinity(), in the case of a v9? It
will look coherent with dl_task_can_attach()...

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

