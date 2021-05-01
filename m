Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1043706F3
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEAKs0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 06:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhEAKsY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 06:48:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED72C06138D
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 03:47:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso837202otn.3
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dogrgVKo+eUYaN7DWgb4gh1G07uaLoO2fYWTRss9iAI=;
        b=RXd7Pa84UaPsvv1WQUd+2tNTlRkVdTPn98cB2vGqVnBlHOjczQJiPboEyiACRXd3Nn
         /wkaBA65VO+ykvAgkTl+/bnxgAJMIUKivUCglsdMkib4o1v0zJ/PljiH813uGRna55Fi
         LMVWNlYGYBUQFgjmvURMSs5dt7oi8W4DG0Wel9bNFRqFBbBaGJSpjqfCqrC37oPUDvhg
         Ba2J5y6CWKlu5D0YfBzwY/pzHuvKBa12lhhBFkquRd9ciO/txWOuIfpSgxVY0UU6LtS7
         z+v1T143HIaSFDe4noB+sC1Tqu3fQeGduSkkBdJixWTCcEuZXvPObrZwHQOGyRQzhuN8
         PpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dogrgVKo+eUYaN7DWgb4gh1G07uaLoO2fYWTRss9iAI=;
        b=GbMYFS/9hCrvUty3svQ9XAwfx65WFT4WxO41W5KpzoBNhk0DjNDnzALX3Mr9t01vyh
         pcWGMPHkdwcf0zXlLqYk6mDpAa0KhRipqPHPdNMFRh2q1pSo9Ss4ynoQP6NkPu1oGcUI
         v9PPGtlhCKuEzegbD/KkZim2ge0l9eC+NeGrs2vZE7xM+2XrlRNjPPM+ZBVr07mLTdqG
         vQ4HzM/dvGtgM7mjvoqvkxrqEzb1TqPA8bEmFUKcvdBKTkbGHXfIona+PGpEdYm3ZrD9
         K984SMQOXt6pEWRrG9kXDQ7N6SfkNJltuldw72IzWVlCxMSN6//66ZvWH7TAVCkTQrIC
         UR1Q==
X-Gm-Message-State: AOAM532I0MoSX2Qrif+7q+wPmE54j5GjC6KaHTxdcfNPugDsdLbA5sTN
        sfTtSxrDJyrHf/yBWjKPpZ4b1xLXWL3A+U30ScTYlA==
X-Google-Smtp-Source: ABdhPJxf9tNMnMy95XZVyUjwb6AxqIVu7cewiAjcsACV1ZPyR5WFU+FKDncVd37TMqICz+WpXpWEYolxGFRLTcwXPJc=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr7373221otn.233.1619866052694;
 Sat, 01 May 2021 03:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m11rarqqx2.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m11rarqqx2.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:47:21 +0200
Message-ID: <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
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

On Sat, 1 May 2021 at 01:44, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Don't abuse si_errno and deliver all of the perf data in si_perf.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Thank you for the fix, this looks cleaner.

Just note that this patch needs to include updates to
tools/testing/selftests/perf_events. This should do it:
>  sed -i 's/si_perf/si_perf.data/g; s/si_errno/si_perf.type/g' tools/testing/selftests/perf_events/*.c

Subject: s/perf_data/perf data/ ?

For uapi, need to switch to __u32, see below.

>  fs/signalfd.c                      |  3 ++-
>  include/linux/compat.h             |  5 ++++-
>  include/uapi/asm-generic/siginfo.h |  5 ++++-
>  include/uapi/linux/signalfd.h      |  4 ++--
>  kernel/signal.c                    | 18 +++++++++++-------
>  5 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 83130244f653..9686af56f073 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -134,7 +134,8 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -               new.ssi_perf = kinfo->si_perf;
> +               new.ssi_perf_type = kinfo->si_perf.type;
> +               new.ssi_perf_data = kinfo->si_perf.data;
>                 break;
>         case SIL_CHLD:
>                 new.ssi_pid    = kinfo->si_pid;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 24462ed63af4..0726f9b3a57c 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -235,7 +235,10 @@ typedef struct compat_siginfo {
>                                         u32 _pkey;
>                                 } _addr_pkey;
>                                 /* used when si_code=TRAP_PERF */
> -                               compat_ulong_t _perf;
> +                               struct {
> +                                       compat_ulong_t data;
> +                                       u32 type;
> +                               } _perf;
>                         };
>                 } _sigfault;
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 2abdf1d19aad..19b6310021a3 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -90,7 +90,10 @@ union __sifields {
>                                 __u32 _pkey;
>                         } _addr_pkey;
>                         /* used when si_code=TRAP_PERF */
> -                       unsigned long _perf;
> +                       struct {
> +                               unsigned long data;
> +                               u32 type;

This needs to be __u32.


> +                       } _perf;
>                 };
>         } _sigfault;
>
> diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
> index 7e333042c7e3..e78dddf433fc 100644
> --- a/include/uapi/linux/signalfd.h
> +++ b/include/uapi/linux/signalfd.h
> @@ -39,8 +39,8 @@ struct signalfd_siginfo {
>         __s32 ssi_syscall;
>         __u64 ssi_call_addr;
>         __u32 ssi_arch;
> -       __u32 __pad3;
> -       __u64 ssi_perf;
> +       __u32 ssi_perf_type;
> +       __u64 ssi_perf_data;
>
>         /*
>          * Pad strcture to 128 bytes. Remember to update the
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 5b1ad7f080ab..cb3574b7319c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1758,11 +1758,13 @@ int force_sig_perf(void __user *pending_addr, u32 type, u64 sig_data)
>         struct kernel_siginfo info;
>
>         clear_siginfo(&info);
> -       info.si_signo = SIGTRAP;
> -       info.si_errno = type;
> -       info.si_code  = TRAP_PERF;
> -       info.si_addr  = pending_addr;
> -       info.si_perf  = sig_data;
> +       info.si_signo     = SIGTRAP;
> +       info.si_errno     = 0;
> +       info.si_code      = TRAP_PERF;
> +       info.si_addr      = pending_addr;
> +       info.si_perf.data = sig_data;
> +       info.si_perf.type = type;
> +
>         return force_sig_info(&info);
>  }
>
> @@ -3379,7 +3381,8 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -               to->si_perf = from->si_perf;
> +               to->si_perf.data = from->si_perf.data;
> +               to->si_perf.type = from->si_perf.type;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid = from->si_pid;
> @@ -3455,7 +3458,8 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = compat_ptr(from->si_addr);
> -               to->si_perf = from->si_perf;
> +               to->si_perf.data = from->si_perf.data;
> +               to->si_perf.type = from->si_perf.type;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid    = from->si_pid;
> --
> 2.30.1
