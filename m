Return-Path: <linux-arch+bounces-8502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506989AD7EC
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 00:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BA51F26B9D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 22:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0891FF619;
	Wed, 23 Oct 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1a7YiAM4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68111FDFB7
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723471; cv=none; b=hG9N83GMpzzFETExrPNatefzz+/Z6WPt09PMjzPJ/jlwZU7ARvrHMyDW0jSVCwdaSksA2ZtGQR0IOFIdd8o+fxnmeg8UN9y8jLtzwO83+Ss14o/f4ma1mSL0vsSjkizTvVArzd3V/F9kKmjezXvFdUiWsFS2j644jhX8a31BgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723471; c=relaxed/simple;
	bh=+EYzE6bUpFWaysYBTiPiE47x9uhx5by9Fcc63SZyPDw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MSRi5LfyxynvUFp/rIS8om6YMD804AD3YtuaLeysennrqkZl+lUiu9KsWDCD4/6poQTQ1yHnbM1SbbTHQo/RHOcaeym1HKaL2p6qI1wPAH25+mcHsPvCkjwLS8wDEy+Pqbgz4O4z4qNmndSndzvSNT2+2sCp/P7CjeNKLaRjVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1a7YiAM4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370139342so5309057b3.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729723468; x=1730328268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRI8lQFqrxj2JMwwXNsn61r8WW6x3Uv7UcXimMEDnvE=;
        b=1a7YiAM44ZWh45H7LZMmb25NDZKq2YYTNAcFy8SiOBQYT/5X6ZGGijqjCwah1qn5Ac
         SnVdOzyjEIGbYim4q3WdsfkFo92MJDyCnBfLMSOua9P3cuePROiglodkMO2FGerRI8j0
         +82xNpULDDRnH/Q0dzRjAImZo6OkcXDS+1648ox4x/RiuGaXMsJi/+yL+1yWymUoQ6bs
         Jpw0byU5tyMGTNCvyYloTk7SUG8eYL8Crz0WeYx2mAf+WpwSUhEbwm+ZpOvEOFD/7uYb
         smjofdcOXOOD7+2ptt/IE/+nzPIjdWCCBc93iGqOdRwXnqS/4chI1M2NVdivyo+VMACX
         v7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723468; x=1730328268;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRI8lQFqrxj2JMwwXNsn61r8WW6x3Uv7UcXimMEDnvE=;
        b=jG8cLdu7L4hB0CuIx5C1crzYay04mtIgkyIvAyCMN0Efc/w8qo/cz6c+UxjbdXfb4b
         hwFDkBvcKnO+8hQbD+n90ZYs3Fu7xkhEcCRnJhT+sbnsBtkdYvNCHyySirf6VsVhW753
         q5B75vDAS4xQlYrDS/9azJl9nKJhyikTdWFaNImUaxV6R9pkkxksEyuL5opHV7WJtuqC
         wEKwrHCmH11XPTHGghjHUw1d/YKFR4dINMZyUYBHxHfJEKEeAJdEUD2vb8430dl4Tlrr
         gqzWt/3PtZvBhUDbiR1pPbAq7UqrUVT/cLG3234GES04eF7CzUIowanGiRVqkFaiD0FP
         2gYA==
X-Forwarded-Encrypted: i=1; AJvYcCVEW8vFmnxP0ZmF7hHVIumnKr7j5qVA1azprl65s+b03n+LVXRrdyL0eRIoELCu6EYkJcDP4hwVuIaT@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB4wyF59+sjx2WzVAQ4uKTh9pdMRqA3stp6LbC4uZQE6WB/Rm
	Um8pVhivKzN+iB4LRPkvpmUxHV1lftHTujDT3QNwS4Bo6jiWvrCLTbUL2W19EhzPGg==
X-Google-Smtp-Source: AGHT+IHEhUPdvrUni2UNIvcsiSpZhxKe9mNePMaOkhFVX05UhPsXKLSjopyHNUbI6OF4TwIET4joc14=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:2501:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6e85814c9d7mr2347b3.1.1729723467553; Wed, 23 Oct 2024 15:44:27
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:43:59 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023224409.201771-1-xur@google.com>
Subject: [PATCH v5 0/7] Add AutoFDO and Propeller support for Clang build
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
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

[P 4] Add markers for text_unlikely and text_hot sections

[P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build

[P 6] Enable Machine Function Split (MFS) optimization for AutoFDO

[P 7] Add Propeller configuration to the kernel build

Patch 1 provides basic AutoFDO build support. Patches 2 to 6 further
enhance the performance of AutoFDO builds and are functionally dependent
on Patch 1. Patch 7 enables support for Propeller and is dependent on
patch 2 to patch 4.

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

For ARM, we plan to send patches for SPE-based Propeller when
AutoFDO for Arm is ready.

Experiments and Results

Experiments were conducted to compare the performance of AutoFDO-optimized
kernel images (version 6.9.x) against default builds.. The evaluation
encompassed both open source microbenchmarks and real-world production
services from Google and Meta. The selected microbenchmarks included Neper,
a network subsystem benchmark, and UnixBench which is a comprehensive suite
for assessing various kernel operations.

For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement in its
index score under low system load and a 2.6% improvement under high system
load.

For further details on the improvements observed in Google and Meta's
production services, please refer to the LLVM discourse post:
https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-inclu=
ding-thinlto-and-propeller/79108

Thanks,

Rong Xu and Han Shen

Change-Logs in V2:
Rebased to commit e32cde8d2bd7 ("Merge tag 'sched_ext-for-6.12-rc1-fixes-1'
of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

1. [P 0]: moved the Propeller description to the top (Peter Zijlstra)
2. [P 1]: (1) Makefile: fixed file order (Masahiro Yamada)
          (2) scripts/Makefile.lib: used is-kernel-object to exclude
              files (Masahiro Yamada)
          (3) scripts/Makefile.autofdo: improved the code (Masahiro Yamada)
          (4) scripts/Makefile.autofdo: handled when DEBUG_INFO disabled
	      (Nick Desaulniers)
3. [P 2]: tools/objtool/elf.c: updated the comments (Peter Zijlstra)
4. [P 3]: include/asm-generic/vmlinux.lds.h:
          (1) explicit set cold text function aligned (Peter Zijlstra and
	      Peter Anvin)
          (2) set hot-text page aligned
5. [P 6]: (1) include/asm-generic/vmlinux.lds.h: made Propeller not
              depending on AutoFDO
          (2) Makefile: fixed file order (Masahiro Yamada)
          (3) scripts/Makefile.lib: used is-kernel-object to exclude
              files (Masahiro Yamada). This removed the change in
              arch/x86/platform/efi/Makefile,
              drivers/firmware/efi/libstub/Makefile, and
              arch/x86/boot/compressed/Makefile.
              And this also addressed the comment from Arnd Bergmann
	      regarding arch/x86/purgatory/Makefile
          (4) scripts/Makefile.propeller: improved the code
	      (Masahiro Yamada)

Change-Logs in V3:
Rebased to commit eb952c47d154 ("Merge tag 'for-6.12-rc2-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

Integrated the following changes suggested by Mike Rapoport.
1. [P 1]: autofdo.rst: removed code-block directives and used "::"
2. [P 6]: propeller.rst: removed code-block directives and use "::"

Change-Logs in V4:
1. [P 1]: autofdo.rst: fixed a typo for create_llvm_prof command.

Change-Logs in V5:
Added "Tested-by: Yonghong Song <yonghong.song@linux.dev>" to all patches.

Integrated the following changes suggested by Masahiro Yamada.
1. [P 0]: (1) moved ARM related remark from patch 6 to here
2. [P 1]: (1) autofdo.rst: improved the documentation
          (2) scripts/Makefile.autofdo: improved comments and used ifdef
	      instead of ifeq
3. [P 3]: Make the layout change unconditionally
4. [P 4]: Split the patch into two: this patch only added the markers, and
          the AutoFDO change went to the new [P 5]
5. [P 7]: (1) propeller.rst: improved the documentation
          (2) scripts/Makefile.propeller: improved comments and used ifdef
	      instead of ifeq
	  (3) arch/Kconfig: made Propeller build independent of AutoFDO
	      build
	  (4) moved ARM related remarks to the cover letter

Rong Xu (7):
  Add AutoFDO support for Clang build
  objtool: Fix unreachable instruction warnings for weak functions
  Change the symbols order when --ffunction-sections is enabled
  Add markers for text_unlikely and text_hot sections
  AutoFDO: Enable -ffunction-sections for the AutoFDO build
  AutoFDO: Enable machine function split optimization for AutoFDO
  Add Propeller configuration for kernel build

 Documentation/dev-tools/autofdo.rst   | 167 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   2 +
 Documentation/dev-tools/propeller.rst | 162 +++++++++++++++++++++++++
 MAINTAINERS                           |  14 +++
 Makefile                              |   2 +
 arch/Kconfig                          |  39 ++++++
 arch/x86/Kconfig                      |   2 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 include/asm-generic/vmlinux.lds.h     |  49 ++++++--
 scripts/Makefile.autofdo              |  24 ++++
 scripts/Makefile.lib                  |  20 +++
 scripts/Makefile.propeller            |  28 +++++
 tools/objtool/check.c                 |   2 +
 tools/objtool/elf.c                   |  15 ++-
 14 files changed, 514 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/dev-tools/autofdo.rst
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.autofdo
 create mode 100644 scripts/Makefile.propeller


base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
--=20
2.47.0.105.g07ac214952-goog


