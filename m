Return-Path: <linux-arch+bounces-13676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF4B856EC
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D82F1C27530
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121030F944;
	Thu, 18 Sep 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezg/bOJJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401E30E0C8
	for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207682; cv=none; b=Yk1hLA7uDOivHFb02IM5GBOCjWY2hjCYs6YlJbuYR1znwsjEfrE1WEYMpA5GXBphoc0gCGwX01K8nzeG18jEG4SWWoCwKvwzEHGQE3Z/koBzEV1019ZT4ex6RVQov/xxZ7vcLD4Q3AW0rzljUYtZsSpeNYq8ScnqwUZgUU4Fo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207682; c=relaxed/simple;
	bh=jigv5lGRfozuxeNjrQe5Jd18flyc/mH3vSjt7WpCG9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OE46fK5PIaOZToHInIJ2C8B9x8AaCA64lF5t1q0EImf4zv7lkRR2p8CxGMUYr0l/TjyeRmJC2SzbObKd11/uTndKU1m+iXnei4leO26QF5GDUU03bnrdt5exWHgQrQJrAUmRIYlNrVfKKmQyYro7WyzasCU8ZA1s62a3d0j5fsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezg/bOJJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b550eff972eso322175a12.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207679; x=1758812479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z793sSCLFMecAL1qHudhek1VXc1Ubweo7E2LhfZeqJ4=;
        b=ezg/bOJJ0njkugtVzt5nAP1yujsPZLB9gAHO6A8cJB1jwdKd9a+SIeEfqBlMRYNFng
         pNvdrEbTfRb01J+SDeCIY5V1exWhSpo4jIxoBHQUmJHrioGRiYQGyllhpy1SQs180usT
         hdMohOkiVnv6H3Vlcds8X6EMmMbPmj0BUU+hZfwMWD8v9snro0I2CFcNHwJrDKXizgt1
         iikHODJcYrp2hRi2a5KY9qNjsG7L0AUcmOyeottW+537rsJRucgFrEVNlze0m5O37bf1
         RLz4LngFDhAZm1ln4WyddvbNuu5fJrYazSKZ2N/yzZGM6u20TqNn3+ryxww9racihR0q
         kZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207679; x=1758812479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z793sSCLFMecAL1qHudhek1VXc1Ubweo7E2LhfZeqJ4=;
        b=jDmUK88vizzUKkxJodhY/fSRfZFw/fKjLng/s012/B+4IT/TU6Zjym+g1Ci3CQ1LMY
         KbdQtrD+tbA264mg+gcou3pZXqBY9cwD6HMm/uvnRddml+vdLqvN904IN30yk6LLpMgR
         3U0hQ0jxOfDMl+cQ6WUZ5nY8A5M4O6aXLUa7vw/iGbsOihGhjLaGFyJNj/0zro5tfhMb
         /JeMcXsTK0yEEvQr/LzbjNqOd8TtN4wrx9HSdMgEcLm45ur0zBtfrd9pEESQKrKIzMKa
         kvzDsj4kZmOV0sGd3/JqXWeDAtqFsflrWnSaMzN6t0c1jGNVC7k1y4evsu6IcRzTQKRI
         Qj9w==
X-Gm-Message-State: AOJu0YzRCwQXlNl6QMuvwKShI7k1mXZ53AMWAud7nXPhurSqOgyyrwc8
	Uo0IZLCpzbGdxuvzELvim7n62ysUc4B6n8/hPlN4UOONuARPJzU+wNFP
X-Gm-Gg: ASbGncsb3xBSOpqD/E8xsO/h5vozz8Q+x+OmOJty4Xyj6jUa1bV+4koMTS5n8KLmIkm
	17wfEpeMRm/F2TZ0To30B/9evtfGmFrE+/wC5tXSPJ+n0mHB70LR0OFgNlGxQv050K9tCC4xdMS
	yCOWuCUTlaFJ0zWiy4bFdW739erpSpavp/Qw1lDyLQIHfkuAvLdAtAsIU9UJJj7zYkZ1sDs3C6J
	GqCGRdVy+k/cFV6kRyL7ess8KnqrpFjlff/VQ9elpDeXs6uLcvotTR6KhxQPczISmHygZdiUM0+
	zr0MgqFpgxTsie5R3r94wpDxWLFMlm2/kxELx0dkjBqwZ2NYVCoIvvh0i0c2YvkwZxkXYYJjh4a
	tJAhyLdETibkeubZFrjISGcJgV+ihmHFmFvplEPuqhsIo2BqhVCeevMru0/j2cvAukA==
X-Google-Smtp-Source: AGHT+IEd6CLVBPEgC0+cky8wVNz975p+LYsCVhE+8kAl231+xpyYKE9iXFkssmQQTcZKLyd0w2CKmQ==
X-Received: by 2002:a17:902:d511:b0:267:9aa5:f6a6 with SMTP id d9443c01a7336-26812190737mr98812395ad.19.1758207678581;
        Thu, 18 Sep 2025 08:01:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:17 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
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
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86/Hyper-V: Add Hyper-V specific hvcall to set backing page
Date: Thu, 18 Sep 2025 11:00:23 -0400
Message-Id: <20250918150023.474021-6-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secure AVIC hardware provides APIC backing page
to aid the guest in limiting which interrupt
vectors can be injected into the guest. Hyper-V
introduces a new register HV_X64_REGISTER_SEV_GPA_PAGE
to notify hypervisor with APIC backing page and call
it in Secure AVIC driver.

Setting APIC backing page for APs takes place before
allocating hyperv_pcpu_input_arg and so allocate
hv_vp_early_input_arg to handle such case.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c           | 24 +++++++++++++++++-
 arch/x86/hyperv/ivm.c               | 38 ++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  2 ++
 arch/x86/kernel/apic/x2apic_savic.c |  9 ++++++-
 include/hyperv/hvgdk_mini.h         | 39 +++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a38bb96c9f5e..3fa8e91cd03f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -39,6 +39,7 @@
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
+void *hv_vp_early_input_arg;
 union hv_ghcb * __percpu *hv_ghcb_pg;
 
 /* Storage to save the hypercall page temporarily for hibernation */
@@ -412,6 +413,7 @@ void __init hyperv_init(void)
 	u64 guest_id;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int cpuhp;
+	int ret;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -419,6 +421,22 @@ void __init hyperv_init(void)
 	if (hv_common_init())
 		return;
 
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC)) {
+		hv_vp_early_input_arg = kcalloc(num_possible_cpus(),
+					     PAGE_SIZE,
+					     GFP_KERNEL);
+		if (hv_vp_early_input_arg) {
+			ret = set_memory_decrypted((u64)hv_vp_early_input_arg,
+					     num_possible_cpus());
+			if (ret) {
+				kfree(hv_vp_early_input_arg);
+				goto common_free;
+			}
+		} else {
+			goto common_free;
+		}
+	}
+
 	/*
 	 * The VP assist page is useless to a TDX guest: the only use we
 	 * would have for it is lazy EOI, which can not be used with TDX.
@@ -433,7 +451,7 @@ void __init hyperv_init(void)
 		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
 
 		if (!hv_isolation_type_tdx())
-			goto common_free;
+			goto free_vp_early_input_arg;
 	}
 
 	if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
@@ -591,6 +609,10 @@ void __init hyperv_init(void)
 free_vp_assist_page:
 	kfree(hv_vp_assist_page);
 	hv_vp_assist_page = NULL;
+free_vp_early_input_arg:
+	set_memory_encrypted((u64)hv_vp_early_input_arg, num_possible_cpus());
+	kfree(hv_vp_early_input_arg);
+	hv_vp_early_input_arg = NULL;
 common_free:
 	hv_common_free();
 }
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ade6c665c97e..e69dae57730c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -291,6 +291,44 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
+enum es_result hv_set_savic_backing_page(u64 gfn)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_SET_VP_REGISTERS;
+	struct hv_set_vp_registers_input *input
+		= hv_vp_early_input_arg + smp_processor_id() * PAGE_SIZE;
+	union hv_x64_register_sev_gpa_page value;
+	unsigned long flags;
+	int retry = 5;
+	u64 ret;
+
+	local_irq_save(flags);
+
+	value.enabled = 1;
+	value.reserved = 0;
+	value.pagenumber = gfn;
+
+	memset(input, 0, struct_size(input, element, 1));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = ms_hyperv.vtl;
+	input->element[0].name = HV_X64_REGISTER_SEV_AVIC_GPA;
+	input->element[0].value.reg64 = value.u64;
+
+	do {
+		ret = hv_do_hypercall(control, input, NULL);
+	} while (ret == HV_STATUS_TIME_OUT && retry--);
+
+	if (!hv_result_success(ret))
+		pr_err("Failed to set Secure AVIC backing page %llx.\n", ret);
+
+	local_irq_restore(flags);
+
+	if (hv_result_success(ret))
+		return ES_OK;
+	else
+		return ES_VMM_ERROR;
+}
+
 int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..b140558816de 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -43,6 +43,7 @@ static inline unsigned char hv_get_nmi_reason(void)
 extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
+extern void *hv_vp_early_input_arg;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
@@ -252,6 +253,7 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu);
+enum es_result hv_set_savic_backing_page(u64 gfn);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index dbc5678bc3b6..60bdb524de53 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -14,6 +14,7 @@
 
 #include <asm/apic.h>
 #include <asm/sev.h>
+#include <asm/mshyperv.h>
 
 #include "local.h"
 
@@ -342,6 +343,7 @@ static void savic_setup(void)
 	void *ap = this_cpu_ptr(savic_page);
 	enum es_result res;
 	unsigned long gpa;
+	unsigned long gfn;
 
 	/*
 	 * Before Secure AVIC is enabled, APIC MSR reads are intercepted.
@@ -350,6 +352,7 @@ static void savic_setup(void)
 	apic_set_reg(ap, APIC_ID, native_apic_msr_read(APIC_ID));
 
 	gpa = __pa(ap);
+	gfn = gpa >> PAGE_SHIFT;
 
 	/*
 	 * The NPT entry for a vCPU's APIC backing page must always be
@@ -361,7 +364,11 @@ static void savic_setup(void)
 	 * VMRUN, the hypervisor makes use of this information to make sure
 	 * the APIC backing page is mapped in NPT.
 	 */
-	res = savic_register_gpa(gpa);
+	if (hv_isolation_type_snp())
+		res = hv_set_savic_backing_page(gfn);
+	else
+		res = savic_register_gpa(gpa);
+
 	if (res != ES_OK)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 1be7f6a02304..e3092469aafe 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1170,6 +1170,28 @@ union hv_register_value {
 	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
 };
 
+/* HvSetVpRegisters hypercall with variable size reg name/value list*/
+struct hv_set_vp_registers_input {
+	struct {
+		u64 partitionid;
+		u32 vpindex;
+		u8  inputvtl;
+		u8  padding[3];
+	} header;
+	struct {
+		u32 name;
+		u32 padding1;
+		u64 padding2;
+		union {
+			union hv_register_value value;
+			struct {
+				u64 valuelow;
+				u64 valuehigh;
+			};
+		};
+	} element[];
+} __packed;
+
 /* NOTE: Linux helper struct - NOT from Hyper-V code. */
 struct hv_output_get_vp_registers {
 	DECLARE_FLEX_ARRAY(union hv_register_value, values);
@@ -1210,6 +1232,15 @@ struct hv_input_get_vp_registers {
 	u32 names[];
 } __packed;
 
+union hv_x64_register_sev_gpa_page {
+	u64 u64;
+	struct {
+		u64 enabled:1;
+		u64 reserved:11;
+		u64 pagenumber:52;
+	};
+} __packed;
+
 struct hv_input_set_vp_registers {
 	u64 partition_id;
 	u32 vp_index;
@@ -1230,6 +1261,14 @@ struct hv_send_ipi {	 /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
 
 #define	HV_VTL_MASK			GENMASK(3, 0)
 
+/*
+ * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
+ * there is not associated MSR address.
+ */
+#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
+#define	HV_X64_VTL_MASK			GENMASK(3, 0)
+#define	HV_X64_REGISTER_SEV_AVIC_GPA    0x00090043
+
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
 	VMBUS_PAGE_NOT_VISIBLE		= 0,
-- 
2.25.1


