Return-Path: <linux-arch+bounces-2992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051087BA03
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 10:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A55281EA7
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB56BFA0;
	Thu, 14 Mar 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THgkgzhD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9E3EA6C;
	Thu, 14 Mar 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407150; cv=none; b=RxwJZw5MmGkCIFfe6Km2xyhXOAuk/ODK0qql2vp1DVKjNYLKZzFo/Yk4uE/FZGJHT7hIaoW7JM154aEdNSxyq035vrfssa7TpY3JgQvwB8olJYgmbZNHw14el6qLnLCie/Z2+Cee3LN3BHvZw75FSZ1oPqYmApzX/Rd0XtzZ+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407150; c=relaxed/simple;
	bh=RVDzzH5i1FlQl8rgsxI9QOfCaS4ddm1ZBzsF1v2cvDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JhowXM5wovLvAhEKNGzA3QMU8/Sp1iz06e6o9NDH79EMxr5l4d5ySsOp+GXKCnUNYpVpei71WdRMKm1Ia/b9dK2/lcnDJhF8n+SmLCxCm1/0wWK/EY2m0mhMEHoQN8PhAcx8mfQ9uve3HhaeIIVVWdbvnEXaDO7S2M08oJAH6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THgkgzhD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e9dfd343fso398345f8f.0;
        Thu, 14 Mar 2024 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710407147; x=1711011947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01PS9MyjvZ+fa5ZtYejHf1bfKehy4wrijtyd8vZ9ETI=;
        b=THgkgzhD9sqR8ZBYf9fvXIbOLmp6GRuPyZI85WK1tIH8kqH29o6HiTqYFQ28J7xKeX
         3Vgh316DJeR8wffFNOBLwEOEIPY93EECmcIC/Ha7M9cMrcWl+sxrfa7WDSZmAD3tOu78
         Us/S++ulLTDfsnnk8kgwj0lEkHUZUEL52n/1oVzeQ9aP8iRLVSNopT1ivo+Jmhl6g06L
         dNA1bc5YeKmRDdhBpcJyEeYEy0GlTu7jJ+B2rgepEOPo06T7X4n38MivuPmOFyyjPhMi
         THmoX6NOQ+UTBtvw7R7KbaGODBRG80fqVvRPrGzkLMgEUVrm6s2/ojjmk9+aG2OhZto4
         2j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407147; x=1711011947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01PS9MyjvZ+fa5ZtYejHf1bfKehy4wrijtyd8vZ9ETI=;
        b=o2ZBm2lkzFSk1n93jCKUrtM3wVJq437W45Lkcio8bX5P/ZKhN2daCRdPPdJsV+4OYc
         0zNX3UOy9bIGTIALKZ5d1EqavbK4Spfi6gZ874t2TRjmPCrHCcR/N1eWIKI4/VqxY4Nw
         rzm+umrZseW4mqixGo2yyPS713YMaldi/3ygHHYaMzEFliztp94F5z15BSe+ZX27etia
         oner35yrcNE8k5Ujx2E58tqA+ITWxk3Vp19vrrz7JNn4IVrq1UvfevuV23xzJP38Zt5B
         ZbOLsrCaofTBLzI+DRmZ0XsKsm6P1xm3hhsSqlSp/+nuyFe0DN3odx4XHCHJ6HEjjuJ5
         EwJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqn9iXIY5bZ279Z8D5W5HFSE9N53c3OiSfmOb70D3DYXUUc2jRiYfeKyZlYlUhcR9bgK1MV71ieOPk1P0wN3LSwcQoebLe3q9sa21upoWf3L69F9Uv03kkRKt/2Dl38jQVDfvNAsDDTu3YALMPhVmI907/9P8UsbEgsUOKew==
X-Gm-Message-State: AOJu0YyaTFCAyMT9REPDODCpGCGvThP2IaxBUbeA/6/hCUbXqvGwiKaV
	MlUHxQKcU+nld7tRHrXKA7Q4wOY50tlcRNIIv3Rg0m98qxZXD+Pm
X-Google-Smtp-Source: AGHT+IFFKd5FCs2i1AVIOZdOQmuDBOotWYgL/a1/GRZg2EFfeopIfGlwR3Fp1YHVJ9LqjKxUjgpRqw==
X-Received: by 2002:a5d:4083:0:b0:33d:f56e:f867 with SMTP id o3-20020a5d4083000000b0033df56ef867mr647384wrp.67.1710407146731;
        Thu, 14 Mar 2024 02:05:46 -0700 (PDT)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id w16-20020adfcd10000000b0033e5c54d0d9sm266265wrm.38.2024.03.14.02.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:05:46 -0700 (PDT)
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
	mark.rutland@arm.com,
	mszeredi@redhat.com,
	casey@schaufler-ca.com,
	reibax@gmail.com,
	davem@davemloft.net,
	brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v7] posix-timers: add clock_compare system call
Date: Thu, 14 Mar 2024 11:05:40 +0200
Message-Id: <20240314090540.14091-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some user space applications need to read a couple of different clocks.
Each read requires moving from user space to kernel space.
Reading each clock separately (syscall) introduces extra
unpredictable/unmeasurable delay. Minimizing this delay contributes to user
space actions on these clocks (e.g. synchronization etc).

Introduce a new system call clock_compare, which can be used to measure
the offset between two clocks, from variety of types: PHC, virtual PHC
and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
The system call returns the clocks timestamps.

When possible, use crosstimespec to sync read values.
Else, read clock A twice (before, and after reading clock B) and average these
times – to be as close as possible to the time we read clock B.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Addressed comments from:
 - Arnd Bergman : https://www.spinics.net/lists/netdev/msg980859.html

 Changes since version 6:
 - cheaper implantation regarding timespec64 operations. 
  
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 drivers/ptp/ptp_clock.c                |  34 ++++--
 include/linux/posix-clock.h            |   2 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 kernel/time/posix-clock.c              |  25 +++++
 kernel/time/posix-timers.c             | 138 +++++++++++++++++++++++++
 kernel/time/posix-timers.h             |   2 +
 8 files changed, 200 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..727930d27e05 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462	common	clock_compare		sys_clock_compare
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4868..37ce66d4159f 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -156,17 +156,31 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	return err;
 }
 
+static int ptp_clock_getcrosstime(struct posix_clock *pc, struct system_device_crosststamp *xtstamp)
+{
+	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	int err;
+
+	if (!ptp->info->getcrosststamp)
+		err = -EOPNOTSUPP;
+	else
+		err = ptp->info->getcrosststamp(ptp->info, xtstamp);
+
+	return err;
+}
+
 static struct posix_clock_operations ptp_clock_ops = {
-	.owner		= THIS_MODULE,
-	.clock_adjtime	= ptp_clock_adjtime,
-	.clock_gettime	= ptp_clock_gettime,
-	.clock_getres	= ptp_clock_getres,
-	.clock_settime	= ptp_clock_settime,
-	.ioctl		= ptp_ioctl,
-	.open		= ptp_open,
-	.release	= ptp_release,
-	.poll		= ptp_poll,
-	.read		= ptp_read,
+	.owner			= THIS_MODULE,
+	.clock_adjtime		= ptp_clock_adjtime,
+	.clock_gettime		= ptp_clock_gettime,
+	.clock_getres		= ptp_clock_getres,
+	.clock_settime		= ptp_clock_settime,
+	.clock_getcrosstime	= ptp_clock_getcrosstime,
+	.ioctl			= ptp_ioctl,
+	.open			= ptp_open,
+	.release		= ptp_release,
+	.poll			= ptp_poll,
+	.read			= ptp_read,
 };
 
 static void ptp_clock_release(struct device *dev)
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..3a5b4bb3f56b 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -47,6 +47,8 @@ struct posix_clock_operations {
 
 	int  (*clock_settime)(struct posix_clock *pc,
 			      const struct timespec64 *ts);
+	int  (*clock_getcrosstime)(struct posix_clock *pc,
+				   struct system_device_crosststamp *xtstamp);
 
 	/*
 	 * Optional character device methods:
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..47c5de3bdb18 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1188,6 +1188,10 @@ asmlinkage long sys_ni_syscall(void);
 
 asmlinkage long sys_ni_posix_timers(void);
 
+asmlinkage long clock_compare(const clockid_t clock_a, const clockid_t clock_b,
+			      struct __kernel_timespec __user *tp_a,
+			      struct __kernel_timespec __user *tp_b,
+				  s64 __user *offs_err);
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
  * Instead, use one of the functions which work equivalently, such as
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..537a35afd237 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_clock_compare 462
+__SYSCALL(__NR_clock_compare, sys_clock_compare)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..68b2d6741036 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -327,9 +327,34 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	return err;
 }
 
+static int pc_clock_get_crosstime(clockid_t id, struct system_device_crosststamp *xtstamp)
+{
+	struct posix_clock_desc cd;
+	int err;
+
+	err = get_clock_desc(id, &cd);
+	if (err)
+		return err;
+
+	if ((cd.fp->f_mode & FMODE_WRITE) == 0) {
+		err = -EACCES;
+		goto out;
+	}
+
+	if (cd.clk->ops.clock_getcrosstime)
+		err = cd.clk->ops.clock_getcrosstime(cd.clk, xtstamp);
+	else
+		err = -EOPNOTSUPP;
+out:
+	put_clock_desc(&cd);
+
+	return err;
+}
+
 const struct k_clock clock_posix_dynamic = {
 	.clock_getres		= pc_clock_getres,
 	.clock_set		= pc_clock_settime,
 	.clock_get_timespec	= pc_clock_gettime,
 	.clock_adj		= pc_clock_adjtime,
+	.clock_get_crosstimespec	= pc_clock_get_crosstime,
 };
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..ea43527cd5e9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1426,6 +1426,144 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 #endif
 
+/**
+ * clock_compare - Get couple of clocks time stamps
+ * @clock_a:	clock a ID
+ * @clock_b:	clock b ID
+ * @tp_a:		Pointer to a user space timespec64 for clock a storage
+ * @tp_b:		Pointer to a user space timespec64 for clock b storage
+ *
+ * clock_compare gets time sample of two clocks.
+ * Supported clocks IDs: PHC, virtual PHC and various system clocks.
+ *
+ * In case of PHC that supports crosstimespec and the other clock is Monotonic raw
+ * or system time, crosstimespec will be used to synchronously capture
+ * system/device time stamp.
+ *
+ * In other cases: Read clock_a twice (before, and after reading clock_b) and
+ * average these times – to be as close as possible to the time we read clock_b.
+ *
+ * Returns:
+ *	0		Success. @tp_a and @tp_b contains the time stamps
+ *	-EINVAL		@clock a or b ID is not a valid clock ID
+ *	-EFAULT		Copying the time stamp to @tp_a or @tp_b faulted
+ *	-EOPNOTSUPP	Dynamic POSIX clock does not support crosstimespec()
+ **/
+SYSCALL_DEFINE5(clock_compare, const clockid_t, clock_a, const clockid_t, clock_b,
+		struct __kernel_timespec __user *, tp_a, struct __kernel_timespec __user *,
+		tp_b, s64 __user *, offs_err)
+{
+	struct timespec64 ts_a, ts_a1, ts_b, ts_a2;
+	struct system_device_crosststamp xtstamp_a1, xtstamp_a2, xtstamp_b;
+	const struct k_clock *kc_a, *kc_b;
+	ktime_t ktime_a;
+	s64 ts_offs_err = 0;
+	int error = 0;
+	bool crosstime_support_a = false;
+	bool crosstime_support_b = false;
+
+	kc_a = clockid_to_kclock(clock_a);
+	if (!kc_a) {
+		error = -EINVAL;
+		return error;
+	}
+
+	kc_b = clockid_to_kclock(clock_b);
+	if (!kc_b) {
+		error = -EINVAL;
+		return error;
+	}
+
+	// In case crosstimespec supported and b clock is Monotonic raw or system
+	// time, synchronously capture system/device time stamp
+	if (clock_a < 0) {
+		error = kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a1);
+		if (!error) {
+			if (clock_b == CLOCK_MONOTONIC_RAW) {
+				ts_b = ktime_to_timespec64(xtstamp_a1.sys_monoraw);
+				ts_a1 = ktime_to_timespec64(xtstamp_a1.device);
+				goto out;
+			} else if (clock_b == CLOCK_REALTIME) {
+				ts_b = ktime_to_timespec64(xtstamp_a1.sys_realtime);
+				ts_a1 = ktime_to_timespec64(xtstamp_a1.device);
+				goto out;
+			} else {
+				crosstime_support_a = true;
+			}
+		}
+	}
+
+	// In case crosstimespec supported and a clock is Monotonic raw or system
+	// time, synchronously capture system/device time stamp
+	if (clock_b < 0) {
+		// Synchronously capture system/device time stamp
+		error = kc_b->clock_get_crosstimespec(clock_b, &xtstamp_b);
+		if (!error) {
+			if (clock_a == CLOCK_MONOTONIC_RAW) {
+				ts_a1 = ktime_to_timespec64(xtstamp_b.sys_monoraw);
+				ts_b = ktime_to_timespec64(xtstamp_b.device);
+				goto out;
+			} else if (clock_a == CLOCK_REALTIME) {
+				ts_a1 = ktime_to_timespec64(xtstamp_b.sys_realtime);
+				ts_b = ktime_to_timespec64(xtstamp_b.device);
+				goto out;
+			} else {
+				crosstime_support_b = true;
+			}
+		}
+	}
+
+	if (crosstime_support_a)
+		error = kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a1);
+	else
+		error = kc_a->clock_get_timespec(clock_a, &ts_a1);
+
+	if (error)
+		return error;
+
+	if (crosstime_support_b)
+		error = kc_b->clock_get_crosstimespec(clock_b, &xtstamp_b);
+	else
+		error = kc_b->clock_get_timespec(clock_b, &ts_b);
+
+	if (error)
+		return error;
+
+	if (crosstime_support_a)
+		error = kc_a->clock_get_crosstimespec(clock_a, &xtstamp_a2);
+	else
+		error = kc_a->clock_get_timespec(clock_a, &ts_a2);
+
+	if (error)
+		return error;
+
+	if (crosstime_support_a) {
+		ktime_a = ktime_sub(xtstamp_a2.device, xtstamp_a1.device);
+		ts_offs_err = ktime_divns(ktime_a, 2);
+		ktime_a = ktime_add_ns(xtstamp_a1.device, (u64)ts_offs_err);
+		ts_a1 = ktime_to_timespec64(ktime_a);
+	} else {
+		ts_a = timespec64_sub(ts_a2, ts_a1);
+		ktime_a = timespec64_to_ktime(ts_a);
+		ts_offs_err = ktime_divns(ktime_a, 2);
+		timespec64_add_ns(&ts_a1, (u64)ts_offs_err);
+	}
+
+	if (crosstime_support_b)
+		ts_b = ktime_to_timespec64(xtstamp_b.device);
+out:
+	if (put_timespec64(&ts_a1, tp_a))
+		error = -EFAULT;
+
+	if (!error && put_timespec64(&ts_b, tp_b))
+		error = -EFAULT;
+
+	if (!error && copy_to_user(offs_err, &ts_offs_err, sizeof(ts_offs_err)))
+		error = -EFAULT;
+
+	return error;
+}
+
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index f32a2ebba9b8..b1f6075f35bb 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -11,6 +11,8 @@ struct k_clock {
 				      struct timespec64 *tp);
 	/* Returns the clock value in the root time namespace. */
 	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
+	int	(*clock_get_crosstimespec)(const clockid_t which_clock,
+					   struct system_device_crosststamp *xtstamp);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.26.3


