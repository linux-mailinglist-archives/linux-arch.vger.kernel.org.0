Return-Path: <linux-arch+bounces-1547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38083B9EC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB012830B5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6A10A30;
	Thu, 25 Jan 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gWHNa0lq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B101B97C
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164205; cv=none; b=CtClHNCrNe1QRt0XlIZ8k61pPwjbP2C7jZLMxEof/dTk+0Wn6/c3T8/bvrANGR0O5gDDmF9duC+OgACIShWL+iDR6/2+VXd0AuRZ31sI/I9+IRO6LbOX16Xib6Wo0Jn4AZzLlYzdMmGv9x+CFO6H0wQGfz2pJtfRj/SXMGVBFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164205; c=relaxed/simple;
	bh=4Sh975sgRymcAV8ZKHUXceUa3PNA20l5DD1CTQBTdPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MElDI6qNlmc97/rHBDIxCLuqIuMquOekm3wWCR4XjBaNG3gd0dhNK0bGsiiJpdiSt/wcTkxvdmEhd25O3oUe8o4ERsW4/ypzatIClIcFXHtlQWxOef593VzrqLA35L8mAfDU3KvpbDivv3lBYo17zCDA2Nf3CF5GA0/XTCwPKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gWHNa0lq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dbb003be79so346700b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164203; x=1706769003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGW+3ds4X7hyu8QcIwFbpgQ3FZs37tf1ecbtDkVWTR0=;
        b=gWHNa0lqV/68/v/yI5Jm0C76G9Eyarj6xjKlgA6mO+yQRD25saMAMIEVB8tcKJPQ7h
         hNInJiQqDJf0niVh/N1jS6SwgIdRP4N1UWmL5SUkoickGA8wxo0BcvZVqPHXyI+5QZkK
         nJGeB39u6gnqaGVnWz7vSrxEucb9tHEDAjZCUFvFQYHG9DdNT7NKpx22iNjtiesh85CH
         OoeERgWzrrKj8thupgC+V74uPT+ie5+B5VTHhAxy8DS2tqNiAhCabWdn25lOf9aVmHiH
         84/hDrfJrtlPoeEpp1sDZLC/mJn9Tgmx21NhTDFk4HSzfEw8tTLvg29SnIgx2qGNQMXX
         FWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164203; x=1706769003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGW+3ds4X7hyu8QcIwFbpgQ3FZs37tf1ecbtDkVWTR0=;
        b=rMvHQtfV2aTiGovPd2pT8j+OZC+UQGnOA1CfrJcK3evxQnR+zWeawg42GGd5rLukou
         Fop11X+pUFY+KD/VfohBZu9KeKhOQjVs62QxwAygBfXvrYBzfy1lltezG11fTbJZlOti
         Nz3n9F0ysSWlDlONef+RPEz1m9kLj7wOoeQJ/uVdL5Tt8hdu8g6XRCe7lYVYzHYtEABT
         88xjfTZh+L3Vo2M32VxwkTJ3SZALcMNx6e2eojyQcQCmRTp70keZTfrESg9oNHYLqQpw
         FAeOAKm+aI4ob8lkoFqOj9Pm1grDs+z5nHDoWFwV6fKdeh3k6W8i4UQ147mOXZMpe4vE
         /8fw==
X-Gm-Message-State: AOJu0YxRBNU4GdEOzZQR8RXM1CLk/DOVNkRe9B/Qq1tsC0n7pH8o6UdV
	uhsVrM3Q+7Yz+Uertu39/7irurkMR7fKJS3mmdoS4WS3r0wV3z2Xh7x5JvRUsvU=
X-Google-Smtp-Source: AGHT+IFX0O2DMMykvx1boq4E3+vew5Q+ucUD8KeW51e5M6H2MI9XnhwlSZDCE7ZMzSEryAMcjaVeiA==
X-Received: by 2002:a05:6a00:b87:b0:6dd:c77a:721f with SMTP id g7-20020a056a000b8700b006ddc77a721fmr862372pfj.0.1706164203244;
        Wed, 24 Jan 2024 22:30:03 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:02 -0800 (PST)
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
Subject: [RFC PATCH v1 18/28] prctl: arch-agnostic prtcl for indirect branch tracking
Date: Wed, 24 Jan 2024 22:21:43 -0800
Message-ID: <20240125062739.1339782-19-debug@rivosinc.com>
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

From: Deepak Gupta <debug@rivosinc.com>

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses memory
operand to perform control transfer in program. As part of this tracking on
indirect branches, CPU goes in a state where it expects a landing pad instr
on target and if not found then CPU raises some fault (architecture dependent)

x86 landing pad instr - `ENDBRANCH`
aarch64 landing pad instr - `BTI`
riscv landing instr - `lpad`

Given that three major arches have support for indirect branch tracking,
This patch makes `prctl` for indirect branch tracking arch agnostic.

To allow userspace to enable this feature for itself, following prtcls are
defined:
 - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect branch
   tracking.
 - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch tracking
   Following status options are allowed
           - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
             thread.
           - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
             thread.
 - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
   tracking for user thread.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3c66ed8f46d8..b7a8212a068e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,31 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      73
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      74
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      75
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      76
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 96e8a6b5993a..9e2ebf9d9859 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2316,6 +2316,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2773,6 +2788,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.43.0


