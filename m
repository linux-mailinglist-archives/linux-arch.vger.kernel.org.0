Return-Path: <linux-arch+bounces-1546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0D83B9E9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A9328A206
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C915179A7;
	Thu, 25 Jan 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tumVLHYM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD11B96F
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164202; cv=none; b=Hg6sDVq7tPZLf3ltU0q4PNnnr7Z43A0pEsI8mxwVNoeJzyqW6IFJpsKIEcy5t7m6ccjEKLtKdUjpvvF3KroISW772HAUhI3FDLThxHjljC1tHECKlprEHwhML+8aXyLoLXAw0W5vd2O4caHUdbSBG8RnPGOv76ieGOsYcDfNWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164202; c=relaxed/simple;
	bh=zsH+L4+5U31JOanxoSfD/HI65SbmiKKd2XZ/ZrrZKO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2Rglj1jMTjk3wEqOiz8qZfSs/Z43PHYKvRZNFFzowZ1gsJJLTs5hnflzFO6/lGnx4waKff298hlD8yDisr/yJKwPEBBRgWh2QQy+u2+Y/zZV4T/f3Ei8lpLDDrPupBYHDiWSxelU17Ap5pDxnBMTzlpbo8oZlK/agYvEFrzF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tumVLHYM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso959719b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164199; x=1706768999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zflxddcDQBcU2vSu/tVz8rqPQxJomCL53KP/QLCzbU=;
        b=tumVLHYMRZNpwkx+IOHWvPpjC+R2gtSJtjnI78ZSjVpTWIllIdFm4fPMx/DnFffsNG
         6VdIxxf78PH6bDNlM5zxnNZcW8CwYYftu2diMxujYBphdOwixpvuS1AWRF2N/idR//jI
         QTaECaVLCq+PSkv17QmMlxmwPZw5bWYj268RRoCqommGeCHR5SdctVOEsq+Cm28QaaIj
         vtM/ENI3zhH0vL7gy579Kyrmpy+g/sL0ccrV1u+yXSgMUYDDVTH+9H2VEdwm6OwAnOK/
         X7nmyJgFVII9z2i9zrsgo3X4jjZZqF8/AUMqzm74MqKbrYzmsbNE6O9szw6yU+XTOcrT
         r1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164199; x=1706768999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zflxddcDQBcU2vSu/tVz8rqPQxJomCL53KP/QLCzbU=;
        b=FY/z+3yAWGrMonyP+lzN3htSodDAxjlpMMGHygQ2clMvXicez34GbcjUQbt/5ozk3J
         Z1T5S+kh8xaLg/ay2amR16RQJ+ztE2gs7x7MH3xUMZW0qk7IX6iRVIjfaR/zUoJFrlPy
         kamCdUAzq5R8orhEL8kGmuRhHWmo8Y6L69gVLowM3bgNgIzY+vJzeVsuFt1tmPzzz0iP
         XsPM2vRMGW5Kxon+XT/bNqC9dRVhTxYzemi3TOZFcUGYoWFa5OLwYDk/j+RJgpbXoneP
         PCj+Ocl3wUBj1rMFWuHXlrr6zw0UJkfhHcATaMb8gmV2c8YUsvp4KH8nMRgGMbpbWMih
         tppA==
X-Gm-Message-State: AOJu0YwFrQpSjGLl0mjsm+bESMCBg33g0YnZYSfPT9+Zu0lv+pInnrff
	PhcmQlQ/jBMwGaE17Ttd4VLVV/Lp1bG5xhJbQIXwTscbu9Ehe8eEmp+NHpJFGDU=
X-Google-Smtp-Source: AGHT+IGVLurI7ehwFwOqiPymyWwdcwBSGSxuQ1bEK3sHE/LCFMR0aIK1c3iw9hogS/394Qm8iTIo1Q==
X-Received: by 2002:a05:6a00:198c:b0:6db:ea8b:52ae with SMTP id d12-20020a056a00198c00b006dbea8b52aemr360157pfl.66.1706164199621;
        Wed, 24 Jan 2024 22:29:59 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:59 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 17/28] prctl: arch-agnostic prctl for shadow stack
Date: Wed, 24 Jan 2024 22:21:42 -0800
Message-ID: <20240125062739.1339782-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

Three architectures (x86, aarch64, riscv) have announced support for
shadow stacks with fairly similar functionality.  While x86 is using
arch_prctl() to control the functionality neither arm64 nor riscv uses
that interface so this patch adds arch-agnostic prctl() support to
get and set status of shadow stacks and lock the current configuation to
prevent further changes, with support for turning on and off individual
subfeatures so applications can limit their exposure to features that
they do not need.  The features are:

  - PR_SHADOW_STACK_ENABLE: Tracking and enforcement of shadow stacks,
    including allocation of a shadow stack if one is not already
    allocated.
  - PR_SHADOW_STACK_WRITE: Writes to specific addresses in the shadow
    stack.
  - PR_SHADOW_STACK_PUSH: Push additional values onto the shadow stack.
  - PR_SHADOW_STACK_DISABLE: Allow to disable shadow stack.
    Note once locked, disable must fail.

These features are expected to be inherited by new threads and cleared
on exec(), unknown features should be rejected for enable but accepted
for locking (in order to allow for future proofing).

This is based on a patch originally written by Deepak Gupta but later
modified by Mark Brown for arm's GCS patch series.

Signed-off-by: Mark Brown <broonie@kernel.org>
Co-developed-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h         |  3 +++
 include/uapi/linux/prctl.h | 22 ++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15c70fc677a3..df248764bcec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4170,5 +4170,8 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
+int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
 #endif /* _LINUX_MM_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..3c66ed8f46d8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,26 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/*
+ * Get the current shadow stack configuration for the current thread,
+ * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      71
+
+/*
+ * Set the current shadow stack configuration.  Enabling the shadow
+ * stack will cause a shadow stack to be allocated for the thread.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+/*
+ * Prevent further changes to the specified shadow stack
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_SHADOW_STACK_STATUS      73
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..96e8a6b5993a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2301,6 +2301,21 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2743,6 +2758,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_GET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_shadow_stack_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_shadow_stack_status(me, arg2);
+		break;
+	case PR_LOCK_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_shadow_stack_status(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.43.0


