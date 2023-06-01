Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18F71A23A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjFAPQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjFAPQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74792123;
        Thu,  1 Jun 2023 08:16:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so1147692b3a.2;
        Thu, 01 Jun 2023 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632593; x=1688224593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clSqwvV8e8hE1TuhQU11+QhpX7lJNDmKO1n9lfx7mM4=;
        b=OI4ATCIYKZicRB0N0Yt8sJeY2C1usR00xZNQlBWNljmBppiqTm3fuHvV2TvUPLWGVM
         5/F/XmPbc0A+BIaW2XARN2cb/bzYWd7mtLKERQZVy+ODTG9v8+8tDq3K6F3oksJXxg0F
         mM11bWWfvJVmTbaygKmhGaQPOdG48kS7eUBbMnxLtqN0O1dlHiBLakNRTcCdZUeIYyfk
         UoSRPfwYTxhOdE9Rdi/WC279pnApYhoaFfkZw3mA6ejNYL7FAS3GPqWMF09vc+U0Cm8E
         72SWYUYbZr7bx2ochiodYR1TbiHj4cJXUyCgmuJRCI6dARsBnB/7h0fv/neaQjaPf+bv
         ogPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632593; x=1688224593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clSqwvV8e8hE1TuhQU11+QhpX7lJNDmKO1n9lfx7mM4=;
        b=VnrGL1LKSzxHL+Lu2XUIEG/TNLlK5ak0pWatrNO3VOanQoIB7aeso17D0l7SziBfPQ
         VtCJMjEuKjHalJIxx/yssM9aP1H8EzZzpdo29IQCHSQBsCvQfPFu/EwYicgAHSDVhBMY
         1kGym3dN9UUISjigDlHUAtzyga5kUz6NIcqObTahJK6zRF9U7yeGWXIVujUtD6io7WD3
         g5DtdpRCxUXNbbll752qVMPuxj3L3UkIh0GVcldi6Tb5OJiTKyXd9OwALCnuCzPeA+Vr
         feeBiGhoBF5QtJICpkoe2Z+5Jl2R/I1BTbmppSYaloGCO6vyuzUXbnYlIr4Zgzfh8/zG
         Pw+A==
X-Gm-Message-State: AC+VfDwpdv+LoeAzfv6DM1g7iJXNaqhZPlfbxKxK9HeytVqGwHR+QTqi
        5BXW1AMPHzo6t3RigM8vR20=
X-Google-Smtp-Source: ACHHUZ51GG6uw4brx2GnP4zAGM1DxxWxYJ4G8guSFBHMWFO3VEUjSaaP7bMR7BEbXxRYKzzoln/OqA==
X-Received: by 2002:a05:6a00:15c7:b0:646:6cc3:4a52 with SMTP id o7-20020a056a0015c700b006466cc34a52mr11759587pfu.3.1685632592889;
        Thu, 01 Jun 2023 08:16:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:32 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in SEV-SNP enlightened guest
Date:   Thu,  1 Jun 2023 11:16:17 -0400
Message-Id: <20230601151624.1757616-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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

Hypervisor needs to access iput arg, VMBus synic event and
message pages. Mask these pages unencrypted in the sev-snp
guest and free them only if they have been marked encrypted
successfully.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++++++++++---
 drivers/hv/hv_common.c | 24 +++++++++++++++++-
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index de6708dbe0df..94406dbe0df0 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
+#include <linux/set_memory.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
@@ -78,7 +79,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
 int hv_synic_alloc(void)
 {
-	int cpu;
+	int cpu, ret = -ENOMEM;
 	struct hv_per_cpu_context *hv_cpu;
 
 	/*
@@ -123,26 +124,76 @@ int hv_synic_alloc(void)
 				goto err;
 			}
 		}
+
+		if (hv_isolation_type_en_snp()) {
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
+				hv_cpu->synic_message_page = NULL;
+
+				/*
+				 * Free the event page here and not encrypt
+				 * the page in hv_synic_free().
+				 */
+				free_page((unsigned long)hv_cpu->synic_event_page);
+				hv_cpu->synic_event_page = NULL;
+				goto err;
+			}
+
+			ret = set_memory_decrypted((unsigned long)
+				hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
+				hv_cpu->synic_event_page = NULL;
+				goto err;
+			}
+
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+		}
 	}
 
 	return 0;
+
 err:
 	/*
 	 * Any memory allocations that succeeded will be freed when
 	 * the caller cleans up by calling hv_synic_free()
 	 */
-	return -ENOMEM;
+	return ret;
 }
 
 
 void hv_synic_free(void)
 {
-	int cpu;
+	int cpu, ret;
 
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+		/* It's better to leak the page if the encryption fails. */
+		if (hv_isolation_type_en_snp()) {
+			if (hv_cpu->synic_message_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->synic_message_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
+					hv_cpu->synic_message_page = NULL;
+				}
+			}
+
+			if (hv_cpu->synic_event_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->synic_event_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
+					hv_cpu->synic_event_page = NULL;
+				}
+			}
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 179bc5f5bf52..bed9aa6ac19a 100644
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
@@ -387,7 +400,9 @@ int hv_common_cpu_die(unsigned int cpu)
 {
 	unsigned long flags;
 	void **inputarg, **outputarg;
+	int pgcount = hv_root_partition ? 2 : 1;
 	void *mem;
+	int ret;
 
 	local_irq_save(flags);
 
@@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
-	kfree(mem);
+	if (hv_isolation_type_en_snp()) {
+		ret = set_memory_encrypted((unsigned long)mem, pgcount);
+		if (ret)
+			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
+				cpu, ret);
+		/* It's unsafe to free 'mem'. */
+		return 0;
+	}
 
 	return 0;
 }
-- 
2.25.1

