Return-Path: <linux-arch+bounces-8589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289D9B1306
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD2C283863
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD920F3D3;
	Fri, 25 Oct 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwrNrbjY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CD1D1748
	for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897399; cv=none; b=HT90+eK9+eZEhO/8Ou1gBMOz4QTg6/pzaRf1+ak1jK6Je6gi+r0cSueqiYR6Lan63sz7s6CmFm4n9wCkFGdVY0JZYwg2w+kkK3YZKjjME+Y6Hz0jW2xIq0WdNYzqtHQ1zSJo4Hs0Qi84lQKkoQZnvXbuOaNDgrzUpQhEjAOf8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897399; c=relaxed/simple;
	bh=1n92e5qucTrClmMA4lkb2KQhhRH6eXmFRl+YucexndY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5VjQypx3PhersFKH6sio0D0vnT2yDpxQFUlCgvS8CVlMfFKP/phhMC2mr+iadwKUJG7L5S+c7B3+D0r+K7sPculGcSGV5VXAtRFXlSOdbcD5OWJqNZtIuQyYsTstTWkjmNep3RmPTm8otiP92lJKhHXAvU+JY1ss3U00VUGw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwrNrbjY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460ad98b031so15186541cf.0
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2024 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729897396; x=1730502196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zskAXP+rp1Cj4qEAP8PdH9bkMBjIc5SfV8f9TuJPRs=;
        b=bwrNrbjY4L9E64Figi2CpR0XF2rV0JsCtHCHVzIl5L3yOm49OEi7zIXTSQKv5ZsvS0
         MItqV0Egib80rl89j/CoH7VylAJ6PIXJmJpDJWrBrSrBXHHf7Dc9dpxS2RmID6liBPAQ
         s6stIsR8s9CNSUkJq+FZQ3bB72neoa4UjW4jKjwpszgPTfUAkMBzSWk0viFdZqoyymMX
         L3GXXFd1F/oiIbGgxX+LTTRxN7mUq9nTJaknf0h9UaZPn9H8E3NvDaIR50h4qCGYUR1D
         ZFdCWFZPwqQNm66X+0BBxmobdMxwcBP2rcQjXEJLto5hh5xUsUiTJZho0A2KDKZFCUfo
         /vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729897396; x=1730502196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zskAXP+rp1Cj4qEAP8PdH9bkMBjIc5SfV8f9TuJPRs=;
        b=MoIBYCFNtxnuyOrYeqp7FvsxOuVQGl5ALAqWnPO6Rtv6T5FWth9NmbtlSQXVQRINvx
         Ney2+Uo4G6NhXay4xbXcSG8jgMdGUIGQvhmFx1VLHg2yfsMn4vnFs++SBqHGihukTdTp
         4JDFiiF8KfjtnhtQflktm8x2v9rNpy3/jsBUIMhld7WqtUrZeOFjEAx5Ta/512Rwfui2
         5yInSAccuEeDwoeYDADesuwhq1ng1t3Dn61Qjy8nQF2kSLPoqWcQLOAnbO1PK7m92cgH
         ZdRUfWiJgBRkeTHewD1dbMxW9w3h5KzLR4APzuRh2jA4htQyyPGYpDSrmppo85Ih+Iao
         9kwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7U4IBSNuM2e7Gj5Dg4fDDPfLU4cittCPiugHEWqUW/SAEc6HUBVmqeJinWCumk+gkIfe10Pkd7ruA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YEEWURID8I9UNwYZCDiflQNBM2xbPCVkkbs72Cdj8MrlrXQl
	JVxphsszxIgDW5Pt2xIZ8DhMdpENEVwCZT7/n3WB9YI21RxQGPwa5tAlAYs9sGKPJUxunLBf7Lw
	zKcmfIplDSIK7f7//eW8tbA/avvGCvZe0LmE=
X-Google-Smtp-Source: AGHT+IEdqj5wqJWCi878QGQ8x4qQhYer9BQYeBhP4y8WuSf6tsZDdJkVoVA79Xp0ob7Vt1crpkjOyfm5rBPUgBL/2QY=
X-Received: by 2002:a05:622a:607:b0:460:ac8f:3bcd with SMTP id
 d75a77b69052e-4613c197bd7mr11490801cf.45.1729897395442; Fri, 25 Oct 2024
 16:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023224409.201771-1-xur@google.com>
In-Reply-To: <20241023224409.201771-1-xur@google.com>
From: Yabin Cui <yabinc@google.com>
Date: Fri, 25 Oct 2024 16:03:02 -0700
Message-ID: <CALJ9ZPPtdFbQntb46LHnRCOn7DC5MdPXgTgVTzXWfCW68dSdsA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add AutoFDO and Propeller support for Clang build
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
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
	Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Maksim Panchenko <max4bolt@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rong,

I tested this patchset on the android-mainline kernel branch (closely track=
ing
the Linux mainline branch) using the latest Clang compiler with an AutoFDO
profile. It passed all presubmit tests, including boot and local tests, and
the AutoFDO profile yielded performance improvements across various benchma=
rks.

Tested-by: Yabin Cui <yabinc@google.com>

Thanks,
Yabin


On Wed, Oct 23, 2024 at 3:44=E2=80=AFPM Rong Xu <xur@google.com> wrote:
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
> [P 4] Add markers for text_unlikely and text_hot sections
>
> [P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build
>
> [P 6] Enable Machine Function Split (MFS) optimization for AutoFDO
>
> [P 7] Add Propeller configuration to the kernel build
>
> Patch 1 provides basic AutoFDO build support. Patches 2 to 6 further
> enhance the performance of AutoFDO builds and are functionally dependent
> on Patch 1. Patch 7 enables support for Propeller and is dependent on
> patch 2 to patch 4.
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
> For ARM, we plan to send patches for SPE-based Propeller when
> AutoFDO for Arm is ready.
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
> and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement in its
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
> Rebased to commit e32cde8d2bd7 ("Merge tag 'sched_ext-for-6.12-rc1-fixes-=
1'
> of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")
>
> 1. [P 0]: moved the Propeller description to the top (Peter Zijlstra)
> 2. [P 1]: (1) Makefile: fixed file order (Masahiro Yamada)
>           (2) scripts/Makefile.lib: used is-kernel-object to exclude
>               files (Masahiro Yamada)
>           (3) scripts/Makefile.autofdo: improved the code (Masahiro Yamad=
a)
>           (4) scripts/Makefile.autofdo: handled when DEBUG_INFO disabled
>               (Nick Desaulniers)
> 3. [P 2]: tools/objtool/elf.c: updated the comments (Peter Zijlstra)
> 4. [P 3]: include/asm-generic/vmlinux.lds.h:
>           (1) explicit set cold text function aligned (Peter Zijlstra and
>               Peter Anvin)
>           (2) set hot-text page aligned
> 5. [P 6]: (1) include/asm-generic/vmlinux.lds.h: made Propeller not
>               depending on AutoFDO
>           (2) Makefile: fixed file order (Masahiro Yamada)
>           (3) scripts/Makefile.lib: used is-kernel-object to exclude
>               files (Masahiro Yamada). This removed the change in
>               arch/x86/platform/efi/Makefile,
>               drivers/firmware/efi/libstub/Makefile, and
>               arch/x86/boot/compressed/Makefile.
>               And this also addressed the comment from Arnd Bergmann
>               regarding arch/x86/purgatory/Makefile
>           (4) scripts/Makefile.propeller: improved the code
>               (Masahiro Yamada)
>
> Change-Logs in V3:
> Rebased to commit eb952c47d154 ("Merge tag 'for-6.12-rc2-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
>
> Integrated the following changes suggested by Mike Rapoport.
> 1. [P 1]: autofdo.rst: removed code-block directives and used "::"
> 2. [P 6]: propeller.rst: removed code-block directives and use "::"
>
> Change-Logs in V4:
> 1. [P 1]: autofdo.rst: fixed a typo for create_llvm_prof command.
>
> Change-Logs in V5:
> Added "Tested-by: Yonghong Song <yonghong.song@linux.dev>" to all patches=
.
>
> Integrated the following changes suggested by Masahiro Yamada.
> 1. [P 0]: (1) moved ARM related remark from patch 6 to here
> 2. [P 1]: (1) autofdo.rst: improved the documentation
>           (2) scripts/Makefile.autofdo: improved comments and used ifdef
>               instead of ifeq
> 3. [P 3]: Make the layout change unconditionally
> 4. [P 4]: Split the patch into two: this patch only added the markers, an=
d
>           the AutoFDO change went to the new [P 5]
> 5. [P 7]: (1) propeller.rst: improved the documentation
>           (2) scripts/Makefile.propeller: improved comments and used ifde=
f
>               instead of ifeq
>           (3) arch/Kconfig: made Propeller build independent of AutoFDO
>               build
>           (4) moved ARM related remarks to the cover letter
>
> Rong Xu (7):
>   Add AutoFDO support for Clang build
>   objtool: Fix unreachable instruction warnings for weak functions
>   Change the symbols order when --ffunction-sections is enabled
>   Add markers for text_unlikely and text_hot sections
>   AutoFDO: Enable -ffunction-sections for the AutoFDO build
>   AutoFDO: Enable machine function split optimization for AutoFDO
>   Add Propeller configuration for kernel build
>
>  Documentation/dev-tools/autofdo.rst   | 167 ++++++++++++++++++++++++++
>  Documentation/dev-tools/index.rst     |   2 +
>  Documentation/dev-tools/propeller.rst | 162 +++++++++++++++++++++++++
>  MAINTAINERS                           |  14 +++
>  Makefile                              |   2 +
>  arch/Kconfig                          |  39 ++++++
>  arch/x86/Kconfig                      |   2 +
>  arch/x86/kernel/vmlinux.lds.S         |   4 +
>  include/asm-generic/vmlinux.lds.h     |  49 ++++++--
>  scripts/Makefile.autofdo              |  24 ++++
>  scripts/Makefile.lib                  |  20 +++
>  scripts/Makefile.propeller            |  28 +++++
>  tools/objtool/check.c                 |   2 +
>  tools/objtool/elf.c                   |  15 ++-
>  14 files changed, 514 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/dev-tools/autofdo.rst
>  create mode 100644 Documentation/dev-tools/propeller.rst
>  create mode 100644 scripts/Makefile.autofdo
>  create mode 100644 scripts/Makefile.propeller
>
>
> base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
> --
> 2.47.0.105.g07ac214952-goog
>

