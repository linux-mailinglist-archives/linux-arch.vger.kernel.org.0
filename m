Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C864A71A232
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjFAPQm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjFAPQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:37 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4112C;
        Thu,  1 Jun 2023 08:16:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso1205712b3a.0;
        Thu, 01 Jun 2023 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632594; x=1688224594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20PfxUIBn5Kpww1WZYnKX4OwKeg7lWWjkFwlEuv9yX8=;
        b=mdMXADuPKtg6pZHi4rHdubjEZsdNyUwRcdf+1/mn0YEWGux7/x1eoRpO7JZbRlCKKp
         njD9GKsWD31Q/nWLjFhxKkJp4kfc5QrPg3eqwWXP8KYpfrrUgsAMjjNKC1qYfZDLatty
         7GKUU49SuYeZG8eopqGeb50WCft7zv0NyBWeEn5VdivKfn+rtQ3eSsdp4sHL1uWu0AaW
         Lp/r1pRl6DPWuzClQkpjIS0Pdj0t+sss5B622u1I+ySyuo01E6ULflRSLRrHg8AyV9cv
         OsA8mmm58sdp7V/eab3zC2UHQZxBGNMgui41nqLuASPHfLxpDXbggRfotv2EDtajmZPt
         9dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632594; x=1688224594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20PfxUIBn5Kpww1WZYnKX4OwKeg7lWWjkFwlEuv9yX8=;
        b=ZyYhsPNFxcob3j/4uv+nJ8woCFuEV+6KVORjL/O2CsLAGv1MNAa2wB5iDGpnh50Fdx
         SqTDuErSELRbYzVB+djGtKprEPHzZXTdRFxcJJQjt9kHs9OdFQzcWaOm4NYel/D7AM5r
         MXv4HvdMrFG/VFlYMdyVRNhiCv0htc+xLI8C7hDTThWqrwpOOTb9qngn5NMBaXKFIYL2
         3ZEPI09WwG/5PT5rEUy01AYJBndK+bL4S5TGaahbAV0kGJvVvXsp93bEz1v5f3ELFnVM
         wJ28lIuT3M4d5fJNvPico0abB+0xG/kKvJLXRnbNHpMmNJy2DmxDktPUOaZPqFqfhFcJ
         V4bw==
X-Gm-Message-State: AC+VfDwASh+o1vhICiWJkhUBSsCZguGQLSKF7uVQej9x+rkFRwvzhPcI
        Ku/ix5Xz5eaXg8yELmmj18Q=
X-Google-Smtp-Source: ACHHUZ7x5FMKTPvxDqH4AmSDxwlGwzNYm9Hj5IBROUeINO+L+jU7O/lsGtLei1ze5X/8zwkkEV3laQ==
X-Received: by 2002:a05:6a20:3d85:b0:100:60f3:2975 with SMTP id s5-20020a056a203d8500b0010060f32975mr11694279pzi.4.1685632594074;
        Thu, 01 Jun 2023 08:16:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:33 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 5/9] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Thu,  1 Jun 2023 11:16:18 -0400
Message-Id: <20230601151624.1757616-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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

There is no x86 SEV SNP feature flag support so far and
hardware provides MSR_AMD64_SEV register to check SEV-SNP
capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
work without SEV-SNP x86 feature flag. May add later when
the associated flag is introduced. 

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 31c476f4e656..d859d7c5f5e8 100644
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

