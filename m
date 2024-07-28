Return-Path: <linux-arch+bounces-5665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD293E95D
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 22:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5445D1F2198E
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01D7F499;
	Sun, 28 Jul 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GB13msEA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D7E575
	for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198670; cv=none; b=aC5DfHO7R8F0FmLrEySq974/9HBVBJd775SI1aoB/gSuoc56nhNAS354JtDdrhjSVcxxFg/3JLKKxxKks4WLhINsZVhk/Srl1KFtxg1PSRp3MJuUttJZkQjpc6JIf0RDZwxtfH1SeozDB5agIT6aRAiuBUxzBlgUD5yCNPHzEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198670; c=relaxed/simple;
	bh=XwREC3Zn27Mwzwot+SrxEwvb50Hp1zKL3+sNJmz6Mf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CoICP4K0LbXQb6hhZMK5wFIUmFCcNkhrLFPKcAW11lHfmRmBWxvQl7AqRVJswdo00XTwoTF568Bx+XexgkIrZCljVXaJafq32I4u8NiSQk04/mPNysR0LJ4Ga3im5buML5IpKk86KOVmbs3KpWafFgFRzBKdwgcOfbHPX1wvM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GB13msEA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6688b5b40faso50504047b3.2
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198667; x=1722803467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7mCEB24MiuOLEIX0+MZEpfyFZDjGobAIp2IOnV2iDg=;
        b=GB13msEAQC9SelAKNqj0jhCnF/f7CXgWeNjXaCTJdr0HVqMc4IRDdnx2UvEpdMJqzH
         QuQhdd00u26CCHwQQXO1koV65Ri4xMT69l+gVS6BAMBhMfNBvrlixM/xuF+0V3C68yQT
         /9wUCm7oIlNcx9ho4c9M5QUJHmO2j0ColfLeYEK+/kvqvCIWaLII0+c7MeAtMDpGOqEq
         bQ2+eigJZdM6nsHhnibaDH7KpjxF5L1KuJz9++mJAu5TB+TYu+Eb/xSGUu98KKNEz/9/
         zn/zHq0xkLMcdjJ2bB/tHeyZzaDC1WQ0KX3zsF3Dxm4aJNo/PbQjsKHXZTdxtK7TX+V1
         JePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198667; x=1722803467;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7mCEB24MiuOLEIX0+MZEpfyFZDjGobAIp2IOnV2iDg=;
        b=BqEoihL8AkBAK4qPdOF6tKwgVQweS36k5UZFvbmpEa1uNbnxKS/ZNs47Gktjoo7btq
         pAKKHeG6iUsDvwcLzXZvVz6el0dIkb+wab3rHo7ifvfcL2iYOvsxwvxmnA4QL0zd9qPu
         FCXpzfxSsyf0RWHfhERoJhZqH/Y68Ap4uIMNwJ2iDT1teoJAJ6+xYURjfqy6Iae2+uw6
         DRmo/aM1K/JcmebMkJMR3D+7FA3zcSof5xkbCjqrkKS+iMW5r97YI9ezMmYP+bfwJG4b
         XDpXBREbul+sbv5ic74mmIoj1ZMu4OwJ8VCazNFo2cGpNK9xNBSaXlsZ5wytQtootq8o
         g5wA==
X-Forwarded-Encrypted: i=1; AJvYcCUocLKLtK1QpbImRSmlvgUf86XIsYvi5TsDg4FPn5zLW7SDySxn7xYFS6mR1pzvnT7G0Nu/tjMvhl6nCKU+4KPTbODaWSTPDNhxIQ==
X-Gm-Message-State: AOJu0YxcdQ3ZUs2d9d76JbALSWSlhXj3zLFsgCrDRW7Afqg9qYPHqrym
	n0u2ZXjpj71RiLiRb8te+EODB3INGVId6/1JRoFLuwfI7t6V67rNVWASCHy6j/YoTA==
X-Google-Smtp-Source: AGHT+IGu4sbDUjEAKDB0hLyn3rxjDGmQnEZfdZL/ZgIho/aHfAuBV4gpPSxV5Bc3IDQzXkaJsNIU3DI=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:6902:1029:b0:e0b:9b5:8647 with SMTP id
 3f1490d57ef6-e0b544ec4ddmr11322276.8.1722198666571; Sun, 28 Jul 2024 13:31:06
 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:59 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-7-xur@google.com>
Subject: [PATCH 6/6] Add Propeller configuration for kernel build.
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
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the build support for using Clang's Propeller optimizer. Like
AutoFDO, Propeller uses hardware sampling to gather information
about the frequency of execution of different code paths within a
binary. This information is then used to guide the compiler's
optimization decisions, resulting in a more efficient binary.

The support requires a Clang compiler LLVM 19 or later, and the
create_llvm_prof tool
(https://github.com/google/autofdo/releases/tag/v0.30.1). This
submission is limited to x86 platforms that support PMU features
like LBR on Intel machines and AMD Zen3 BRS.

For Arm, we plan to send patches for SPE-based Propeller when
AutoFDO for Arm is ready.

Here is an example workflow for building an AutoFDO+Propeller
optimized kernel:

1) Build the kernel on the HOST machine, with AutoFDO and Propeller
   build config
      CONFIG_AUTOFDO_CLANG=3Dy
      CONFIG_PROPELLER_CLANG=3Dy
   then
      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile>

=E2=80=9C<autofdo_profile>=E2=80=9D is the profile collected when doing a n=
on-Propeller
AutoFDO build. This step builds a kernel that has the same optimization
level as AutoFDO, plus a metadata section that records basic block
information. This kernel image runs as fast as an AutoFDO optimized
kernel.

2) Install the kernel on test/production machines.

3) Run the load tests. The '-c' option in perf specifies the sample
   event period. We suggest using a suitable prime number,
   like 500009, for this purpose.
   For Intel platforms:
      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
        -o <perf_file> -- <loadtest>
   For AMD platforms:
      The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
      # To see if Zen3 support LBR:
      $ cat proc/cpuinfo | grep " brs"
      # To see if Zen4 support LBR:
      $ cat proc/cpuinfo | grep amd_lbr_v2
      # If the result is yes, then collect the profile using:
      $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
        -N -b -c <count> -o <perf_file> -- <loadtest>

4) (Optional) Download the raw perf file to the HOST machine.

5) Generate Propeller profile:
   $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
     --format=3Dpropeller --propeller_output_module_name \
     --out=3D<propeller_profile_prefix>_cc_profile.txt \
     --propeller_symorder=3D<propeller_profile_prefix>_ld_profile.txt

   =E2=80=9Ccreate_llvm_prof=E2=80=9D is the profile conversion tool, and a=
 prebuilt
   binary for linux can be found on
   https://github.com/google/autofdo/releases/tag/v0.30.1 (can also build
   from source).

   "<propeller_profile_prefix>" can be something like
   "/home/user/dir/any_string".

   This command generates a pair of Propeller profiles:
   "<propeller_profile_prefix>_cc_profile.txt" and
   "<propeller_profile_prefix>_ld_profile.txt".

6) Rebuild the kernel using the AutoFDO and Propeller profile files.
      CONFIG_AUTOFDO_CLANG=3Dy
      CONFIG_PROPELLER_CLANG=3Dy
   and
      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile> \
        CLANG_PROPELLER_PROFILE_PREFIX=3D<propeller_profile_prefix>

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Stephane Eranian <eranian@google.com>
---
 Documentation/dev-tools/index.rst     |   1 +
 Documentation/dev-tools/propeller.rst | 188 ++++++++++++++++++++++++++
 MAINTAINERS                           |   7 +
 Makefile                              |   1 +
 arch/Kconfig                          |  22 +++
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/compressed/Makefile     |   3 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 arch/x86/platform/efi/Makefile        |   1 +
 drivers/firmware/efi/libstub/Makefile |   2 +
 include/asm-generic/vmlinux.lds.h     |   8 +-
 scripts/Makefile.lib                  |  10 ++
 scripts/Makefile.propeller            |  25 ++++
 tools/objtool/check.c                 |   1 +
 14 files changed, 270 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.propeller

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 46636e4efe15..16e33eadb73b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -33,6 +33,7 @@ Documentation/dev-tools/testing-overview.rst
    ktap
    checkuapi
    autofdo
+   propeller
=20
=20
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/propeller.rst b/Documentation/dev-tool=
s/propeller.rst
new file mode 100644
index 000000000000..15ef0e6d973e
--- /dev/null
+++ b/Documentation/dev-tools/propeller.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Using Propeller with the Linux kernel
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This enables Propeller build support for the kernel when using Clang
+compiler. Propeller is a profile-guided optimization (PGO) method used
+to optimize binary executables. Like AutoFDO, it utilizes hardware
+sampling to gather information about the frequency of execution of
+different code paths within a binary. Unlike AutoFDO, this information
+is then used right before linking phase to optimize (among others)
+block layout within and across functions.
+
+A few important notes about adopting Propeller optimization:
+
+#. Although it can be used as a standalone optimization step, it is
+   strongly recommended to apply Propeller on top of AutoFDO,
+   AutoFDO+ThinLTO or Instrument FDO. The rest of this document
+   assumes this paradigm.
+
+#. Propeller uses another round of profiling on top of
+   AutoFDO/AutoFDO+ThinLTO/iFDO. The whole build process involves
+   "build-afdo - train-afdo - build-propeller - train-propeller -
+   build-optimized".
+
+#. Propeller requires LLVM 19 release or later for Clang/Clang++
+   and the linker(ld.lld).
+
+#. In addition to LLVM toolchain, Propeller requires a profiling
+   conversion tool: https://github.com/google/autofdo with a release
+   after v0.30.1: https://github.com/google/autofdo/releases/tag/v0.30.1.
+
+The Propeller optimization process involves the following steps:
+
+#. Initial building: Build the AutoFDO or AutoFDO+ThinLTO binary as
+   you would normally do, but with a set of compile-time / link-time
+   flags, so that a special metadata section is created within the
+   kernel binary. The special section is only intend to be used by the
+   profiling tool, it is not part of the runtime image, nor does it
+   change kernel run time text sections.
+
+#. Profiling: The above kernel is then run with a representative
+   workload to gather execution frequency data. This data is collected
+   using hardware sampling, via perf. Propeller is most effective on
+   platforms supporting advanced PMU features like LBR on Intel
+   machines. This step is the same as profiling the kernel for AutoFDO
+   (the exact perf parameters can be different).
+
+#. Propeller profile generation: Perf output file is converted to a
+   pair of Propeller profiles via an offline tool.
+
+#. Optimized build: Build the AutoFDO or AutoFDO+ThinLTO optimized
+   binary as you would normally do, but with a compile-time /
+   link-time flag to pick up the Propeller compile time and link time
+   profiles. This build step uses 3 profiles - the AutoFDO profile,
+   the Propeller compile-time profile and the Propeller link-time
+   profile.
+
+#. Deployment: The optimized kernel binary is deployed and used
+   in production environments, providing improved performance
+   and reduced latency.
+
+Preparation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Configure the kernel with:
+
+   .. code-block:: make
+
+      CONFIG_AUTOFDO_CLANG=3Dy
+      CONFIG_PROPELLER_CLANG=3Dy
+
+Customization
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+You can enable or disable Propeller build for individual file and
+directories by adding a line similar to the following to the
+respective kernel Makefile:
+
+- For enabling a single file (e.g. foo.o)
+
+     .. code-block:: make
+
+        PROPELLER_PROFILE_foo.o :=3D y
+
+- For enabling all files in one directory
+
+     .. code-block:: make
+
+        PROPELLER_PROFILE :=3D y
+
+- For disabling one file
+
+     .. code-block:: make
+
+        PROPELLER_PROFILE_foo.o :=3D n
+
+- For disabling all files in one directory
+
+     .. code-block:: make
+
+        PROPELLER__PROFILE :=3D n
+
+
+Workflow
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Here is an example workflow for building an AutoFDO+Propeller kernel:
+
+1) Assuming an AutoFDO profile is already collected following
+   instructions in the AutoFDO document, build the kernel on the HOST
+   machine, with AutoFDO and Propeller build configs:
+
+      .. code-block:: make
+
+         CONFIG_AUTOFDO_CLANG=3Dy
+         CONFIG_PROPELLER_CLANG=3Dy
+
+   and
+
+      .. code-block:: sh
+
+         $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo-profile-name>
+
+2) Install the kernel on the TEST machine.
+
+3) Run the load tests. The '-c' option in perf specifies the sample
+   event period. We suggest using a suitable prime number, like 500009,
+   for this purpose.
+
+   - For Intel platforms:
+
+      .. code-block:: sh
+
+         $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c \
+           <count> -o <perf_file> -- <loadtest>
+
+   - For AMD platforms:
+
+      .. code-block:: sh
+
+         $ perf record --pfm-event RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k \
+           -a -N -b -c <count> -o <perf_file> -- <loadtest>
+
+   Note you can repeat the above steps to collect multiple <perf_file>s.
+
+4) (Optional) Download the raw perf file(s) to the HOST machine.
+
+5) Use the create_llvm_prof tool (https://github.com/google/autofdo) to Ge=
nerate Propeller profile.
+
+      .. code-block:: sh
+
+         $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
+                            --format=3Dpropeller --propeller_output_module=
_name \
+                            --out=3D<propeller_profile_prefix>_cc_profile.=
txt \
+                            --propeller_symorder=3D<propeller_profile_pref=
ix>_ld_profile.txt
+
+   "<propeller_profile_prefix>" can be something like
+   "/home/user/dir/any_string".
+
+   This command generates a pair of Propeller profiles:
+   "<propeller_profile_prefix>_cc_profile.txt" and
+   "<propeller_profile_prefix>_ld_profile.txt".
+
+   If there are more than 1 perf_file collected in the previous step,
+   you can create a temp list file "<perf_file_list>" with each line
+   containing one perf file name and run:
+
+      .. code-block:: sh
+
+         $ create_llvm_prof --binary=3D<vmlinux> --profile=3D@<perf_file_l=
ist> \
+                            --format=3Dpropeller --propeller_output_module=
_name \
+                            --out=3D<propeller_profile_prefix>_cc_profile.=
txt \
+                            --propeller_symorder=3D<propeller_profile_pref=
ix>_ld_profile.txt
+
+6) Rebuild the kernel using the AutoFDO and Propeller profiles.
+
+      .. code-block:: make
+
+         CONFIG_AUTOFDO_CLANG=3Dy
+         CONFIG_PROPELLER_CLANG=3Dy
+
+   and
+
+      .. code-block:: sh
+
+         $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file> CLANG_PROP=
ELLER_PROFILE_PREFIX=3D<propeller_profile_prefix>
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a89e7f0d9d5..0c7f3cebe4fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17974,6 +17974,13 @@ S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
=20
+PROPELLER BUILD
+M:	Rong Xu <xur@google.com>
+M:	Han Shen <shenhan@google.com>
+S:	Supported
+F:	Documentation/dev-tools/propeller.rst
+F:	scripts/Makefile.propeller
+
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
diff --git a/Makefile b/Makefile
index 5ae30cc94a26..85a96d973f20 100644
--- a/Makefile
+++ b/Makefile
@@ -1025,6 +1025,7 @@ include-$(CONFIG_KCOV)		+=3D scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+=3D scripts/Makefile.randstruct
 include-$(CONFIG_GCC_PLUGINS)	+=3D scripts/Makefile.gcc-plugins
 include-$(CONFIG_AUTOFDO_CLANG)	+=3D scripts/Makefile.autofdo
+include-$(CONFIG_PROPELLER_CLANG)	+=3D scripts/Makefile.propeller
=20
 include $(addprefix $(srctree)/, $(include-y))
=20
diff --git a/arch/Kconfig b/arch/Kconfig
index e12599c4ab63..5b136e904400 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -822,6 +822,28 @@ config AUTOFDO_CLANG
=20
 	  If unsure, say N.
=20
+config ARCH_SUPPORTS_PROPELLER_CLANG
+	bool
+
+config PROPELLER_CLANG
+	bool "Enable Clang's Propeller build"
+	depends on ARCH_SUPPORTS_PROPELLER_CLANG
+	depends on AUTOFDO_CLANG
+	depends on CC_IS_CLANG && CLANG_VERSION >=3D 190000
+	help
+	  This option enables Clang=E2=80=99s Propeller build which
+	  is on top of AutoFDO build. When the Propeller profiles
+	  is specified in variable CLANG_PROPELLER_PROFILE_PREFIX
+	  during the build process, Clang uses the profiles to
+	  optimize the kernel.
+
+	  If no profile is specified, Proepller options are
+	  still passed to Clang to facilitate the collection
+	  of perf data for creating the Propeller profiles in
+	  subsequent builds.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_CFI_CLANG
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dca526b1364f..6fb5269d39b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,6 +123,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
+	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/M=
akefile
index f2051644de94..35d19b4e6361 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -17,6 +17,9 @@
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
=20
+# Do not run Propeller optimizer for early boot code.
+PROPELLER_PROFILE              :=3D n
+
 targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bi=
n.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
=20
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3509afc6a672..167dd05323cf 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -440,6 +440,10 @@ SECTIONS
=20
 	STABS_DEBUG
 	DWARF_DEBUG
+#ifdef CONFIG_PROPELLER_CLANG
+	.llvm_bb_addr_map : { *(.llvm_bb_addr_map) }
+#endif
+
 	ELF_DETAILS
=20
 	DISCARDS
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefil=
e
index 543df9a1379d..e0c846b6d636 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE :=3D n
 GCOV_PROFILE :=3D n
+PROPELLER_PROFILE :=3D n
=20
 obj-$(CONFIG_EFI) 		+=3D memmap.o quirks.o efi.o efi_$(BITS).o \
 				   efi_stub_$(BITS).o
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/l=
ibstub/Makefile
index 06f0428a723c..55ca5250df1a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -56,6 +56,8 @@ KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_CFI), $(KBUILD=
_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
=20
+PROPELLER_PROFILE		:=3D n
+
 lib-y				:=3D efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 7d9dc8a3c046..ea3d8bf51edd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,14 +95,14 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
- * With LTO_CLANG, the linker also splits sections by default, so we need
- * these macros to combine the sections during the final link.
+ * CONFIG_AUTOFD_CLANG and CONFIG_PROPELLER_CLANG will also split text sec=
tions
+ * and cluster them in the linking time.
  *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CL=
ANG) || \
-defined(CONFIG_AUTOFDO_CLANG)
+defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
@@ -612,7 +612,7 @@ defined(CONFIG_AUTOFDO_CLANG)
  * first when in these builds.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CL=
ANG) || \
-defined(CONFIG_AUTOFDO_CLANG)
+defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_TEXT							\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c2cab5adaf25..e239fa709c20 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -219,6 +219,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
 	$(CFLAGS_AUTOFDO_CLANG))
 endif
=20
+#
+# Enable Clang's Propeller build flags for a file or directory depending o=
n
+# variables AUTOFDO_PROPELLER_obj.o and PROPELLER_PROFILE.
+#
+ifeq ($(CONFIG_PROPELLER_CLANG),y)
+_c_flags +=3D $(if $(patsubst n%,, \
+	$(AUTOFDO_PROFILE_$(basetarget).o)$(AUTOFDO_PROFILE)$(PGO_PROFILE)$(PROPE=
LLER_PROFILE)y), \
+	$(CFLAGS_PROPELLER_CLANG))
+endif
+
 # $(src) for including checkin headers from generated source files
 # $(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
new file mode 100644
index 000000000000..0c9318be5f64
--- /dev/null
+++ b/scripts/Makefile.propeller
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Enable available and selected Clang Propeller features.
+# Propeller required debug information to embed module names in the profil=
es.
+CFLAGS_PROPELLER_CLANG :=3D -fdebug-info-for-profiling
+
+ifdef CLANG_PROPELLER_PROFILE_PREFIX
+CFLAGS_PROPELLER_CLANG +=3D -fbasic-block-sections=3Dlist=3D$(CLANG_PROPEL=
LER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
+KBUILD_LDFLAGS +=3D --symbol-ordering-file=3D$(CLANG_PROPELLER_PROFILE_PRE=
FIX)_ld_profile.txt --no-warn-symbol-ordering
+else
+CFLAGS_PROPELLER_CLANG +=3D -fbasic-block-sections=3Dlabels
+endif
+
+ifdef CONFIG_LTO_CLANG
+ifdef CONFIG_LTO_CLANG_THIN
+ifdef CLANG_PROPELLER_PROFILE_PREFIX
+KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3D$(CLANG_PROPELLER_PROFILE=
_PREFIX)_cc_profile.txt
+else
+KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3Dlabels
+endif
+endif
+else
+endif
+
+export CFLAGS_PROPELLER_CLANG
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 254913498c3c..7cea8ba53cf4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4489,6 +4489,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".kcfi_traps")			||
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
+		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
=20
--=20
2.46.0.rc1.232.g9752f9e123-goog


