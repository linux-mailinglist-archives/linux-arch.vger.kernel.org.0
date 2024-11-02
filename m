Return-Path: <linux-arch+bounces-8790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1579BA206
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1658BB216E1
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98281B2199;
	Sat,  2 Nov 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWbh70Hj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF01AAE2E
	for <linux-arch@vger.kernel.org>; Sat,  2 Nov 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569894; cv=none; b=Ud3aCvM5PhbxxxgDOCgLCK5mK24mZ8E55W0dexVJGstw83eD6u15q2I+IvZqpGPOir/hM6jVRJVSIIV+L2TmK8nPGkyT4AqnB+mh/jH8na9nT0OAhNBSuR6To8DiMxVInKjb5MxlwHzeDu8D2+zy2NrOjdNk5paLTJXm8haMLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569894; c=relaxed/simple;
	bh=n5DwlfeUbkUe6VSe+Bsrx/eAnae4lYm55Gp25mwM/AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8za2gBVxgbAiR2D89GNeow0Ff/TaId6d7PJo43+8afCkEqYkvE7piuLXpPbcVK3BMeEa+Zcv07wp+yfllh7FmlPZNDW7VRPN3KszJejctdPPJRlkRVE2G+6rwYFCj/o8R2XL/2ahyufT4m4E5CSILz9prbHxag7BZ1hBHYa8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWbh70Hj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so5457626276.3
        for <linux-arch@vger.kernel.org>; Sat, 02 Nov 2024 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730569890; x=1731174690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p4AXk5DtJgiR7nbgs6gd2bejhjHdd1tXiNEcSnqRps=;
        b=LWbh70Hje0dR2x3PavUnXRqoLCrpro30Xf7zqJU3BLthJ9/u/0G3L1sDqHMB40/JfV
         TwZw13vJ/F/vnKCqFv544gGu8v0PVM9N5Zu/KUmUrcglCo0XMwcYQvzgXHJYK9CDcc6Q
         GlvUYpZMbmlK19tT5s/c8PVSTK9mSmgJSKIj1INnEC6JI35365BEkFbU6qZLkNHhV59l
         9fgqq7H3P9gqO1wQjFCxrH/HI/P1nuEkwZ6Ygu0o2r0OrGeS/fWdX9ei1L/UueP5pFFP
         wNxVEKakbXbIinm065ysHSIBxzlDcfMuVM8PdKqLP0ZIw51adkpCJnL3Mtxdf9sZsW4e
         R5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569890; x=1731174690;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3p4AXk5DtJgiR7nbgs6gd2bejhjHdd1tXiNEcSnqRps=;
        b=xFrjHpOtPNhSpfYLKBxyzqc0P4C4E85tj11qaN635DOdRbdH5q4V4YYptgdg/VP8KH
         k/Lx2XfSw+bLsFmAQTgycT788P16mXEkm5akzIJGIii9D8FfBuAUZ6ESwpG7qaASA4/C
         RY+J6fttcTOztkGllnYskTTFDPKs+5esBYjPn/23hVUWr9UWnRNoi4FZGD2Gz8QBMzz4
         yjVQMJ5uZiCG8vIQLVsAo4H4n5BEtlkwVvgX4+osFWWc6xcdz9upMoMEIj/psenl3YB3
         ygCTU56kpRcLC/gD0+TM9np+p/MAqnXnPVbZRrL36qcORkR1FSzAt44Qm5NqAf795hEb
         7LXw==
X-Forwarded-Encrypted: i=1; AJvYcCVI2dSfuvKA8j1SpKvApdPk005LwByptVj+k+l4TOZs1Qlmqnz24FYY616HtH95ggQy7P/0Q4z6Km+G@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr/v/tm/7ePFO2/pGyiA5fbcBrVrvhjmu6DYs5/A4ehObpNRF
	1s8Dg4sEeV1qW/jUT/sFR+pikxshVTDr4aw31irRQ6tjv5kvKVEzjFb3u7CJ4iIU5w==
X-Google-Smtp-Source: AGHT+IEZ+AxDqMwv1T8/N6VbPHxXAJQIxGK0//+kNZzPq9Tu/0rNxZacImTwdovzsKaod3QXHJCzhKg=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:26d1:0:b0:e2b:d0e9:130f with SMTP id
 3f1490d57ef6-e30cf2e9c2bmr10994276.0.1730569890149; Sat, 02 Nov 2024 10:51:30
 -0700 (PDT)
Date: Sat,  2 Nov 2024 10:51:14 -0700
In-Reply-To: <20241102175115.1769468-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102175115.1769468-8-xur@google.com>
Subject: [PATCH v7 7/7] Add Propeller configuration for kernel build
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
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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
commit is limited to x86 platforms that support PMU features
like LBR on Intel machines and AMD Zen3 BRS.

Here is an example workflow for building an AutoFDO+Propeller
optimized kernel:

1) Build the kernel on the host machine, with AutoFDO and Propeller
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

4) (Optional) Download the raw perf file to the host machine.

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
Tested-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Documentation/dev-tools/index.rst     |   1 +
 Documentation/dev-tools/propeller.rst | 162 ++++++++++++++++++++++++++
 MAINTAINERS                           |   7 ++
 Makefile                              |   1 +
 arch/Kconfig                          |  19 +++
 arch/x86/Kconfig                      |   1 +
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 include/asm-generic/vmlinux.lds.h     |   6 +-
 scripts/Makefile.lib                  |  10 ++
 scripts/Makefile.propeller            |  28 +++++
 tools/objtool/check.c                 |   1 +
 11 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.propeller

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 6945644f7008a..3c0ac08b27091 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -35,6 +35,7 @@ Documentation/dev-tools/testing-overview.rst
    checkuapi
    gpio-sloppy-logic-analyzer
    autofdo
+   propeller
=20
=20
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/propeller.rst b/Documentation/dev-tool=
s/propeller.rst
new file mode 100644
index 0000000000000..92195958e3dbc
--- /dev/null
+++ b/Documentation/dev-tools/propeller.rst
@@ -0,0 +1,162 @@
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
+Configure the kernel with::
+
+   CONFIG_AUTOFDO_CLANG=3Dy
+   CONFIG_PROPELLER_CLANG=3Dy
+
+Customization
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The default CONFIG_PROPELLER_CLANG setting covers kernel space objects
+for Propeller builds. One can, however, enable or disable Propeller build
+for individual files and directories by adding a line similar to the
+following to the respective kernel Makefile:
+
+- For enabling a single file (e.g. foo.o)::
+
+   PROPELLER_PROFILE_foo.o :=3D y
+
+- For enabling all files in one directory::
+
+   PROPELLER_PROFILE :=3D y
+
+- For disabling one file::
+
+   PROPELLER_PROFILE_foo.o :=3D n
+
+- For disabling all files in one directory::
+
+   PROPELLER__PROFILE :=3D n
+
+
+Workflow
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Here is an example workflow for building an AutoFDO+Propeller kernel:
+
+1) Assuming an AutoFDO profile is already collected following
+   instructions in the AutoFDO document, build the kernel on the host
+   machine, with AutoFDO and Propeller build configs ::
+
+      CONFIG_AUTOFDO_CLANG=3Dy
+      CONFIG_PROPELLER_CLANG=3Dy
+
+   and ::
+
+      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo-profile-name>
+
+2) Install the kernel on the test machine.
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
+   - For AMD platforms::
+
+      $ perf record --pfm-event RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N =
-b -c <count> -o <perf_file> -- <loadtest>
+
+   Note you can repeat the above steps to collect multiple <perf_file>s.
+
+4) (Optional) Download the raw perf file(s) to the host machine.
+
+5) Use the create_llvm_prof tool (https://github.com/google/autofdo) to
+   generate Propeller profile. ::
+
+      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file>
+                         --format=3Dpropeller --propeller_output_module_na=
me
+                         --out=3D<propeller_profile_prefix>_cc_profile.txt
+                         --propeller_symorder=3D<propeller_profile_prefix>=
_ld_profile.txt
+
+   "<propeller_profile_prefix>" can be something like "/home/user/dir/any_=
string".
+
+   This command generates a pair of Propeller profiles:
+   "<propeller_profile_prefix>_cc_profile.txt" and
+   "<propeller_profile_prefix>_ld_profile.txt".
+
+   If there are more than 1 perf_file collected in the previous step,
+   you can create a temp list file "<perf_file_list>" with each line
+   containing one perf file name and run::
+
+      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D@<perf_file_list=
>
+                         --format=3Dpropeller --propeller_output_module_na=
me
+                         --out=3D<propeller_profile_prefix>_cc_profile.txt
+                         --propeller_symorder=3D<propeller_profile_prefix>=
_ld_profile.txt
+
+6) Rebuild the kernel using the AutoFDO and Propeller
+   profiles. ::
+
+      CONFIG_AUTOFDO_CLANG=3Dy
+      CONFIG_PROPELLER_CLANG=3Dy
+
+   and ::
+
+      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file> CLANG_PROPELL=
ER_PROFILE_PREFIX=3D<propeller_profile_prefix>
diff --git a/MAINTAINERS b/MAINTAINERS
index d6ea49433747a..42e3af0791e15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18449,6 +18449,13 @@ S:	Maintained
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
index b89d87b5dca79..b2830b27e1a7f 100644
--- a/Makefile
+++ b/Makefile
@@ -1019,6 +1019,7 @@ include-$(CONFIG_UBSAN)		+=3D scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+=3D scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+=3D scripts/Makefile.randstruct
 include-$(CONFIG_AUTOFDO_CLANG)	+=3D scripts/Makefile.autofdo
+include-$(CONFIG_PROPELLER_CLANG)	+=3D scripts/Makefile.propeller
 include-$(CONFIG_GCC_PLUGINS)	+=3D scripts/Makefile.gcc-plugins
=20
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/arch/Kconfig b/arch/Kconfig
index 8dca3b5e6ef53..00551f340dbe3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -831,6 +831,25 @@ config AUTOFDO_CLANG
=20
 	  If unsure, say N.
=20
+config ARCH_SUPPORTS_PROPELLER_CLANG
+	bool
+
+config PROPELLER_CLANG
+	bool "Enable Clang's Propeller build"
+	depends on ARCH_SUPPORTS_PROPELLER_CLANG
+	depends on CC_IS_CLANG && CLANG_VERSION >=3D 190000
+	help
+	  This option enables Clang=E2=80=99s Propeller build. When the Propeller
+	  profiles is specified in variable CLANG_PROPELLER_PROFILE_PREFIX
+	  during the build process, Clang uses the profiles to optimize
+	  the kernel.
+
+	  If no profile is specified, Propeller options are still passed
+	  to Clang to facilitate the collection of perf data for creating
+	  the Propeller profiles in subsequent builds.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_CFI_CLANG
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9dc87661fb373..89b8fc452a7cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -127,6 +127,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
+	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb48..cf22081601ed6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -443,6 +443,10 @@ SECTIONS
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 8a0bb3946cf05..c995474e4c649 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,14 +95,14 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
- * With AUTOFDO_CLANG, by default, the linker splits text sections and
- * regroups functions into subsections.
+ * With AUTOFDO_CLANG and PROPELLER_CLANG, by default, the linker splits
+ * text sections and regroups functions into subsections.
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
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2d0942c1a0277..e7859ad90224a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -201,6 +201,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
 	$(CFLAGS_AUTOFDO_CLANG))
 endif
=20
+#
+# Enable Propeller build flags except some files or directories we don't w=
ant to
+# enable (depends on variables AUTOFDO_PROPELLER_obj.o and PROPELLER_PROFI=
LE).
+#
+ifdef CONFIG_PROPELLER_CLANG
+_c_flags +=3D $(if $(patsubst n%,, \
+	$(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(PROPELLER_PROFILE)=
)$(is-kernel-object), \
+	$(CFLAGS_PROPELLER_CLANG))
+endif
+
 # $(src) for including checkin headers from generated source files
 # $(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
new file mode 100644
index 0000000000000..344190717e471
--- /dev/null
+++ b/scripts/Makefile.propeller
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Enable available and selected Clang Propeller features.
+ifdef CLANG_PROPELLER_PROFILE_PREFIX
+  CFLAGS_PROPELLER_CLANG :=3D -fbasic-block-sections=3Dlist=3D$(CLANG_PROP=
ELLER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
+  KBUILD_LDFLAGS +=3D --symbol-ordering-file=3D$(CLANG_PROPELLER_PROFILE_P=
REFIX)_ld_profile.txt --no-warn-symbol-ordering
+else
+  CFLAGS_PROPELLER_CLANG :=3D -fbasic-block-sections=3Dlabels
+endif
+
+# Propeller requires debug information to embed module names in the profil=
es.
+# If CONFIG_DEBUG_INFO is not enabled, set -gmlt option. Skip this for Aut=
oFDO,
+# as the option should already be set.
+ifndef CONFIG_DEBUG_INFO
+  ifndef CONFIG_AUTOFDO_CLANG
+    CFLAGS_PROPELLER_CLANG +=3D -gmlt
+  endif
+endif
+
+ifdef CONFIG_LTO_CLANG_THIN
+  ifdef CLANG_PROPELLER_PROFILE_PREFIX
+    KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3D$(CLANG_PROPELLER_PRO=
FILE_PREFIX)_cc_profile.txt
+  else
+    KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3Dlabels
+  endif
+endif
+
+export CFLAGS_PROPELLER_CLANG
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4c5229991e1e0..05a0fb4a3d1a0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4558,6 +4558,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".kcfi_traps")			||
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
+		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
=20
--=20
2.47.0.163.g1226f6d8fa-goog


