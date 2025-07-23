Return-Path: <linux-arch+bounces-12902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA4B0FAA5
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF78B7B0D52
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD822FAF8;
	Wed, 23 Jul 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo1coXzQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE021A42F;
	Wed, 23 Jul 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297397; cv=none; b=niR/Ka4MOo5uGS6DVNok0mMXgBYUxvgwvUKiIC6uRiKGpHKCvs2hifo6G7/PP6H0BlaUnufdxQtATIuTGdzjZuFAV7fpaN/GTd41Ljep8Q3hkL/byJxAiN51H3ebWVsWTc90RWaOGSQZ1dc0CbMQAXTkMEGWO2SvYba0MslAooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297397; c=relaxed/simple;
	bh=F0QcUV2GpzxLWK79UBGJM5xZhPEntD+StQRxSsqwA1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JuYRqv5Owk48W+n1B4D4aWoTFXqq3bi7SJ5mRBgfeMuP3m4DXRQwR0x12PzIzF2N3qonDYsywgZdCzgryo6Ff7juvLim9+muc4rhGA4fUHhJbjVSNO5RdTNmw1lyY05BBy0Swh6Qz3uvuZ4OdKBrpuFcAXpgudiA8qXyJWCz6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo1coXzQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so879263a91.0;
        Wed, 23 Jul 2025 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297395; x=1753902195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMbOhpwWYUm0Ppb5mKeY2S/rLvAw840TCqNURlJCkCI=;
        b=Uo1coXzQCtbCqQvhwD38Zmees8ddCJp5fMBOVq9GULQMEHQaa5jVzJfIUBsPm3NsY1
         fP1uECilsmPtVu+s/Pvxz32ZVXyt1wT7MuLXXbouDbCtxieT5buDLQT1+S4+XWVR36v4
         odR5O/YrDThD22TdLXgN4vhVa06ayJGA6xWhMWvlUVx2RjvQKsQd8PLvSf+omPc9xrH+
         CYpK2Gr0w3ah04wPAiwbq75KzF7ggf5VHpomlaPwzEeUGM3FR1PsvZ0j0yLXA/k1RgTs
         wK+XLS61twHHURbuHK/hgB06flA1Mim9oVqE9IXs30pwV51lUTcaDVwj78dYvtYS63HV
         LaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297395; x=1753902195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMbOhpwWYUm0Ppb5mKeY2S/rLvAw840TCqNURlJCkCI=;
        b=hXhMnWkDU/EdOQYTVobd+q/NnEpJjsTbzd8UJiFy9DFjzuwMJuvesEPo847YZfUXiU
         q9uWgQKtnI9NpSEZg78Ml/QXuFErOqUrLCsmgQmWyB6IOTRAnsNfykG0xydhbQVVET6D
         OH9VrITk1p1VB7pUrGNYMvO/ssR4ob7XWLaxoFG6efLSQJwZCszMwZbbUXImTqnPP+R/
         c38wx3kAgMkUMK4SOwPgpbthDZIkr9+bhVroVUncclKvBTBp3x7HF6yxMKReQfExYIhz
         X9rPI63S/+FNeSWDh4ZbvbexidqWgoaFMskYKZBoBl0SVeCo+7WlwOfIEDNdu1gQSGwQ
         UapQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOs+NGP3yGBVtMkjBsl9PtSwI2qS2tS1MWrq/FznHDMIjtTgr1seV5t5vqkO3wBl/gvHMAh3cSWql+rxR6@vger.kernel.org, AJvYcCUPa3cOr/nrWmNXhRQ6f0KTqT+mCdpmXHAN4FXMaIhANOXZMZ3f56oplG7dGmwwsA8LyGnhGsp1fo23A5Ej@vger.kernel.org, AJvYcCXnCs5kWrMIWTYFC0ItmcDhzz4ekRT9RBYGFO2rsNYELbZVd/YlhfX3gJu+x971ankvKkge3F1gRkye@vger.kernel.org
X-Gm-Message-State: AOJu0Ywia+PYFX8/gPxlAjawN2lXFAxAZF2VurB8UIJOqwlBJ5lZCfkh
	r9Lm6gUEj3ur23mTeIH+Kp6HmDuwPdf+qk1rIFGcea33G75C7QsmIMic
X-Gm-Gg: ASbGncuZWfTweFffGBGqPo/srJEJ+BvCKOhvxIQj4RXnpZbhsPknCHqHp4D2+4Q7Ew0
	mvXUEaz/vITPfRoKsiA7I6B4TaV/5lleuUmzvHMbBuS5mDb9B/cXL5CMXMlnHkB2SVfEKpDAzW0
	ugQlfctJTdBtQsy676PQUzzJ2BmrWdfGGhhCZko52j5Tl0jzX2eMbWjHzptLGQqTpmZSznBfy/9
	cMIzxX2cOBMvX2gMJfuvFipJUhDYnoaFJ7R/4UItyaJ2d2biLBiAR8gxhZluiVkNtxtgoyNmCNl
	6eXYSxVDQKqYDzEteCO5WuOOT65g3jFBVFDoevovvpWA1grePcXp9zZRt8T2ZYnAEOoKM+oYolR
	Ee41c6EOwfS5Wg7+1++LEzfsppXTTXMXVtjWnx98wZzBJlBGFBwIrHr2oN4nHJW4=
X-Google-Smtp-Source: AGHT+IH9nVYC5Tjp2TFWcLFI5AwZOy8EsFuv5wt4CKAYmneeaO5AeJSEpnJETkfA8xoDyK5QgTXtpA==
X-Received: by 2002:a17:90b:2650:b0:315:aa6d:f20e with SMTP id 98e67ed59e1d1-31e5130f5d5mr5077507a91.4.1753297395274;
        Wed, 23 Jul 2025 12:03:15 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:73:51be:8747:b004:dd13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm9513884a12.2.2025.07.23.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:14 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 2/4] Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Wed, 23 Jul 2025 15:03:06 -0400
Message-Id: <20250723190308.5945-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723190308.5945-1-ltykernel@gmail.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
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

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since v3
       - Add hv_enable_coco_interrupt() as wrapper
       of apic_update_vector()

 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1c48396e5389..dd6829440ea2 100644
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
index 308c8f279df8..2aafe8946e5b 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
+#include <asm/apic.h>
 #include <linux/set_memory.h>
 #include "hyperv_vmbus.h"
 
@@ -310,6 +311,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
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


