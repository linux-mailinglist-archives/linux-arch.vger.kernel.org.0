Return-Path: <linux-arch+bounces-7644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3D98E710
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B70B24498
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4D1C6F48;
	Wed,  2 Oct 2024 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggBXxGlH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED091C1746
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912072; cv=none; b=rPYPF5bTybbLM3ysKABVCel7FPk4oW4aGIV6npUPSAIUVdXBHSpTNnicaztMy/HlzF/yYELBXkUkngOtMwwTVecxwNFVD0495l4kch2uU6EsRV8a8miozkgd8z66HeWcRa1sTzC2Lb9phZQegZKwxeEnLy94s6NMInLZfQIvyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912072; c=relaxed/simple;
	bh=OQm6RAZeRj4Yx9LpxhsmUNFRCuuVq5yGHzJTKTrNKOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IGWKM0h7AihPpLBcJu+LtCm6spRzd1tuE1zG/TQQ+RjZOMzIrOvpxMwzqxSP58+yWzdwfYNsKorS/2XBhp63qoSO99ww6m0eNvHuR1DqAsJ4S2zjG3CHTq7etGfsnllnAQZad3btDYUqtKKdEhPPjJR7Kj7Y71mx1b5OBJ/1+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggBXxGlH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2605ce4276so659763276.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727912069; x=1728516869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5mPGGI6nJcINmThpk3lfdMaj44SKUiEp9a/Jwua2D0=;
        b=ggBXxGlHdJ792+ZWhFniD9Z2+SZym9ob8qzrgWUkE65PQdvut+3wYyWpSGV6tDRBNF
         xQa+Sx5HcghVrY60Uo25dlOOvfss0FB4xzOvWu7NXWErltOTWUUnYLpigWjgZXp54iDL
         C8DP6DCLsROqPbznU3tnAf375qmvxJI3OaMiAqpNha+erK07vYpw4+cueBiwWLQ05cFq
         KFp/EKFH7klCP+MTcoAoWK5U3nUTvNQ8exhBsfFfz9gXEAlFCKfsrWUKcKNkEt1sJ5Xt
         v5MOHsujz6OBa8ov26JJh1agIGUmU+IPc/4vRaY3PQKO77H3t5pwx81yiyrpIxECALOv
         jLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912069; x=1728516869;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5mPGGI6nJcINmThpk3lfdMaj44SKUiEp9a/Jwua2D0=;
        b=AfHSKFOXsLwzcxzY4kyR21H1XEN1rMFaAYXLHh9LTzwq6c97yfr4S9a7FKXw9TaeYP
         sJDKf4k4ewOq0aVF/Yi6rrdEU1bLWBI7Gcse9HyOxiNnTW1M3fwbmXwFxAW+vF7YvwLf
         T4iSq1FPSKKPTZ68HpomRpn4/XCGuDmqxVSsvEKs2NHYmLQfalYRv/cmsjHw02pM9DEW
         gogdThtQVrIO8DqHauLJTupqPjd8OTz9s7eqR9HbSOm8xgm1CLl5IRaBAZhJnxE2wPkJ
         dIF9YW/U+ApBWbopvL1ENr5RlsW9/KKlzL4gRS6F/fOKHFRzFfcm60R72gU+nDQDQIaH
         3Bqw==
X-Forwarded-Encrypted: i=1; AJvYcCWcv1oCtoXBjUuXNtxlmgwMYUtovb7w2AJqL19cGFThhUC+tdCVgCpsjlowNM+ubatslYEIcWm/OwGj@vger.kernel.org
X-Gm-Message-State: AOJu0YymxZ+BJrE6e7iDUvKmVYojgN+wzl5dGoygEKMD2hHbfCzKCpNT
	Qi+G2Q4qDWYMHEsJ8lb9JtmQ301bHgp3lPq6O6Q/H6+vzAuig/BTSIybuDkONlWf+w==
X-Google-Smtp-Source: AGHT+IF+mAPY4LibeWBJRMIdzPlSyxqSqzg+0QS0NDbPnukpCpSDfwTQlNvfAx4GBuW+Ui8deXdOOaA=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:904:0:b0:e16:6771:a299 with SMTP id
 3f1490d57ef6-e26384478f9mr3244276.11.1727912068774; Wed, 02 Oct 2024 16:34:28
 -0700 (PDT)
Date: Wed,  2 Oct 2024 16:34:05 -0700
In-Reply-To: <20241002233409.2857999-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002233409.2857999-7-xur@google.com>
Subject: [PATCH v2 6/6] Add Propeller configuration for kernel build.
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
Cc: Stephane Eranian <eranian@google.com>
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
 arch/x86/kernel/vmlinux.lds.S         |   4 +
 include/asm-generic/vmlinux.lds.h     |  10 +-
 scripts/Makefile.lib                  |  10 ++
 scripts/Makefile.propeller            |  28 ++++
 tools/objtool/check.c                 |   1 +
 11 files changed, 268 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/dev-tools/propeller.rst
 create mode 100644 scripts/Makefile.propeller

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 6945644f7008..3c0ac08b2709 100644
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
index 62b798c20128..022b8d233558 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18556,6 +18556,13 @@ S:	Maintained
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
index 55d19c81b382..0fa6d35602a4 100644
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
index 106d09fc42ce..5aacd9c8a0d2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -831,6 +831,28 @@ config AUTOFDO_CLANG
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
index 503a0268155a..da47164bfddc 100644
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
index 6726be89b7a6..7ecc21c569be 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -442,6 +442,10 @@ SECTIONS
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
index 20e46c0917db..5986dd4cfb14 100644
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
@@ -556,7 +556,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__cpuidle_text_end =3D .;					\
 		__noinstr_text_end =3D .;
=20
-#ifdef CONFIG_AUTOFDO_CLANG
+#if defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_HOT							\
 		__hot_text_start =3D .;					\
 		*(.text.hot .text.hot.*)				\
@@ -584,7 +584,7 @@ defined(CONFIG_AUTOFDO_CLANG)
  * first when in these builds.
  */
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CL=
ANG) || \
-defined(CONFIG_AUTOFDO_CLANG)
+defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e85d6ac31bd9..60354c476956 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -201,6 +201,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
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
index 000000000000..344190717e47
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
index 4c5229991e1e..05a0fb4a3d1a 100644
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
2.46.1.824.gd892dcdcdd-goog


