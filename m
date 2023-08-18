Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E0780A1F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359496AbjHRKaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359836AbjHRK3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C922701;
        Fri, 18 Aug 2023 03:29:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf3a2f44f0so3145575ad.2;
        Fri, 18 Aug 2023 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354570; x=1692959370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f087Kw274k/dHkYZVOPSAgM/VBWlSfgBOsFhfzHlNmw=;
        b=KZrFiA8fiiM4d0xz7n9Ixn971l+r4JjIvA19bKj27HpnXecRGgq/nEDYTqomme2W2m
         EVfC0to8UoDOI7uS49w7DdnvxguvMPeiJqW8/XzgST0cL491iB1vOnkybRIpRxPrGkx8
         qYUea8vnBjP6V37Q/hioEAg9tKRAXIryJ5oSjwX/sk2OTgqEPIg66VHfhS4BEruTx3zs
         k+J7AAVO7nwsOlbXuC/FuNgj5SMQKoj47WMiV7xPsUWzISUyImXpj1UZAFo7GcnBVMqg
         XF3lDFnyW3JCHgpZgfZ0WP8OqV9Zxgmsgx9G/8vzEM5H6ZdjfjUnkGLeAujMN6byh9gU
         wGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354570; x=1692959370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f087Kw274k/dHkYZVOPSAgM/VBWlSfgBOsFhfzHlNmw=;
        b=Yx0bIxN5Mg4xJzUJrDw8bBnMD/ty8TdLukFFEBUtkEPqxA+4e5YIxEj8mOGcXeQdtK
         aS9K149x+Cp5JmrKgCihjkWq10dXA8ipo22qG0wbaDLUNMYMHnut/3O3GLqv8Ps50SeG
         HU7Qr2xN5UnhasMhc2h44wjfQPJMvll4b1uISJlKxW8/w0gaCXAeVZt+UNmx5bbi4HIJ
         wZwo94RkyGB4txLRjlKp8Yl0peIPny9kksGaeo4A8d3qAebIQSYgZ4z422zldw3IbuAk
         GZGdmOMy1+0gAzQuvv5wi9F3agsg/Imd9GfydbgJZXN4Qzx63R9Re1Ga4oRLeSGD9iGk
         rBBQ==
X-Gm-Message-State: AOJu0YzX2BSO50Epcy4wjcIbN45Q1QYXuoSbTqL4LOFe9DnH5BN5uEtg
        G3aTbpaPGfr/nci2vJ8yxmE=
X-Google-Smtp-Source: AGHT+IHWOnWffy/5o427UeNdAeXXntr4FcIrpe7g+HZVxbtiIHyjkpV+7mWe810Qfupkb5K7GQO4/Q==
X-Received: by 2002:a17:902:7b94:b0:1bc:ee6:7f2e with SMTP id w20-20020a1709027b9400b001bc0ee67f2emr1700820pll.53.1692354570443;
        Fri, 18 Aug 2023 03:29:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:29 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH v7 5/8] x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
Date:   Fri, 18 Aug 2023 06:29:15 -0400
Message-Id: <20230818102919.1318039-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
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
 arch/x86/include/asm/mshyperv.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9f11f0495950..8660d6bca6f2 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -48,6 +48,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_en_snp(void);
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -59,6 +61,16 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_en_snp()) {
+		__asm__ __volatile__("mov %4, %%r8\n"
+				     "vmmcall"
+				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				       "+c" (control), "+d" (input_address)
+				     :  "r" (output_address)
+				     : "cc", "memory", "r8", "r9", "r10", "r11");
+		return hv_status;
+	}
+
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -102,7 +114,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
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
@@ -147,7 +165,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
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
@@ -240,7 +265,6 @@ static inline void hv_vtom_init(void) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
-extern bool hv_isolation_type_en_snp(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
-- 
2.25.1

