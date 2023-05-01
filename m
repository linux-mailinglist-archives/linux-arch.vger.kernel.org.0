Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635D36F2FA6
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjEAI6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEAI5t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90505E7A;
        Mon,  1 May 2023 01:57:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaea43def7so8722535ad.2;
        Mon, 01 May 2023 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931460; x=1685523460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8lQptbWtTMcCpIUwC+SzQjIl5Lzr5bz7ZBsqcGRMAU=;
        b=o4d53S8d5VyAf5qebAE9yXFatg1NHzWnPwqVGtuQQoUyxq8+haPPhm7zKoygxajnfv
         I5S+s4TbtGyytuaqV7FQ0DjSerZNTnHVxoO0uFI23Hs3+zEtBCB0LZXepwCn0cXR+NSR
         ymuPKNonexYx0rYvavkRs1i5BclR1v9gPCkKf6WqU9BnSIA7cp0ANYYW0wmVlFUQ7pHc
         LBefPmdidZQ+WOlD4H59mI76vy4YxLvw20WiaIFHwfTTrP5N2AthYKliY3XwSj5tk1C+
         c/7kRi/gY/Fmh1ruzaK6vTUz00BfCFfCfmPkFGOoVt0ScNKKRlcUylp77tNmCUhlaADO
         0OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931460; x=1685523460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8lQptbWtTMcCpIUwC+SzQjIl5Lzr5bz7ZBsqcGRMAU=;
        b=Uji3nsYiCwiCtBQpxS7fd6phMzHB2e/BWjHuSMtSEyF2EE8hfgaDag2ExUWMS7nVhg
         jUoOMT5eq/QiLRS8COP8P3sU9EOjbKPMpDnO+MSep4I6P1RklMpZBa4lMRsa1X98UQuS
         yDwzU41tqESkes5nT9+vju+b10pHU4g12JAHVeXTZ+iFH0gTFhxzCS/Fxb9w1u/HsPzE
         uFLBd7e/YKnSHqhwJYa+kqVPeJWLEWDrAAQLFgcRqfW4oJBy18e0oUg4PZ9Ny/DqI3/w
         KGGsgHhwE2PeT0FXY3CMUfmqw1Y3TdMEMJQQzW6YbzWQ4oaNWsipTmGabp+B4Sa/wCRB
         IHLQ==
X-Gm-Message-State: AC+VfDw6hQSIwUaCeUg4/kJNXtPQPiM0RTeEE6TMeZnnd85qM+LOGYff
        PmntzMq5NJcSY22K8eaXG6k=
X-Google-Smtp-Source: ACHHUZ7eDrCz/Bj7JdGVG3Uz1k2Jw1gJYenbaOHgIVa2m5W3GnYdIiprug0a3YTIX7w3fyemrBx82A==
X-Received: by 2002:a17:902:d2c2:b0:19d:778:ff5 with SMTP id n2-20020a170902d2c200b0019d07780ff5mr16694641plc.15.1682931459793;
        Mon, 01 May 2023 01:57:39 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:39 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V5 07/15] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Mon,  1 May 2023 04:57:17 -0400
Message-Id: <20230501085726.544209-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change since RFC V4:
        * Use pgcount to free intput arg page

Change since RFC V3:
	* Use pgcount to decrypt memory.

Change since RFC V2:
	* Set inputarg to be zero after kfree()
	* Not free mem when fail to encrypt mem in the hv_common_cpu_die().
---
 drivers/hv/hv_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 179bc5f5bf52..15d3054f3440 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -24,6 +24,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -359,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -368,6 +370,17 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (!(*inputarg))
 		return -ENOMEM;
 
+	if (hv_isolation_type_en_snp()) {
+		ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
+		if (ret) {
+			kfree(*inputarg);
+			*inputarg = NULL;
+			return ret;
+		}
+
+		memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
+	}
+
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
@@ -387,6 +400,7 @@ int hv_common_cpu_die(unsigned int cpu)
 {
 	unsigned long flags;
 	void **inputarg, **outputarg;
+	int pgcount = hv_root_partition ? 2 : 1;
 	void *mem;
 
 	local_irq_save(flags);
@@ -402,7 +416,12 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
-	kfree(mem);
+	if (hv_isolation_type_en_snp()) {
+		if (!set_memory_encrypted((unsigned long)mem, pgcount))
+			kfree(mem);
+	} else {
+		kfree(mem);
+	}
 
 	return 0;
 }
-- 
2.25.1

