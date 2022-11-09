Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0B6234FF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKIUyQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKIUyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EDF286E4;
        Wed,  9 Nov 2022 12:54:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h14so17821919pjv.4;
        Wed, 09 Nov 2022 12:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItxDpPRpAqbvZZHr07qhhxQmPJehVCNLqSw71HrxTxc=;
        b=DWRKubV2MC8OVFfGb+nU13mlp2BX7hAM1eut4rKlTMym7/NQ2fcKcGHYNKBh7HTtZS
         EXThdDSzO4SSvhOK/LiW/OM+29uGiTi7Y3JgwXLSJNN8+qc6D0bFkS/678RSdKUCGqzE
         +PYoX995719to5tZOzZW1J+QGAFHmwSDgL3WY1S9qUDmEaLjLqunOiit3PPX1GoPGjP0
         6e0S8EhjlPNXgHoHc6cYoWEQGlO+dXcLwztGHel50aKW1jBpLgzBzui65kIvrC3KiZcS
         /yIgPna37HHKG07VGReSbunA6KFNFKP4TkXItHdz6BiN/vfPBO6FbdQItxOGP/rt/7rf
         W6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItxDpPRpAqbvZZHr07qhhxQmPJehVCNLqSw71HrxTxc=;
        b=Rl2b6G9EcAXWDfg/PV85cU2u+ljF4tAk5tWDapBViQ0jYCSt+7t4zbTxNFGU4DF+z0
         /e/IMIV/IyTUaPL8pbHZF+XgFiW3oEWr+bqazuo1RfUc7qUsIarboZQ0IXJL7V13SbL+
         HvAghUUR0TixrxWCOgyEb5ZJbcOrVfTOjjXCpsLAlK8iEVgw8XYcCazA0qk6EiPvDJM1
         ZhlEfev0ohelNeWPU8zkGPmfn2ubIblYMkgPRzLKrnOgzyPkySyVVUc5Xeaem1a83ini
         Gy8LbU5bV1xD+Nc7SakIUeIHb+R/iFVttbLqI4yggFg9KdfZuNXlg8Td9yd+4p1jHD0D
         WFhA==
X-Gm-Message-State: ACrzQf19V1pEvezqfhAljHhhy8bRrXOUwZpyR9+oaHT2nWSZoiu7lD6R
        0HDt8wBzC/NVfFRkjLpzsOQ=
X-Google-Smtp-Source: AMsMyM7AIssMTtfAfidjKDntRSvre1lQc9phzpmbWoQTGwqRTUETIf2q29WnvywD1l2Z844x/hYQNg==
X-Received: by 2002:a17:902:bcc1:b0:187:31da:494a with SMTP id o1-20020a170902bcc100b0018731da494amr47640218pls.121.1668027249033;
        Wed, 09 Nov 2022 12:54:09 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:08 -0800 (PST)
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
Subject: [RFC PATCH 09/17] x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:44 -0500
Message-Id: <20221109205353.984745-10-ltykernel@gmail.com>
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

