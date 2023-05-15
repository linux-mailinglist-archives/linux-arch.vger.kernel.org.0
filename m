Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA57035A4
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbjEORAT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243426AbjEOQ7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:53 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E17ED1;
        Mon, 15 May 2023 09:59:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52079a12451so9362365a12.3;
        Mon, 15 May 2023 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169982; x=1686761982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8lQptbWtTMcCpIUwC+SzQjIl5Lzr5bz7ZBsqcGRMAU=;
        b=ggG2ucog+cO9MP0g29R++Jl4Q999l/IlWujCrBvupWsv1Xv8zdI5xNVnlRkuVFQ1c5
         Zbeq83nk3Mk20m2Zi1QdEzAEVtxBKk6kmF8Z6ivlSN6bNfFaWZap37KfrRf5vwxeatG2
         XNu/8yAGK2LXSUeeEOnvGaEM1pWSAV0F1nJ4h0Q03yGZT5fC0nCKCNYA9/2gSzEoYMoU
         GOzSShy87dmcrIvnvF10FC9CcC1acdHlDmE/LQIWWMcv4kA1mjNQM179dLO8yz2Z7ajU
         zD1jV1GvChUETvOAFCZLa2CSc9aKKE5TDTYr42B6wlqZIZH3ueJkJmUt/DxooM9myn74
         o/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169982; x=1686761982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8lQptbWtTMcCpIUwC+SzQjIl5Lzr5bz7ZBsqcGRMAU=;
        b=O23qAYSRHAlYmGyppb6CXqFuRruVE7/vLfoZeiRX8w/zOnQgt/6xkH6JLE8tJwMEZF
         FYdkTmcRuQhE5g/sqen9Jj5k5e/cvIuw6PdkQLmjebKZWKTG5dr1S2nM5/XSTemYiWRP
         7haF+IGW6rPgN9sA4CscOXQcl/vx8NWV0eUEMCs+GzPSEDHdnsL08ARUWPwo8MpDzmLw
         B8n3RXsqvsHu2+HVpz/zAO9vZ98vkj2W7M0snjMREwDRZShn0K0QKq9j5jm8L44ThPKh
         OZPT5CS6wiZkVW1r6dRX7pIMsYmTVoUQai31ZjpBXNdoqirYSfu8DjwDFPJtP8XrsLT2
         pfgQ==
X-Gm-Message-State: AC+VfDy3cZm2x9rgV7zqPZkHZkYQfDA5qjB7vMBQzVWiwBjsONfIGUDN
        XwAXGm34LfylaH3S6nThMP8=
X-Google-Smtp-Source: ACHHUZ5saDduEOms1YHP54rO0xRRMeATG7Neg4Olzlw4vNsl6oHb2QKmTcWwMZMnsnMbOj6CWJ+YGg==
X-Received: by 2002:a17:90b:4ac8:b0:24e:507:7408 with SMTP id mh8-20020a17090b4ac800b0024e05077408mr33818524pjb.37.1684169982187;
        Mon, 15 May 2023 09:59:42 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:41 -0700 (PDT)
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
Subject: [RFC PATCH V6 11/14] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Mon, 15 May 2023 12:59:13 -0400
Message-Id: <20230515165917.1306922-12-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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

