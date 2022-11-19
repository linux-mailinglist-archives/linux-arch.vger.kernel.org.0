Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00867630B4A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiKSDq6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiKSDqo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6ABF803;
        Fri, 18 Nov 2022 19:46:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so6617132pgh.4;
        Fri, 18 Nov 2022 19:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l9afkkKeSOzI6mzq1htMqRSlzdNXqGpUKUcuz2i9ek=;
        b=qE2HYPAuJ52VU6dEZOdfLmCANGmCXWcs45kfZvjcuh8A7Vy3KgZQY0ydGY0R+OE3ci
         0Z9JXSwEvMHH+EV78Y2ljOhU0hm9mvG3huO30M8+m0BW7i4vg06gBz59D7/Oj/sdWg27
         dE2EwofvGxhgCDMAagxzQmCQdIXH7D44YUVFEmVNk6zNFqMIbBLRDQwgdJRmz5it8LP+
         CHsMuvAR8m2xjZzJarHYpYWOa8cuQHPlgiTMBfz/dBR17MD0vC5Bv9wDI9hOofgAN4TJ
         mOgtjWDdGSeYz1oWmMI42WK0zI86yTyCqi7MtlPtLsKeMJIpZJKZi+n5xYE8SVh7EThR
         /bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l9afkkKeSOzI6mzq1htMqRSlzdNXqGpUKUcuz2i9ek=;
        b=8FV2t0jwnMWu/L5/fqm2SxDjA0xqdZ5SivuOFLKxvhRQilUm4kZjzBVn+VFqQnqiVZ
         SzXlTBxcCDj26Khdgwoh2qPJAVNwJV64pPux5VqRyv/XDP9RQsjWcJneiNRZ48tlUn+s
         9AJpfcm44A3nQLJjnmDWt08o/1KGHdMa4uYjyUg8igTC8RwSuH6nMDW3nw1H9Hou1hlh
         3XS/NGJTfbEsEQkE3PjHyRF2wzs4gS3kt3wg4snkuMPiRIhdVC7nF0d0Bd393V/tJtak
         7EYp7yptQiQ2LtduQC4UYPxMBfikozQ8oJJxUfTqKuy3/VuCI+vhckjPVwsMU2Qa0i5M
         O9oA==
X-Gm-Message-State: ANoB5pln0BvB9akNG7Y6GpcRVA8dZJE5m8B65WMY4TMgS8Dz4W5kogNr
        IqgBndci57M9/ogPfh2arYE=
X-Google-Smtp-Source: AA0mqf7UDVjSG+tLndDVGuKUx7C5w+cTSrsMn+v0cthIG7y8DQpEL+oKgXf10/A+TKGKUcFV3Gj2qQ==
X-Received: by 2002:aa7:8054:0:b0:56c:4303:a93d with SMTP id y20-20020aa78054000000b0056c4303a93dmr10662237pfm.73.1668829602636;
        Fri, 18 Nov 2022 19:46:42 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:42 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V2 03/18] x86/hyperv: apic change for sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:17 -0500
Message-Id: <20221119034633.1728632-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyperv sev-snp enlightened guest doesn't support x2apic and
apic page read/write operation. Bypass these requests. ipi
request maybe returned with timeout error code and add retry
mechanism.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c         | 79 ++++++++++++++++++++++++-------
 include/asm-generic/hyperv-tlfs.h |  1 +
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fb8b2c088681..214354d20833 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -66,9 +66,15 @@ static u32 hv_apic_read(u32 reg)
 		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
 		(void)hi;
 		return reg_val;
-
+	case APIC_ID:
+		if (hv_isolation_type_en_snp())
+			return smp_processor_id();
+		fallthrough;
 	default:
-		return native_apic_mem_read(reg);
+		if (!hv_isolation_type_en_snp())
+			return native_apic_mem_read(reg);
+		else
+			return 0;
 	}
 }
 
@@ -82,7 +88,8 @@ static void hv_apic_write(u32 reg, u32 val)
 		wrmsr(HV_X64_MSR_TPR, val, 0);
 		break;
 	default:
-		native_apic_mem_write(reg, val);
+		if (!hv_isolation_type_en_snp())
+			native_apic_mem_write(reg, val);
 	}
 }
 
@@ -106,6 +113,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
 	int nr_bank = 0;
+	int retry = 5;
 	u64 status = HV_STATUS_INVALID_PARAMETER;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
@@ -144,8 +152,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 	}
 
-	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+	do {
+		status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
 			      ipi_arg, NULL);
+	} while (status == HV_STATUS_TIME_OUT && retry--);
 
 ipi_mask_ex_done:
 	local_irq_restore(flags);
@@ -159,6 +169,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	struct hv_send_ipi ipi_arg;
 	u64 status;
 	unsigned int weight;
+	int retry = 5;
 
 	trace_hyperv_send_ipi_mask(mask, vector);
 
@@ -212,8 +223,11 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
-	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
-				     ipi_arg.cpu_mask);
+	do {
+		status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
+						ipi_arg.cpu_mask);
+	} while (status == HV_STATUS_TIME_OUT && retry--);
+
 	return hv_result_success(status);
 
 do_ex_hypercall:
@@ -224,6 +238,7 @@ static bool __send_ipi_one(int cpu, int vector)
 {
 	int vp = hv_cpu_number_to_vp_number(cpu);
 	u64 status;
+	int retry = 5;
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
@@ -236,26 +251,48 @@ static bool __send_ipi_one(int cpu, int vector)
 	if (vp >= 64)
 		return __send_ipi_mask_ex(cpumask_of(cpu), vector, false);
 
-	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
+	do {
+		status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
+	} while (status == HV_STATUS_TIME_OUT || retry--);
+
 	return hv_result_success(status);
 }
 
 static void hv_send_ipi(int cpu, int vector)
 {
-	if (!__send_ipi_one(cpu, vector))
-		orig_apic.send_IPI(cpu, vector);
+	if (!__send_ipi_one(cpu, vector)) {
+		if (!hv_isolation_type_en_snp())
+			orig_apic.send_IPI(cpu, vector);
+		else
+			WARN_ON_ONCE(1);
+	}
 }
 
 static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
 {
-	if (!__send_ipi_mask(mask, vector, false))
-		orig_apic.send_IPI_mask(mask, vector);
+	if (!__send_ipi_mask(mask, vector, false)) {
+		if (!hv_isolation_type_en_snp())
+			orig_apic.send_IPI_mask(mask, vector);
+		else
+			WARN_ON_ONCE(1);
+	}
 }
 
 static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 {
-	if (!__send_ipi_mask(mask, vector, true))
-		orig_apic.send_IPI_mask_allbutself(mask, vector);
+	unsigned int this_cpu = smp_processor_id();
+	struct cpumask new_mask;
+	const struct cpumask *local_mask;
+
+	cpumask_copy(&new_mask, mask);
+	cpumask_clear_cpu(this_cpu, &new_mask);
+	local_mask = &new_mask;
+	if (!__send_ipi_mask(local_mask, vector, true)) {
+		if (!hv_isolation_type_en_snp())
+			orig_apic.send_IPI_mask_allbutself(mask, vector);
+		else
+			WARN_ON_ONCE(1);
+	}
 }
 
 static void hv_send_ipi_allbutself(int vector)
@@ -265,14 +302,22 @@ static void hv_send_ipi_allbutself(int vector)
 
 static void hv_send_ipi_all(int vector)
 {
-	if (!__send_ipi_mask(cpu_online_mask, vector, false))
-		orig_apic.send_IPI_all(vector);
+	if (!__send_ipi_mask(cpu_online_mask, vector, false)) {
+		if (!hv_isolation_type_en_snp())
+			orig_apic.send_IPI_all(vector);
+		else
+			WARN_ON_ONCE(1);
+	}
 }
 
 static void hv_send_ipi_self(int vector)
 {
-	if (!__send_ipi_one(smp_processor_id(), vector))
-		orig_apic.send_IPI_self(vector);
+	if (!__send_ipi_one(smp_processor_id(), vector)) {
+		if (!hv_isolation_type_en_snp())
+			orig_apic.send_IPI_self(vector);
+		else
+			WARN_ON_ONCE(1);
+	}
 }
 
 void __init hv_apic_init(void)
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index fdce7a4cfc6f..6e2a090e2649 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -208,6 +208,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_TIME_OUT			0x78
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
-- 
2.25.1

