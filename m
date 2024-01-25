Return-Path: <linux-arch+bounces-1549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227D83B9F7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002F2282C2C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3461BDCF;
	Thu, 25 Jan 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b+/kfNVz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93421BDDC
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164213; cv=none; b=GZPfzDowzz1xErX32uDAMXZX+yUmeDiVBWjYkxSujAsMF3EDIN3rKj0F+gIV0yQr9zmjzVtYOPikXilUb7niAwgb8zSXk9dLVfGt0rczP5WXMQ5WiC1jh9GitfZuLyYh/XOlAGiW2gzs3Zpa3s7lYSku357v/RBqD9l7H3tmnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164213; c=relaxed/simple;
	bh=EeYE+liconztX3vH/QbRUB4lYtHeeSm6ruQQjkWo+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWVPZQxMCjW7orLeHmDP7bp9Lpycb2k0MGYZ9fyGNsvtw/5m+8H4mfBUR7lZnYDXVlrUXVqT9i/2NxFEtZqJpJDpTT2xz5oCn+rMzi/GpJmuhtvBRuttC2DIph2DTZt/cGzATXqNdIkDkbBe13NExJQOouDKd1mQIJeMDlkrNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b+/kfNVz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb9b28acb4so5043486b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164211; x=1706769011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZQZJuD25Dv4YRroK4zFhzWBRez2vp1MS493EB8S7EM=;
        b=b+/kfNVzZDe+CNWAISINy/6oNPq8qq7qEHSqLdYSyW01d/aIajuR8YQkfqfBM5ckoG
         DmFiAKEuQungjoP+s92MvTukPPB73lpddfJuYeixz783oIoRvjcsOAprpXcy02M2+HiJ
         goWJJFdEvw7GlzvvnAwpcjfL27zhS8T4VTmSjZansh3FLTmiGufMqm1f23AyJdzoJr9l
         uyVQOXfS2UGZMsSHdm/L+firkJFcMUl+i8zp8/pFo4QB52oAgTEXAVcXfUkEpXN0U6Fj
         gotriAFPdlugq8vQv7S/WLIfPkreebU7CK0mKHCIfN8PzuWkSxdl4ui+PZp2BXtHGIwv
         R7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164211; x=1706769011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZQZJuD25Dv4YRroK4zFhzWBRez2vp1MS493EB8S7EM=;
        b=mLn95dpYpIRZfXqPzTgYR38jyD7aRZN+zgCdshHV/VOkMZoZZGJHKdDZflfR2c6LtC
         VUux9L03OT9JGpCJe9NnbM/kvog8kTdV8BwKHcxIfPWSkuDNkukCon6kbJjzdnXORv6j
         WbRjbCS7G14iUmSYr9Hph2EbOyG94phLyAbuBWkrX/6DXDhhYuiuvTHYO2y/mfcB+kpL
         F4D9sPBmnaAYxv4k0E2RdtTbVCzpv3EljCqg7l3Fs9Tp1HjqsQHBg/EXlyL59PLvIcEv
         jVftfulJJChRjJPyIdHImnO3H3Y5EhpyEwbpgW3LSsOaaTm97krX5OqDeiLkhaghdCCb
         1cww==
X-Gm-Message-State: AOJu0Yxusox+puwRWDU2tUdZFEC4yk4sBy/zkLG/whkn6AI5cpuFzOPP
	+uHw0baIDPugKEZKN7wlj1aOhgD8rpXD3uWWWh+RFmkRJ4jdyC6ciCMV+zYKdvE=
X-Google-Smtp-Source: AGHT+IEILiG8nfheUeEY3dgaOhbjObj6SeloQjQPpcALaC4ZkHtiDf7mRG4/M+Lq5WuyhX+48/5Osw==
X-Received: by 2002:a05:6808:d51:b0:3bd:bf47:d635 with SMTP id w17-20020a0568080d5100b003bdbf47d635mr590089oik.41.1706164210775;
        Wed, 24 Jan 2024 22:30:10 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:10 -0800 (PST)
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
Subject: [RFC PATCH v1 20/28] riscv: Implements arch argnostic indirect branch tracking prctls
Date: Wed, 24 Jan 2024 22:21:45 -0800
Message-ID: <20240125062739.1339782-21-debug@rivosinc.com>
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

prctls implemented are PR_SET_INDIR_BR_LP_STATUS / PR_GET_INDIR_BR_LP_STATUS
and PR_LOCK_INDIR_BR_LP_STATUS.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 17 +++++++-
 arch/riscv/kernel/usercfi.c      | 74 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 72bcfa773752..4bd10dcd48aa 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,7 +16,9 @@ struct kernel_clone_args;
 struct cfi_status {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
-	unsigned long rsvd : ((sizeof(unsigned long)*8) - 2);
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 4);
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -29,6 +31,8 @@ void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned
 void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
 bool is_shstk_enabled(struct task_struct *task);
 bool is_shstk_locked(struct task_struct *task);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -66,6 +70,17 @@ static inline bool is_shstk_locked(struct task_struct *task)
 	return false;
 }
 
+static inline bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return false;
+}
+
+static inline bool is_indir_lp_locked(struct task_struct *task)
+
+{
+	return false;
+}
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index be3a071272d8..af8cc8f4616c 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -67,6 +67,30 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked ? true : false;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread_info.envcfg |= ENVCFG_LPE;
+	else
+		task->thread_info.envcfg &= ~ENVCFG_LPE;
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -374,3 +398,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
 	return 0;
 }
+
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is enabled on the task or not */
+	fcfi_status |= (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE : 0);
+
+	return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	bool enable_indir_lp = false;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is locked and further can't be modified by user */
+	if (is_indir_lp_locked(t))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (status & ~PR_INDIR_BR_LP_ENABLE)
+		return -EINVAL;
+
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE) ? true : false;
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+		!is_indir_lp_enabled(task))
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}
-- 
2.43.0


