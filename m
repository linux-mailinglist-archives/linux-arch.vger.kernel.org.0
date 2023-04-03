Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775F76D4F43
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjDCRoX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCRoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221462134;
        Mon,  3 Apr 2023 10:44:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x15so27969903pjk.2;
        Mon, 03 Apr 2023 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPkIOzll4BT9Ay9ERRkIKNiMh09YPuKAEEznSDGpKUM=;
        b=GnkvhrAoOuvq1qBFm7b02W8wKlDxceU3aehcnmEc00cKuV5OL2e5Faet0SPwn5Z1zx
         UR5yWDtNE1MFnT8NYHUCLkGrQuS5F0QgukO6CcK+ccUajPxMtFfaXBJJg2TV/3KdaNVT
         d9vDluaLz0va6QKE7l4pYkIU0otJND7BF26jDnyfUOFKlNgOfT0Sen39BjrbtkUSievb
         IJ2eDeg9m1FE8ygKMFuBxKk+UYCi55yiMHvhqd0NXfzPguDRh7S+a2DT47+S27aqE4Ih
         5RDld1VifjupHqBi+LJh319PF8je5z5qoruAUFtLURs2jvOosBGfAD5SrtUfycpRZ1d1
         1REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPkIOzll4BT9Ay9ERRkIKNiMh09YPuKAEEznSDGpKUM=;
        b=Br9U7pSQX9507SP/IMpVLC0mu1Bs7suf27qcmXjqiGv+7+jg3QXOFJ51DWmAAXnXNk
         X1IxLCF1GZVadM7Z0/TZHjpAoBo/ed4pEvkc3+seLXHwAQ1t9WsAuocNHA/Txqbcu1E6
         Y8uRhhks7grNNxZ7fPxePYQg/A76l2OZleRBpYtqHGHkXvoHySqDEVeXuzJR5QZgN5Z7
         Ynpx6NqQSV2K9Sq9TwhC2sX+BgePm+JT8gxMDb255McKbJkkqhlimv/p9F3Ld/pf5HEb
         TSlE0b1yd/OeT/W2h3Hh5AvCJJaIAHPbsnG1d4Lldoqc7CiYkQSQT9V/e+KdIq60Kaf2
         a/Nw==
X-Gm-Message-State: AAQBX9e3G1WlnNqTg4xeUySpYQgXj9ol6Xj4j2eg3uZo6Lb2ScfSHK3X
        H6vHF2Y4I+C4cdMnqpBCF9g=
X-Google-Smtp-Source: AKy350ZX2/5cNiNJs7eqEeCmiv4eBiXo2CBjNP1uWsqfNGtesqYRU8AIYRwVeljZF08yiOkLqBIOrQ==
X-Received: by 2002:a17:902:d2c1:b0:1a0:7425:4b73 with SMTP id n1-20020a170902d2c100b001a074254b73mr24670101plc.4.1680543855438;
        Mon, 03 Apr 2023 10:44:15 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:15 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V4 04/17] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Mon,  3 Apr 2023 13:43:52 -0400
Message-Id: <20230403174406.4180472-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

In sev-snp enlightened guest, Hyper-V hypercall needs
to use vmmcall to trigger vmexit and notify hypervisor
to handle hypercall request.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V2:
       * Fix indentation style
---
 arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2fa40c6ca99f..3c15e23162e7 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -52,16 +52,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (!hv_hypercall_pg)
-		return U64_MAX;
+	if (hv_isolation_type_en_snp()) {
+		__asm__ __volatile__("mov %4, %%r8\n"
+				     "vmmcall"
+				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				       "+c" (control), "+d" (input_address)
+				     :  "r" (output_address)
+				     : "cc", "memory", "r8", "r9", "r10", "r11");
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
+				     CALL_NOSPEC
+				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				       "+c" (control), "+d" (input_address)
+				     :  "r" (output_address),
+					THUNK_TARGET(hv_hypercall_pg)
+				     : "cc", "memory", "r8", "r9", "r10", "r11");
+	}
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
 	u32 input_address_lo = lower_32_bits(input_address);
@@ -95,7 +104,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
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
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input1)
@@ -140,7 +155,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	{
+	if (hv_isolation_type_en_snp()) {
+		__asm__ __volatile__("mov %4, %%r8\n"
+				     "vmmcall"
+				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				       "+c" (control), "+d" (input1)
+				     : "r" (input2)
+				     : "cc", "r8", "r9", "r10", "r11");
+	} else {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-- 
2.25.1

