Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD16D4F59
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDCRoy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjDCRoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135402688;
        Mon,  3 Apr 2023 10:44:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w4so28787938plg.9;
        Mon, 03 Apr 2023 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRBMiXzZNygTcZn2nWWcUVPl/gZC7IQbi/zy9Q0QWG8=;
        b=Vn/Lo0p4Nv0x5bLf7vQUWrfkkMLVlX6jfveMHNj0Uti93dq8W3ItJV4FlSUdH0o1Dl
         jdHp4yXrT8HX4TG/Kw7MWRZfxnlwTRtrIhT88kRY2QvyW9Na9P6mKsue5w+IAgPMgLmw
         RfYMEQ3Pja6wz/35rnzn8aXIRPy2U2nJeRezAplaGXNEXCVpH8rXlCR3iBNmYIwH2t0w
         wrUZ5PpPFQrINNYhD5pSUvQZkoLrx75iWUCmVxyUc4p3+/LvLDPKmoz98zX0efRybiED
         PsLn6IufclLcNHByQWLcGCDsjaGyiMUG0aZ73r8Neop2kM6RCTuT5V5CfpiiR4cbcg6Q
         NyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRBMiXzZNygTcZn2nWWcUVPl/gZC7IQbi/zy9Q0QWG8=;
        b=0zaSfYqIiTK5Pv8YDCxycIYISWzkb4xZ3IzccFrihl5G43b8pdYXwLBlydwrFIs0xl
         Rq6IFqLx67EWSPRh0+J1grVfU6nX4lNPxWxTV/yvOt9mFWO2J1TTxROe/eDlcgwFmMwk
         UDxDCqQZ+L0pmsENsi/eFUEr8t9LfWU3HfOrBrnl5+JdENoJ3FlEQW8lC8DNT97UIRKv
         eEXqZ1irq20gd+9hLfF8D/j3pRjZAnNZ7MWVL9ZlIhsF8Fzr1D7z4nO/c1QOZYA/4Jor
         ygmQAxPdQLhjmqhTn+ev54Dci6zcPsQDwwZAGzrWUcNY/ucGY8Ohl1zIWUIvuy3d761x
         61Lg==
X-Gm-Message-State: AAQBX9fa9iJzO9Bsdi6STon9/MawenfK/o4y9kgpM3M8w+QDVpoav8ab
        uiUSZgwj8vbgqYk2bM5b/fw=
X-Google-Smtp-Source: AKy350bgaRlI+pSd0yR6OkLeUp0nfBqWDPsMadzvxbDT8HCL58L5FJrQtgajuf32tRHeSjojFkjJfA==
X-Received: by 2002:a17:902:f687:b0:19c:be0c:738 with SMTP id l7-20020a170902f68700b0019cbe0c0738mr48077342plg.59.1680543859450;
        Mon, 03 Apr 2023 10:44:19 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:19 -0700 (PDT)
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
Subject: [RFC PATCH V4 07/17] drivers: hv: Decrypt percpu hvcall input arg page in sev-snp enlightened guest
Date:   Mon,  3 Apr 2023 13:43:55 -0400
Message-Id: <20230403174406.4180472-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Change since RFC V3:
	* Use pgcount to decrypt memory.

Change since RFC V2:
	* Set inputarg to be zero after kfree()
	* Not free mem when fail to encrypt mem in the hv_common_cpu_die().
---
 drivers/hv/hv_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e3b04e978932..455432d49fd3 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -128,6 +129,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -137,6 +139,17 @@ int hv_common_cpu_init(unsigned int cpu)
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
@@ -156,6 +169,7 @@ int hv_common_cpu_die(unsigned int cpu)
 {
 	unsigned long flags;
 	void **inputarg, **outputarg;
+	int pgcount = hv_root_partition ? 2 : 1;
 	void *mem;
 
 	local_irq_save(flags);
@@ -171,7 +185,12 @@ int hv_common_cpu_die(unsigned int cpu)
 
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

