Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDF630B46
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiKSDrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKSDqp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43958BF805;
        Fri, 18 Nov 2022 19:46:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so996093pjk.1;
        Fri, 18 Nov 2022 19:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OVwfeSJzfcwy29SuQO6DhipoyIsaZzVhoPd/85YD4c=;
        b=LD3AT/BYpwC/HqxCDdRm//s50GtDWZorc/UFGpuAPu2xhi34RQwp7GRQMvFxTdVWxu
         bowWb+WTPbjeO6ovgkk0OQiz1021DOUHT+z3MrH8Cp/evCzdkACdEjNxS5TFmn01h/Gf
         bjifJRtK6TTofF0a3iOJyICNN87CncDHEk9RbcOY8PsXhAwPBGaQL17oxZLxG2nTrDw3
         C9Kwp6fkFT6bZrS8ifcIKXWIl0bVtrxRmRnRPMJWOsO6TqVZo/WFYP8dLZGgZ3XBcn9M
         xzrmErYHuy5zG9qpTydaAxyiNngOtPd+mLCaj1zGNtOTliv8a52uUeSp1Dsn2z1CVkw5
         wByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OVwfeSJzfcwy29SuQO6DhipoyIsaZzVhoPd/85YD4c=;
        b=k6ohULoEMtQy3ANL5uwaeB9gx7CpR2zHRRGnpUdL9Y8AmQR19BoAgIx8c/12yVOCKQ
         +l23LXeuZeCSKfbDelUhSLaVCUH7nYkZX4WmDXBuHUj1E86nYSbtEij5tfmlUhXA/Chk
         xON4in3HnRaex6eWvLfgt6w5JN3XCHYizIYxAt5aVsB1awNRthUYfm9z8MMMPJF0DJlV
         AplsnIIN23SfoCVgnVvdsAgNfqrguoj0Jvx2WNxZH41jTkT51zQFFmAv3AkK4gR4EP5U
         qgV/67gqD6BixOjkkauSABHf9VhDIPQuRnp8/C4RD5VNHkiPUQiMwmJ7vNqoA3omyWjB
         MYXQ==
X-Gm-Message-State: ANoB5pkwZiUm4WdG/cGIGkASrf/aDx6S5JvK1dT5M4+xnEm90vdgzW/K
        tPEukkhbJX030qVZ6OWwP3Q=
X-Google-Smtp-Source: AA0mqf7hiJVtgg1DhDW42yAAa9DrEzz1sqT6RtyJ+nXa4uL21WoINwaxnUnf1gQokdJat9PnbUylWQ==
X-Received: by 2002:a17:90a:d50c:b0:218:722e:cac7 with SMTP id t12-20020a17090ad50c00b00218722ecac7mr10860624pju.47.1668829603776;
        Fri, 18 Nov 2022 19:46:43 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:43 -0800 (PST)
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
Subject: [RFC PATCH V2 04/18] x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:18 -0500
Message-Id: <20221119034633.1728632-5-ltykernel@gmail.com>
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

hv vp assist page is shared between sev snp guest and hyperv. Decrypt
the page when use it.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 29774126e931..4600c5941957 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -30,6 +30,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 #include <linux/swiotlb.h>
+#include <linux/set_memory.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -112,6 +113,11 @@ static int hv_cpu_init(unsigned int cpu)
 		}
 		WARN_ON(!(*hvp));
 		if (*hvp) {
+			if (hv_isolation_type_en_snp()) {
+				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1) != 0);
+				memset(*hvp, 0, PAGE_SIZE);
+			}
+
 			msr.enable = 1;
 			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 		}
@@ -228,6 +234,12 @@ static int hv_cpu_die(unsigned int cpu)
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
 		union hv_vp_assist_msr_contents msr = { 0 };
+
+		if (hv_isolation_type_en_snp())
+			WARN_ON_ONCE(set_memory_encrypted(
+				    (unsigned long)hv_vp_assist_page[cpu],
+				    1) != 0);
+
 		if (hv_root_partition) {
 			/*
 			 * For root partition the VP assist page is mapped to
-- 
2.25.1

