Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87612E33F2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Dec 2020 04:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgL1Dy5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Dec 2020 22:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgL1Dy5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Dec 2020 22:54:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E3C061794
        for <linux-arch@vger.kernel.org>; Sun, 27 Dec 2020 19:54:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n16so6389742wmc.0
        for <linux-arch@vger.kernel.org>; Sun, 27 Dec 2020 19:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgMlEQMwUkkD6KJWmCk8NsuP2RHpzUCaGkYxuaH4YTc=;
        b=F+QwU0Wo8DuBl8Z9FBsz5fNvziobnxRqBpjpHmQ1SV6/BC2nIrgb/RTTDfCMw1whQj
         dLuX3bIBJTUcmrz24ak5lE+q9WdyGwnAqdt6AyI5mWvBJXX0JDTvCw9RBXhIdW7mgYcS
         3TFtlH+K/+SsI9YlW5eMUWNNBFRr5UAhBSU42/DNbFBID9PcK+cqQAb9V7ewb7avDP6q
         IMMCXsCwNMJmv8067DCuskSb9UWiAjYRnQlnSk+GVm45dCfNwt+EmdqUtG/I90Bo3P2l
         k61Mb4OFE3X9AYyIhQAt/q43pCcl4HRaMJPS5yPp3VxNKal4DeX9q5T9/vpdcHKbYaOG
         XkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgMlEQMwUkkD6KJWmCk8NsuP2RHpzUCaGkYxuaH4YTc=;
        b=N1LWoM8IZt9+iCLELcD9kSPbeObjFj4cJnRHnoNa1OT/71ngLHfU6W0tNV9ZQdFsVG
         RpHTzyLg9qlvOJE4JxSEXTo0s+5Znrg/vLHL1a+TlEQi7fSovZMHbvEb1Qa6hCQKB4qg
         Uf5j/LS2E0MfdB9TCW6uN7b76ArlVDCALmG5BI4YwPQoQAWePIxsaGZS0KAGOcT5/Vq5
         bsce+2Jxwa0N8e8LvkAz4X5OVEC/+LYrm6A96fQRU/U0YCvf1qOV23oU+aqfcR2kxLhS
         v9qqtWBaHZC6wW/PVdWxMMSvRKhP5Yg1TgVl4Bi3hmSNbxIScVLxCRFpKfBtmn/SylDy
         qOKQ==
X-Gm-Message-State: AOAM532bv2cRpXlnN2VNrk2nSTQaVHeEikmsybincOMYG97DTgxwi3Tm
        LdpIx9qtDVIrcGjO8Y/CNu1sODTsM0ODHPsMsZQXLQ==
X-Google-Smtp-Source: ABdhPJyaepeWrP1v+M/ADiUbWr4ekoIQPI5jggNjY05iEVcVIFiSfpAL6sGe8s8jBsSHmCEKcZWbns5tqxn0nE8Uqlc=
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr18395649wmg.37.1609127655318;
 Sun, 27 Dec 2020 19:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20201208132835.6151-1-will@kernel.org> <20201208132835.6151-9-will@kernel.org>
In-Reply-To: <20201208132835.6151-9-will@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 27 Dec 2020 19:54:04 -0800
Message-ID: <CAJuCfpGdG4Wmrb-pVPTFuqWkfMKTkhL0f-_Dv6M-0M7VDnW5Bw@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 5:29 AM Will Deacon <will@kernel.org> wrote:
>
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
>
> Modify guarantee_online_cpus() to take task_cpu_possible_mask() into
> account when trying to find a suitable set of online CPUs for a given
> task. This will avoid passing an invalid mask to set_cpus_allowed_ptr()
> during ->attach() and will subsequently allow the cpuset hierarchy to be
> taken into account when forcefully overriding the affinity mask for a
> task which requires migration to a compatible CPU.
>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/cpuset.h |  3 ++-
>  kernel/cgroup/cpuset.c | 33 +++++++++++++++++++--------------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 04c20de66afc..414a8e694413 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -15,6 +15,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/nodemask.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_context.h>
>  #include <linux/jump_label.h>
>
>  #ifdef CONFIG_CPUSETS
> @@ -184,7 +185,7 @@ static inline void cpuset_read_unlock(void) { }
>  static inline void cpuset_cpus_allowed(struct task_struct *p,
>                                        struct cpumask *mask)
>  {
> -       cpumask_copy(mask, cpu_possible_mask);
> +       cpumask_copy(mask, task_cpu_possible_mask(p));
>  }
>
>  static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e970737c3ed2..d30febf1f69f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -372,18 +372,26 @@ static inline bool is_in_v2_mode(void)
>  }
>
>  /*
> - * Return in pmask the portion of a cpusets's cpus_allowed that
> - * are online.  If none are online, walk up the cpuset hierarchy
> - * until we find one that does have some online cpus.
> + * Return in pmask the portion of a task's cpusets's cpus_allowed that
> + * are online and are capable of running the task.  If none are found,
> + * walk up the cpuset hierarchy until we find one that does have some
> + * appropriate cpus.
>   *
>   * One way or another, we guarantee to return some non-empty subset
>   * of cpu_online_mask.
>   *
>   * Call with callback_lock or cpuset_mutex held.
>   */
> -static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
> +static void guarantee_online_cpus(struct task_struct *tsk,
> +                                 struct cpumask *pmask)
>  {
> -       while (!cpumask_intersects(cs->effective_cpus, cpu_online_mask)) {
> +       struct cpuset *cs = task_cs(tsk);
> +       const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
> +       if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))

IIUC, this represents the case when there is no online CPU that can
run this task. In this situation guarantee_online_cpus() will return
an online CPU which can't run the task (because we ignore
possible_mask). I don't think this can be considered a valid fallback
path. However I think patch [13/15] ensures that we never end up in
this situation by disallowing to offline the last 32-bit capable CPU.
If that's true then maybe the patches can be reordered so that [13/15]
comes before this one and this condition can be treated as a bug here?


> +               cpumask_copy(pmask, cpu_online_mask);
> +
> +       while (!cpumask_intersects(cs->effective_cpus, pmask)) {
>                 cs = parent_cs(cs);
>                 if (unlikely(!cs)) {
>                         /*
> @@ -393,11 +401,10 @@ static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
>                          * cpuset's effective_cpus is on its way to be
>                          * identical to cpu_online_mask.
>                          */
> -                       cpumask_copy(pmask, cpu_online_mask);
>                         return;
>                 }
>         }
> -       cpumask_and(pmask, cs->effective_cpus, cpu_online_mask);
> +       cpumask_and(pmask, pmask, cs->effective_cpus);
>  }
>
>  /*
> @@ -2176,15 +2183,13 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>
>         percpu_down_write(&cpuset_rwsem);
>
> -       /* prepare for attach */
> -       if (cs == &top_cpuset)
> -               cpumask_copy(cpus_attach, cpu_possible_mask);
> -       else
> -               guarantee_online_cpus(cs, cpus_attach);
> -
>         guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>
>         cgroup_taskset_for_each(task, css, tset) {
> +               if (cs != &top_cpuset)
> +                       guarantee_online_cpus(task, cpus_attach);
> +               else
> +                       cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
>                 /*
>                  * can_attach beforehand should guarantee that this doesn't
>                  * fail.  TODO: have a better way to handle failure here
> @@ -3280,7 +3285,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>
>         spin_lock_irqsave(&callback_lock, flags);
>         rcu_read_lock();
> -       guarantee_online_cpus(task_cs(tsk), pmask);
> +       guarantee_online_cpus(tsk, pmask);
>         rcu_read_unlock();
>         spin_unlock_irqrestore(&callback_lock, flags);
>  }
> --
> 2.29.2.576.ga3fc446d84-goog
>
