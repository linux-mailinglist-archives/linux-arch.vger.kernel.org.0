Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4B77045A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHDPXX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjHDPXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AE49E8;
        Fri,  4 Aug 2023 08:23:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb2468257fso15359465ad.0;
        Fri, 04 Aug 2023 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162585; x=1691767385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mqb14LBzHQf18FY7xszQiIf830qOZYbv6/JECgr54c=;
        b=ewvQeUgLX6uTQYq5z+/mwfrbq4AC2eOnbFrL/5kRmyq2f4jlf/xYcxMpWbG6d/BXrL
         eBmvRd9CHMu9sDx0RpP/OqJL4/itItEZBb/+2OFBdm0TwdYXn9DsQQXyMzcL1eLEcl/7
         WjrmB9bpJQzkujo2l0f+iQZdS+PNfh41LUc2W2f668oHSEes0vD5YvTvvE0poRIe48B6
         qGMvE6YLdrC4dSz4lriKsubc3DiEbDTS3f/3I48lFnq10fn4ridNgf83USuJP5ceiUEQ
         FciLzAddIcPdlnZrVtLAL7BuKRbsIwmkHmYJ27mgjk00SFY/6OsRVhaBUe5vmIbRUMEm
         2zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162585; x=1691767385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mqb14LBzHQf18FY7xszQiIf830qOZYbv6/JECgr54c=;
        b=kDYEGPRzX1mI4VYW8KcVX6/i1SMyaO+kUAulx+n3ZPSxQNHjBOSixNDO6v/DUTlDRT
         OrKxPT+rsfWd3F3zQAZJ/X9/l6/nlaVEkjPuzF4c9aSJDqt+9JCOybghf8Qp7R+Bu/ro
         TC+AHf4Kbz9JqZ19k+vKj42Qs4sqY9jUDAN2mAKaEtb9h1L4OqQ3kuCOehelw0uyYw7V
         retGirYjgF0LGRxrPDiNe7fnSiQ8QWgkHIydsboDgXd5OX7BZfIcNjzU07xQc98A5Cki
         th9uMfRHIT8OUjnYvuRfjf3X0aD3AblPOBnyDZnU+YkQUwlUa2V2zVl1q1HYLkkpSRBB
         QLQw==
X-Gm-Message-State: AOJu0YyiG1SW831zW9Y7J+lmKXU4ewsUV/naQzi75W0bqYXmv+7rUAZ/
        d9v4pK0Jqhp/pFgeWr61mro=
X-Google-Smtp-Source: AGHT+IFmt3M5cnByO3chMI3TIBi8vIEc46DWv3PD+9W2jBUAsyW6M88GX/haxdq1VMxhc1ms8gFBCQ==
X-Received: by 2002:a17:902:b201:b0:1bb:94ed:20a with SMTP id t1-20020a170902b20100b001bb94ed020amr1640568plr.24.1691162585503;
        Fri, 04 Aug 2023 08:23:05 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:05 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 4/9] drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP enlightened guest
Date:   Fri,  4 Aug 2023 11:22:48 -0400
Message-Id: <20230804152254.686317-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hypervisor needs to access input arg, VMBus synic event and
message pages. Mark these pages unencrypted in the SEV-SNP
guest and free them only if they have been marked encrypted
successfully.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++++++++++---
 drivers/hv/hv_common.c | 13 ++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index de6708dbe0df..ec6e35a0d9bf 100644
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
+				 * Free the event page here so that hv_synic_free()
+				 * won't later try to re-encrypt it.
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
index 4b4aa53c34c2..2d43ba2bc925 100644
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
@@ -378,6 +380,17 @@ int hv_common_cpu_init(unsigned int cpu)
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 		}
+
+		if (hv_isolation_type_en_snp()) {
+			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
+			if (ret) {
+				kfree(*inputarg);
+				*inputarg = NULL;
+				return ret;
+			}
+
+			memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
+		}
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
-- 
2.25.1

