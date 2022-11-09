Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510E6234F9
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKIUyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiKIUyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759223057F;
        Wed,  9 Nov 2022 12:54:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2985178pjs.4;
        Wed, 09 Nov 2022 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHdN7biDTMCbZsH86bq9wEVAHh9Jk5WDAS/BJmNojPQ=;
        b=THFm4WlORiFu6wM+hxaUB0asUX7JAnBfCvwV26HjY41bQCdT7U9yg/HffOLxdniunz
         RbiglkCQYedFF0t5YeN0+TBtvcokjeddtNHkLemD4h7yi1bO3Rg1tyGXwQYzM9r4mR3e
         YTvIrZHQmjPClcIvMfq8NyY++9diK2RcH+VjooLFNIqkegcfLs+OEdDUqSJs5gZK9VPl
         uJ+qapjNgBUbno+lbcSPydJfkAvKMhTuFBfMgMql/oa+rEMoOGYMngtllcxhQCjKCHV+
         6RC+MSB4wjizPRH99eBVkBeB0wMk/hcBOeJIQMNitNvky0i0RJIWOO/2KigmblrsY2zf
         trkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHdN7biDTMCbZsH86bq9wEVAHh9Jk5WDAS/BJmNojPQ=;
        b=o+XS3KBpn7jCHabN3SBBreVXUWAci4thawQiEBr/tiikffRvAAHUPPNRGZkSrt+pX+
         wPL1OW8OtGOWIP0f6vT1NoqQ5HEit7+nmBX3NQzbU/EUEFxRaIyZ6GoY8/gTp7qcoIjY
         jy+/hw+i9feXwxsJiiEguDL1rdAkrBTsfpLU6Mho3auO6xrIAkIqDQFfWzZUJMp8n12q
         U8lvT9ckHYuxWBgskdgq90GawIj8QbTQFwQW9l8kamHkzb3M6a9/bktsdw/0yYepJ3mi
         TzPIMHgqfHqGdtaJteA+e8/jifVFx5/G4XtlRx8OG0eNg0iX7wjGOa9abHgH/a6uWbaB
         Vlhw==
X-Gm-Message-State: ACrzQf1FhVP10gWkl37AahhhD1TxdYlEbh2fmgNH5IwHc/karXvF9acs
        5EaafP6wBQgTwlE3b0iV4wI=
X-Google-Smtp-Source: AMsMyM5yXI9fys+ecbDjt2yNsL/mOih43onzwERF6aUXXPKnA8tHsu1OejgTmbuNDnSndoV6Z9PR2g==
X-Received: by 2002:a17:903:2452:b0:187:99b:c8fe with SMTP id l18-20020a170903245200b00187099bc8femr60899734pls.113.1668027244946;
        Wed, 09 Nov 2022 12:54:04 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:04 -0800 (PST)
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
Subject: [RFC PATCH 06/17] x86/hyperv: Get Virtual Trust Level via hvcall
Date:   Wed,  9 Nov 2022 15:53:41 -0500
Message-Id: <20221109205353.984745-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
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

