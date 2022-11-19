Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F0630B5D
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiKSDrd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKSDq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A98EBF822;
        Fri, 18 Nov 2022 19:46:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so6349431pjb.0;
        Fri, 18 Nov 2022 19:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItxDpPRpAqbvZZHr07qhhxQmPJehVCNLqSw71HrxTxc=;
        b=VQxEqC5qot3L/gBM3Sf1bbsdOF9if2kV/RVHJFP65XEk0ifY/2XASgPM++aXUyKchT
         TQ4efq06/HtUT3jAbNbtFLIfIf2BhwxPbGubtO8Lxstay5MYzdNJASfgRUVsk6pJuv4d
         eARufqyIzHmJx5HwxkSvlSj6Em9vvSblPFjpnYdQOPvNDBOztA790QOnHRQKPSP/Tr4q
         T8PsDn+w+vtzBVqab8aWwu/NJ9p/o2ERcKATOb8/5jkGJfuD7QBF92OjaSh9ov4DAHYc
         hK5NqZyFTjbSJKEGCAGtiYgRad7Xe8T44UBi/KUH+DKTVndUSMgTI0UKcEAsmHT1YK5Q
         d0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItxDpPRpAqbvZZHr07qhhxQmPJehVCNLqSw71HrxTxc=;
        b=dnfmHBgAb65b9zcUKSjWjsu/mMx1d7kNJ8crRNBmsTZA9JXK6kOj2TdJjSWNikROGT
         +816c9XCTMjJEouoOmCep1mfjAfUI/R0dfw21mj4othhPJoaD+YTmnO/ePQn8dmHUzM2
         HUOUF7mOJvDioPEtH9hF/fBvYqp04jfxcNC/5NxJ534KMkpuS6wk6oe9FxbCBQ2xHo1+
         TXsNv5MshdUIwPhARdPfoZyaU+GH2Qy1jdhC5q15EF8J+jH+gDuiJvOk6q991u8INMQQ
         4OOKqWkbI02eg7fi/r/c7nvm3laSj8uAhl8QBkDOGGOLjx70INCguxblz+WpzEvJRiyE
         g5dA==
X-Gm-Message-State: ANoB5pkUm9KqpnCJOqexPNHPIHj5Kr/FVNT6+4FMfI38Qrnu+uW3+4fX
        cC2Sjq94hSbxu1PmUnd/I2o=
X-Google-Smtp-Source: AA0mqf6Qw5HeeCOlmu7rZ59aqHFSQUAoRvby6UhqkbdaM9NOcB3rWY+HvxJyUP1+EtFsq1YlG5DDMg==
X-Received: by 2002:a17:90a:bb86:b0:218:8d27:cdae with SMTP id v6-20020a17090abb8600b002188d27cdaemr4403165pjr.244.1668829609794;
        Fri, 18 Nov 2022 19:46:49 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:49 -0800 (PST)
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
Subject: [RFC PATCH V2 08/18] x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:22 -0500
Message-Id: <20221119034633.1728632-9-ltykernel@gmail.com>
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

Vmbus int, synic and post message pages are shared with hypervisor
and so decrypt these pages in the sev-snp guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/connection.c | 13 +++++++++++++
 drivers/hv/hv.c         | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..43141225ea15 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -215,6 +215,15 @@ int vmbus_connect(void)
 		(void *)((unsigned long)vmbus_connection.int_page +
 			(HV_HYP_PAGE_SIZE >> 1));
 
+	if (hv_isolation_type_snp() || hv_isolation_type_en_snp()) {
+		ret = set_memory_decrypted((unsigned long)
+				vmbus_connection.int_page, 1);
+		if (ret)
+			goto cleanup;
+
+		memset(vmbus_connection.int_page, 0, PAGE_SIZE);
+	}
+
 	/*
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
@@ -372,6 +381,10 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
+		if (hv_isolation_type_en_snp())
+			set_memory_encrypted((unsigned long)
+				vmbus_connection.int_page, 1);
+
 		hv_free_hyperv_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..f9111eb32739 100644
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
@@ -168,6 +169,29 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
+
+		if (hv_isolation_type_en_snp()) {
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->synic_message_page, 1);
+			ret |= set_memory_decrypted((unsigned long)
+				hv_cpu->synic_event_page, 1);
+			ret |= set_memory_decrypted((unsigned long)
+				hv_cpu->post_msg_page, 1);
+
+			if (ret) {
+				set_memory_encrypted((unsigned long)
+					hv_cpu->synic_message_page, 1);
+				set_memory_encrypted((unsigned long)
+					hv_cpu->synic_event_page, 1);
+				set_memory_encrypted((unsigned long)
+					hv_cpu->post_msg_page, 1);
+				goto err;
+			}
+
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
+		}
 	}
 
 	return 0;
@@ -188,6 +212,12 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+		if (hv_isolation_type_en_snp()) {
+			set_memory_encrypted((unsigned long)hv_cpu->synic_message_page, 1);
+			set_memory_encrypted((unsigned long)hv_cpu->synic_event_page, 1);
+			set_memory_encrypted((unsigned long)hv_cpu->post_msg_page, 1);
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
-- 
2.25.1

