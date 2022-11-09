Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480662350B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKIUy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKIUyM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5E27FC2;
        Wed,  9 Nov 2022 12:54:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so18218700plc.9;
        Wed, 09 Nov 2022 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAXRqP2y00DrPAfpogwk3TLv9UhC4S/D5/TlIyE91Hw=;
        b=Te6H+TH+yST8c6KwaFmZrKwGmb/qFLAP4Ijs+O0sg16ggjNVi1pniMt8qRquxctGo8
         bG894KSqsGQzNTkQVawrXkjvUz4MBGbwm5emlok9cQrNP4cVVAoh/pKOj7RYoX8RYy4a
         t1rVYkdBA4ze+dGdcEbpVjwLF6N3/v38VH0wLJF3nyT4/ZqSA+Vgy135v+xS+BMvGnRx
         kOxqG5zEKlE9xIXEp3MFMedPJVROB5SwJ52rVvpQLyxHQ4jlNbjNYliYygSrqD1HqhrQ
         MuqDpIY5atERxparXSh5/f7em9davf9PVRDaVx8XB4m01uKCdc55EVJoWHRc87AEZ/jR
         2Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAXRqP2y00DrPAfpogwk3TLv9UhC4S/D5/TlIyE91Hw=;
        b=DdvZVPn7QHmKcYJAd1scW8gBiT82UIs8QII7Jt9MXcxyn7MnrBH4VHNC2oCF6jSeL5
         LLt0Mhmzs/ZOiuKZK9HCdJ2p5srefmNLe+2sFNrEOg9fQV5SC2nsobdhuj1KypieQTDi
         maX7vjhsJBKmYahfWBY0PEdX1Fj3YZFkopHMhSLk1xhh9+T0kI4GtgrNl34Kj8e6C0Ix
         EKq2U4OGbm/5+gB7uDa4HDyo+0CSyZ8gRTPEQFJNFxcT8NuON637NR4pqHTHVRk74aii
         7g3g192BewBD/qwwxdwvn4LGr8/PNmjtEqH020mxPdr1FB69kQXqC2/zUJCBjRWRYAzC
         2SXA==
X-Gm-Message-State: ACrzQf1OxfTPc6E/UT72CV7u++hyeIlEujWWRtPa79auV8LaFxWoFmMN
        tNxq5Tu99u4wLc4TEqJLRIA=
X-Google-Smtp-Source: AMsMyM6FKraDvmCSKM8SltaKBfYOM83RXMvfiFmhKbOkh7EavSs25oEeebRK8YEEiRnFDRRvUgoSDA==
X-Received: by 2002:a17:902:b70c:b0:179:eb79:cf9a with SMTP id d12-20020a170902b70c00b00179eb79cf9amr62100881pls.130.1668027251732;
        Wed, 09 Nov 2022 12:54:11 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:11 -0800 (PST)
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
Subject: [RFC PATCH 11/17] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:46 -0500
Message-Id: <20221109205353.984745-12-ltykernel@gmail.com>
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

Hypervisor needs to access iput arg page and guest should decrypt
the page.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv_common.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2c6602571c47..c16961e686a0 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -125,6 +126,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -134,6 +136,16 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (!(*inputarg))
 		return -ENOMEM;
 
+	if (hv_isolation_type_en_snp()) {
+		ret = set_memory_decrypted((unsigned long)*inputarg, 1);
+		if (ret) {
+			kfree(*inputarg);
+			return ret;
+		}
+
+		memset(*inputarg, 0x00, PAGE_SIZE);
+	}
+
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
@@ -168,6 +180,9 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
+	if (hv_isolation_type_en_snp())
+		set_memory_encrypted((unsigned long)mem, 1);
+
 	kfree(mem);
 
 	return 0;
-- 
2.25.1

