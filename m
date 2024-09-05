Return-Path: <linux-arch+bounces-7055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE096CE12
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 06:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF531F22B97
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FA144D01;
	Thu,  5 Sep 2024 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="rXoQ72lW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A344149E16
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510864; cv=none; b=tcZ2nxwt+rayg+glywBjwYuPNRLOFD8bD1EbP+Oi8bZ9Zw//3p9Zs4LKlvhtfVHLDHgrxMedGrgcKyvZEStka9JKdh7avH6WMsp+NlDvx198liDVAgkxkrCixWPl7JwLqBR/NOFYZKViIGHuRuDATYVqxFW0EX6fHgmwH/WgIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510864; c=relaxed/simple;
	bh=79yTqNn26ViRO3IUhmm8GeG7mCsRLzu49faRenUSCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPHVXdJ8PVTR4fDY3EJea81uVlemrBxZV5eophAPU0Mcs/HD6HmQc4TnWy9T5KCoJiZ/xjyoapUzzK8s73wS2y7gDOYS4KZxI8BekWkXC7HX7/rvkJPGoe5U86aVGgs3JDWpbhg8ZzRz/uloIg5Vdy50MygPTBkqc6SUGnc3W4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=rXoQ72lW; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-457d46ea04dso2105671cf.2
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510862; x=1726115662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXwRT8m6Xph+VDsTMDBWhqCULbnMb6YStVj437p8G88=;
        b=rXoQ72lWojdWe9cTZ2zTk288UnvoIgCz9m8/nRdBBqdNdHFmI4XgFpMwAEwqxtLNEW
         gkNT2djOchGfOG7QTHBZyfJNrWH6Mkt2JLxABgyi/lEqHCZaGhWvU3zAU0gIrlVzKvZW
         dPdJ6/wIsYzLQ0706SQERnP7JMwh5Bf+LJbXvE6DArW6w0qlDV+rv6UCNcgHr6xJ0v2C
         4pauLD89n3SRV+JqqyK9KCgJM0PfG8A3/lVWAy5ixBXtY/82lKriwJ/LdtnnXgFurVUC
         8GsVSD/kO2lBYpXy6Em0ezSCnSjVdhkZk6Al1+T3C36lOTTO5Vvh4clMOFeDyPXH8+o2
         G2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510862; x=1726115662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXwRT8m6Xph+VDsTMDBWhqCULbnMb6YStVj437p8G88=;
        b=j++Z2ptfEEov54Hj9qbxOq9DU0GEILEBYWJGoeqDKEgCGW7C4GbrwZrI/XcRG4y7e9
         7gkCnt/Bc8Jc3QbTB/9v6klUCtTsZveIqIEYbKnmGTCYqy4v54afDKGket7QSlw87tAt
         CoVuzz84y41C2MFs3XNFSvQxCC1RBJJAtbJXKctIl5vWnmcBpKf+2/5Ya8wGNMF0hKQG
         4ycwibfdkL4t3oI0s5ISbNRExVd858ugg+SXRXMoEC6UyXXgisUzPgo/MA6bqQrCRQgV
         +HbMeBZEMfJAAiLpdNfYnKJxkod8ztVgSaoDw5GeQ/w4pkj0oegCFUA282Pw9NJIzS8K
         +vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrIoUj3ZDiRvFZnXU/BqiWlCU3Z5FymCxY4aIkt5CdT4UWx46nj+84gGwt6RJgUa4fkCJ+4a8Bos6@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6EjohieYeqGDFAw75l0yOMf48qhdneecgoSVyVdx//kuY5Dz
	CY5uLRpkXsP1UWQwqj+l3Bvp9vJ4rsg0XqpX0gUllbf5GjQU24c8VCSMNe5dcw==
X-Google-Smtp-Source: AGHT+IFTB/3wqBcVl6wvomiIgWeQlHWrAIgqsz88ivupnMcndi1qsyA3rsmqKofarBSsvJ9rROjnLA==
X-Received: by 2002:a05:622a:5e15:b0:454:ea33:ebb6 with SMTP id d75a77b69052e-4570ec1115fmr200588491cf.19.1725510861666;
        Wed, 04 Sep 2024 21:34:21 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:34:21 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 2/4] llvm-cov: add Clang's MC/DC support
Date: Wed,  4 Sep 2024 23:32:43 -0500
Message-ID: <20240905043245.1389509-3-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add infrastructure to enable Clang's Modified Condition/Decision Coverage
(MC/DC) [1].

Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
grained coverage metric required by many automotive and aviation industrial
standards for certifying mission-critical software [2].

In the following example from arch/x86/events/probe.c, llvm-cov gives the
MC/DC measurement for the compound logic decision at line 43.

   43|     12|			if (msr[bit].test && !msr[bit].test(bit, data))
  ------------------
  |---> MC/DC Decision Region (43:8) to (43:50)
  |
  |  Number of Conditions: 2
  |     Condition C1 --> (43:8)
  |     Condition C2 --> (43:25)
  |
  |  Executed MC/DC Test Vectors:
  |
  |     C1, C2    Result
  |  1 { T,  F  = F      }
  |  2 { T,  T  = T      }
  |
  |  C1-Pair: not covered
  |  C2-Pair: covered: (1,2)
  |  MC/DC Coverage for Decision: 50.00%
  |
  ------------------
   44|      5|				continue;

As the results suggest, during the span of measurement, only condition C2
(!msr[bit].test(bit, data)) is covered. That means C2 was evaluated to both
true and false, and in those test vectors C2 affected the decision outcome
independently. Therefore MC/DC for this decision is 1 out of 2 (50.00%).

As of Clang 19, users can determine the max number of conditions in a
decision to measure via option LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS, which
controls -fmcdc-max-conditions flag of Clang cc1 [3]. Since MC/DC
implementation utilizes bitmaps to track the execution of test vectors,
more memory is consumed if larger decisions are getting counted. The
maximum value supported by Clang is 32767. According to local experiments,
the working maximum for Linux kernel is 46, with the largest decisions in
kernel codebase (with 47 conditions, as of v6.11) excluded, otherwise the
kernel image size limit will be exceeded. The largest decisions in kernel
are contributed for example by macros checking CPUID.

Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
warnings.

As of LLVM 19, certain expressions are still not covered, and will produce
build warnings when they are encountered:

"[...] if a boolean expression is embedded in the nest of another boolean
 expression but separated by a non-logical operator, this is also not
 supported. For example, in x = (a && b && c && func(d && f)), the d && f
 case starts a new boolean expression that is separated from the other
 conditions by the operator func(). When this is encountered, a warning
 will be generated and the boolean expression will not be
 instrumented." [4]

Link: https://en.wikipedia.org/wiki/Modified_condition%2Fdecision_coverage [1]
Link: https://digital-library.theiet.org/content/journals/10.1049/sej.1994.0025 [2]
Link: https://discourse.llvm.org/t/rfc-coverage-new-algorithm-and-file-format-for-mc-dc/76798 [3]
Link: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation [4]
Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 Makefile                |  6 ++++++
 kernel/llvm-cov/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib    | 12 ++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Makefile b/Makefile
index 51498134c..1185b38d6 100644
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,12 @@ all: vmlinux
 CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
 export CFLAGS_LLVM_COV
 
+CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
+ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)
+endif
+export CFLAGS_LLVM_COV_MCDC
+
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
 CFLAGS_GCOV	+= -fno-tree-loop-im
diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
index 9241fdfb0..66259e1f2 100644
--- a/kernel/llvm-cov/Kconfig
+++ b/kernel/llvm-cov/Kconfig
@@ -61,4 +61,40 @@ config LLVM_COV_PROFILE_ALL
 	  Note that a kernel compiled with profiling flags will be significantly
 	  larger and run slower.
 
+config LLVM_COV_KERNEL_MCDC
+	bool "Enable measuring modified condition/decision coverage (MC/DC)"
+	depends on LLVM_COV_KERNEL
+	depends on CLANG_VERSION >= 180000
+	help
+	  This option enables modified condition/decision coverage (MC/DC)
+	  code coverage instrumentation.
+
+	  If unsure, say N.
+
+	  This will add Clang's Source-based Code Coverage MC/DC
+	  instrumentation to your kernel. As of LLVM 19, certain expressions
+	  are still not covered, and will produce build warnings when they are
+	  encountered.
+
+	  "[...] if a boolean expression is embedded in the nest of another
+	   boolean expression but separated by a non-logical operator, this is
+	   also not supported. For example, in
+	   x = (a && b && c && func(d && f)), the d && f case starts a new
+	   boolean expression that is separated from the other conditions by the
+	   operator func(). When this is encountered, a warning will be
+	   generated and the boolean expression will not be instrumented."
+
+	   https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation
+
+config LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+	int "Maximum number of conditions in a decision to instrument"
+	range 6 32767
+	depends on LLVM_COV_KERNEL_MCDC
+	depends on CLANG_VERSION >= 190000
+	default "6"
+	help
+	  This value is passed to "-fmcdc-max-conditions" flag of Clang cc1.
+	  Expressions whose number of conditions is greater than this value will
+	  produce warnings and will not be instrumented.
+
 endmenu
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b468856b8..afc94e92d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -169,6 +169,18 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_LLVM_COV))
 endif
 
+#
+# Flag that turns on modified condition/decision coverage (MC/DC) measurement
+# with Clang's Source-based Code Coverage. Enable the flag for a file or
+# directory depending on variables LLVM_COV_PROFILE_obj.o, LLVM_COV_PROFILE and
+# CONFIG_LLVM_COV_PROFILE_ALL.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL_MCDC),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(target-stem).o)$(LLVM_COV_PROFILE)$(if $(is-kernel-object),$(CONFIG_LLVM_COV_PROFILE_ALL))), \
+		$(CFLAGS_LLVM_COV_MCDC))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
-- 
2.45.2


