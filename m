Return-Path: <linux-arch+bounces-6566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580F95E04B
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 01:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5526D282708
	for <lists+linux-arch@lfdr.de>; Sat, 24 Aug 2024 23:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9313D525;
	Sat, 24 Aug 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="Shgj5Q0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823673BBF5
	for <linux-arch@vger.kernel.org>; Sat, 24 Aug 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724540816; cv=none; b=D/BmZVdbtJcXN4Jm+UtuM57hiHaNz3fBNNr2A24CIYXpVR2EhQUhZFW3VxcjvbKFo0EgD1VPXsTFkdsf9jL1ducKp3uLxeySeUTtmaUVbSNCyy9f8JSzB6XjISRPsw9VwyDEIICoIvqy1IAVMS/CYJt9gY6M1gxQ3baj2AkUkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724540816; c=relaxed/simple;
	bh=4s2OQZlLWv/Sj2T/ZisztQLtWvEwSvvzKdnbaAdn6Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwEi76d6HFZbz1YAGm8hiNSZGb9OLgyWjPPE9Ymjc+ZTyuFCAB/4D8EWSFzEGYT7TYmv8L1v/MN8Z1XmgA2/Yt8zR19U/x6f7HNoA17qOUN3SRhPgaPWhgVH2VjDVUFcRE45uF/nxZf96R5yTGi8sCZMYGQApIKw8F/ALDRr0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=Shgj5Q0b; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-81fd9251d99so111031439f.0
        for <linux-arch@vger.kernel.org>; Sat, 24 Aug 2024 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540812; x=1725145612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPVQkYUkKgMfNB80VWVW+kjDfOxnjk6hugGJuqGctqE=;
        b=Shgj5Q0bf9zoGFbDcWdjAzm/eQx64GpqdpApMteCXzqRm0HR/ftGU/NbkjT7sOFHqe
         SGvU5HckhERFWJar9dXOgC1WKElQqkb2wy2fKLrkxZ/ITBV05jAt6JWHAAcQ8YoXIg71
         6euTVal3bXeClwkahIX6xYK52ULqgim1lGgX9XE0Cp6W5DVWhTVg4Ji6xvODRVvJwM9Z
         nzZe99+Vu7Nw9+ZS57VATfPZf7dLDewt5GQ6US76TeDQNrrhJl3H3nbLnqrZ3/FBx3nk
         UZZP3H7qPrHgQtjE/s3EYIVkS67bbH/3Y7LIRTNcfCdJ+ArblPlatJkKSzjaJ9sVk+8k
         Wdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540812; x=1725145612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPVQkYUkKgMfNB80VWVW+kjDfOxnjk6hugGJuqGctqE=;
        b=DOo5gmsdxkLHlS2Qn01RsIemmYWz2EDaQlWOjx5KS/KWAhiX7bL7H7Uy0X37dT1q7G
         xBUFl39krqF+Ti7/UUZhhXE9RSr4fhkVEfJSYXaMHjcR03I9xxkjE5Di0E4zV3wD6x9g
         B5nJzs1jVcpRRpia7J3pMRATfmLpf09w89cd0HwEfrsfgQ0oe8JAXt4AgTV5C52UeV5B
         W728xXeJtwTds0GbiUH31qimmB82bkTtwnh0JFdWM+l8c4hvEMtxiIiezs9VgvcJ35iS
         AHtQbKzGXaPnXpOeJyF88oyoWNZgfS2u/zYr7mZ6ux1Vy87HbqT+Sesmu8vzZ3eCI98C
         M55A==
X-Forwarded-Encrypted: i=1; AJvYcCXWh2nF74Wdp2ZryK50uvujd1oqsRz+zESo3qlQuzhBeEuYBnv6l4pPUre+o7XG9612gWv1S8z7pLQk@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWj81ZwfKvMVrXxAfOm7U2X/IjGr+QRth0USmGQyE1kNMMWyI
	AfWntTGzmfjIX1AQlPLIlBGEn5viSnU98EqHxdON/o0J2X1tqEkXuRiyXzcIWQ==
X-Google-Smtp-Source: AGHT+IGMQxhcJkQ6ziSI+v0WKfS2seyT6MqZHNFCU+FCXMcl3PQf88gW45DK9XBsKf3pVpegGFpChA==
X-Received: by 2002:a05:6602:13ce:b0:803:cc64:e0d4 with SMTP id ca18e2360f4ac-8278730b0f3mr812804539f.3.1724540812422;
        Sat, 24 Aug 2024 16:06:52 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:06:52 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 0/3] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Sat, 24 Aug 2024 18:06:38 -0500
Message-Id: <20240824230641.385839-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for building x86-64 kernels with Clang's Source-
based Code Coverage[1] in order to facilitate Modified Condition/Decision
Coverage (MC/DC)[2] that provably correlates to source code for all levels
of compiler optimization.

The newly added kernel/llvm-cov/ directory complements the existing gcov
implementation. Gcov works at the object code level which may better
reflect actual execution. However, Gcov lacks the necessary information to
correlate coverage measurement with source code location when compiler
optimization level is non-zero (which is the default when building the
kernel). In addition, gcov reports are occasionally ambiguous when
attempting to compare with source code level developer intent.

In the following gcov example from drivers/firmware/dmi_scan.c, an
expression with four conditions is reported to have six branch outcomes,
which is not ideally informative in many safety related use cases, such as
automotive, medical, and aerospace.

        5: 1068:	if (s == e || *e != '/' || !month || month > 12) {
branch  0 taken 5 (fallthrough)
branch  1 taken 0
branch  2 taken 5 (fallthrough)
branch  3 taken 0
branch  4 taken 0 (fallthrough)
branch  5 taken 5

On the other hand, Clang's Source-based Code Coverage instruments at the
compiler frontend which maintains an accurate mapping from coverage
measurement to source code location. Coverage reports reflect exactly how
the code is written regardless of optimization and can present advanced
metrics like branch coverage and MC/DC in a clearer way. Coverage report
for the same snippet by llvm-cov would look as follows:

 1068|      5|	if (s == e || *e != '/' || !month || month > 12) {
  ------------------
  |  Branch (1068:6): [True: 0, False: 5]
  |  Branch (1068:16): [True: 0, False: 5]
  |  Branch (1068:29): [True: 0, False: 5]
  |  Branch (1068:39): [True: 0, False: 5]
  ------------------

Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
grained coverage metric required by many automotive and aviation industrial
standards for certifying mission-critical software [3].

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

To do a full kernel measurement, instrument the kernel with
LLVM_COV_KERNEL_MCDC enabled, and optionally set a
LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS value (the default is six). Run the
testsuites, and collect the raw profile data under
/sys/kernel/debug/llvm-cov/profraw. Such raw profile data can be merged and
indexed, and used for generating coverage reports in various formats.

  $ cp /sys/kernel/debug/llvm-cov/profraw vmlinux.profraw
  $ llvm-profdata merge vmlinux.profraw -o vmlinux.profdata
  $ llvm-cov show --show-mcdc --show-mcdc-summary                         \
             --format=text --use-color=false -output-dir=coverage_reports \
             -instr-profile vmlinux.profdata vmlinux

The first patch in this series enables Clang's Source-based Code Coverage
in the kernel. The second patch disables instrumentation in the same areas
that were disabled for kernel/gcov/. The third patch adds kernel
configuration directives to enable MC/DC instrumentation.

This work reuses code from a previous effort by Sami Tolvanen et al. [4].
Our aim is for source-based *code coverage* required for high assurance
(MC/DC) while [4] focused more on performance optimization.

This initial submission is restricted to x86-64. Support for other
architectures would need a bit more Makefile & linker script modification.
Informally we've confirmed that arm64 works and more are being tested.

Note that Source-based Code Coverage is Clang-specific and isn't compatible
with Clang's gcov support in kernel/gcov/. Currently, kernel/gcov/ is not
able to measure MC/DC without modifying CFLAGS_GCOV and it would face the
same issues in terms of source correlation as gcov in general does.

Some demo and results can be found in [5]. We will talk about this patch
series in the Refereed Track at LPC 2024 [6] and would appreciate the
community's feedback.

Known Limitations:

Kernel code with logical expressions exceeding
LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
Expressions with up to 45 conditions are found in the Linux kernel source
tree, but 44 seems to be the max value before the build fails due to kernel
size. As of LLVM 19 the max number of conditions possible is 32767.

As of LLVM 19, certain expressions are still not covered, and will produce
build warnings when they are encountered:

"[...] if a boolean expression is embedded in the nest of another boolean
 expression but separated by a non-logical operator, this is also not
 supported. For example, in x = (a && b && c && func(d && f)), the d && f
 case starts a new boolean expression that is separated from the other
 conditions by the operator func(). When this is encountered, a warning
 will be generated and the boolean expression will not be
 instrumented." [7]


[1] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html
[2] https://en.wikipedia.org/wiki/Modified_condition%2Fdecision_coverage
[3] https://digital-library.theiet.org/content/journals/10.1049/sej.1994.0025
[4] https://lore.kernel.org/lkml/20210407211704.367039-1-morbo@google.com/
[5] https://github.com/xlab-uiuc/linux-mcdc
[6] https://lpc.events/event/18/contributions/1718/
[7] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation

Wentao Zhang (3):
  [RFC PATCH 1/3] llvm-cov: add Clang's Source-based Code Coverage
    support
  [RFC PATCH 2/3] kbuild, llvm-cov: disable instrumentation in odd or
    sensitive code
  [RFC PATCH 3/3] llvm-cov: add Clang's MC/DC support

 Makefile                              |   9 +
 arch/Kconfig                          |   1 +
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/Makefile                |   1 +
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   1 +
 arch/x86/kernel/vmlinux.lds.S         |   2 +
 arch/x86/platform/efi/Makefile        |   1 +
 arch/x86/purgatory/Makefile           |   1 +
 arch/x86/realmode/rm/Makefile         |   1 +
 arch/x86/um/vdso/Makefile             |   1 +
 drivers/firmware/efi/libstub/Makefile |   2 +
 include/asm-generic/vmlinux.lds.h     |  38 ++++
 kernel/Makefile                       |   1 +
 kernel/llvm-cov/Kconfig               |  65 +++++++
 kernel/llvm-cov/Makefile              |   5 +
 kernel/llvm-cov/fs.c                  | 253 ++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h            | 156 ++++++++++++++++
 kernel/trace/Makefile                 |   1 +
 scripts/Makefile.lib                  |  21 +++
 scripts/Makefile.modfinal             |   1 +
 scripts/mod/modpost.c                 |   2 +
 22 files changed, 565 insertions(+)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

-- 
2.45.2


