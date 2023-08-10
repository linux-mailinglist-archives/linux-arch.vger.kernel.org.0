Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1E777D8B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHJQGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbjHJQFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:05:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D542E3C0D;
        Thu, 10 Aug 2023 09:04:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb893e6365so8234095ad.2;
        Thu, 10 Aug 2023 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683470; x=1692288270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrmI5CfPxVY7AnD9ZXTkBFKVyDfbtlM8uSjA/DWsUFg=;
        b=nKKUhZebRQhMhb8DbOpZRrQ8kDB57Yk6YeTf74gDwfzeZ5Pam9jhu1xY7+/5wtUarE
         cN33Kz99N4+6hOZ18gb7x4hI4Bj/Qg3vsBMrseoKvwlh5oa8rvX7BQp3QQNtMD8LJQ+R
         mWeUa4OM2chIJ9WviufkH5nC4blEts252hdn8TK18x4SRjYBoVD5iUDn4q+xTIZGLd9F
         wZNkdw71WYbN17fQhTCA67i7D1dDjBPnETala0dgcMd7zByl0pWknvUecBFJD46T1lBF
         kD3qU7DikYlgaGk74RsQI5A0kHzumsYs1zw9UihpvOnUjchgenirBUhfk+XI7tIR0NA+
         qY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683470; x=1692288270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrmI5CfPxVY7AnD9ZXTkBFKVyDfbtlM8uSjA/DWsUFg=;
        b=Jy0sif7mdJvWkADQg/ps1tB1UXkVHDyA7NC7onizGLtMQLhC+IA7ibhKt6/GNQAwEX
         UH+c3x0yOTubRw5ZiNK4wrMFO3tQ+lPbn0J3f7o4CGHqJ24GscuShNrsBAEKYCdtab29
         T3RX9wGpPy6VuuOXJiI7korwUj0jCL7WFXvSDICV2gWMmEdus+NVCNagR6SFxgKevcD5
         l0nbRdpwIhQsAPFheKuUvxor49itOt/M4mRFsf8+7jrgE8qCZ0HUtDy9Y7djx6Y/Ucds
         K8FhTzwA2bo7Hh/SDEsbAX5Et1K0gP4xhUbkrG8WE42SArE6JNbmw8tqrZ3V9cIJFrG0
         OcHg==
X-Gm-Message-State: AOJu0YwB/JGG2LMuzei36RdSSWnAlyIQVyVtFNAxoBnOQi//ZIkIpPQF
        jQGSm655fxaogkk7mBnbRG0=
X-Google-Smtp-Source: AGHT+IFtWqznWBMZjH08kPy1EbfGzjAoJg7EfHUYmfpkseGW22HHZjfyzlXEZ5c1o8hgkWktu3jxyA==
X-Received: by 2002:a17:902:daca:b0:1bb:1e69:28be with SMTP id q10-20020a170902daca00b001bb1e6928bemr2944141plx.42.1691683469696;
        Thu, 10 Aug 2023 09:04:29 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:28 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V5 5/8] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Thu, 10 Aug 2023 12:04:08 -0400
Message-Id: <20230810160412.820246-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
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

In sev-snp enlightened guest, Hyper-V hypercall needs
to use vmmcall to trigger vmexit and notify hypervisor
to handle hypercall request.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9f11f0495950..07cad6c2af56 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -62,12 +62,12 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
-	__asm__ __volatile__("mov %4, %%r8\n"
-			     CALL_NOSPEC
+	__asm__ __volatile__("mov %[output], %%r8\n"
+			     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
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
@@ -103,7 +103,8 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 
 #ifdef CONFIG_X86_64
 	{
-		__asm__ __volatile__(CALL_NOSPEC
+		__asm__ __volatile__("mov %[thunk_target], %%r8\n"
+				     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input1)
 				     : THUNK_TARGET(hv_hypercall_pg)
@@ -148,13 +149,13 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 
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
+		     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
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

