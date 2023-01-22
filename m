Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B3676AC2
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjAVCqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjAVCq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF8241F4;
        Sat, 21 Jan 2023 18:46:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i65so6604920pfc.0;
        Sat, 21 Jan 2023 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSuNKkMXWHSa3J60m4rY4F79SY/10La9kbhfpfz9TzE=;
        b=VkVetbyCcGyNR+peKjvZmq1rh+GYQboKSEMpmfmYtRDt/XA1pMxwyIH1YOWmzj56ew
         DxryIxyvCP56FAfTMIkq47XAFpHM6ZkikVrfys80CqKN2kK5c6kFDpmEc5Z3ojxLe+Gx
         vbqH68TcpXINebpFsBdBNH4GVh/CFA798XBLWBmYsS/NAxT00p/TJIEXtJM5PKX6MoZX
         hd3eeoPaN1FxN76h3I/QsAfLcMPxOr6L7N5bqoOpd60MvIjWvwmpexN3qFCeXdej+A1H
         Sa8H2CQZt2cgQf2eFW5AkEGck0xbvc3rBMKKmqRb4mmY2NO0tJ0YZXqZlwacOJsQ2b9K
         RLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSuNKkMXWHSa3J60m4rY4F79SY/10La9kbhfpfz9TzE=;
        b=PegM51jYgPsvcmcByz58py8QyRD4vTae3b9BXGy5u27oyF8MUt2jUXISaIDCken1J+
         nxdt2Va3gQ23tHY17xjImzq3FW4v7Uc06C6Y+o6SCnM75ZEAFGk3GsDP0DHsro23Qf1b
         8P//sHRKHrdW4bpUl9PjYbx4zqLA/uMG2cIh8YgPi3I9NmZPMgyZOPYnmX8ZWUtbuWgG
         smQvsGq50RJdGeSU55sQLutLufg3B8NGkeCpWNe4XP0MtxQZYggb5VOG1GdgE8Vf+N1B
         hQwhvDHVFcfYJSi69OKy4HnEkTK7OwaZJBNUle38I1np1w70x/YZOMCq4hjqSvQUKTdF
         e03w==
X-Gm-Message-State: AFqh2kpgpljVrP/Tyxd86h88yw7k/1Lvu8srrInQh9LVmuqPE9G1ScXM
        vOxO2svo3vJpy6aGq+m4LDc=
X-Google-Smtp-Source: AMrXdXvE9Bcml9Mo/WbAKLd9q68UcwTXJOz+R5uCgaC7ad7djllW2ZKCNYXMprZSEPVIjI1oAT1q0w==
X-Received: by 2002:a62:79d2:0:b0:582:b089:d9be with SMTP id u201-20020a6279d2000000b00582b089d9bemr21737321pfc.13.1674355581499;
        Sat, 21 Jan 2023 18:46:21 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:21 -0800 (PST)
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
Subject: [RFC PATCH V3 07/16] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Sat, 21 Jan 2023 21:45:57 -0500
Message-Id: <20230122024607.788454-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
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
Change since RFC V2:
	* Set inputarg to be zero after kfree()
	* Not free mem when fail to encrypt mem in the hv_common_cpu_die().
---
 drivers/hv/hv_common.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index f788c64de0bd..205b6380d794 100644
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
@@ -134,6 +136,17 @@ int hv_common_cpu_init(unsigned int cpu)
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
+		memset(*inputarg, 0x00, PAGE_SIZE);
+	}
+
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
@@ -168,7 +181,12 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
-	kfree(mem);
+	if (hv_isolation_type_en_snp()) {
+		if (!set_memory_encrypted((unsigned long)mem, 1))
+			kfree(mem);
+	} else {
+		kfree(mem);
+	}
 
 	return 0;
 }
-- 
2.25.1

