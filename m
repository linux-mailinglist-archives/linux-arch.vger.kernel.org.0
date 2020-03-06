Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3617C27D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFQEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 11:04:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50378 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFQEs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 11:04:48 -0500
Received: by mail-pj1-f67.google.com with SMTP id nm6so1242310pjb.0
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7u/E+2AE1Gw8zduCp3vcJIoh4aQz/xJ780ourlTfM+A=;
        b=sN76knTsDhriUkG19wLELNwpyVi+/rbXIP2T87WGT1QGWcHmT/BsuaL6OW6GEmiWEi
         q5ii+OqqpNIHkikM2a8G+b9OxV3Art09X0BxGlQZvJjOSxf+BVFuiw2UMR7mIzAmkgh8
         mz8ForE+eeOf63yQ1EHnALRKGm07hrTjMbY6qzP/Nl0W5aF9uy1AEdBeOx6CUuzTeGBy
         sga/FVDBOZuNQoL7/UGISLyz3lTdZes0c3lMB1QNcuKdiyJuhwIxEZpSFuDoNzWp2o4E
         xE7eh9Ung0ro/8DiWdshMpi2l7QEPY1Okauooxkumnpc6Q/8ceBUSHwD1PaUXdozbXnz
         QNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7u/E+2AE1Gw8zduCp3vcJIoh4aQz/xJ780ourlTfM+A=;
        b=D2IUx7mIH3zmmLjX7jphUwPgPD1mLOxSreHudXHUbOejKkeFVVE8UoNb1tsPxJk0yd
         8NQDjRE5gQcYgi3BdDXie6pgUwYCkGbqzG0xdozgNvIT3QFWT68fmQog9zllM8PLiboC
         gHnoqT1uMDJFEBilxirpNkIhT0h7j/rzKQ/e+YwDVRJU/caxXbUnVSdN8RDLFbvWRcXg
         eMLF+wAksuFBNKZ29kQz4kydrzavsjHOlyUCBwv2M9gRJPzsv2Fx2sMyhh2tT7nxwELR
         7ohaKx1DPs8DxV2lv3/x3JsYA88a9MEGKlZ68FNOGcPdanSl+T0Kat32FHxvQqbQY6JD
         pPAw==
X-Gm-Message-State: ANhLgQ0okofJG0BSOR05z8+fbc5k6sPEuAdvuMgi1LiBPJ3Jg8UZojwd
        VNAiJg/Faxaw/K+x4vBgdKte/Q==
X-Google-Smtp-Source: ADFU+vs0+LkE+RZ+zIa1aRnqFAH4IvTx1EaCOOROWJ2RzqEoBqoGr+Boew1V0hsFwbpMd9sRC9RV1w==
X-Received: by 2002:a17:90a:9f93:: with SMTP id o19mr4348094pjp.76.1583510687333;
        Fri, 06 Mar 2020 08:04:47 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:9126:9a7f:9c94:9d63? ([2601:646:c200:1ef2:9126:9a7f:9c94:9d63])
        by smtp.gmail.com with ESMTPSA id p2sm18206125pfb.41.2020.03.06.08.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:04:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 00/20] Introduce common headers
Date:   Fri, 6 Mar 2020 08:04:44 -0800
Message-Id: <3278D604-28F1-47A1-BAB8-D8EB439995E8@amacapital.net>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>
In-Reply-To: <20200306133242.26279-1-vincenzo.frascino@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Mar 6, 2020, at 5:32 AM, Vincenzo Frascino <vincenzo.frascino@arm.com> w=
rote:
>=20
> =EF=BB=BFBack in July last year we started having a problem in building co=
mpat
> vDSOs on arm64 [1] [2] that was not present when the arm64 porting to
> the Unified vDSO was done. In particular when the compat vDSO on such
> architecture is built with gcc it generates the warning below:
>=20
> In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
>                 from ./include/linux/thread_info.h:38,
>                 from ./arch/arm64/include/asm/preempt.h:5,
>                 from ./include/linux/preempt.h:78,
>                 from ./include/linux/spinlock.h:51,
>                 from ./include/linux/seqlock.h:36,
>                 from ./include/linux/time.h:6,
>                 from ./lib/vdso/gettimeofday.c:7,
>                 from <command-line>:0:
> ./arch/arm64/include/asm/memory.h: In function =E2=80=98__tag_set=E2=80=99=
:
> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer
>                to integer of different size [-Wpointer-to-int-cast]
>  u64 __addr =3D (u64)addr & ~__tag_shifted(0xff);
>               ^
> In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
>                 from ./arch/arm64/include/asm/processor.h:34,
>                 from ./arch/arm64/include/asm/elf.h:118,
>                 from ./include/linux/elf.h:5,
>                 from ./include/linux/elfnote.h:62,
>                 from arch/arm64/kernel/vdso32/note.c:11:
> ./arch/arm64/include/asm/memory.h: In function =E2=80=98__tag_set=E2=80=99=
:
> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer
>                to integer of different size [-Wpointer-to-int-cast]
>  u64 __addr =3D (u64)addr & ~__tag_shifted(0xff);
>=20
> The same porting does not build at all when the selected compiler is
> clang.
>=20
> I started an investigation to try to understand better the problem and
> after various discussions at Plumbers and Recipes last year the
> conclusion was that the vDSO library as it stands it is including more
> headers that it needs. In particular, being a user-space library, it
> should require only the UAPI and a minimal vDSO kernel interface instead
> of all the kernel-related inline functions which are not directly used
> and in some cases can have side effects.
>=20
> To solve the problem, I decided to use the approach below:
>  * Extract from include/linux/ the vDSO required kernel interface
>    and place it in include/common/

I really like the approach, but I=E2=80=99m wondering if =E2=80=9Ccommon=E2=80=
=9D is the right name. This directory is headers that aren=E2=80=99t stable A=
BI like uapi but are shared between the kernel and the vDSO. Regular user co=
de should *not* include these, right?

Would =E2=80=9Cvdso=E2=80=9D or perhaps =E2=80=9Cprivate-abi=E2=80=9D be cle=
arer?

>  * Make sure that where meaningful the kernel includes "common"
>  * Limit the vDSO library to include headers coming only from UAPI
>    and "common" (with 2 exceptions compiler.h for barriers and
>    param.h for HZ).
>  * Adapt all the architectures that support the unified vDSO library
>    to use "common" headers.

>=20
> According to me this approach allows up to exercise a better control on
> what the vDSO library can include and to prevent potential issues in
> future.
>=20
> This patch series contains the implementation of the described approach.
>=20
> The "common" headers have been verified on all the architectures that supp=
ort
> unified vDSO using the vdsotest [3] testsuite for what concerns the vDSO p=
art
> and randconfig to verify that they are included in the correct places.
>=20
> To simplify the testing, a copy of the patchset on top of a recent linux
> tree can be found at [4].
>=20
> [1] https://github.com/ClangBuiltLinux/linux/issues/595
> [2] https://lore.kernel.org/lkml/20190926151704.GH9689@arrakis.emea.arm.co=
m
> [3] https://github.com/nathanlynch/vdsotest
> [4] git://linux-arm.org/linux-vf.git common-headers/v2
>=20
> Changes:
> --------
> v2:
>  - Addressed review comments for clang support.
>  - Rebased on 5.6-rc4.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Mark Salyzyn <salyzyn@android.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>=20
> Vincenzo Frascino (20):
>  linux/const.h: Extract common header for vDSO
>  linux/bits.h: Extract common header for vDSO
>  linux/limits.h: Extract common header for vDSO
>  linux/math64.h: Extract common header for vDSO
>  linux/time.h: Extract common header for vDSO
>  linux/time32.h: Extract common header for vDSO
>  linux/time64.h: Extract common header for vDSO
>  linux/jiffies.h: Extract common header for vDSO
>  linux/ktime.h: Extract common header for vDSO
>  common: Introduce processor.h
>  linux/elfnote.h: Replace elf.h with UAPI equivalent
>  arm64: Introduce asm/common/processor.h
>  arm64: vdso: Include common headers in the vdso library
>  arm64: vdso32: Include common headers in the vdso library
>  arm64: Introduce asm/common/arch_timer.h
>  mips: vdso: Enable mips to use common headers
>  x86: vdso: Enable x86 to use common headers
>  arm: vdso: Enable arm to use common headers
>  lib: vdso: Enable common headers
>  arm64: vdso32: Enable Clang Compilation
>=20
> arch/arm/include/asm/common/cp15.h            | 38 +++++++++++++++++++
> arch/arm/include/asm/common/processor.h       | 22 +++++++++++
> arch/arm/include/asm/cp15.h                   | 20 +---------
> arch/arm/include/asm/processor.h              | 11 +-----
> arch/arm/include/asm/vdso/gettimeofday.h      |  4 +-
> arch/arm64/include/asm/arch_timer.h           | 29 +++-----------
> arch/arm64/include/asm/common/arch_timer.h    | 33 ++++++++++++++++
> arch/arm64/include/asm/common/processor.h     | 31 +++++++++++++++
> arch/arm64/include/asm/processor.h            | 16 +-------
> .../include/asm/vdso/compat_gettimeofday.h    |  2 +-
> arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++--
> arch/arm64/kernel/vdso/vgettimeofday.c        |  2 -
> arch/arm64/kernel/vdso32/Makefile             | 13 ++++++-
> arch/arm64/kernel/vdso32/vgettimeofday.c      |  3 --
> arch/mips/include/asm/common/processor.h      | 27 +++++++++++++
> arch/mips/include/asm/processor.h             | 16 +-------
> arch/mips/include/asm/vdso/gettimeofday.h     |  4 --
> arch/x86/include/asm/common/processor.h       | 23 +++++++++++
> arch/x86/include/asm/processor.h              | 12 +-----
> include/common/bits.h                         |  9 +++++
> include/common/const.h                        | 10 +++++
> include/common/jiffies.h                      | 11 ++++++
> include/common/ktime.h                        | 16 ++++++++
> include/common/limits.h                       | 18 +++++++++
> include/common/math64.h                       | 24 ++++++++++++
> include/common/processor.h                    | 14 +++++++
> include/common/time.h                         | 12 ++++++
> include/common/time32.h                       | 17 +++++++++
> include/common/time64.h                       | 14 +++++++
> include/linux/bits.h                          |  2 +-
> include/linux/const.h                         |  5 +--
> include/linux/elfnote.h                       |  2 +-
> include/linux/jiffies.h                       |  4 +-
> include/linux/ktime.h                         |  9 +----
> include/linux/limits.h                        | 13 +------
> include/linux/math64.h                        | 20 +---------
> include/linux/time.h                          |  5 +--
> include/linux/time32.h                        | 13 +------
> include/linux/time64.h                        | 10 +----
> include/vdso/datapage.h                       | 32 ++++++++++++++--
> lib/vdso/gettimeofday.c                       | 21 ----------
> 41 files changed, 388 insertions(+), 207 deletions(-)
> create mode 100644 arch/arm/include/asm/common/cp15.h
> create mode 100644 arch/arm/include/asm/common/processor.h
> create mode 100644 arch/arm64/include/asm/common/arch_timer.h
> create mode 100644 arch/arm64/include/asm/common/processor.h
> create mode 100644 arch/mips/include/asm/common/processor.h
> create mode 100644 arch/x86/include/asm/common/processor.h
> create mode 100644 include/common/bits.h
> create mode 100644 include/common/const.h
> create mode 100644 include/common/jiffies.h
> create mode 100644 include/common/ktime.h
> create mode 100644 include/common/limits.h
> create mode 100644 include/common/math64.h
> create mode 100644 include/common/processor.h
> create mode 100644 include/common/time.h
> create mode 100644 include/common/time32.h
> create mode 100644 include/common/time64.h
>=20
> --=20
> 2.25.1
>=20
