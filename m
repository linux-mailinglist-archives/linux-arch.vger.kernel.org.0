Return-Path: <linux-arch+bounces-1217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45565820C10
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B9D281B0D
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD208C00;
	Sun, 31 Dec 2023 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9GQ4MeO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169058F42;
	Sun, 31 Dec 2023 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3ae326f6so90286095e9.3;
        Sun, 31 Dec 2023 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704042449; x=1704647249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/M2QU8ovLnm7JVX+BLvVX+SFfKrCPAK+NLbXM2IK84=;
        b=H9GQ4MeOg5g4W4sEkIoaGFpV93wpLhFJ1Fufn0unxwFhesUw++TFh8XW3hFvPd3mNF
         N3J+u4xhzwEKjreEwTK3HACZMp8hrglm6DZOFE83Xo2kePC0etT7OmAlaCqxIIGBtzqc
         eq7V8GoWiRumDXL3HIACvnacZRfmVNXHKqXc/W08z4s6g4l9xAjrFT8gmdcHyQpIsRoV
         LobfTQ8bY8PSbs6bTqXdFe1tIaqzHEOhRz1anGP/94MvkO45K1G2LZLDyoBHqjeNVx8i
         DkhTbcAm9HsfyJ35S25fZuITjovF2lrmiH/4LrzkXLUJzGfXXLRS685q9xTFhWZOgJpq
         T0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704042449; x=1704647249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/M2QU8ovLnm7JVX+BLvVX+SFfKrCPAK+NLbXM2IK84=;
        b=CHLT3sH+SXNxCqiC2O2la8HplvlKWLYwuNEAkZwRowZ2zgNRzca+3ey/lRqiDF5q04
         /tFiCrEd+Eymf92Hz19wuOq1iXiMkI84SMjOTReE5Ttedd4DCVMDfpysmhw0nAtUDhKw
         cW28pe0SV6i5MZRQdUDXe2ylz2JD+75Ulbg71/kGD//NlVPc0ota5g6fOdR38IhhV0Hd
         7C18rFaB+QTa9iImjyHE7tachx0OqlotcfxrzTp6mzrcE/x6/MHaPMLhfJzWeu5yGWLT
         Fk595quYf57ZmE1cUe50JnxtHVaKQHm2LDg88ri/Rqll8TVvAV/X5ygPiF06XxVfdl9Y
         9a3A==
X-Gm-Message-State: AOJu0YwwOtxG42wG9C7f5jGict95c5IBuuyCaFge/x8mpz4A4zRSiQDO
	+Ny+cGUX5Ia4Tg7i31rgxKs=
X-Google-Smtp-Source: AGHT+IFtOicv5vkf+f6WonETGdxwCmPsO6RSimYSRaQLXO6CGrieZ+R0CBgABoB2Sxk9EgVwZM1bfw==
X-Received: by 2002:a05:600c:3d1a:b0:40d:887b:f510 with SMTP id bh26-20020a05600c3d1a00b0040d887bf510mr216811wmb.86.1704042448971;
        Sun, 31 Dec 2023 09:07:28 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c138e00b0040d62f97e3csm13452347wmf.10.2023.12.31.09.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:07:28 -0800 (PST)
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
Subject: [PATCH v4] posix-timers: add multi_clock_gettime system call
Date: Sun, 31 Dec 2023 19:07:21 +0200
Message-Id: <20231231170721.3381-1-maimon.sagi@gmail.com>
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
 - Arnd Bergmann : https://www.spinics.net/lists/netdev/msg962019.html
          
 Changes since version 3:
 - Replacing the clkid fixed size arrays with a dynamically sized array.
 - Coping only necessary data from user space.
 - Calling put_timespec64() only after all time samples taken in order to 
   reduce the put_timespec64() overhead.

 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  2 +-
 include/uapi/asm-generic/unistd.h      |  4 +-
 include/uapi/linux/multi_clock.h       | 21 +++++++++
 kernel/time/posix-timers.c             | 59 ++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 2 deletions(-)
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
index 000000000000..5e78dac3a533
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
+#define MULTI_PTP_MAX_CLOCKS 32 /* Max number of clocks */
+#define MULTI_PTP_MAX_SAMPLES 32 /* Max allowed offset measurement samples. */
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
index b924f0f096fa..1d321dc56a25 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -31,6 +31,8 @@
 #include <linux/compat.h>
 #include <linux/nospec.h>
 #include <linux/time_namespace.h>
+#include <linux/multi_clock.h>
+#include <linux/slab.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1426,6 +1428,63 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 #endif
 
+SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
+{
+	const struct k_clock *kc;
+	struct timespec64 *kernel_tp;
+	struct timespec64 *kernel_tp_base;
+	unsigned int n_clocks; /* Desired number of clocks. */
+	unsigned int n_samples; /* Desired number of measurements per clock. */
+	unsigned int i, j;
+	clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
+	int error = 0;
+
+	if (copy_from_user(&n_clocks, &ptp_multi_clk_get->n_clocks, sizeof(n_clocks)))
+		return -EFAULT;
+	if (copy_from_user(&n_samples, &ptp_multi_clk_get->n_samples, sizeof(n_samples)))
+		return -EFAULT;
+	if (n_samples > MULTI_PTP_MAX_SAMPLES)
+		return -EINVAL;
+	if (n_clocks > MULTI_PTP_MAX_CLOCKS)
+		return -EINVAL;
+	if (copy_from_user(clkid_arr, &ptp_multi_clk_get->clkid_arr,
+			   sizeof(clockid_t) * n_clocks))
+		return -EFAULT;
+
+	kernel_tp_base = kmalloc_array(n_clocks * n_samples,
+				       sizeof(struct timespec64), GFP_KERNEL);
+	if (!kernel_tp_base)
+		return -ENOMEM;
+
+	kernel_tp = kernel_tp_base;
+	for (j = 0; j < n_samples; j++) {
+		for (i = 0; i < n_clocks; i++) {
+			kc = clockid_to_kclock(clkid_arr[i]);
+			if (!kc) {
+				error = -EINVAL;
+				goto out;
+			}
+			error = kc->clock_get_timespec(clkid_arr[i], kernel_tp++);
+			if (error)
+				goto out;
+		}
+	}
+
+	kernel_tp = kernel_tp_base;
+	for (j = 0; j < n_samples; j++) {
+		for (i = 0; i < n_clocks; i++) {
+			if (put_timespec64(kernel_tp++, (struct __kernel_timespec __user *)
+					&ptp_multi_clk_get->ts[j][i])) {
+				error = -EFAULT;
+				goto out;
+			}
+		}
+	}
+out:
+	kfree(kernel_tp_base);
+	return error;
+}
+
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
-- 
2.26.3


