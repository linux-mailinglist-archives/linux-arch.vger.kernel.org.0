Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F53706E1
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhEAKe6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhEAKe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 06:34:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304FC06174A
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 03:34:05 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso812276otv.6
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCan+6xptMFqGkbIIPn1nwIIm9+SRi9i6mWKGsgGhAU=;
        b=UWGMH/nVDvcINlx4QrLJbQfDpg7ZCA/4MH41cC10w5jRUrFQhUVXZsLqvqHeGW19qW
         xhx0Odv3ZQ/ExTt8yWnNe7VP55kAeS3Op0WY5Csu31R7T0Wi2rQpER7XhlT5y6XTFNE3
         BVueuV0oPH/OGvQMGG/PrivMOEMBYTzB82jBNK8dbdKF0yLWvik21rliXWNGLTIgNPlL
         wdY0Aj5OQ55kFq6QLP0RhuBUt/a2T24B/FiC488jTTIBYlkQG1bPn53xCS/SrBB9XixT
         V1L6RX0f0+bW9q/P55FWVhQFoZZgWW/y45rdLwfzurJe17yAFBAHrBU6vPzkZg7z7awF
         5Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCan+6xptMFqGkbIIPn1nwIIm9+SRi9i6mWKGsgGhAU=;
        b=oJC/YS471drs95MRLlC5O0sd7k/7JnK5rfEoFpAhf1c5ZPftLNTfkbE+t5ez1ndDeZ
         s/5DTe/rvMxVrA8KgMG+8B0kLT7vgGFtodFTHOmR7r6V9/aNJu/tykJ97YCqoGCOaScE
         fM25DjG9Rfkm3CpIbvZw90UIebT6YgDBEDlASyXQrlAgzu/LGIlXubyXvY6Nn7AF4iYp
         ffxHb+VeGIMQEgaAJSk9DlZebtpB97HL1SnQSqbrs4BTEX9WmP+2M72AySi8AH7L0nLn
         A7TuWpksd/k4RCRhKYYJA9i+aUE3VpZR/pOSdMK7iXAQEUmS1Pm6dirzq4OWVRXFmhBk
         d+ow==
X-Gm-Message-State: AOAM531VK3GFOsahFQPin5PLAitnqR6PdFe9x9unBgq192HiXq1KOT/I
        0K87hks6vfnxPX6Oju50zxvAqn4fshAJsPvvJYKHcA==
X-Google-Smtp-Source: ABdhPJy1MvY2a7/kycfqy83Ks3Lj9IAWBx4Z0v17e+oXLsYz+vYG3fbuw+w7d3/8DHojuQ+i2zmKcGwBxHfgSotrgpg=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr7228167otk.17.1619865244678;
 Sat, 01 May 2021 03:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1eeers7q7.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1eeers7q7.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 12:33:53 +0200
Message-ID: <CANpmjNPztuttUqN3=Z4r7GPCyGu76CWNK-oYhxtByAx5OP_2rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] signal: Use dedicated helpers to send signals with
 si_trapno set
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

On Sat, 1 May 2021 at 00:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Now that si_trapno is no longer expected to be present for every fault
> reported using siginfo on alpha and sparc remove the trapno parameter
> from force_sig_fault, force_sig_fault_to_task and send_sig_fault.
>
> Add two new helpers force_sig_fault_trapno and send_sig_fault_trapno
> for those signals where trapno is expected to be set.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/alpha/kernel/osf_sys.c      |  2 +-
>  arch/alpha/kernel/signal.c       |  4 +--
>  arch/alpha/kernel/traps.c        | 24 ++++++++---------
>  arch/alpha/mm/fault.c            |  4 +--
>  arch/sparc/kernel/process_64.c   |  2 +-
>  arch/sparc/kernel/sys_sparc_32.c |  2 +-
>  arch/sparc/kernel/sys_sparc_64.c |  2 +-
>  arch/sparc/kernel/traps_32.c     | 22 ++++++++--------
>  arch/sparc/kernel/traps_64.c     | 44 ++++++++++++++------------------
>  arch/sparc/kernel/unaligned_32.c |  2 +-
>  arch/sparc/mm/fault_32.c         |  2 +-
>  arch/sparc/mm/fault_64.c         |  2 +-
>  include/linux/sched/signal.h     | 12 +++------
>  kernel/signal.c                  | 41 +++++++++++++++++++++--------
>  14 files changed, 88 insertions(+), 77 deletions(-)

This still breaks sparc64:

> sparc64-linux-gnu-ld: arch/sparc/kernel/traps_64.o: in function `bad_trap':
> (.text+0x2a4): undefined reference to `force_sig_fault_trapno'

[...]
> +#if IS_ENABLED(SPARC)

This should be 'IS_ENABLED(CONFIG_SPARC)'.

> +int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return force_sig_info(&info);
> +}
> +#endif
> +
> +#if IS_ENABLED(ALPHA)

CONFIG_ALPHA


> +int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
> +                         struct task_struct *t)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return send_sig_info(info.si_signo, &info, t);
> +}
> +#endif
> +
>  /* For the crazy architectures that include trap information in
>   * the errno field, instead of an actual errno value.
>   */
> --
> 2.30.1
>
