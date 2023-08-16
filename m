Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9B77E5D8
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbjHPP7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbjHPP7Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD46270D;
        Wed, 16 Aug 2023 08:59:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68842ebdcf7so2452567b3a.0;
        Wed, 16 Aug 2023 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201540; x=1692806340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q0ExsI3pZAGsklMym6d7DNNYHY+idgg1apdYHwk6a0=;
        b=rXITgZZp0o9Vtlah42WjNzegYa/NV+nMDhC8/tGI4GJ2/SWRTYJaATXHEWUC4TVcZK
         fH+15DAe986d0wiHXKEYCeICXp7I6MkN7AiuBHLCdQ9brbNEGWPn+Wkk+H4xSzLM2PEH
         2Vz01nx3MUPRcpGB4IBPyysVE3CTQ7pLoehdeB11/I9gtL9rD5C5zwhUX+qpCbavTasZ
         uZXk4syi+0HJCuJpxXBzhGjqq2N8L6/R6tapr9WPQY3ROoE8ZBI6kwtafvR0TSCfSJfV
         W4YYxeTgAKKc+K16HV3i2OBKzmS6gg4AdX4luGVpw59rhQdmkK4LhMWtjZ+C/+ukHzJP
         sA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201540; x=1692806340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q0ExsI3pZAGsklMym6d7DNNYHY+idgg1apdYHwk6a0=;
        b=CseTweX1Ebm8pJn0FenfA+uEdQWT9NhYVR48zqc4zCa21paj2w9vDl998HExrbXCA7
         cz2+61Mte70mVxWXjnf631YNFDo6VMte8qlRHKsGKilYxvs6Wz7rZxsK87qfPCMxJU6w
         tDcdTFpcHHSzUqVVumNuGVzrQ0vHUBwANC7F3LahtUfbGZ7oc95/Ab9aPxOrUUXyEaPh
         2VqzWLpNaDKxkWUIcVSMgFo8LpqHidCAeul9K6k1NWSj8N5T4a1M7qA/PFzuzyTDSbwE
         1dlvc8OCBox7DfsqkuSq4ZA6fKBLXGx0Wd7fJcrFZAVSZNFvVrFJd7U9gakIF2t++XdR
         +QoA==
X-Gm-Message-State: AOJu0Yw5bpzIxEJuBJiJtfj32vu05oQsUwRqPBzFAjgKoUTDula883aW
        UoTalFMedXLsziwB1VbPGy4=
X-Google-Smtp-Source: AGHT+IFMRgL+51v/aLD/m+oquII/+B1z41Re83qM9wvj9kFOX6vM5jTEeCJcwIUyGQo0dE8GyvxSvQ==
X-Received: by 2002:a05:6a20:ce91:b0:13e:a442:c899 with SMTP id if17-20020a056a20ce9100b0013ea442c899mr2639372pzb.37.1692201540591;
        Wed, 16 Aug 2023 08:59:00 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:59:00 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH v6 5/8] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Wed, 16 Aug 2023 11:58:46 -0400
Message-Id: <20230816155850.1216996-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816155850.1216996-1-ltykernel@gmail.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9f11f0495950..8479626cd7cb 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -59,16 +59,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
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
@@ -102,7 +111,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
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
@@ -147,7 +162,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
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

