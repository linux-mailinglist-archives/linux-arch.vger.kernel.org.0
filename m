Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C06D4F54
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjDCRoh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjDCRoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0642D74;
        Mon,  3 Apr 2023 10:44:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so27980318pjd.1;
        Mon, 03 Apr 2023 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOp+J/MlPfipkIt8hJ1o3RldVOHyWVonLkOqsh7nnxE=;
        b=cNHdFhG1ku6DUDGidsm1yJOL/aAIk1oglkPnxeY7og8ZgkiM+b3Pv24z5fzscyI+os
         qzhTSEuFFXMfpi09zy7sPw8B6SXXsLMWC3+SHcg0WImPp+0Sz3TbPyySkpGliNacOBRX
         /PL69a5eFxhM+r2UHZGd7le+Mvs76NrUJxg0yXEbRpru7AFS3LV45Bc6S0KHvn2Rmko8
         dMHFTU9IDosPlLpsldPWD0M0bHltEFRmpnaGECmcRFlB/nq78Du61dNx0ERORHQKsufp
         NSbGnU0V3q10kfriRRm8zOL8hjiJMQ3H6pn7c5VdClkRM3CApaxFZLKxOOKovWXwHvr7
         +lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOp+J/MlPfipkIt8hJ1o3RldVOHyWVonLkOqsh7nnxE=;
        b=yYoCWEFGzBP1fsQtlclz0KCkA5OHe0amxTK42FYOWOOg8t+Xqfbf7dZ9Srj6mONd6v
         YXzV+WPMQE/zmyR6jBo6zPA2Sfwx6PtAGwd1nqbbwP+bUubF88e5FJJbOrCY8J1OsVJy
         CGewKSFeqgjzrZPxpFuXAyWH1/8qvtrjVsI5BA+3GEsCQPzuo9qid5NcY6vLbtKKwaQF
         FH7utvCP1GO/xjPD9hPbZQHyTKw0UIG5WtIRmrVM4IDpMKvBjlMaUskIDZcia6LnYbsN
         Cj5vNDSpdQ00dhjqbNQDRvaxVnK0BXMVHgRsSfYLUKYM9kQAFm5ZH+17Wk35qyWfiYdV
         eoBA==
X-Gm-Message-State: AAQBX9cur3AZJ5SkuTQ9QjR++KaJiiGsxpNKzT1twNljQjmj/XGQJIec
        C04XcIf5BMp35L0QOuBMNFY=
X-Google-Smtp-Source: AKy350bgSpE7FqsEYwJ33BV67GQv+DWoN9DsIYPXLnrVVPKzO31Hv3TYn0cY+TJ77q81lu98kJcYaw==
X-Received: by 2002:a17:90b:1e43:b0:23f:8752:98be with SMTP id pi3-20020a17090b1e4300b0023f875298bemr43385277pjb.4.1680543858196;
        Mon, 03 Apr 2023 10:44:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:17 -0700 (PDT)
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
Subject: [RFC PATCH V4 06/17] x86/hyperv: decrypt VMBus pages for sev-snp enlightened guest
Date:   Mon,  3 Apr 2023 13:43:54 -0400
Message-Id: <20230403174406.4180472-7-ltykernel@gmail.com>
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

VMBus post msg, synic event and message pages are shared
with hypervisor and so decrypt these pages in the sev-snp guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       * Set encrypt page back in the hv_synic_free()

Change since RFC V2:
       * Fix error in the error code path and encrypt
       	 pages correctly when decryption failure happens.
---
 drivers/hv/hv.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 008234894d28..e09cea8f2f04 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
+#include <linux/set_memory.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
@@ -117,7 +118,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
 int hv_synic_alloc(void)
 {
-	int cpu;
+	int cpu, ret;
 	struct hv_per_cpu_context *hv_cpu;
 
 	/*
@@ -168,9 +169,39 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
+
+		if (hv_isolation_type_en_snp()) {
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->synic_message_page, 1);
+			if (ret)
+				goto err;
+
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->synic_event_page, 1);
+			if (ret)
+				goto err_decrypt_event_page;
+
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->post_msg_page, 1);
+			if (ret)
+				goto err_decrypt_msg_page;
+
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
+		}
 	}
 
 	return 0;
+
+err_decrypt_msg_page:
+	set_memory_encrypted((unsigned long)
+		hv_cpu->synic_event_page, 1);
+
+err_decrypt_event_page:
+	set_memory_encrypted((unsigned long)
+		hv_cpu->synic_message_page, 1);
+
 err:
 	/*
 	 * Any memory allocations that succeeded will be freed when
@@ -191,6 +222,15 @@ void hv_synic_free(void)
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
+
+		if (hv_isolation_type_en_snp()) {
+			set_memory_encrypted((unsigned long)
+				hv_cpu->synic_message_page, 1);
+			set_memory_encrypted((unsigned long)
+				hv_cpu->synic_event_page, 1);
+			set_memory_encrypted((unsigned long)
+				hv_cpu->post_msg_page, 1);
+		}
 	}
 
 	kfree(hv_context.hv_numa_map);
-- 
2.25.1

