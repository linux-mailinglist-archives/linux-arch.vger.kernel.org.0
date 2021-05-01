Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841FF3706DC
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhEAKea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhEAKea (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 06:34:30 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFFC06174A
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 03:33:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso825003oti.2
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdaqve5YvScbUJtoSM3sAOiUvwbsjnuFfVlCkD3R0H0=;
        b=q3Ci9b94QU8r2Q3Wig3IeSiM+ThYbLMl4dvL+/l4LsWoTx7alyreZZogQkWUqGWXkF
         hSUH0cRc5zXXvqB7FAASko94scJ8HAMZPdG8FRZfawbyG3arYtBy1glACGdOVj8DGqud
         j1e+aVpRRG3OziwM+0XDK1iyu2RBGv01I3/mEcW9+hy/+fgGEWDWdfDqBaW4lJD0wYDL
         uAPCYsNY+tTCZNv+AYzXROipzG+rTgfc0TriwWpW2UsDztX8FW5XjiEWnJqhPyspEGHg
         Ri5BJPh1TeDZwlPlNUV7r92O1PH20djtccFJQBBqtY0HKwmk+uIA42UEdTPGBBzJq51D
         DWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdaqve5YvScbUJtoSM3sAOiUvwbsjnuFfVlCkD3R0H0=;
        b=ifjpFkK8VI2G2IBHIdYpp7Zb5v6LMIm+rJHcLtPh0dRvM8PxHYhGtaI/WU5vDBwl9C
         ERxExKrcwfNI6pLLeyC8iDa8a164R2hTtcHleAV4GRObnPha4Ja7Dfn1jZ2YDQRUiNNb
         wv9dtJid6SVz3qFrltUNacyydYLMlGEcv4MqGvwdzPIqMzoJishCDKPz1ApKyWz9i6qY
         plbLym/snOAxJLInMG2p+U+HDjREWxWI6YvUYFzx68r0rnkDIe5x5xEwbHtPStY04Hqe
         B05KVn36SzqfyrxqYGIz/gvRS4nLlXIFBgrToaXyZl095EdqVjKpy0mvSag/TRELAYAY
         DqOg==
X-Gm-Message-State: AOAM533th32q0ffEMBSXHVH56C0/V2ujREhE1RaNgxSpNtEn70QX/C8s
        hcqhr8+WkjxKM3nLtlWUGFdf3qIcIReIWozQqEEkTA==
X-Google-Smtp-Source: ABdhPJyW55H41iED7uLYdlb+Rgis6acnSJ21mQzhMKc1s2vSVVR0ZEv47Spe1B/kWGPPn8MrkjbHSkf/dFAeeI1qEv8=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr5442391ott.251.1619865218745;
 Sat, 01 May 2021 03:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1o8dvs7s7.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1o8dvs7s7.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:33:27 +0200
Message-ID: <CANpmjNNhd+qAy7tPSu=08_y-BZiowKigVkOh6HnXsxhWYuFpJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] signal: Implement SIL_FAULT_TRAPNO
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

On Sat, 1 May 2021 at 00:54, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Now that si_trapno is part of the union in _si_fault and available on
> all architectures, add SIL_FAULT_TRAPNO and update siginfo_layout to
> return SIL_FAULT_TRAPNO when si_trapno is actually used.
>
> Update the code that uses siginfo_layout to deal with SIL_FAULT_TRAPNO
> and have the same code ignore si_trapno in in all other cases.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/signalfd.c          |  7 ++-----
>  include/linux/signal.h |  1 +
>  kernel/signal.c        | 36 ++++++++++++++----------------------
>  3 files changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 040a1142915f..126c681a30e7 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -123,15 +123,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                  */
>         case SIL_FAULT:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -#ifdef __ARCH_SI_TRAPNO
> +       case SIL_FAULT_TRAPNO:
> +               new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_trapno = kinfo->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -#ifdef __ARCH_SI_TRAPNO
> -               new.ssi_trapno = kinfo->si_trapno;
> -#endif
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
>         case SIL_PERF_EVENT:
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 1e98548d7cf6..5160fd45e5ca 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -40,6 +40,7 @@ enum siginfo_layout {
>         SIL_TIMER,
>         SIL_POLL,
>         SIL_FAULT,
> +       SIL_FAULT_TRAPNO,
>         SIL_FAULT_MCEERR,
>         SIL_FAULT_BNDERR,
>         SIL_FAULT_PKUERR,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c3017aa8024a..7b2d61cb7411 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1194,6 +1194,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>         case SIL_TIMER:
>         case SIL_POLL:
>         case SIL_FAULT:
> +       case SIL_FAULT_TRAPNO:
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> @@ -2527,6 +2528,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>  {
>         switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
>         case SIL_FAULT:
> +       case SIL_FAULT_TRAPNO:
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> @@ -3206,6 +3208,12 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                         if ((sig == SIGBUS) &&
>                             (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
>                                 layout = SIL_FAULT_MCEERR;
> +                       else if (IS_ENABLED(ALPHA) &&
> +                                ((sig == SIGFPE) ||
> +                                 ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
> +                               layout = SIL_FAULT_TRAPNO;
> +                       else if (IS_ENABLED(SPARC) && (sig == SIGILL) && (si_code == ILL_ILLTRP))
> +                               layout = SIL_FAULT_TRAPNO;

The breakage isn't apparent here, but in later patches. These need to
become CONFIG_SPARC and CONFIG_ALPHA.


>                         else if ((sig == SIGSEGV) && (si_code == SEGV_BNDERR))
>                                 layout = SIL_FAULT_BNDERR;
>  #ifdef SEGV_PKUERR
> @@ -3317,30 +3325,22 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 break;
>         case SIL_FAULT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +               break;
> +       case SIL_FAULT_TRAPNO:
> +               to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_trapno = from->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_addr_lsb = from->si_addr_lsb;
>                 break;
>         case SIL_FAULT_BNDERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_lower = ptr_to_compat(from->si_lower);
>                 to->si_upper = ptr_to_compat(from->si_upper);
>                 break;
>         case SIL_FAULT_PKUERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_pkey = from->si_pkey;
>                 break;
>         case SIL_PERF_EVENT:
> @@ -3401,30 +3401,22 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 break;
>         case SIL_FAULT:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +               break;
> +       case SIL_FAULT_TRAPNO:
> +               to->si_addr = compat_ptr(from->si_addr);
>                 to->si_trapno = from->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_addr_lsb = from->si_addr_lsb;
>                 break;
>         case SIL_FAULT_BNDERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_lower = compat_ptr(from->si_lower);
>                 to->si_upper = compat_ptr(from->si_upper);
>                 break;
>         case SIL_FAULT_PKUERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_pkey = from->si_pkey;
>                 break;
>         case SIL_PERF_EVENT:
> --
> 2.30.1
