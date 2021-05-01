Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615303706ED
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhEAKqw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhEAKqv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 06:46:51 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C24C06138C
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 03:46:01 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id e9-20020a4ada090000b02901f91091e5acso208796oou.0
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dER8WYp4YE8meKl/Etoz17guMOCTTHD//33hX1fp/nc=;
        b=IMwXPYTHlYOoD5VsAO4X3ijzUYSqjzTkipTMXSJAa4Ec/Z91vBXmKGZpM1LZjGeTfi
         A2o8QHkEc0HHPO6HcyVHnWNCcxhjLYl8fWYOkaGxOeT4X9gjXlrseEIRapNH06M1B6X4
         qgtgd/nxRmuOBVpKTW2uycdyqLuBlpjyjlEjbIeY+HjuqazrkOFRppFAukWodMJjucbM
         bS37OSIMjLyekZH3aBAYORVOonEqHQJMQIxfJsX8ODMCx0YvN3l6Kgrsb+eVbO+XZehq
         2cPOsLocLN9qX2CesXNgiS8rbKeuUPpSsvSo9ixyAf/4Fgs9AhVmnYqvR6B5Spba4fhd
         hucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dER8WYp4YE8meKl/Etoz17guMOCTTHD//33hX1fp/nc=;
        b=FqQlj5hWWi3ve+Lkrvbtvm5lfUS0RSJVrZn74JBTfrV0WuN17Gtxq6UxJu0nOBhDY4
         vhozBdCkbMoJr8w55aITOuLBPGdL69MbCQ0nAaEp7f+goXSSLUaHj6an81EbEs2t0MNA
         lifL5+qgqpdEhnPiLowdmifKQK8EDyH6cYYcWaz69K4n/6mmIKCM0Hc94OhymHF1gwDD
         HHmldVvVkcpPYdWsyee1CO8cv6MLiHtaf1l//waLkCT761VXZyY3jILZlc8IvgzGoYxd
         DvlAW407vIpDbwzBzfTnwYOO+FCnma265QrBEnk1cwU7Ni7phSP5NxG7idWbvI3BDssQ
         +jTg==
X-Gm-Message-State: AOAM530/Agy3hjPEeLbp/Vfw5d/IT4z21c0O7A6LyJvrpy/WZ4U4HLLZ
        LoecR/X5e7z6rxax3JA7TjzjnHyUJHWNJPuUw7Ix4Q==
X-Google-Smtp-Source: ABdhPJwyZTajujDBWMyTAvPK3N6DFZiw8JB3v4N76NVXdHr3uBrbQQQI6dyNnFx9xWQBWMw406Q9oqavmAutfHaQ36Q=
X-Received: by 2002:a4a:3511:: with SMTP id l17mr7963113ooa.36.1619865960952;
 Sat, 01 May 2021 03:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m17dkjqqxz.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m17dkjqqxz.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:45:49 +0200
Message-ID: <CANpmjNP32SRsnJBBfhjX63fcMyPAMgj8VDuMPdJXeut_+g2x_A@mail.gmail.com>
Subject: Re: [PATCH 6/3] signal: Factor force_sig_perf out of perf_sigtrap
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 1 May 2021 at 01:43, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Separate generating the signal from deciding it needs to be sent.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched/signal.h |  1 +
>  kernel/events/core.c         | 11 ++---------
>  kernel/signal.c              | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 7daa425f3055..1e2f61a1a512 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -318,6 +318,7 @@ int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
>
>  int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
>  int force_sig_pkuerr(void __user *addr, u32 pkey);
> +int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
>
>  int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
>  int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 928b166d888e..48ea8863183b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6394,8 +6394,6 @@ void perf_event_wakeup(struct perf_event *event)
>
>  static void perf_sigtrap(struct perf_event *event)
>  {
> -       struct kernel_siginfo info;
> -
>         /*
>          * We'd expect this to only occur if the irq_work is delayed and either
>          * ctx->task or current has changed in the meantime. This can be the
> @@ -6410,13 +6408,8 @@ static void perf_sigtrap(struct perf_event *event)
>         if (current->flags & PF_EXITING)
>                 return;
>
> -       clear_siginfo(&info);
> -       info.si_signo = SIGTRAP;
> -       info.si_code = TRAP_PERF;
> -       info.si_errno = event->attr.type;
> -       info.si_perf = event->attr.sig_data;
> -       info.si_addr = (void __user *)event->pending_addr;
> -       force_sig_info(&info);
> +       force_sig_perf((void __user *)event->pending_addr,
> +                      event->attr.type, event->attr.sig_data);
>  }
>
>  static void perf_pending_event_disable(struct perf_event *event)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 690921960d8b..5b1ad7f080ab 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1753,6 +1753,19 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
>  }
>  #endif
>
> +int force_sig_perf(void __user *pending_addr, u32 type, u64 sig_data)

s/pending_addr/addr/

to match force_sig_perf() declaration.

> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = SIGTRAP;
> +       info.si_errno = type;
> +       info.si_code  = TRAP_PERF;
> +       info.si_addr  = pending_addr;
> +       info.si_perf  = sig_data;
> +       return force_sig_info(&info);
> +}
> +
>  #if IS_ENABLED(SPARC)
>  int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
>  {
> --
> 2.30.1
