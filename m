Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC537477E
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhEER6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 13:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhEER6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 13:58:12 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71009C014AA1
        for <linux-arch@vger.kernel.org>; Wed,  5 May 2021 10:28:31 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso2368048otb.13
        for <linux-arch@vger.kernel.org>; Wed, 05 May 2021 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8AaP/lvxUNB3rrLU595zuxT9OqLnp3Rqgcgif6hwNc=;
        b=EXvGc2UUZ3jUpb3Mwrf260u6rm16633aBwEdjBwqCrOfTh38bYF1BbWc//6xVUJvZ3
         nimI0AcDXVhX2oYnadpTsCdbOEop+LvzedwfPfGJVqBo5BE/0Sp03D6cHPyOvGkH1GnI
         VpoRsAp8UWYFv5j/kewfavhy8fJ2EduYkqwLL+Z9gAaCSjyYKS4PyE5eZWPs26BxIgQV
         B6acvGhDucvInX/WhYmBch4U7yUGAIMTMBc4Bc7NyhUl8NxHp74egkERDFAnnM8PzU/n
         xiaFPEJRJe4fYS+7kgqwcc9F9xq/DVORC7v9fLpMqsesbQJ8U7GYhVmnxc8ZTqhoHQEu
         wzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8AaP/lvxUNB3rrLU595zuxT9OqLnp3Rqgcgif6hwNc=;
        b=XESy4QNDrCCv46KExT/pjosiGN1tN18ZCwGrCYGZfrQ60VA3s1qTYwPYOJFebdGif7
         vDdjW8Uqr5BxKByXVwFtams2lPqS6nKajoCwgXTh863OIk7iUPwkp5kkfGbp3VDWaga+
         1J+Sc9egf5zTOCv7hogVHsxs5DSw1Mos+qOj+EtPZ5zou2DxwsQ5HU8J3dlkF0uu/6sJ
         Lnp6vg0InphvwcxCsf48PDnzU2fpXLS3QRkjFsKsNQe8emVmAmP/TjfxNzDolovNp0rj
         KKwfJDrZJfikysVpohyyV9kY+3NGr/WUR7RBrregQS8DEVsFm+DLGYYTChUJ7xkp5Dff
         Hq1A==
X-Gm-Message-State: AOAM532x/XuG8jNyR5qQPOsanPAUss9XDgyf3bZfgKPIfaIsvGdToEoo
        6Ou0xScG98d77s1EOncU3Eb8bfjBuf1fwzJXHSuKzQ==
X-Google-Smtp-Source: ABdhPJwBfePd37x8jcZMNg4h5PBr/URe0Ve8N2lapM4qoprsvsOneJZhWyxNhKww2Z/imlLAUs5fJ+ZS5AuUF+K1Bdc=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr23875287ott.251.1620235710813;
 Wed, 05 May 2021 10:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-11-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-11-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:27:00 +0200
Message-ID: <CANpmjNOBtpMad-mn1JE1LmkEURtc0RJX-9LNXvJPMfDpSC3ASw@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] signal: Deliver all of the siginfo perf data in _perf
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
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

On Wed, 5 May 2021 at 16:11, Eric W. Beiderman <ebiederm@xmission.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Don't abuse si_errno and deliver all of the perf data in _perf member
> of siginfo_t.
>
> The data field in the perf data structures in a u64 to allow a pointer
> to be encoded without needed to implement a 32bit and 64bit version of
> the same structure.  There already exists a 32bit and 64bit versions
> siginfo_t, and the 32bit version can not include a 64bit member as it
> only has 32bit alignment.  So unsigned long is used in siginfo_t
> instead of a u64 as unsigned long can encode a pointer on all
> architectures linux supports.

Since there is no functional change (we already had the unsigned long
here), the explanation made me think there was a change in that area
(but there wasn't). (Can leave as-is, but a "Note: " or similar if you
deem it appropriate.)

> v1: https://lkml.kernel.org/r/m11rarqqx2.fsf_-_@fess.ebiederm.org
> v2: https://lkml.kernel.org/r/20210503203814.25487-10-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!


> ---
>  arch/arm/kernel/signal.c                      |  3 ++-
>  arch/arm64/kernel/signal.c                    |  3 ++-
>  arch/arm64/kernel/signal32.c                  |  3 ++-
>  arch/sparc/kernel/signal32.c                  |  3 ++-
>  arch/sparc/kernel/signal_64.c                 |  3 ++-
>  arch/x86/kernel/signal_compat.c               |  6 ++++--
>  fs/signalfd.c                                 |  3 ++-
>  include/linux/compat.h                        |  5 ++++-
>  include/uapi/asm-generic/siginfo.h            |  8 +++++--
>  include/uapi/linux/signalfd.h                 |  4 ++--
>  kernel/signal.c                               | 21 ++++++++++++-------
>  .../selftests/perf_events/sigtrap_threads.c   | 12 +++++------
>  12 files changed, 47 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 643bcb0f091b..f3800c0f428b 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -757,7 +757,8 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)      == 0x10);
>  static_assert(offsetof(siginfo_t, si_lower)    == 0x14);
>  static_assert(offsetof(siginfo_t, si_upper)    == 0x18);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x14);
> -static_assert(offsetof(siginfo_t, si_perf)     == 0x10);
> +static_assert(offsetof(siginfo_t, si_perf_data)        == 0x10);
> +static_assert(offsetof(siginfo_t, si_perf_type)        == 0x14);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x0c);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x10);
>  static_assert(offsetof(siginfo_t, si_call_addr)        == 0x0c);
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index ad4bd27fc044..b3978b468bd4 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -1005,7 +1005,8 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)    == 0x18);
>  static_assert(offsetof(siginfo_t, si_lower)    == 0x20);
>  static_assert(offsetof(siginfo_t, si_upper)    == 0x28);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x20);
> -static_assert(offsetof(siginfo_t, si_perf)     == 0x18);
> +static_assert(offsetof(siginfo_t, si_perf_data)        == 0x18);
> +static_assert(offsetof(siginfo_t, si_perf_type)        == 0x20);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x10);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x18);
>  static_assert(offsetof(siginfo_t, si_call_addr)        == 0x10);
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index ee6c7484e130..d3be01c46bec 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -489,7 +489,8 @@ static_assert(offsetof(compat_siginfo_t, si_addr_lsb)       == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_lower)     == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_upper)     == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_pkey)      == 0x14);
> -static_assert(offsetof(compat_siginfo_t, si_perf)      == 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_perf_data) == 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_perf_type) == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_band)      == 0x0c);
>  static_assert(offsetof(compat_siginfo_t, si_fd)                == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_call_addr) == 0x0c);
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index 5573722e34ad..4276b9e003ca 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -778,6 +778,7 @@ static_assert(offsetof(compat_siginfo_t, si_addr_lsb)       == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_lower)     == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_upper)     == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_pkey)      == 0x14);
> -static_assert(offsetof(compat_siginfo_t, si_perf)      == 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_perf_data) == 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_perf_type) == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_band)      == 0x0c);
>  static_assert(offsetof(compat_siginfo_t, si_fd)                == 0x10);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index a69a78984c36..cea23cf95600 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -588,6 +588,7 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)      == 0x18);
>  static_assert(offsetof(siginfo_t, si_lower)    == 0x20);
>  static_assert(offsetof(siginfo_t, si_upper)    == 0x28);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x20);
> -static_assert(offsetof(siginfo_t, si_perf)     == 0x18);
> +static_assert(offsetof(siginfo_t, si_perf_data)        == 0x18);
> +static_assert(offsetof(siginfo_t, si_perf_type)        == 0x20);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x10);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x14);
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index c9601f092a1e..b52407c56000 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -147,8 +147,10 @@ static inline void signal_compat_build_tests(void)
>         BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
>         BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
>
> -       BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
> -       BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
> +       BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
> +       BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
> +       BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
> +       BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
>
>         CHECK_CSI_OFFSET(_sigpoll);
>         CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 83130244f653..335ad39f3900 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -134,7 +134,8 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -               new.ssi_perf = kinfo->si_perf;
> +               new.ssi_perf_type = kinfo->si_perf_type;
> +               new.ssi_perf_data = kinfo->si_perf_data;
>                 break;
>         case SIL_CHLD:
>                 new.ssi_pid    = kinfo->si_pid;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 6af7bef15e94..a27fffaae121 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -236,7 +236,10 @@ typedef struct compat_siginfo {
>                                         u32 _pkey;
>                                 } _addr_pkey;
>                                 /* used when si_code=TRAP_PERF */
> -                               compat_ulong_t _perf;
> +                               struct {
> +                                       compat_ulong_t _data;
> +                                       u32 _type;
> +                               } _perf;
>                         };
>                 } _sigfault;
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 3503282021aa..3ba180f550d7 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -96,7 +96,10 @@ union __sifields {
>                                 __u32 _pkey;
>                         } _addr_pkey;
>                         /* used when si_code=TRAP_PERF */
> -                       unsigned long _perf;
> +                       struct {
> +                               unsigned long _data;
> +                               __u32 _type;
> +                       } _perf;
>                 };
>         } _sigfault;
>
> @@ -159,7 +162,8 @@ typedef struct siginfo {
>  #define si_lower       _sifields._sigfault._addr_bnd._lower
>  #define si_upper       _sifields._sigfault._addr_bnd._upper
>  #define si_pkey                _sifields._sigfault._addr_pkey._pkey
> -#define si_perf                _sifields._sigfault._perf
> +#define si_perf_data   _sifields._sigfault._perf._data
> +#define si_perf_type   _sifields._sigfault._perf._type
>  #define si_band                _sifields._sigpoll._band
>  #define si_fd          _sifields._sigpoll._fd
>  #define si_call_addr   _sifields._sigsys._call_addr
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
> index 49560ceac048..7fec9d1c5b11 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1758,11 +1758,13 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
>         struct kernel_siginfo info;
>
>         clear_siginfo(&info);
> -       info.si_signo = SIGTRAP;
> -       info.si_errno = type;
> -       info.si_code  = TRAP_PERF;
> -       info.si_addr  = addr;
> -       info.si_perf  = sig_data;
> +       info.si_signo     = SIGTRAP;
> +       info.si_errno     = 0;
> +       info.si_code      = TRAP_PERF;
> +       info.si_addr      = addr;
> +       info.si_perf_data = sig_data;
> +       info.si_perf_type = type;
> +
>         return force_sig_info(&info);
>  }
>
> @@ -3380,7 +3382,8 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -               to->si_perf = from->si_perf;
> +               to->si_perf_data = from->si_perf_data;
> +               to->si_perf_type = from->si_perf_type;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid = from->si_pid;
> @@ -3456,7 +3459,8 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 break;
>         case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = compat_ptr(from->si_addr);
> -               to->si_perf = from->si_perf;
> +               to->si_perf_data = from->si_perf_data;
> +               to->si_perf_type = from->si_perf_type;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid    = from->si_pid;
> @@ -4639,7 +4643,8 @@ static inline void siginfo_buildtime_checks(void)
>         CHECK_OFFSET(si_lower);
>         CHECK_OFFSET(si_upper);
>         CHECK_OFFSET(si_pkey);
> -       CHECK_OFFSET(si_perf);
> +       CHECK_OFFSET(si_perf_data);
> +       CHECK_OFFSET(si_perf_type);
>
>         /* sigpoll */
>         CHECK_OFFSET(si_band);
> diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
> index 78ddf5e11625..fde123066a8c 100644
> --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> @@ -164,8 +164,8 @@ TEST_F(sigtrap_threads, enable_event)
>         EXPECT_EQ(ctx.signal_count, NUM_THREADS);
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
> -       EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -183,8 +183,8 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
>         EXPECT_EQ(ctx.signal_count, NUM_THREADS);
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
> -       EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -203,8 +203,8 @@ TEST_F(sigtrap_threads, signal_stress)
>         EXPECT_EQ(ctx.signal_count, NUM_THREADS * ctx.iterate_on);
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
> -       EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.30.1
>
