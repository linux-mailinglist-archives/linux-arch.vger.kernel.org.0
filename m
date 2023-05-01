Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB76F2F7A
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjEAI5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjEAI5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65A10C0;
        Mon,  1 May 2023 01:57:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf21bb42bso6351705ad.2;
        Mon, 01 May 2023 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931455; x=1685523455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fry12NLoScUn7gbAM5zwlql+LIRPvftdxXtygfKZOSU=;
        b=K7jksmbTeUQw32z78/4ng/NzDiplAWJEG71m35MnXGDYaORVybT+T6G+yBN1nOJzn/
         pAjeJ3TJoFIgQPcNn3hW3LHFIujcc6qNnBBr4qz6ho34LdoI6nS91RRIub5Vo7C5TcQI
         /4izzhyFpldYlqEyMd9RYeylokixec8Lx1jBQcZcccR2pMImedN0BlElAkN009HB9WI2
         U7ti2dtp9zOfPXM80Cn3Q7ECo5Szqxr5G5KzjY9IKtapwwJ4mRE/jhJwdb5yBjXijq2S
         QWyaLNkrUezOi4o5eA8Q24SpBhVN1TfApYce8PlFt7/7Ijm1Z+6VmZRfzK1ks+HZ3O+/
         j3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931455; x=1685523455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fry12NLoScUn7gbAM5zwlql+LIRPvftdxXtygfKZOSU=;
        b=SvNqLvmfhnBL/Se1u2jTN17Geid5RDisJYzYRGfwSjxSebMZ/Hq51/UigyN73oCH30
         D2bMYRSkdPttX+8Eh0inf0PiFvFM2Y3tUcHK3rwBgnp3OoaJDbQjtHLSb8NsAAoI7zfP
         b50Qc7H30LJvho3fFwQrClHbEi9gXS/R8KBwtf6/sBn3MiOECobm63ingvc3iQLc/y2r
         8A7YLjuGzYVp1YqOlXB5gY4KYtEjAr7OXx6yvmK40I7jo0cxewUMx/LtnAjNUovDiUTl
         IIteyet8q4KQVmA+RG6w97A+WHnTuOrupdQhzgv7KKqHZiImDfp0NMC9q5qw5sXyitl5
         vyuw==
X-Gm-Message-State: AC+VfDwsnd60qAWGl4xcRK0ZLJxSwBLIgdWZrd1Gr+5irBt5EezFTLKH
        9pUXqbRpv05K0X1eDS1YmNE=
X-Google-Smtp-Source: ACHHUZ5AxIolfnZywSPhghag7iLuDD6o1C2AaUdro9lVq5nNaCg1A5/izYX69cCASi1ejjuJSAO8yg==
X-Received: by 2002:a17:902:b70c:b0:1a6:413c:4a47 with SMTP id d12-20020a170902b70c00b001a6413c4a47mr13048714pls.1.1682931455420;
        Mon, 01 May 2023 01:57:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:35 -0700 (PDT)
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
Subject: [RFC PATCH V5 04/15] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Mon,  1 May 2023 04:57:14 -0400
Message-Id: <20230501085726.544209-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 97d117ec95c4..939373791249 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
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
@@ -104,7 +113,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
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
@@ -149,7 +164,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
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

