Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA275722F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGRDXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGRDXa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:23:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14310F0;
        Mon, 17 Jul 2023 20:23:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9c942eb18so2219974a34.3;
        Mon, 17 Jul 2023 20:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650598; x=1692242598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGDTbc8t+NaU1OP3xKzemfdpSc0H/y8ZWu0f/3/zAAY=;
        b=pt2jGLoFHP0lMXD+QOuJ/WB4g5pOP4OGFpgO8L8I+Ro2vkMGheu2h3qOi9xX5VINxq
         130pK6ZDVMkJf8TJpTzgSTXkQpDxs90FVCh6JWKxG4OHmHdMmCifl40yk1TB3Yqk7JlY
         rYSHwOuFLqe+HBNWWD3IhmwqoIqO0mMppXOtV6zkX5drNZ3h1N+ddz6L+N36JiZUvyuI
         LUC6NYHUf9a4Op9rwdTaHt5K1R+DDbkCF5+ZYZjuR1pxhkGxZjEU2gKIXASFzWU0mTnJ
         2PXwq9uFlECDjceWTOMFkc3gqTOw5hDG5xUD544tDLMKL4EaEquaR+T/QYjH01DHYUWT
         cBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650598; x=1692242598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGDTbc8t+NaU1OP3xKzemfdpSc0H/y8ZWu0f/3/zAAY=;
        b=Y18CwSB5u7UBstmTMgM+HnRbXige3GVsNtDzXITcev05jyWHvnUzIVOV+rjYQ2twew
         OlW/VfZP/Sw7rqQLKgiCJvE9yCjEqSfaixwSTYXri0W8No1rPTsh+KEmzgSDQ03QQ8do
         7vR0UArWxOgwiifA1lbaRHygeu7eg0BKUeu73Rx9yjMMa1SWOuPLSCyukRgH7HR15ZYC
         nxZazAC1CJiS67LCNk/6BTV4M8pM1tdidFTd0xsgJJGdSuzNPTTjbCAcftfbZjGssXhB
         MM5cIN72FjkUh2pL0/TragMlPyA6yfmMooOyA6mD+5ocggWR/rJHx5OIqkAprTS6WUcY
         HXOw==
X-Gm-Message-State: ABy/qLbcO120yknKNDxwMW8MMn1r7pJOTBk5bl45rzTcb10bMJdneqbB
        U1AHuzSMMkEfV+hsYkm2VZgGofRrntLNjg==
X-Google-Smtp-Source: APBJJlFr0F6lm+pb0Tv7ZS/ddnZTjFk5hfKjsHqhSsgA4j+rVYN98VedkjwWGdhpDXJw082jcn/4YA==
X-Received: by 2002:a05:6358:2815:b0:134:d559:259a with SMTP id k21-20020a056358281500b00134d559259amr14262083rwb.17.1689650597056;
        Mon, 17 Jul 2023 20:23:17 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:16 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Mon, 17 Jul 2023 23:22:59 -0400
Message-Id: <20230718032304.136888-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718032304.136888-1-ltykernel@gmail.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 arch/x86/include/asm/mshyperv.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2fa38e9f6207..025eda129d99 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -64,12 +64,12 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
-	__asm__ __volatile__("mov %4, %%r8\n"
-			     CALL_NOSPEC
+	__asm__ __volatile__("mov %[output], %%r8\n"
+			     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
 			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-			       "+c" (control), "+d" (input_address)
-			     :  "r" (output_address),
-				THUNK_TARGET(hv_hypercall_pg)
+			     "+c" (control), "+d" (input_address)
+			     : [output] "r" (output_address),
+			       THUNK_TARGET(hv_hypercall_pg)
 			     : "cc", "memory", "r8", "r9", "r10", "r11");
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
@@ -105,7 +105,8 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 
 #ifdef CONFIG_X86_64
 	{
-		__asm__ __volatile__(CALL_NOSPEC
+		__asm__ __volatile__("mov %[thunk_target], %%r8\n"
+				     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input1)
 				     : THUNK_TARGET(hv_hypercall_pg)
@@ -150,13 +151,13 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 
 #ifdef CONFIG_X86_64
 	{
-		__asm__ __volatile__("mov %4, %%r8\n"
-				     CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : "r" (input2),
-				       THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
+		__asm__ __volatile__("mov %[output], %%r8\n"
+		     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
+		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+		       "+c" (control), "+d" (input1)
+		     : [output] "r" (input2),
+		       THUNK_TARGET(hv_hypercall_pg)
+		     : "cc", "r8", "r9", "r10", "r11");
 	}
 #else
 	{
-- 
2.25.1

