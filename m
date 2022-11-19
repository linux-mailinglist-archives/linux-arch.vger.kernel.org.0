Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57822630B4E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKSDrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiKSDq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B53BF81A;
        Fri, 18 Nov 2022 19:46:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d20so6166878plr.10;
        Fri, 18 Nov 2022 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loq3axK/RYrhXox7s9iRtCxZB75cuqQoJg9zTfXxZb4=;
        b=GllTYzWqVeBfD05vmI3Kf6GQCRffUlQTKvgReqPUs8bFAsnamfS/bSPbWcMdZIz2On
         xZY3KrIbQwunMR9cxZZDrR+/49IOPL1TzdJcRBUxkciMza7kYtr3Vxkzv8HF9F/zPoMV
         zryjUzHKcaq9Ml2m+ql3StS+qHYKftVUqHeqDRcBAa5QOx7r3etLKD7YsXOhUpEvgsMi
         gR346QLh3kwgCl726R/h5BMr8Gf6fYP5acx9USQ3yTNDknhLocyRNXs7gB0pTVD9J5NQ
         wd4vIF9JBinej/tPBZCt5HX3cjSIbmfXGRwiDvJbjcxL9HxRHu1NGhyQrxC1nhGAReP9
         Mf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loq3axK/RYrhXox7s9iRtCxZB75cuqQoJg9zTfXxZb4=;
        b=MdidGG+BnIa8MpeOjH5Z9WPu8AmXpfmKccWH9YqnCW9ulPB0uBfbUIom8zwnrW6WAr
         A4vdnF0J1As8bkGwHZD5mKnxt6cTsfSJO9haGzvz5Ec4bWoQxAVjlZ324cFKBPWCElFh
         p3kzZhCJxjRShhpEqNYe2swLlUrUMyhMwwa1xgyTFkAPZUdf/4kLiYyxwHWMyFBLTxe2
         g4UurQUuW1EMEBv0gasg1fTYg1jZm5oct7XoPgDgRgm/eTxOee6dHM+FNF13zNBOFP/i
         WwjcIVLbqy0Ok6KxH9cUS5DPh2PCYuXo4cKnaJHwIbUf5L2I+LNid/ilmtCLf76XnXs/
         KuIw==
X-Gm-Message-State: ANoB5pk8cCzD+CoPsc1J+riYtFJrRIvCHlixYDPdvT4GT1nf0RV5C8d4
        nIfK3aqAaeeM9Bu0c851FGTU/lBNovk9Rg==
X-Google-Smtp-Source: AA0mqf4Yr80lVxobHyYze1nJWwmu9pREn8Lqn0OrbCGwLv5PSXDahvLnr3CQjNI90RQVOeSyl8FSVA==
X-Received: by 2002:a17:902:cac4:b0:188:51c0:705 with SMTP id y4-20020a170902cac400b0018851c00705mr2411353pld.62.1668829606972;
        Fri, 18 Nov 2022 19:46:46 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:46 -0800 (PST)
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
Subject: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall in sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:20 -0500
Message-Id: <20221119034633.1728632-7-ltykernel@gmail.com>
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

