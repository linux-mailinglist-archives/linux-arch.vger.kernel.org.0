Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7B73F2B3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0D3B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjF0D2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B627C2117;
        Mon, 26 Jun 2023 20:22:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso2944648a91.1;
        Mon, 26 Jun 2023 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836179; x=1690428179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WavXlIUDaiNvQ7Jhn4eQcl+B7LwqPDg8ntyEa3A0jyM=;
        b=LSRiUlnVbD1yG2LtgeNbwA5zFxbzqYOZMJQQOSULLaJJLryLZPpcKSTWUqJvZt4Qme
         OQc7BpsRmxlvTFgL8eFXT26zQTRFpN7CL7Eg2ZApv1ea3T1bM2OwHzOP+qQo/DMiMydl
         m5k1OTpGQz9kXiIzwZC6JoLBfQ+S4hVOGciYKWnEICaM8jJuWqahZu03anyCH1Vn37fU
         MLPDgVVy5G9paXDSIQ8wPTof6jMTMmyVPmgeKV8soGX/dB8tEkOWyMj+IiFhVedctgis
         jEaAe44y9o7UZhiQyYGQshMWn/x2Oe8wl5xg7bTgGHalCuVBxEdtKL7+WjGk9m1vj5FR
         lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836179; x=1690428179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WavXlIUDaiNvQ7Jhn4eQcl+B7LwqPDg8ntyEa3A0jyM=;
        b=Yft2M8fpU/CZR2uz/wJU1xx6NVZ5hzyZFAkLFzJ9kZ4q2zpeje+1G9yzxolnSJ9LXw
         JrMh2cQs/yH2Nh54J0fun595XDsNAmT9iKBhw6Fd4qwefTkSvMZaXt4VYcjU2fTRJZOJ
         I2sAcpee9e5wN2a/bk1cDfZ/0u6SrIopt6CQyJx0FM5UXl93DhlOcKtUHb2Yw0esDNpy
         ql8h6O6rH16C46rGmMh36jaCwDQRaXr5mUW5yg5XKgsaVbNsWyq/8K6tyzI8JQ0hcNjo
         rwUjNzZ0TWqcOvKzNtmBMYgMo0SdK9078LOEUHS3+CUDbQt9bLPMr276r3Vgm2THr+99
         zN6Q==
X-Gm-Message-State: AC+VfDzUcukr1s652cTi9FhkFcJUbq8XSc+XhfHkDVfbiSOEBLZlpdTJ
        E1Ths7hfs0OnFbLn8+9rdMw=
X-Google-Smtp-Source: ACHHUZ4bHFbhEu7fAz1E4ESsRByJd1Jqm4+f+OnoVMcgMllJUT9JvSYVvsUX0CQFnJ2sh+bC/iHADg==
X-Received: by 2002:a17:90a:19ca:b0:25f:20f:2f7d with SMTP id 10-20020a17090a19ca00b0025f020f2f7dmr23774243pjj.2.1687836179114;
        Mon, 26 Jun 2023 20:22:59 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:58 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 5/9] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in  sev-snp enlightened guest
Date:   Mon, 26 Jun 2023 23:22:43 -0400
Message-Id: <20230627032248.2170007-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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

