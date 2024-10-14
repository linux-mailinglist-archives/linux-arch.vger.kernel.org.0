Return-Path: <linux-arch+bounces-8115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B345599D915
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E1E1C236FF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8B1D174F;
	Mon, 14 Oct 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ws2CCqTn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451E15575E
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941629; cv=none; b=j2OiQadS+q95KSdW7mzv7+25c8sAGhuYybe/cVhEVZ+3kcpMoUhKfMZW5NXws5hTumHf/UthMCFQ1GA+Z1wj6l5v2kNnyWc3Gro0EALQFkjNni3yW0ECqO8524nbexmu7jl7j2uqIPLi1wi1OtHfXD0pel8fWeGuU2qFJwu6bFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941629; c=relaxed/simple;
	bh=NyS1R4OCXj+Dl1x0srG8X72CsFiCteFOhz1mT9H07FA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WF7u5kAwkogmvHY5Bxx3fkV5eHEytLSFGZ5r/AFWX4R6zHMmEdsV7FonftimJM5riGZE+8lnJ8H42VqVghDTSvchUGQzF74wt4ddaaVf/Qn/kPqIloteE7ZUkhxWWMG/3B6HXJWO/M3FhLQ211smLbOyMhjRGZNEyN9eDsdY/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ws2CCqTn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2932b0f4fbso2854761276.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728941626; x=1729546426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNrtnn1jkYuFX0orwDZ0I0a1jxvb8DII210IbrodWmE=;
        b=Ws2CCqTnCvZSwHnnei/7N8yhonQb5TuXex86xmAqNPa8ibYX+1kCJQyfm6Utu0eOnA
         jdfKQSsXYtdFEqbKb3bFbCLfcez/UMPY+RADGzV29ilxzP+p2azAp0ehjOvWWnJbKgMQ
         pZqcFcwz9IPj0cUM68wCSRr9kxqQxL4uAugajAwXg5rtNG3mdx6ouNxkpW8Sq8SXgX72
         YsWuGfySvK/NCxjvlu3eRR04onXZOgyoJqxlfHziDaFpepkotFKmeE1Ej3QNLac5ncjD
         QKUIvQbCyimATskgtxKgFmExPNkzG71MIqGSs/xheasOxbc3WOiHwV8uNt1nXp5J2U7Q
         AaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941626; x=1729546426;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNrtnn1jkYuFX0orwDZ0I0a1jxvb8DII210IbrodWmE=;
        b=hitL4bas/hv/2HlzogjiKmf6Lo4z6F7Mp+9OM9F9BsRIWoybifWl/wicJRZMCEA9wb
         oQNw7PQ83+3RAPLMNcqK6hNrGKqdHJdFxXAk7mqu6xBCi7nBV0m/cVexdV9q55zdWNpc
         KqRPtPNppTML1WkNXBHImx90oG6jqnaBjMxdynYS+HRQIl2k7nmGe32frHcN0zLXqN08
         BIGTsmSTdOwnXy/rZRsA6RRWiRNQsUPE8bdzi9hEePkPlpKKSDoisiXIPP5PVrenPZkr
         vsQCu5pAsGpXsWoDSPfVhp2SayrICrk9gJyffwKkKde2jc3KL/pH5zIds2ERGdZujDly
         yP9w==
X-Forwarded-Encrypted: i=1; AJvYcCX+WJzrJPQx2T4VOUVzdoJk3E2ZT/GJud5LFDe8GA8P67XFGH1MeT4v976cGKGC4vG9cErWiBQtzBwE@vger.kernel.org
X-Gm-Message-State: AOJu0YwOD9/QhddCtMPEmAB2EN5+MyOGnrhfZU5Y8Naqq76nNQ30L3aI
	Er3O3M5IF9ebhs+6WUxH/FN6Krr4CUCAm1MtOVnsvR0vAkgcEVJLMoGOHNp8x74GkQ==
X-Google-Smtp-Source: AGHT+IHpFleIn8xIRBWQN/OXQyBUVoykc/S+Vd9sn03CN26qK8AOr/rqBlbIBGZGPpmR7yUr/TIsPLE=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:dd06:0:b0:e28:fdd7:bb27 with SMTP id
 3f1490d57ef6-e290b89e3e2mr160214276.3.1728941625911; Mon, 14 Oct 2024
 14:33:45 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:33:34 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014213342.1480681-1-xur@google.com>
Subject: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
From: Rong Xu <xur@google.com>
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series is to integrate AutoFDO and Propeller support into
the Linux kernel. AutoFDO is a profile-guided optimization technique
that leverages hardware sampling to enhance binary performance.
Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
and straightforward application process. While iFDO generally yields
superior profile quality and performance, our findings reveal that
AutoFDO achieves remarkable effectiveness, bringing performance close
to iFDO for benchmark applications.

Propeller is a profile-guided, post-link optimizer that improves
the performance of large-scale applications compiled with LLVM. It
operates by relinking the binary based on an additional round of runtime
profiles, enabling precise optimizations that are not possible at
compile time.  Similar to AutoFDO, Propeller too utilizes hardware
sampling to collect profiles and apply post-link optimizations to improve
the benchmark=E2=80=99s performance over and above AutoFDO.

Our empirical data demonstrates significant performance improvements
with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
on large warehouse-scale benchmarks. This makes a strong case for their
inclusion as supported features in the upstream kernel.

Background

A significant fraction of fleet processing cycles (excluding idle time)
from data center workloads are attributable to the kernel. Ware-house
scale workloads maximize performance by optimizing the production kernel
using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).

iFDO can significantly enhance application performance but its use
within the kernel has raised concerns. AutoFDO is a variant of FDO that
uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to collect
profiling data. While AutoFDO typically yields smaller performance
gains than iFDO, it presents unique benefits for optimizing kernels.

AutoFDO eliminates the need for instrumented kernels, allowing a single
optimized kernel to serve both execution and profile collection. It also
minimizes slowdown during profile collection, potentially yielding
higher-fidelity profiling, especially for time-sensitive code, compared
to iFDO. Additionally, AutoFDO profiles can be obtained from production
environments via the hardware=E2=80=99s PMU whereas iFDO profiles require
carefully curated load tests that are representative of real-world
traffic.

AutoFDO facilitates profile collection across diverse targets.
Preliminary studies indicate significant variation in kernel hot spots
within Google=E2=80=99s infrastructure, suggesting potential performance ga=
ins
through target-specific kernel customization.

Furthermore, other advanced compiler optimization techniques, including
ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO.
ThinLTO achieves better runtime performance through whole-program
analysis and cross module optimizations. The main difference between
traditional LTO and ThinLTO is that the latter is scalable in time and
memory.

This patch series adds AutoFDO and Propeller support to the kernel. The
actual solution comes in six parts:

[P 1] Add the build support for using AutoFDO in Clang

      Add the basic support for AutoFDO build and provide the
      instructions for using AutoFDO.

[P 2] Fix objtool for bogus warnings when -ffunction-sections is enabled

[P 3] Change the subsection ordering when -ffunction-sections is enabled

[P 4] Enable =E2=80=93ffunction-sections for the AutoFDO build

[P 5] Enable Machine Function Split (MFS) optimization for AutoFDO

[P 6] Add Propeller configuration to the kernel build

Patch 1 provides basic AutoFDO build support. Patches 2 to 5 further
enhance the performance of AutoFDO builds and are functionally dependent
on Patch 1. Patch 6 enables support for Propeller and is dependent on
patch 2 and patch 3.

Caveats

AutoFDO is compatible with both GCC and Clang, but the patches in this
series are exclusively applicable to LLVM 17 or newer for AutoFDO and
LLVM 19 or newer for Propeller. For profile conversion, two different
tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively,
create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.

Additionally, the build is only supported on x86 platforms equipped
with PMU capabilities, such as LBR on Intel machines. More
specifically:
 * Intel platforms: works on every platform that supports LBR;
   we have tested on Skylake.
 * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
   needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3Dy", To
   check, use
   $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
   For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
   AMD LBRv2 implementation in Genoa which blocks the usage.

Experiments and Results

Experiments were conducted to compare the performance of AutoFDO-optimized
kernel images (version 6.9.x) against default builds.. The evaluation
encompassed both open source microbenchmarks and real-world production
services from Google and Meta. The selected microbenchmarks included Neper,
a network subsystem benchmark, and UnixBench which is a comprehensive suite
for assessing various kernel operations.

For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
and a 10.6% reduction in latency. Unixbench saw a 2.2% improvement in its
index score under low system load and a 2.6% improvement under high system
load.

For further details on the improvements observed in Google and Meta's
production services, please refer to the LLVM discourse post:
https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-inclu=
ding-thinlto-and-propeller/79108

Thanks,

Rong Xu and Han Shen

Change-Logs in V2:
Rebased the source to e32cde8d2bd7 (Merge tag 'sched_ext-for-6.12-rc1-fixes=
-1')
1. Cover-letter: moved the Propeller description to the top (Peter Zijlstra=
)
2. [P 1]: (1) Makefile: fixed file order (Masahiro Yamada)
          (2) scripts/Makefile.lib: used is-kernel-object to exclude
              files (Masahiro Yamada)
          (3) scripts/Makefile.autofdo: improved the code (Masahiro Yamada)
          (4) scripts/Makefile.autofdo: handled when DEBUG_INFO disabled (N=
ick Desaulniers)
3. [P 2]: tools/objtool/elf.c: updated the comments (Peter Zijlstra)
4. [P 3]: include/asm-generic/vmlinux.lds.h:
          (1) explicit set cold text function aligned (Peter Zijlstra and P=
eter Anvin)
          (2) set hot-text page aligned
5. [P 6]: (1) include/asm-generic/vmlinux.lds.h: made Propeller not dependi=
ng
              on AutoFDO
          (2) Makefile: fixed file order (Masahiro Yamada)
          (3) scripts/Makefile.lib: used is-kernel-object to exclude
              files (Masahiro Yamada). This removed the change in
              arch/x86/platform/efi/Makefile,
              drivers/firmware/efi/libstub/Makefile, and
              arch/x86/boot/compressed/Makefile.
              And this also addressed the comment from Arnd Bergmann regard=
ing
              arch/x86/purgatory/Makefile.
          (4) scripts/Makefile.propeller: improved the code (Masahiro Yamad=
a)

Change-Logs in V3:
Rebased the source to eb952c47d154 (Merge tag 'for-6.12-rc2-tag').
1. [P 1]: autofdo.rst: removed code-block directives and used "::" (Mike Ra=
poport)
2. [P 6]: propeller.rst: removed code-block directives and use "::" (Mike R=
apoport)

Change-Logs in V4:
1. [P 1]: autofdo.rst: fixed a typo for create_llvm_prof commmand.

Rong Xu (6):
  Add AutoFDO support for Clang build
  objtool: Fix unreachable instruction warnings for weak funcitons
  Change the symbols order when --ffuntion-sections is enabled
  AutoFDO: Enable -ffunction-sections for the AutoFDO build
  AutoFDO: Enable machine function split optimization for AutoFDO
  Add Propeller configuration for kernel build.

 Documentation/dev-tools/autofdo.rst   | 165 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   2 +
 Documentation/dev-tools/propeller.rst | 161 +++++++++++++++++++++++++
 MAINTAINERS                           |  14 +++
 Makefile                              |   2 +
 arch/Kconfig                          |  42 +++++++
 arch/x86/Kconfig                      |   2 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 include/asm-generic/vmlinux.lds.h     |  54 +++++++--
 scripts/Makefile.autofdo              |  25 ++++
 scripts/Makefile.lib                  |  20 ++++
 scripts/Makefile.propeller            |  28 +++++
 tools/objtool/check.c                 |   2 +
 tools/objtool/elf.c                   |  15 ++-
 14 files changed, 524 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/dev-tools/autofdo.rst
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.autofdo
 create mode 100644 scripts/Makefile.propeller


base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
--=20
2.47.0.rc1.288.g06298d1525-goog


