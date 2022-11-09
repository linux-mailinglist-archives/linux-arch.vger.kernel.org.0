Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB56234F6
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiKIUyK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiKIUyH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408B21273;
        Wed,  9 Nov 2022 12:54:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3074706pjl.3;
        Wed, 09 Nov 2022 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loq3axK/RYrhXox7s9iRtCxZB75cuqQoJg9zTfXxZb4=;
        b=beFZ5Y47kp1rJfIpBxAoTPtins11XDT5gcQls7HiwKvU68KQJRTlUxewLDVT5p7d5Z
         5ikaFpLZmG09q9dQRVDpgfLnZelttUOzwqcewJ2gfAZBBbijcm6pHDlJZhUH45TcAQ+N
         iB8pckuHrFxqCLROUWXOs9ukICIqRYYTIc7HFJUWpaFEE42FcklaP2oRbzhSM0VuT/MB
         DUpE3bCgo8Vx1acGTmV9YgGDEOumV2qf1DF8KeikfFA9pYlv1dr7LDTvWnJng06aTtnD
         PRf3QjwdUTYmT6n7Ubrc+uRoHp2IUHYucJBikq28PR3a7j1D8I9wi0CeuFUcm/WKi/cq
         gAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loq3axK/RYrhXox7s9iRtCxZB75cuqQoJg9zTfXxZb4=;
        b=q7bR2cvWO5Bs5/xs/T0d4VjjZ7aJv7cn6mpUaPzNIVFn+p2hm4rkfwOm+Wv2eArBXC
         o0Ml4i98i6Eg4R9sbPuI0B43JYYEY76iWO/+Ur5GbuLvZYgumJyPS6P8ukL9C8mlEp2H
         LTGxZgKDvw0mBusAyEkcrIDJStlL321J+WE73tjE80MTv7a8C6H5Hzk7MYUp9P7Es1Wt
         v2J7/9xkxC1rZIDeUhdJlTzZXX+XZkPD3Hrpd4F/MchRVIZEcu3Ie3luWaLs6nUg4/M8
         iUKj2dDB7ruYeRrbl768uOjUBf7EkarG0gbpyNbhIBrbh3M0kQE70ccdRtHVh+edooKQ
         B++A==
X-Gm-Message-State: ACrzQf12Hp6ILYMn8vTEpUaZPuO/fZva1Qfmu7zWdH32sf3G/8hDFUj+
        udfsAc5pWOXkFmWZcCCwOy8=
X-Google-Smtp-Source: AMsMyM6rVvEWgMW5vzavPLlusbA5iUubIdjccR/BkohqA24lMTdaD6SAoRNDyU+5FoHz/UGGK3QGnA==
X-Received: by 2002:a17:90a:eb0c:b0:213:8ff3:a46a with SMTP id j12-20020a17090aeb0c00b002138ff3a46amr69235671pjz.158.1668027246272;
        Wed, 09 Nov 2022 12:54:06 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:05 -0800 (PST)
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
Subject: [RFC PATCH 07/17] x86/hyperv: Use vmmcall to implement hvcall in sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:42 -0500
Message-Id: <20221109205353.984745-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
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

In sev-snp enlightened guest, hvcall needs to use vmmcall to trigger
vmexit and notify hypervisor to handle hypercall request.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 66 ++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9b8c3f638845..28d5429e33c9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -45,16 +45,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (!hv_hypercall_pg)
-		return U64_MAX;
+	if (hv_isolation_type_en_snp()) {
+		__asm__ __volatile__("mov %4, %%r8\n"
+				"vmmcall"
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input_address)
+				:  "r" (output_address)
+				: "cc", "memory", "r8", "r9", "r10", "r11");
+	} else {
+		if (!hv_hypercall_pg)
+			return U64_MAX;
 
-	__asm__ __volatile__("mov %4, %%r8\n"
-			     CALL_NOSPEC
-			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-			       "+c" (control), "+d" (input_address)
-			     :  "r" (output_address),
-				THUNK_TARGET(hv_hypercall_pg)
-			     : "cc", "memory", "r8", "r9", "r10", "r11");
+		__asm__ __volatile__("mov %4, %%r8\n"
+				CALL_NOSPEC
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input_address)
+				:  "r" (output_address),
+					THUNK_TARGET(hv_hypercall_pg)
+				: "cc", "memory", "r8", "r9", "r10", "r11");
+	}
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
 	u32 input_address_lo = lower_32_bits(input_address);
@@ -82,12 +91,18 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
-	{
+	if (hv_isolation_type_en_snp()) {
+		__asm__ __volatile__(
+				"vmmcall"
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input1)
+				:: "cc", "r8", "r9", "r10", "r11");
+	} else {
 		__asm__ __volatile__(CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input1)
+				: THUNK_TARGET(hv_hypercall_pg)
+				: "cc", "r8", "r9", "r10", "r11");
 	}
 #else
 	{
@@ -113,14 +128,21 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
-	{
+	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__("mov %4, %%r8\n"
-				     CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : "r" (input2),
-				       THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
+				"vmmcall"
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input1)
+				: "r" (input2)
+				: "cc", "r8", "r9", "r10", "r11");
+	} else {
+		__asm__ __volatile__("mov %4, %%r8\n"
+				CALL_NOSPEC
+				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				"+c" (control), "+d" (input1)
+				: "r" (input2),
+				THUNK_TARGET(hv_hypercall_pg)
+				: "cc", "r8", "r9", "r10", "r11");
 	}
 #else
 	{
@@ -177,6 +199,7 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
@@ -191,6 +214,7 @@ static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
-- 
2.25.1

