Return-Path: <linux-arch+bounces-5659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A393E941
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 22:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555381C20E6B
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BA757EB;
	Sun, 28 Jul 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBT4Q/EF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C622616
	for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198645; cv=none; b=Qu5Sr+9btnqEOJ4in4ix7Lm2hH/dpFZZPiY7b1Bb4Qmr7Nd5K1KK5NrKTkbI/kZ1V/E5fxMnvkPGy2f36elQ9aKW3Gz8dHzzPnxQ05H/IRK8Zpch8ju7bHPTCAfHAkAFCfzcTaUJIgg08y3IvWIbRAqtF8HsHO+kL6d5w4kM68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198645; c=relaxed/simple;
	bh=ncQAehrbiYUFhpYdfsf1Rwz5h+YNqrVSI2J3upkP1mE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dalY45fMP6ubMI2AQ295R+zj8g1IluVSYR9jkpThHOFXSkHjaotLghkpdGlt4fixx2ks4HW9/nFn97QW09dVp8c1pTYOvuNkc2o1Sn2Jbyy5JH7kz5etk+kDKGGj107amUkMJhp0qY/VI84JXzajCK0gN0R1HvY3yUuJVW5AVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBT4Q/EF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b365efb6cso3149159276.3
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198642; x=1722803442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU7GP/dv7Frutc0dmFAU8Vflj8kpPiaVIIi3HMkG8Ic=;
        b=NBT4Q/EFD4FWT3wQIH/70dZvdVu6x2Npq9vMoEs/e2FhdxO/+IuVrkjH/Vb3pEGxYU
         2nedUABoS5iDdjgEKAMiDXg5jy5gzydOj4GVdyDEFaeavarwJb+jcNOeTGKdex/KguU7
         LW+ROkJnKxg85oMapcINT8QZk7VrKhBFP004W1K5llYUBd6aF2K90Axi9ovx4OG80K7+
         PrXfITNN1Gc0Q3nbX/A6KaATev5B67vSmaJyXnPmPgr8/mEuY1d54588iYyzehmJgB65
         tHDLFBBKBobxXIS5C8WYTp0M4BQ1Km2wEBXnYU02hJ4KqTDtnv0Mrl1foyk6/TYIUC49
         mSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198642; x=1722803442;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU7GP/dv7Frutc0dmFAU8Vflj8kpPiaVIIi3HMkG8Ic=;
        b=oiG8BOVJSdqccI4wCrtyrql+YcW0rMV84MM8lsXsrDqRLwh2BgLnus16AtJaBGsJT7
         KCLVPGZ74DsVZfOBbdoZX9cgKGfJleTugwN3B4LkuoWdBR/Y3OOKreCjO64SboJdGwJS
         j392Ve5x5Uiit6su2+/w0qDvd66c3On31QZlbtkjJ6c6LiGccHpH8TXsbhkknOLgoQpx
         arT0yNy0BrxEZhBPJotjoGFm21Jq42YltEWGXjONwo7iImIlHHE3S3OnJs4C7ZmsgtBM
         CrTfaGaH3jVMf2M8rofZq+j2Ooau/zjaQrEsWuU6eW+C5u40OWwHCPW2rkcNx3s4Z5xC
         gzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSXai0d8MhMOmtbdjyTc4n3cZ6/ZyaV7b49eBsUnnFfTnlhNjPUG5qidoG6rhRJ8EBylkeej5lYsUZoQoEgta5PE7jKBf5tUeRiQ==
X-Gm-Message-State: AOJu0YxOqsoZOPs7DRZms2cv9yI+kp7nbRSHiNKyD6OqKayo32HtizBS
	/KqLqfcr19yVNVvSwkOFZ75Nzv9crdoHZgMIVhw1tbzTHimlJX31WhF+dLyXjxtVHg==
X-Google-Smtp-Source: AGHT+IHQ8sWksXB0JrDTbrpjN2gi6HWebCbj9TLI6Z66yiqxBHhG2zub4bqcDdxYdAB3wKdxtfEYXZU=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:6902:18c1:b0:e05:6026:f741 with SMTP id
 3f1490d57ef6-e0b5442a26bmr459566276.2.1722198641777; Sun, 28 Jul 2024
 13:30:41 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-1-xur@google.com>
Subject: [PATCH 0/6] Add AutoFDO and Propeller support for Clang build
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
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
to iFDO for benchmark applications. Similar to AutoFDO, Propeller too
utilizes hardware sampling to collect profiles and apply post-link
optimizations to improve the benchmark=E2=80=99s performance over and above
AutoFDO.

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
memory. Propeller is a profile-guided, post-link optimizer that improves
the performance of large-scale applications compiled with LLVM. It
operates by relinking the binary based on an additional round of runtime
profiles, enabling precise optimizations that are not possible at
compile time.

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
 arch/x86/boot/compressed/Makefile     |   3 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 arch/x86/platform/efi/Makefile        |   1 +
 drivers/firmware/efi/libstub/Makefile |   2 +
 include/asm-generic/vmlinux.lds.h     |  56 ++++++-
 scripts/Makefile.autofdo              |  22 +++
 scripts/Makefile.lib                  |  20 +++
 scripts/Makefile.propeller            |  25 ++++
 tools/objtool/check.c                 |   2 +
 tools/objtool/elf.c                   |  13 +-
 17 files changed, 588 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/dev-tools/autofdo.rst
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.autofdo
 create mode 100644 scripts/Makefile.propeller


base-commit: 9903efbddba0d14133b5a3c75088b558d2e34ac3
--=20
2.46.0.rc1.232.g9752f9e123-goog


