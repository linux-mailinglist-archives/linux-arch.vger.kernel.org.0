Return-Path: <linux-arch+bounces-7996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF899922A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA75B1C240CC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536E1CF2A6;
	Thu, 10 Oct 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKbyADYO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AB1CF5FF
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588251; cv=none; b=Pb89b1fCo6swAphkFR7J0qTfewuYCXpc7DK6nFi81Y7j7PE/JxZ3AKKuOk9t5eYQoVTiHUIRasxlYZ55ZoSZdMDLLEHoV3cKzsykSklADoa3BbToOXI1wiDLd6xHU3sB7D7PUClssmtN4CFH8VRN8IQsCk2m9nY9nWPowVH/fFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588251; c=relaxed/simple;
	bh=4aV4Vf4Dnlms7H78qFliS5vnmDmCAFO20W4kAwl8veI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OW71kOae73vffazHIhVtdo5IPTUSMrmaLV3Fvig0ZaMEUHwlCnRwrKFme213iPSmosDep+hy3g6Q7tkcQvQQ0Td8kv4baf/Myi29shyirQdjko14GhUp83xZK1N7GZAMnY44u7K4bwFu9z3+BIyVircwkgJKb9LIAaqYbswS6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKbyADYO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e26ba37314so25798607b3.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728588247; x=1729193047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX/6HD4slzBTzGEwcNiNs+1L0zFh7B6w5scbjoGcHw4=;
        b=DKbyADYO9DRkWYd69M+c1u1muRjSJOtgTTC60yKZlVA9k4iH1fnfxP/7v4RFAm53wx
         2/EJZaW4ZvdIXPtlM7RHjMexn1It3o5fn2BIGztzt6+pDxFA17lNtclPgkEokJ4q+xsM
         /b5A5ZexJN3nCtzr8l/hSRRM7/ppRcdcs+hYho1yYrcoMo9bMzh7k7uvUlbsZkw4MeSq
         Xxoym2cDBF2KspB8xofjCjlB8yp1rxFsoTLaV5X77Q28AuCi6do185kFxMyV9vpqiNEU
         by1ccl5rWGSnKk6ojcIY++1zV/EnacuxGF9JBPMV2WuGhCXR4gCkv8faTCV2fhBUNTxj
         WH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588247; x=1729193047;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XX/6HD4slzBTzGEwcNiNs+1L0zFh7B6w5scbjoGcHw4=;
        b=M2iQKAJD8nfaeFOEei8uTpTLGmMPDI7YX2Gh1baUfCyxAyqjNtoaRnUWWpduSQKybx
         eAl4/u74o+fdeJGZ4gTDQBFfTtadJUOFFJnbMnINrcad5y/a0OZqoknsZ8uVeBqxxPMH
         MTHPNO28/N81msWnWARTK2r0rCOJWxlv+TR2JDIwKDYiogaODvInbUKzrUgKvb6XMx2V
         5KhdK+gcdRG2PJa2eH82hJHWGWKDkFYeC1FlhCwOqVjEEbjUh/KOV1I5tEZRgmrkULpl
         jaLH8EGYgYnHuEZ/7GbHaNw8VlR4Cb5KeCauBlLTAs1MRtsmu4k2t5U5TwkgIewIvsA/
         I5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcLz1SyKCw6ZWiLDEhuQEbn8XsxACrYwgOwJUiIdKGs/VdolmBu7h5uIvE42JG04N+Z2xiqEb7rOKm@vger.kernel.org
X-Gm-Message-State: AOJu0YynEy36roe2AK1cdb24scdNXhMZspsRnVm4lTexnpax/jXGXviW
	20n4vEsKLvBxKlq/+DA+YGl8JQ85lVqJ49fTDEZmpWu6wKUywL15eGi0otaZT0aO6Q==
X-Google-Smtp-Source: AGHT+IGyWjvgMgjNWbkOgO7lLoUZEFijLdQklOL6eZgBelbYevlja9yvXhNh71Ny3sIrfPmpes+4ZXM=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:731:b0:6b0:d571:3540 with SMTP id
 00721157ae682-6e32217dfb7mr181217b3.6.1728588246387; Thu, 10 Oct 2024
 12:24:06 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:23:53 -0700
In-Reply-To: <20241010192400.451187-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010192400.451187-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010192400.451187-2-xur@google.com>
Subject: [PATCH v3 1/6] Add AutoFDO support for Clang build
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
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the build support for using Clang's AutoFDO. Building the kernel
with AutoFDO does not reduce the optimization level from the
compiler. AutoFDO uses hardware sampling to gather information about
the frequency of execution of different code paths within a binary.
This information is then used to guide the compiler's optimization
decisions, resulting in a more efficient binary. Experiments
showed that the kernel can improve up to 10% in latency.

The support requires a Clang compiler after LLVM 17. This submission
is limited to x86 platforms that support PMU features like LBR on
Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
 and BRBE on ARM 1 is part of planned future work.

Here is an example workflow for AutoFDO kernel:

1) Build the kernel on the HOST machine with LLVM enabled, for example,
       $ make menuconfig LLVM=3D1
    Turn on AutoFDO build config:
      CONFIG_AUTOFDO_CLANG=3Dy
    With a configuration that has LLVM enabled, use the following
    command:
       scripts/config -e AUTOFDO_CLANG
    After getting the config, build with
      $ make LLVM=3D1

2) Install the kernel on the TEST machine.

3) Run the load tests. The '-c' option in perf specifies the sample
   event period. We suggest     using a suitable prime number,
   like 500009, for this purpose.
   For Intel platforms:
      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
        -o <perf_file> -- <loadtest>
   For AMD platforms:
      The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
     For Zen3:
      $ cat proc/cpuinfo | grep " brs"
      For Zen4:
      $ cat proc/cpuinfo | grep amd_lbr_v2
      $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
        -N -b -c <count> -o <perf_file> -- <loadtest>

4) (Optional) Download the raw perf file to the HOST machine.

5) To generate an AutoFDO profile, two offline tools are available:
   create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
   of the AutoFDO project and can be found on GitHub
   (https://github.com/google/autofdo), version v0.30.1 or later. The
   llvm_profgen tool is included in the LLVM compiler itself. It's
   important to note that the version of llvm_profgen doesn't need to
   match the version of Clang. It needs to be the LLVM 19 release or
   later, or from the LLVM trunk.
      $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_file>=
 \
        -o <profile_file>
   or
      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
        --format=3Dextbinary -o <profile_file>

   Note that multiple AutoFDO profile files can be merged into one via:
      $ llvm-profdata merge -o <profile_file>  <profile_1> ... <profile_n>

6) Rebuild the kernel using the AutoFDO profile file with the same config
   as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Stephane Eranian <eranian@google.com>
---
 Documentation/dev-tools/autofdo.rst | 165 ++++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst   |   1 +
 MAINTAINERS                         |   7 ++
 Makefile                            |   1 +
 arch/Kconfig                        |  20 ++++
 arch/x86/Kconfig                    |   1 +
 scripts/Makefile.autofdo            |  23 ++++
 scripts/Makefile.lib                |  10 ++
 tools/objtool/check.c               |   1 +
 9 files changed, 229 insertions(+)
 create mode 100644 Documentation/dev-tools/autofdo.rst
 create mode 100644 scripts/Makefile.autofdo

diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/=
autofdo.rst
new file mode 100644
index 000000000000..c244e2b697a4
--- /dev/null
+++ b/Documentation/dev-tools/autofdo.rst
@@ -0,0 +1,165 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Using AutoFDO with the Linux kernel
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This enables AutoFDO build support for the kernel when using
+the Clang compiler. AutoFDO (Auto-Feedback-Directed Optimization)
+is a type of profile-guided optimization (PGO) used to enhance the
+performance of binary executables. It gathers information about the
+frequency of execution of various code paths within a binary using
+hardware sampling. This data is then used to guide the compiler's
+optimization decisions, resulting in a more efficient binary. AutoFDO
+is a powerful optimization technique, and data indicates that it can
+significantly improve kernel performance. It's especially beneficial
+for workloads affected by front-end stalls.
+
+For AutoFDO builds, unlike non-FDO builds, the user must supply a
+profile. Acquiring an AutoFDO profile can be done in several ways.
+AutoFDO profiles are created by converting hardware sampling using
+the "perf" tool. It is crucial that the workload used to create these
+perf files is representative; they must exhibit runtime
+characteristics similar to the workloads that are intended to be
+optimized. Failure to do so will result in the compiler optimizing
+for the wrong objective.
+
+The AutoFDO profile often encapsulates the program's behavior. If the
+performance-critical codes are architecture-independent, the profile
+can be applied across platforms to achieve performance gains. For
+instance, using the profile generated on Intel architecture to build
+a kernel for AMD architecture can also yield performance improvements.
+
+There are two methods for acquiring a representative profile:
+(1) Sample real workloads using a production environment.
+(2) Generate the profile using a representative load test.
+When enabling the AutoFDO build configuration without providing an
+AutoFDO profile, the compiler only modifies the dwarf information in
+the kernel without impacting runtime performance. It's advisable to
+use a kernel binary built with the same AutoFDO configuration to
+collect the perf profile. While it's possible to use a kernel built
+with different options, it may result in inferior performance.
+
+One can collect profiles using AutoFDO build for the previous kernel.
+AutoFDO employs relative line numbers to match the profiles, offering
+some tolerance for source changes. This mode is commonly used in a
+production environment for profile collection.
+
+In a profile collection based on a load test, the AutoFDO collection
+process consists of the following steps:
+
+#. Initial build: The kernel is built with AutoFDO options
+   without a profile.
+
+#. Profiling: The above kernel is then run with a representative
+   workload to gather execution frequency data. This data is
+   collected using hardware sampling, via perf. AutoFDO is most
+   effective on platforms supporting advanced PMU features like
+   LBR on Intel machines.
+
+#. AutoFDO profile generation: Perf output file is converted to
+   the AutoFDO profile via offline tools.
+
+The support requires a Clang compiler LLVM 17 or later.
+
+Preparation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Configure the kernel with::
+
+   CONFIG_AUTOFDO_CLANG=3Dy
+
+Customization
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+You can enable or disable AutoFDO build for individual file and directorie=
s by
+adding a line similar to the following to the respective kernel Makefile:
+
+- For enabling a single file (e.g. foo.o) ::
+
+   AUTOFDO_PROFILE_foo.o :=3D y
+
+- For enabling all files in one directory ::
+
+   AUTOFDO_PROFILE :=3D y
+
+- For disabling one file ::
+
+   AUTOFDO_PROFILE_foo.o :=3D n
+
+- For disabling all files in one directory ::
+
+   AUTOFDO_PROFILE :=3D n
+
+Workflow
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Here is an example workflow for AutoFDO kernel:
+
+1)  Build the kernel on the HOST machine with LLVM enabled,
+    for example, ::
+
+      $ make menuconfig LLVM=3D1
+
+    Turn on AutoFDO build config::
+
+      CONFIG_AUTOFDO_CLANG=3Dy
+
+    With a configuration that with LLVM enabled, use the following command=
::
+
+      $ scripts/config -e AUTOFDO_CLANG
+
+    After getting the config, build with ::
+
+      $ make LLVM=3D1
+
+2) Install the kernel on the TEST machine.
+
+3) Run the load tests. The '-c' option in perf specifies the sample
+   event period. We suggest using a suitable prime number, like 500009,
+   for this purpose.
+
+   - For Intel platforms::
+
+      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> -o=
 <perf_file> -- <loadtest>
+
+   - For AMD platforms: For Intel platforms:
+     The supported systems are: Zen3 with BRS, or Zen4 with amd_lbr_v2. To=
 check,
+     For Zen3::
+
+      $ cat proc/cpuinfo | grep " brs"
+
+     For Zen4::
+
+      $ cat proc/cpuinfo | grep amd_lbr_v2
+
+     The following command generated the perf data file::
+
+      $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N=
 -b -c <count> -o <perf_file> -- <loadtest>
+
+4) (Optional) Download the raw perf file to the HOST machine.
+
+5) To generate an AutoFDO profile, two offline tools are available:
+   create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
+   of the AutoFDO project and can be found on GitHub
+   (https://github.com/google/autofdo),  version v0.30.1 or later.
+   The llvm_profgen tool is included in the LLVM compiler itself. It's
+   important to note that the version of llvm_profgen doesn't need to matc=
h
+   the version of Clang. It needs to be the LLVM 19 release of Clang
+   or later, or just from the LLVM trunk. ::
+
+      $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_file=
> -o <profile_file>
+
+   or ::
+
+      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> --fo=
rmat=3Dextbinary -o <profile_file>
+
+   Note that multiple AutoFDO profile files can be merged into one via::
+
+      $ llvm-profdata merge -o <profile_file>  <profile_1> <profile_2> ...=
 <profile_n>
+
+6) Rebuild the kernel using the AutoFDO profile file with the same config =
as step 1,
+   (Note CONFIG_AUTOFDO_CLANG needs to be enabled)::
+
+      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
+
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 53d4d124f9c5..6945644f7008 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
    ktap
    checkuapi
    gpio-sloppy-logic-analyzer
+   autofdo
=20
=20
 .. only::  subproject and html
diff --git a/MAINTAINERS b/MAINTAINERS
index d01256208c9f..1b8db863031f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3678,6 +3678,13 @@ F:	kernel/audit*
 F:	lib/*audit.c
 K:	\baudit_[a-z_0-9]\+\b
=20
+AUTOFDO BUILD
+M:	Rong Xu <xur@google.com>
+M:	Han Shen <shenhan@google.com>
+S:	Supported
+F:	Documentation/dev-tools/autofdo.rst
+F:	scripts/Makefile.autofdo
+
 AUXILIARY BUS DRIVER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 R:	Dave Ertman <david.m.ertman@intel.com>
diff --git a/Makefile b/Makefile
index c5493c0c0ca1..bbb6ec68f5dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1018,6 +1018,7 @@ include-$(CONFIG_KMSAN)		+=3D scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+=3D scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+=3D scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+=3D scripts/Makefile.randstruct
+include-$(CONFIG_AUTOFDO_CLANG)	+=3D scripts/Makefile.autofdo
 include-$(CONFIG_GCC_PLUGINS)	+=3D scripts/Makefile.gcc-plugins
=20
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374ea1adc..5e9604960cbb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -811,6 +811,26 @@ config LTO_CLANG_THIN
 	  If unsure, say Y.
 endchoice
=20
+config ARCH_SUPPORTS_AUTOFDO_CLANG
+	bool
+
+config AUTOFDO_CLANG
+	bool "Enable Clang's AutoFDO build (EXPERIMENTAL)"
+	depends on ARCH_SUPPORTS_AUTOFDO_CLANG
+	depends on CC_IS_CLANG && CLANG_VERSION >=3D 170000
+	help
+	  This option enables Clang=E2=80=99s AutoFDO build. When
+	  an AutoFDO profile is specified in variable
+	  CLANG_AUTOFDO_PROFILE during the build process,
+	  Clang uses the profile to optimize the kernel.
+
+	  If no profile is specified, AutoFDO options are
+	  still passed to Clang to facilitate the collection
+	  of perf data for creating an AutoFDO profile in
+	  subsequent builds.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_CFI_CLANG
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..503a0268155a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_RT
+	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
new file mode 100644
index 000000000000..1c9f224bc221
--- /dev/null
+++ b/scripts/Makefile.autofdo
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Enable available and selected Clang AutoFDO features.
+
+CFLAGS_AUTOFDO_CLANG :=3D -fdebug-info-for-profiling -mllvm -enable-fs-dis=
criminator=3Dtrue -mllvm -improved-fs-discriminator=3Dtrue
+
+# If CONFIG_DEBUG_INFO is not enabled, set -gmlt option.
+ifndef CONFIG_DEBUG_INFO
+  CFLAGS_AUTOFDO_CLANG +=3D -gmlt
+endif
+
+ifdef CLANG_AUTOFDO_PROFILE
+  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFILE=
)
+endif
+
+ifdef CONFIG_LTO_CLANG_THIN
+  ifdef CLANG_AUTOFDO_PROFILE
+    KBUILD_LDFLAGS +=3D --lto-sample-profile=3D$(CLANG_AUTOFDO_PROFILE)
+  endif
+  KBUILD_LDFLAGS +=3D --mllvm=3D-enable-fs-discriminator=3Dtrue --mllvm=3D=
-improved-fs-discriminator=3Dtrue -plugin-opt=3Dthinlto
+endif
+
+export CFLAGS_AUTOFDO_CLANG
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 01a9f567d5af..e85d6ac31bd9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -191,6 +191,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
 	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
=20
+#
+# Enable Clang's AutoFDO build flags for a file or directory depending on
+# variables AUTOFDO_PROFILE_obj.o and AUTOFDO_PROFILE.
+#
+ifeq ($(CONFIG_AUTOFDO_CLANG),y)
+_c_flags +=3D $(if $(patsubst n%,, \
+	$(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(is-kernel-object))=
, \
+	$(CFLAGS_AUTOFDO_CLANG))
+endif
+
 # $(src) for including checkin headers from generated source files
 # $(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6604f5d038aa..4c5229991e1e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4557,6 +4557,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__jump_table")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".kcfi_traps")			||
+		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
=20
--=20
2.47.0.rc1.288.g06298d1525-goog


