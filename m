Return-Path: <linux-arch+bounces-7638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63F98E6F7
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 01:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513D61F23A0D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59019F107;
	Wed,  2 Oct 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en/waIBt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77819E990
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912060; cv=none; b=CVDTj8nUNQMtKGYf8QGQIlmxjOfQvE4rR4omcPoZsVIwmO0EP1uuDIYeuhW5SxTXvMOdzL0XXH/q5tJWH+h7d2NdgtUxwd/i5yoIYezfUZnMcsjzt7pIjEIkITwoeBEYLckWU1gGVORFIfkIFQosBgLWWtuF/NnytYdj7TdPzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912060; c=relaxed/simple;
	bh=K95cL12ttFxJWSrxG3pem4VTEN45fAak380wGXFifSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=bm04i3xwlk8/DX7bhuLF+yqgF1VATg30uxkhM4AWRVVJh7x/T1lrpsbBZMhS5zpSswtjnyIsBgLYqOKBG2GON3PtZWc543G+cWcLZfxHp5koYGgaCLkx7CyNsf5Ck5HXDPR3dXQSDNxADmwlzttX828dMo66kQXcMnzvg0Wpjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en/waIBt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2acec0109so9646637b3.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727912057; x=1728516857; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoL1uZ+AYMkBL/wAz3+mNXfHfBaQHMm+XiWLMrd32BM=;
        b=en/waIBtda9MJzOIFUnQhB6JM9VC/haxrUBRUePA15zDKCbUqMYWUniNdfqau45naR
         HvDAugjsxQOk8Fd0H7IyMyNLDab1PyJGsT83eBJEzfmfLawpPhYEHhCkcTFbKSBulGMA
         mNbWR+V99BiMivkxhYoqaxT1sOUOkN5xgi3rDKT5vSijPhQzEXjRNy1T3Ch9ZLvxoYZh
         ULwzYn5wbtlveYxgHfcErO47mK53b6ZnvnqOw/7HH6j0LeVeyo/0jUllNr78aRXjkqUp
         pVVJlGsv/qnzvuYTh+CVj7Rq6Ay93RcWH9toFu48WFhAxXncCZFBB0bUQBSxjt/0ft2J
         419g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912057; x=1728516857;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoL1uZ+AYMkBL/wAz3+mNXfHfBaQHMm+XiWLMrd32BM=;
        b=QLH4A2OJkegE4X1Zy6Gtu6PjX0EmrKYlDibEH83LgPXS/n3iqIzwWZusLgyvJmtZaH
         VH9wMxoo41uo1DbSXjMWIhURLDuiL0KYdrJwGeQqB2ebFjrKa1La+1a7Yp2dgit1lLWJ
         rOlxGjvVp1KAJ3NuHeM9Eqxwc2rx6BUIOGL1KQYm9DQvqQSvTWKoXQ2TXTGqnIiX7pir
         Y/1J4ZnvwycUzHv/MTNenGdsERSJTDIXLIHSaEEQLJ6ErN5EPTn5xWf1PbSNVUx06JWb
         aZvy6bDTtnEFcoG+k/UYMCzIa1iyzZzesnzytyKtccuBqCDMBr69UYzWxh80j2Mie+Mm
         lIgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqS0y9JKwSvkHUhbmGRHREZP3cOszdrubsHJHQJgBgrcrw1qfPRdJQKasucD0GQXw9E4iIIz74z4T6@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSsGXXYqaUXhcL8gB7q7diuzoj/r6ExJAeAp7lGiwbX26WkJ+
	pEHCl+s+ak/1c/z4LHyOJR+MPk5fTicBCfapMG9N7X54UYCsqjweZyV4tHus4KC0Zg==
X-Google-Smtp-Source: AGHT+IFrrYQwnSzsLSpLS6gHFTkc9bIhXKsYySZ6reRQxHK9tcOLo5QapuIprjLeYmtCzzv9WgwuofI=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:9d84:0:b0:e27:3e6a:345 with SMTP id
 3f1490d57ef6-e273e6a04demr2925276.10.1727912056715; Wed, 02 Oct 2024 16:34:16
 -0700 (PDT)
Date: Wed,  2 Oct 2024 16:33:59 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002233409.2857999-1-xur@google.com>
Subject: [PATCH v2 0/6] Add AutoFDO and Propeller support for Clang build
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, x86@kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
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


Rong Xu (6):
  Add AutoFDO support for Clang build
  objtool: Fix unreachable instruction warnings for weak funcitons
  Change the symbols order when --ffuntion-sections is enabled
  AutoFDO: Enable -ffunction-sections for the AutoFDO build
  AutoFDO: Enable machine function split optimization for AutoFDO
  Add Propeller configuration for kernel build.

 Documentation/dev-tools/autofdo.rst   | 203 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   2 +
 Documentation/dev-tools/propeller.rst | 188 ++++++++++++++++++++++++
 MAINTAINERS                           |  14 ++
 Makefile                              |   2 +
 arch/Kconfig                          |  42 ++++++
 arch/x86/Kconfig                      |   2 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 include/asm-generic/vmlinux.lds.h     |  54 ++++++-
 scripts/Makefile.autofdo              |  25 ++++
 scripts/Makefile.lib                  |  20 +++
 scripts/Makefile.propeller            |  22 +++
 tools/objtool/check.c                 |   2 +
 tools/objtool/elf.c                   |  15 +-
 14 files changed, 583 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/dev-tools/autofdo.rst
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.autofdo
 create mode 100644 scripts/Makefile.propeller

--=20
2.46.1.824.gd892dcdcdd-goog


