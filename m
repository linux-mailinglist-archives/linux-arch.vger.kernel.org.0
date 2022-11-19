Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC4630B61
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKSDrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiKSDrF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF1BFF46;
        Fri, 18 Nov 2022 19:46:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so6773362pjl.3;
        Fri, 18 Nov 2022 19:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAXRqP2y00DrPAfpogwk3TLv9UhC4S/D5/TlIyE91Hw=;
        b=ClwKlnSy/Mz6sk0P1y3kITeMuLjvpRy0L67pKK4fRHpHSolrEEDdsUI8Y20sPFG+7F
         aA6QaIZ52/Y6wT4KHTuSaz6J4S581VQH1ExKZRz3qcZr1jp5kNLLxw5EFxc1EelDP1sD
         7O7HCK0yC7QmOqc5BebQe15FUSnCBBSUXCapZ18gkI+bEAeX2dsf/MK3V7GG3020IeEj
         9RI091r5EyrpPdbEi5E0mciPoKmPis4EU2iJr55IXHvGS+V1Iu3EeDkupNAeftDCtvWR
         v8ABBQLDsXLOz1GjuGO+6apEtUTRvYy6wbZWQ4GW7nLzmBMnbFZJtvcSqYknPCh00wce
         NNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAXRqP2y00DrPAfpogwk3TLv9UhC4S/D5/TlIyE91Hw=;
        b=BOnml5AwKKLp1njyz44x2w1l1JNKASLakeTY5tEPClkhYCbJM3h4Nyw7wOcS8ZqayF
         hWjhLPuWUAtFyXzMeHA66LC1GloQMyKd027/yJrLjbqE4dM88tr9z7fS8D96/pnfrobP
         1O+rl8CiGVgyxuRQqXA1yWCkrowEc7viDFzgLliA3sfeAbjDiuIK7sLlxRHpbNT17qJA
         r4sSvWbJV7S2un8HaSN5Vcnf1397PsPAsbtp89pbrsONqNWM2ac2YNtXM/SHTDGN5g0R
         AiHaHQSj1C8Bro1jldEMvG5Mxq+2UIufoxXSU0iVWxJoKBB78mdLVtxRGTBI42ePE6NY
         Wcqw==
X-Gm-Message-State: ANoB5pkCC1rNTnxg93+Z8QqCEjFFMEtuuAtepnO3Je2Eff9UKuGg7N0a
        bf1gia6AqzddqqccN8VFnn4=
X-Google-Smtp-Source: AA0mqf7C4HWWj9/I41fGzMZ4RjAnGmUbCLdi2fhrOpVXAY0OkMXcLrJbuauBk8W5UthPygU54iZXSw==
X-Received: by 2002:a17:90a:a60c:b0:213:2e97:5ea4 with SMTP id c12-20020a17090aa60c00b002132e975ea4mr16715811pjq.92.1668829612431;
        Fri, 18 Nov 2022 19:46:52 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:51 -0800 (PST)
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
Subject: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:24 -0500
Message-Id: <20221119034633.1728632-11-ltykernel@gmail.com>
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

