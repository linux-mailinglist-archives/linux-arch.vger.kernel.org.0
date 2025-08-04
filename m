Return-Path: <linux-arch+bounces-13059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0EB1A8E4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF03BCA0D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986328B4E1;
	Mon,  4 Aug 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+Subz+W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D05258CD3;
	Mon,  4 Aug 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330734; cv=none; b=ovo0kVRMiIX/DDhdUxZEs+FAsKU3AgLgOq+6+8vNKCnMMCxvSsDhWTR92T78CfnnubNz4WBUH+deH7WC5mhtYeWG2aYBwwlIggSsg5AAMA6++guE3ip6/nTle97C7U7wBPL4sZytUoooH4WcZwt0Gw2bl2Rmjs8PEFa6DY9NYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330734; c=relaxed/simple;
	bh=OwnTw3uK7yB5c51Tl0CAUBqfi3DK/t76c6S4ZAo74ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArN8AJHBX17xT1b2Cw7M0vG19lM+wJmzJNuxKbIikKHdYa17+XQAPD4pOhzl04ry1gZQC3x4AAisel/osmN+WyIMqbbmOdTicsrKtIjYecJO3iIgNPnQnR+tNgVN2EwqVfwEl621PfqtwiCkA4V5PbCzcj9vrVsPbRDOdJaTPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+Subz+W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2403c13cac3so43859735ad.0;
        Mon, 04 Aug 2025 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330732; x=1754935532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5un/sQQC+zCFhLU2I/r3RaEnZHYOsc9l2VjdIVN8y0=;
        b=A+Subz+WOp/Oc+Z/FdH8UsukZ07QuaMG8B7Ar+ZCk+4VhJIZnwFcJOKVHmZVIN2XNX
         GuMa9XEDhlVrgHGmcfXBDHSaKJv26AJLxABhW6DO6UaZhZTpKjUgABTziJNTrJylCPJm
         HylCyZLmXOthtMcJxJoWSvJo7bhz1OdcYjy5rxb2P/w5R6HeX3Wy6xffxs8GZexDm0kb
         o3get1FZ/U8ZY/KTXEZx1hFZ4nvkby8Pin31qDi4gREN+X/bs5keL6we7DYS/cUfZ6dW
         Pq81n9ue9eSEZEU+dFqeMrLbU8T50dOHwbDCtjgzMpu2zw79Hg+w/8E+QD339MZEvf/7
         +3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330732; x=1754935532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5un/sQQC+zCFhLU2I/r3RaEnZHYOsc9l2VjdIVN8y0=;
        b=D5DLZYxkBcv/8kbVZAYwXaDX8b8fPM7uMFxz3ti7uZsdmQf4xjRreDrLoBtP1K68hY
         hKGpCve0oePBcGtd4GUM4GBeHKtwUap1WLf9hSWp9w/uweFy8q/M+ufc8LZ4nimKVM3y
         34peV3domHFqEkTEn2Lw7A1Svl8EDNQjWznVIUQRUeziMuzeuOWosiuWWU1phRZOtFHp
         hJBDC+0aGAbG0oixDg9OYLH/T3KR1DnahkhlI2nRgzYercM19Lfntle1fVrvLJT7zjVk
         zyl0k1NEOu2aNWXSZ5MTX+V6Dd1ZyeAPTdop5vZNP27lbozAJDx+PuZ2pJYQeYi5e58L
         UcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlu8u4NjZxWtealOXSYSRjKBr7qBaFoe57tDyA9wma2bSbOzVhEzzjpI8NrntRS5SCdow4TDLHOz4U@vger.kernel.org, AJvYcCX2ruPKnJ5LvFiARBjPb2JpReNADQivmKziqCMO/xnJB3X9tFVRWgMg2kJcetdRPh65/sJTmb5GofHN1awO@vger.kernel.org, AJvYcCXY7OR6PjjBNayO9wjkTRM1h+9RwDq66gl+9BRz/BrEPLNIko94bPJHtfKZ94l3/m3fXqECr6Ep/KRSQ/6B@vger.kernel.org
X-Gm-Message-State: AOJu0YyBx9U/5+Bp6mUsye59Byd1DJj+VOmSjbKRySt3WAL3qWzYvW99
	ExWRHOFOMwmtm6QtsQjrxszArx4J+aX7V8HOPE9fuK8iSK6moLssYlLc
X-Gm-Gg: ASbGncuJJM07zHqFFuHOR3TR7zKKU6WoYxEIG6ZnETA23VlDcYPJKZmX18O2FEihZVv
	9Fb89qTnaK6WLj8RCHsWe9iW3nWzez625kOBlXdPcG0h1RcEmTl33MC+lj0dZgJ6qe7pm7mehSE
	lJXmV3QqdOM419Jz428kcQZrc/iJeIfDie8EEO4t09e+2O2hqwWajqMKBONWjDNof40vrbu0D1M
	irorEQxKIxAFhISed1hc/i3VaUDjexyYroY+sVSJAhSqLh478P8qt+17Uibn6z4LFhlg0/zkRPS
	eNjURUP0+wGE3hRX61BIoyKuq/L6PJgQT6NThPrs98MVRRCc6PuWiMXomYS6mRi4guhhMJms951
	XqUUCkvIe7uduwA4FedtscXE7w5zihgK6NGTIczkme22TyFbzjxqicJ4aE00PSgM=
X-Google-Smtp-Source: AGHT+IF1r4Uj2dSSbjnREKNgVY5077VXWjmnua/R/CFyFXiWymX1ZlYuodHv1wiIc2verd4QWVpt4A==
X-Received: by 2002:a17:902:fc4d:b0:23f:fa47:f933 with SMTP id d9443c01a7336-24288d46831mr6787045ad.8.1754330732070;
        Mon, 04 Aug 2025 11:05:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:6f:2b47:96b8:6281:35ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm114144825ad.173.2025.08.04.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:05:31 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Mon,  4 Aug 2025 14:05:23 -0400
Message-Id: <20250804180525.32658-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804180525.32658-1-ltykernel@gmail.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is enabled, VMBus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject VMBus message interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V4:
        - Change the order to call hv_enable_coco_interrupt()
	  in the hv_synic_enable/disable_regs().
	- Update commit title "Drivers/hv:" to "Drivers: hv:"

Change since RFC V3:
       - Disable VMBus Message interrupt via hv_enable_
       	 coco_interrupt() in the hv_synic_disable_regs().
---
 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 7 ++++++-
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e669053b637d..a8de503def37 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	wrmsrq(HV_X64_MSR_ICR, reg_val);
 }
 
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+	apic_update_vector(cpu, vector, set);
+}
+
 static u32 hv_apic_read(u32 reg)
 {
 	u32 reg_val, hi;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..2ff433cb5cc2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -314,8 +314,11 @@ void hv_synic_enable_regs(unsigned int cpu)
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
+
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
+
 	/* Enable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 1;
@@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
-
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
@@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
+
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
+
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..0f024ab3d360 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+}
+EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..7907c9878369 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1


