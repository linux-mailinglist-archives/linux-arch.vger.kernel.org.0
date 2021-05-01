Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4703706E6
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhEAKgb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhEAKga (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 06:36:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C976EC06174A
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 03:35:40 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id k25so702332oic.4
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTlI6z8vmo0ApTJAefLbFgioHKc+K8OTZdLV1HoxLWY=;
        b=Fi/veP+riYdnYBcroOoHdp0w+G4l6nXmceQSUisY40BGdG5FxBV2lqjZLmi9UPiQGl
         FLNlAMXUMZn6iwibpySUr4IHlAAL7+exI8JG2nrCVuZIYQuYvDo4mxmqbZbNzdGGRbLG
         /N9+FL1SiGxs82j8H3KOZMcwtSFpSJlDKCuiQVnN6ky9vW/gqJyy7oalcYNs/PfvyVws
         0ZRQM0ZwJ0sFo36fs4FULL6PJjA/FsXbApMg5EwZZMjI2MuT+OMGQ+Bt255jO6ZSo0WV
         tHBKD6FhjsbxqaPmgUlRlxuqxU0BbWcCiGy05YDsW0quVIJQtQID0uoWUHFNWD5rqLEM
         hygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTlI6z8vmo0ApTJAefLbFgioHKc+K8OTZdLV1HoxLWY=;
        b=LyOiKkKOsz8+pxc0dfYVmtl1PCXIlqKr7hUKSHRanGEuASaxEq5llVzdmVoDscmXQF
         pBgHnstTW1eM1q4dZN/HWCYuUS3In7oNFQG+rgtFUSuJHsJ5HU8bm12EgAY6j39wInLW
         PYXnYkGqC0QXwBwsvesks0A4HPRq78PQq8MOoD/HjK3oKQ0gbjEyxLGJWUvEkkIO2ZgO
         B32xR4Y0hiKd78jhJCv9csM4FUrabAqQ9plN1ZL2kBZYHXPfaCr/7qj9CyYA2jPvcrPH
         RlSGKUFZNHAdDtcCkbIgJRUokn7Z6UO/RO4IRRhjrDrt2dIYIlTyae3EmH2hGOz5hWwQ
         Ur8w==
X-Gm-Message-State: AOAM531QPMWm4q+zAeZDgGbLh7z5fKtHwvZYikeE6IXwBlTR/j6MTvZR
        hllFEU2nQjto65semYrlqhLqPqMdrwIDQlaAIMV44w==
X-Google-Smtp-Source: ABdhPJxg5qa1WjYAQ1qDJp1BRy7nPfKGZCWOqMpRWLkbpR5sXctS+omrS1cgEFBccSeNB0ph9iwT30GiV9lKLmQhX/I=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr7103289oif.121.1619865339999;
 Sat, 01 May 2021 03:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1czubqqz0.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1czubqqz0.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:35:28 +0200
Message-ID: <CANpmjNP_FSvVEWjoW3y5ihgnA2swisSXXiH5E2tOUmwoKFeSsg@mail.gmail.com>
Subject: Re: [PATCH 5/3] signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT
 for consistency
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
> It helps to know which part of the siginfo structure the siginfo_layout
> value is talking about.

Your Signed-off-by seems to be missing.

Otherwise,

Acked-by: Marco Elver <elver@google.com>


> ---
>  fs/signalfd.c          |  2 +-
>  include/linux/signal.h |  2 +-
>  kernel/signal.c        | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index e87e59581653..83130244f653 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -132,7 +132,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_perf = kinfo->si_perf;
>                 break;
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 5160fd45e5ca..ed896d790e46 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -44,7 +44,7 @@ enum siginfo_layout {
>         SIL_FAULT_MCEERR,
>         SIL_FAULT_BNDERR,
>         SIL_FAULT_PKUERR,
> -       SIL_PERF_EVENT,
> +       SIL_FAULT_PERF_EVENT,
>         SIL_CHLD,
>         SIL_RT,
>         SIL_SYS,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 0517ff950d38..690921960d8b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1198,7 +1198,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>         case SIL_SYS:
>                 ret = false;
>                 break;
> @@ -2553,7 +2553,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 ksig->info.si_addr = arch_untagged_si_addr(
>                         ksig->info.si_addr, ksig->sig, ksig->info.si_code);
>                 break;
> @@ -3242,7 +3242,7 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                                 layout = SIL_FAULT_PKUERR;
>  #endif
>                         else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
> -                               layout = SIL_PERF_EVENT;
> +                               layout = SIL_FAULT_PERF_EVENT;
>                 }
>                 else if (si_code <= NSIGPOLL)
>                         layout = SIL_POLL;
> @@ -3364,7 +3364,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> @@ -3440,7 +3440,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> --
> 2.30.1
>
