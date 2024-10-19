Return-Path: <linux-arch+bounces-8285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C969A4B80
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 08:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D6D284A13
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3C1D5CF5;
	Sat, 19 Oct 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XCrySxO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0501CC8B0
	for <linux-arch@vger.kernel.org>; Sat, 19 Oct 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729318819; cv=none; b=hYh80REWziytz/crr0+76SQXOZm3usChO+CyKIQT6CgTQUaiUiJmq/itB0yo7Pxne1tqyL3rraIEbHW5vNg3Gs4IfLDvqDhYewwj5z+0IFS0a00hMuQr1dbtYDS4yVWDVhwKQT7ilsOVKmFDv+gr1NOWCMU5RR8b0bceRO/bLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729318819; c=relaxed/simple;
	bh=j8X+5Qa3BA6yYydwwDfAN46CjuG+Ig56cU764oIme4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzeRxPTXb1bG+duk97pl7yozqO6R9bLgcXUDk308hvBm4YD8vVpJfB6HchX7QEAAWV2NR9YB4y9L/gG03ZV+3/h60lqri2tkgAEjvnC2oeKx/4UN2RGUeYjbbGgEYP002JCvYVhrF8zzfv/O41/BZSZ6QFcfX4EpZGAEFZWzfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XCrySxO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c87b0332cso57365ad.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729318816; x=1729923616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG5Ji9yk+5OB5vhrjsIZYD53kBt4ULitiVGV3je8U3M=;
        b=1XCrySxOmkKDtJ1yidN84o7Bs1yzU5v4OdygOFAGsJ5jzXQwz7M1wiFqFYF9yTA/A2
         zWuCTuLvDFK3aC+A8DRwlS1xPC2HsKxG7Rys1i6Je5JBhbJgXGH3vKqc93Y+/xN0qrzG
         D3MLvt0U1Sh6atBjfYJe61Zw/HuBpFRrH0VsnxQuKUBJQgzwUeptk5X3gOOZNRbA26Ai
         2eMr0O8OLS9089MF6kbroiHaRYwdprvROPjY7EnSU0piQflg3NXB05Ho55SIzFHQKZVP
         H70Oy/0e9nUQA30X0cPvKNAk5PbfSzpEtXwaIi74gelQys1YYb11ZGTSO7K5EFHz09t7
         wu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729318816; x=1729923616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG5Ji9yk+5OB5vhrjsIZYD53kBt4ULitiVGV3je8U3M=;
        b=faXw0RIWZM4grqJnh3+xS8ylrKyLJvaWfIizImO5L8VTtJFaGS2HXBOnr+TIiawfZJ
         Y+PrV6bOktxWTf6CjhCfiNxYv6K7Vrvv3DvRtI6Ro1sWFWlpQGmTCSavS7SZgiC6+ghu
         hLTKA669jCnNYyO159SStCdvSSpaSzeXHqrDC5yOeVZ78pcDKWg77n9jSlKCKN+fLyVY
         RQHLEY/XgKFFdTOAyk9iKrdnaO2dvqfWGQ/ll6OCgURzigIggAmYOiY89NDTfnXBJJ3W
         11+jyD8IZ/z3j1wyVuGmsLcoXXDi6B84QcdWe47E7EG53qpgT0khvCv737X4bufY1oN4
         oLEA==
X-Forwarded-Encrypted: i=1; AJvYcCXKjXGuPzSrDKaw/jFaDGpMi5pfdM/9uPoBbVSV1K2jsNHgrsMJ9GxhRyO2cQm+N1Ygs1xrvnFpd9/K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AE3Z04eSjWPKD7T+AlZjk4uE15ai1SENJHJqA4b2Z2b2UJEN
	KlA2Oim2ceaqdKryRt+1GCrZIVKJwHOfd/di3Udji3Vb5EvLMOpDVWqAN57FCuH0Ff9HQe5jKyG
	gsfmJ7QlJ4REJUYxi6mLSdqKoCLCiFLFfJXRY
X-Google-Smtp-Source: AGHT+IG/g1ICUcu3rMMFd5HdtPGKTgkMSGD7b99oCotrAl3M1kzzZpBn3dX2gQQlRRZDdwAveuHP6VBuhszFxOLUudA=
X-Received: by 2002:a17:902:d484:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-20e72b77977mr1489885ad.8.1729318815966; Fri, 18 Oct 2024
 23:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com>
In-Reply-To: <20241014213342.1480681-1-xur@google.com>
From: Rong Xu <xur@google.com>
Date: Fri, 18 Oct 2024 23:20:02 -0700
Message-ID: <CAF1bQ=SQ9rFdwRk_waQvn4PW7x6T1uJmJ8qNqj04oRKmujkCQw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
To: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks to all for the feedback and suggestions! We are ready to make any fu=
rther
changes needed. Is there anything else we can address for this patch?

Also, we know it's not easy to test this patch, but if anyone has had a cha=
nce
to try building AutoFDO/Propeller kernels with it, we'd really appreciate y=
our
input here. Any confirmation that it works as expected would be very helpfu=
l.

-Rong

On Mon, Oct 14, 2024 at 2:33=E2=80=AFPM Rong Xu <xur@google.com> wrote:
>
> Hi,
>
> This patch series is to integrate AutoFDO and Propeller support into
> the Linux kernel. AutoFDO is a profile-guided optimization technique
> that leverages hardware sampling to enhance binary performance.
> Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
> and straightforward application process. While iFDO generally yields
> superior profile quality and performance, our findings reveal that
> AutoFDO achieves remarkable effectiveness, bringing performance close
> to iFDO for benchmark applications.
>
> Propeller is a profile-guided, post-link optimizer that improves
> the performance of large-scale applications compiled with LLVM. It
> operates by relinking the binary based on an additional round of runtime
> profiles, enabling precise optimizations that are not possible at
> compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> sampling to collect profiles and apply post-link optimizations to improve
> the benchmark=E2=80=99s performance over and above AutoFDO.
>
> Our empirical data demonstrates significant performance improvements
> with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
> on large warehouse-scale benchmarks. This makes a strong case for their
> inclusion as supported features in the upstream kernel.
>
> Background
>
> A significant fraction of fleet processing cycles (excluding idle time)
> from data center workloads are attributable to the kernel. Ware-house
> scale workloads maximize performance by optimizing the production kernel
> using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
>
> iFDO can significantly enhance application performance but its use
> within the kernel has raised concerns. AutoFDO is a variant of FDO that
> uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to collect
> profiling data. While AutoFDO typically yields smaller performance
> gains than iFDO, it presents unique benefits for optimizing kernels.
>
> AutoFDO eliminates the need for instrumented kernels, allowing a single
> optimized kernel to serve both execution and profile collection. It also
> minimizes slowdown during profile collection, potentially yielding
> higher-fidelity profiling, especially for time-sensitive code, compared
> to iFDO. Additionally, AutoFDO profiles can be obtained from production
> environments via the hardware=E2=80=99s PMU whereas iFDO profiles require
> carefully curated load tests that are representative of real-world
> traffic.
>
> AutoFDO facilitates profile collection across diverse targets.
> Preliminary studies indicate significant variation in kernel hot spots
> within Google=E2=80=99s infrastructure, suggesting potential performance =
gains
> through target-specific kernel customization.
>
> Furthermore, other advanced compiler optimization techniques, including
> ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO.
> ThinLTO achieves better runtime performance through whole-program
> analysis and cross module optimizations. The main difference between
> traditional LTO and ThinLTO is that the latter is scalable in time and
> memory.
>
> This patch series adds AutoFDO and Propeller support to the kernel. The
> actual solution comes in six parts:
>
> [P 1] Add the build support for using AutoFDO in Clang
>
>       Add the basic support for AutoFDO build and provide the
>       instructions for using AutoFDO.
>
> [P 2] Fix objtool for bogus warnings when -ffunction-sections is enabled
>
> [P 3] Change the subsection ordering when -ffunction-sections is enabled
>
> [P 4] Enable =E2=80=93ffunction-sections for the AutoFDO build
>
> [P 5] Enable Machine Function Split (MFS) optimization for AutoFDO
>
> [P 6] Add Propeller configuration to the kernel build
>
> Patch 1 provides basic AutoFDO build support. Patches 2 to 5 further
> enhance the performance of AutoFDO builds and are functionally dependent
> on Patch 1. Patch 6 enables support for Propeller and is dependent on
> patch 2 and patch 3.
>
> Caveats
>
> AutoFDO is compatible with both GCC and Clang, but the patches in this
> series are exclusively applicable to LLVM 17 or newer for AutoFDO and
> LLVM 19 or newer for Propeller. For profile conversion, two different
> tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively,
> create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.
>
> Additionally, the build is only supported on x86 platforms equipped
> with PMU capabilities, such as LBR on Intel machines. More
> specifically:
>  * Intel platforms: works on every platform that supports LBR;
>    we have tested on Skylake.
>  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
>    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3Dy", =
To
>    check, use
>    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
>    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
>    AMD LBRv2 implementation in Genoa which blocks the usage.
>
> Experiments and Results
>
> Experiments were conducted to compare the performance of AutoFDO-optimize=
d
> kernel images (version 6.9.x) against default builds.. The evaluation
> encompassed both open source microbenchmarks and real-world production
> services from Google and Meta. The selected microbenchmarks included Nepe=
r,
> a network subsystem benchmark, and UnixBench which is a comprehensive sui=
te
> for assessing various kernel operations.
>
> For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
> and a 10.6% reduction in latency. Unixbench saw a 2.2% improvement in its
> index score under low system load and a 2.6% improvement under high syste=
m
> load.
>
> For further details on the improvements observed in Google and Meta's
> production services, please refer to the LLVM discourse post:
> https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-inc=
luding-thinlto-and-propeller/79108
>
> Thanks,
>
> Rong Xu and Han Shen
>
> Change-Logs in V2:
> Rebased the source to e32cde8d2bd7 (Merge tag 'sched_ext-for-6.12-rc1-fix=
es-1')
> 1. Cover-letter: moved the Propeller description to the top (Peter Zijlst=
ra)
> 2. [P 1]: (1) Makefile: fixed file order (Masahiro Yamada)
>           (2) scripts/Makefile.lib: used is-kernel-object to exclude
>               files (Masahiro Yamada)
>           (3) scripts/Makefile.autofdo: improved the code (Masahiro Yamad=
a)
>           (4) scripts/Makefile.autofdo: handled when DEBUG_INFO disabled =
(Nick Desaulniers)
> 3. [P 2]: tools/objtool/elf.c: updated the comments (Peter Zijlstra)
> 4. [P 3]: include/asm-generic/vmlinux.lds.h:
>           (1) explicit set cold text function aligned (Peter Zijlstra and=
 Peter Anvin)
>           (2) set hot-text page aligned
> 5. [P 6]: (1) include/asm-generic/vmlinux.lds.h: made Propeller not depen=
ding
>               on AutoFDO
>           (2) Makefile: fixed file order (Masahiro Yamada)
>           (3) scripts/Makefile.lib: used is-kernel-object to exclude
>               files (Masahiro Yamada). This removed the change in
>               arch/x86/platform/efi/Makefile,
>               drivers/firmware/efi/libstub/Makefile, and
>               arch/x86/boot/compressed/Makefile.
>               And this also addressed the comment from Arnd Bergmann rega=
rding
>               arch/x86/purgatory/Makefile.
>           (4) scripts/Makefile.propeller: improved the code (Masahiro Yam=
ada)
>
> Change-Logs in V3:
> Rebased the source to eb952c47d154 (Merge tag 'for-6.12-rc2-tag').
> 1. [P 1]: autofdo.rst: removed code-block directives and used "::" (Mike =
Rapoport)
> 2. [P 6]: propeller.rst: removed code-block directives and use "::" (Mike=
 Rapoport)
>
> Change-Logs in V4:
> 1. [P 1]: autofdo.rst: fixed a typo for create_llvm_prof commmand.
>
> Rong Xu (6):
>   Add AutoFDO support for Clang build
>   objtool: Fix unreachable instruction warnings for weak funcitons
>   Change the symbols order when --ffuntion-sections is enabled
>   AutoFDO: Enable -ffunction-sections for the AutoFDO build
>   AutoFDO: Enable machine function split optimization for AutoFDO
>   Add Propeller configuration for kernel build.
>
>  Documentation/dev-tools/autofdo.rst   | 165 ++++++++++++++++++++++++++
>  Documentation/dev-tools/index.rst     |   2 +
>  Documentation/dev-tools/propeller.rst | 161 +++++++++++++++++++++++++
>  MAINTAINERS                           |  14 +++
>  Makefile                              |   2 +
>  arch/Kconfig                          |  42 +++++++
>  arch/x86/Kconfig                      |   2 +
>  arch/x86/kernel/vmlinux.lds.S         |   4 +
>  include/asm-generic/vmlinux.lds.h     |  54 +++++++--
>  scripts/Makefile.autofdo              |  25 ++++
>  scripts/Makefile.lib                  |  20 ++++
>  scripts/Makefile.propeller            |  28 +++++
>  tools/objtool/check.c                 |   2 +
>  tools/objtool/elf.c                   |  15 ++-
>  14 files changed, 524 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/dev-tools/autofdo.rst
>  create mode 100644 Documentation/dev-tools/propeller.rst
>  create mode 100644 scripts/Makefile.autofdo
>  create mode 100644 scripts/Makefile.propeller
>
>
> base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

