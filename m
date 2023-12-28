Return-Path: <linux-arch+bounces-1204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721281F831
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFA21C2218E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD6748E;
	Thu, 28 Dec 2023 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRRuEtiC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692397483;
	Thu, 28 Dec 2023 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e76948cda7so40592957b3.3;
        Thu, 28 Dec 2023 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703766260; x=1704371060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwzrGyHtg55O3i+HEC4AZpo/IYoZaxO+3+s9kU5V6zs=;
        b=hRRuEtiClfgw8Nk6yd7wgH5ak9g4lrp428yZn1aAaAmW0FfIIh8u+vGokmO/8aLb21
         1B+fcmgKbYmzm+1Lsk2T4axlPptEl4daJWqvmQMdJKfOeT0v/7OeQVeyw8lcmxdZt7+R
         DIh4MLY2cIen6kBvBs4cLRehgF6JZHI49fvE1u5CTy2LoP+fN0mCDsQQQhARqpClK4l1
         FQErySXgHxg4bXv7vqmka7UKFldIs5DzLtR+u7VWTSWtCKsN+2wtzx3bzlE+Y3O0elxQ
         2C+fVwTWVwNuqlzHt6QxXtmfVBeNEDP0no2/zFBzUXJ3JLg3CcwIJnHOFYsiQxntbwNz
         cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703766260; x=1704371060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwzrGyHtg55O3i+HEC4AZpo/IYoZaxO+3+s9kU5V6zs=;
        b=UfRX/P/P1MeeBhAnHPKpBTRouFIGBoqRe4QN/DaEau9RpXiwd0F0618wi12xaH3JBE
         FesWZRhhigy+sH3sDfr1e0dh0v4WuPTyU2CmuvIzPFQq4FvNIF9H7uIFHsQFgS0XSweB
         YE5nd+1KfuDMWnyS5/JqmNncoP16DgC0cOO7fbinPv+F5Rm3Zo6YtApga/KpDpm+GTpQ
         q1D1sbDB0X65a4ERDmmw42KJrvYEmVSUMg3CM36DLAQeZxdjdGaOOQA2r74xcI0cV2os
         hknvH3py77Q30hfDQES5qo9rbZs/GKlVQsVktLQsWlG/yuAHN03A+MbTgmkNdpWOwN5K
         SXXg==
X-Gm-Message-State: AOJu0YzrLi90uLwzlxYwhZLYYKgQ//lc90wuh2nzfVDce0EDVa8XiviI
	Jd49gJko58ZrTk/XLP4QusU=
X-Google-Smtp-Source: AGHT+IEqylviWUZhokC5K/1wCrCqs4upZZ3Od62RUiUebnNPJE/TJhdNQnjRBQ5D2kyQMzMr2zJhFQ==
X-Received: by 2002:a0d:e642:0:b0:5e7:3e3a:1a4f with SMTP id p63-20020a0de642000000b005e73e3a1a4fmr5590594ywe.17.1703766260252;
        Thu, 28 Dec 2023 04:24:20 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id u80-20020a0deb53000000b005e82879d18esm7474661ywe.53.2023.12.28.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:24:19 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: richardcochran@gmail.com,
	luto@kernel.org,
	datglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	geert@linux-m68k.org,
	peterz@infradead.org,
	hannes@cmpxchg.org,
	sohil.mehta@intel.com,
	rick.p.edgecombe@intel.com,
	nphamcs@gmail.com,
	palmer@sifive.com,
	maimon.sagi@gmail.com,
	keescook@chromium.org,
	legion@kernel.org,
	mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] posix-timers: add multi_clock_gettime system call
Date: Thu, 28 Dec 2023 14:24:11 +0200
Message-Id: <20231228122411.3189-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some user space applications need to read some clocks.
Each read requires moving from user space to kernel space.
The syscall overhead causes unpredictable delay between N clocks reads
Removing this delay causes better synchronization between N clocks.

Introduce a new system call multi_clock_gettime, which can be used to measure
the offset between multiple clocks, from variety of types: PHC, virtual PHC
and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
The offset includes the total time that the driver needs to read the clock
timestamp.

New system call allows the reading of a list of clocks - up to PTP_MAX_CLOCKS.
Supported clocks IDs: PHC, virtual PHC and various system clocks.
Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
The system call returns n_clocks timestamps for each measurement:
- clock 0 timestamp
- ...
- clock n timestamp

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Addressed comments from:
 - Thomas Gleixner : https://www.spinics.net/lists/netdev/msg959514.html
          
 Changes since version 2:
 - Change multi PHC syscall to fit the Y2038 safe variant.
 - Define the syscall data structure under uapi directory, so it will be known in user space.
 
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  2 +-
 include/uapi/asm-generic/unistd.h      |  4 +++-
 include/uapi/linux/multi_clock.h       | 21 ++++++++++++++++
 kernel/time/posix-timers.c             | 33 ++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/multi_clock.h

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..9cdeb0bf49db 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	multi_clock_gettime	sys_multi_clock_gettime
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..b59fa776ab76 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1161,7 +1161,7 @@ asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
 asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
-
+asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
 
 /*
  * Not a real system call, but a placeholder for syscalls which are
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..beb3e0052d3c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_multi_clock_gettime 457
+__SYSCALL(__NR_multi_clock_gettime, sys_multi_clock_gettime)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/multi_clock.h b/include/uapi/linux/multi_clock.h
new file mode 100644
index 000000000000..07099045ec32
--- /dev/null
+++ b/include/uapi/linux/multi_clock.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_MULTI_CLOCK_H
+#define _UAPI_MULTI_CLOCK_H
+
+#include <linux/types.h>
+#include <linux/time_types.h>
+
+#define MULTI_PTP_MAX_CLOCKS 5 /* Max number of clocks */
+#define MULTI_PTP_MAX_SAMPLES 10 /* Max allowed offset measurement samples. */
+
+struct __ptp_multi_clock_get {
+	unsigned int n_clocks; /* Desired number of clocks. */
+	unsigned int n_samples; /* Desired number of measurements per clock. */
+	clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
+	/*
+	 * Array of list of n_clocks clocks time samples n_samples times.
+	 */
+	struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
+};
+
+#endif /* _UAPI_MULTI_CLOCK_H */
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..80cbce59d4f4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/nospec.h>
 #include <linux/time_namespace.h>
+#include <linux/multi_clock.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1426,6 +1427,38 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 #endif
 
+SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
+{
+	const struct k_clock *kc;
+	struct timespec64 kernel_tp;
+	struct __ptp_multi_clock_get multi_clk_get;
+	unsigned int i, j;
+	int error;
+
+	if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
+		return -EFAULT;
+
+	if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
+		return -EINVAL;
+	if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
+		return -EINVAL;
+
+	for (j = 0; j < multi_clk_get.n_samples; j++) {
+		for (i = 0; i < multi_clk_get.n_clocks; i++) {
+			kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
+			if (!kc)
+				return -EINVAL;
+			error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
+			if (!error && put_timespec64(&kernel_tp, (struct __kernel_timespec __user *)
+						     &ptp_multi_clk_get->ts[j][i]))
+				error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
+
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
-- 
2.26.3


