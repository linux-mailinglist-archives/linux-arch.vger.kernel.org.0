Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18077045D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjHDPXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjHDPXI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956A49F0;
        Fri,  4 Aug 2023 08:23:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8ad8383faso19426985ad.0;
        Fri, 04 Aug 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162587; x=1691767387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGDTbc8t+NaU1OP3xKzemfdpSc0H/y8ZWu0f/3/zAAY=;
        b=WRy+WGkntymcLuEpT2lKn8XoQ/VswdVwHbhd3QD6XVOnnA7L6KrOK+9dePe1RJSBjD
         dLdGdHZTZfGW2KQ6cj+X9DUFfmb7AzkTzKoyfCnw+AtdIfslz0DDk5CuEE8sUVJR2MgZ
         I5l3D1KzymrYnTjXwbEIi6Si0NyPB+B0mWcFtxu+XoGIeBfBpE3W4n0/dm3VGAPqo+64
         TUlGk32uiwzTd7u6TqhyRYvXeOTzs8sNFWagUMD30o7s0ZKMZ8yh+yaTvKwbVqBqRKLD
         Hca0c2qTf1wE4RdiX2bBmjYBEDIPvKala/RxbhwB0ZADxXlXCKhY5EjiIGcbcT9yr9vQ
         LLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162587; x=1691767387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGDTbc8t+NaU1OP3xKzemfdpSc0H/y8ZWu0f/3/zAAY=;
        b=MFpgYLlbQ9JLVUstpOWZ0ye3S1gvv9KhILn3P2/sAwFzsmLosTZXKpf9hYsJC47VnY
         ai69fGy3RbYg7SKuNEyrE6kUmeoH2PNlLs48njWp7AiVVHHiGXB0+3NzZX3dWPAVYOB6
         OQCUC2bXPuIUQzY3TW0thusWsR8oYE5ImAxvT1KuJ9vs6FRkUG7aSz8oXPiIKs+Llkh5
         Js5JZGbOIWFdvytGNEXuMGOXcco9taAqz8/oDEhZD2W31C8tMRs5TsVuJPpJssFkbkgd
         t3S2vqD/KGb4gGoZw+Y6QR82I36pgHdZv1TNX3gykZWPY2x0U7LH7iEb3QOxB0WdztxV
         k8SQ==
X-Gm-Message-State: AOJu0Yy8dTnnV1vzgAu86IXFAEnJJrQNMHtz/nJJvhbDMOuPIhgoEZBp
        uP3yPBSNfUSXesu4OtYbF7A=
X-Google-Smtp-Source: AGHT+IGJz/kv1flBC0rEnTiZAcriNNzeXLTbWaW4vmktVEXRTRgP27X9tL32kd5EXuegQyOr24rfnw==
X-Received: by 2002:a17:902:74c3:b0:1bc:203f:3b3c with SMTP id f3-20020a17090274c300b001bc203f3b3cmr2106299plt.24.1691162586772;
        Fri, 04 Aug 2023 08:23:06 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:06 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V4 5/9] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Fri,  4 Aug 2023 11:22:49 -0400
Message-Id: <20230804152254.686317-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
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

