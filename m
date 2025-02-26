Return-Path: <linux-arch+bounces-10396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD81A46F0A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D18A1686B5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0708725DB07;
	Wed, 26 Feb 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UNghjiUy"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3225A65F;
	Wed, 26 Feb 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611340; cv=none; b=XPoT4lriTmWGOupBKtW9vNpFEESoTQuJ4LpDKDDHjSS6mBe+crD3by7ZgwQX8ebXuA/OYezPp2V1J/TV55+nrdutkZTY7zxiUEIAmeYYh3vQzpAF346j+SZkV6xdNsymxJ8PmJpOroDzFiRRZCHc0NILjZCm0njiOEf5SjOlj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611340; c=relaxed/simple;
	bh=gA7FgEoKN3INrA9tV5ABLXfRL6LtkfQRswT90RRN6x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rl8rR7ktDbu7nFzqvriOLo557qN+zTBLT8+U1gnlDBBByfI4L04wpAuIcgXzaPHopfnNajYQfL5Qi9f/lvO811/4l2KhkRyM9XdR+UhSZMMXWy5aCPKbfsjg0JWDgRKeTMpJtid+bAHDMEN1g0XIGA1kK6hPhLcNNIRj+P1kUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UNghjiUy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD77A210EAC7;
	Wed, 26 Feb 2025 15:08:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD77A210EAC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611338;
	bh=Voi1Fzc5rMEYO4WvoQDQTZIpM4gpYLEdpDjYw/a8q2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNghjiUyavrXy563jYLe842b99uvQooFQW3whJDmeHqz+uUE/kk7kLLUvpLpl0jnM
	 2ACKsoqMJy4B0cWZ7rrEyUOdtFsToxL7rQoGBTsj69Ll0CcbT87SUyXypUjLWewF+Q
	 kieJUrEFEjuO3bqWI5Mc2rN9rtRkHdWoTiP/mAP0=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com,
	stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to arm64
Date: Wed, 26 Feb 2025 15:07:57 -0800
Message-Id: <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

These non-nested msr and fast hypercall functions are present in x86,
but they must be available in both architetures for the root partition
driver code.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
 arch/arm64/include/asm/mshyperv.h | 12 ++++++++++++
 include/asm-generic/mshyperv.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 69004f619c57..e33a9e3c366a 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
 }
 EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
 
+/*
+ * hv_do_fast_hypercall16 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
+{
+	struct arm_smccc_res	res;
+	u64			control;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
+
 /*
  * Set a single VP register to a 64-bit value.
  */
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 2e2f83bafcfb..2a900ba00622 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -40,6 +40,18 @@ static inline u64 hv_get_msr(unsigned int reg)
 	return hv_get_vpreg(reg);
 }
 
+/*
+ * Nested is not supported on arm64
+ */
+static inline void hv_set_non_nested_msr(unsigned int reg, u64 value)
+{
+	hv_set_msr(reg, value);
+}
+static inline u64 hv_get_non_nested_msr(unsigned int reg)
+{
+	return hv_get_msr(reg);
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c020d5d0ec2a..258034dfd829 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -72,6 +72,8 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
+
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
-- 
2.34.1


