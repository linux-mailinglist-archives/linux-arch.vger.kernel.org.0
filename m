Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF2630B5E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiKSDrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiKSDq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:57 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8ABF80B;
        Fri, 18 Nov 2022 19:46:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b62so6658466pgc.0;
        Fri, 18 Nov 2022 19:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHdN7biDTMCbZsH86bq9wEVAHh9Jk5WDAS/BJmNojPQ=;
        b=TONekkcAfBmXRry37Wbi51cr2toA2jiBUJMasTmc7l2fvIja1wdaN2X24ZFp2YVWpn
         steUrrkufUn0wEzm57h+/JnRnmvpOChMAFwykT8+bgus9Kj3Hm20/b96RiQ/kyf8WeS/
         G3aUroC/Aq7tA5KejVGVa2bztjFmKadFznW/m/goy045L8PHEnEJaOznmLBunZd2zL+J
         AH/ZONaDjpHjlJPcUSlykncMcLEnDOijSC/TYynTSJdphSB25OW8JuIA8gme1eAL7yXn
         uI8QDS75KwmAYCGnJs533NogBgneAQrRmcio34vIt0Op30bIh3icBuOYVDnScTYy1jiI
         H3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHdN7biDTMCbZsH86bq9wEVAHh9Jk5WDAS/BJmNojPQ=;
        b=sVfHsa3o3FTXqskn9v9ITGXO3M5w6FQCGrPqIktf/M5qk1bhuMLlxHspzUfAJ9EthF
         tK7XHG4wvRfC2XfEUvz7H3JZ/23k7GupFJYbs7nhSLjkEMx24ElDNFs++FKLRT4iVy8C
         0G82neDxSBdscGffl+YVYGH4xGSRKNQLMrLCMtCExaYilt6HZKLx8ip8IC4pxOvhA781
         LzgD0AADHN9b6gBECI2l2LlA7TSzhT9guWdpnVzFGLMfmac4VkIAvFza6vMuyNZpzHNA
         +MjdE/vQuGm7OlcngHHXQF16P6538MZ/sXBz6oi/op+YoelwanuWz+7V1H1skeU1dDx8
         7U8g==
X-Gm-Message-State: ANoB5pmdrpIqD1lp0HLJ/SYNZsqftNTa0Cc7AiYrqNBOdO8FrSosP6Or
        bfSZeDEZoPgKs1MEC2rKbs6kPkQQjlnDsw==
X-Google-Smtp-Source: AA0mqf4W9C8O5R6U3ygETad3CLbfYrIKVfeSRJhpnQRqtB9YGtpcZtnOxW+pV8nSo49Drl7yTT0g+Q==
X-Received: by 2002:a63:5502:0:b0:470:3e8:6f25 with SMTP id j2-20020a635502000000b0047003e86f25mr9319719pgb.294.1668829605426;
        Fri, 18 Nov 2022 19:46:45 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:44 -0800 (PST)
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
Subject: [RFC PATCH V2 05/18] x86/hyperv: Get Virtual Trust Level via hvcall
Date:   Fri, 18 Nov 2022 22:46:19 -0500
Message-Id: <20221119034633.1728632-6-ltykernel@gmail.com>
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

sev-snp guest provides vtl(Virtual Trust Level) and get it from
hyperv hvcall via HVCALL_GET_VP_REGISTERS.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 35 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4600c5941957..5b919d4d24c0 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -390,6 +390,39 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
+static u8 __init get_current_vtl(void)
+{
+	u64 control = ((u64)1 << HV_HYPERCALL_REP_COMP_OFFSET) | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input = NULL;
+	struct hv_get_vp_registers_output *output = NULL;
+	u8 vtl = 0;
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input = *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+	if (!input || !output) {
+		pr_err("Hyper-V: cannot allocate a shared page!");
+		goto done;
+	}
+
+	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = 0x000D0003;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (ret == 0)
+		vtl = output->as64.low & 0xf;
+	else
+		pr_err("Hyper-V: failed to get the current VTL!");
+	local_irq_restore(flags);
+
+done:
+	return vtl;
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -527,6 +560,8 @@ void __init hyperv_init(void)
 	if (hv_is_isolation_supported())
 		swiotlb_update_mem_attributes();
 #endif
+	/* Find the current VTL */
+	ms_hyperv.vtl = get_current_vtl();
 
 	return;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..68133de044ec 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -46,6 +46,7 @@ struct ms_hyperv_info {
 		};
 	};
 	u64 shared_gpa_boundary;
+	u8 vtl;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
@@ -55,6 +56,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

