Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B375780A1A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359867AbjHRKaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359772AbjHRK3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5513E;
        Fri, 18 Aug 2023 03:29:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68872ca740bso602213b3a.2;
        Fri, 18 Aug 2023 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354569; x=1692959369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK1ZddS+rNufRS/GKTxQzyQuSHQUkfdsXPaNAIp4EZM=;
        b=Y09nw6b0SK1tbSSEt5zeMzd1yBFLjwxRX7GP5oHy7WZY2hKhrYyK0qDjoTxyrGMyZL
         XQvdKZr0agu5+yVDnsXGnI+OLtVu//fAkQfnbT07r0Zib+2T6q7GcjvrQV0bjHlfNVBh
         YT0TBH5utzCz8e01wQOvSOgYJhWOpBgi9K9toqm6L680Bkk6V8zWyJpGAuKVvLG2PSEB
         88j+tvcqLYJsdNYIyqgLX+u5udURHsRcZpClNJ+3N7jJWFHd3+mE/8Ne8NDN5QqLERXV
         v8o5oi9zLLzhtLWqHk/MoW3dkVRw5LFsEov9h70BFvRH7rJIvIlhWZ+xZNexwdCYuJal
         eYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354569; x=1692959369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK1ZddS+rNufRS/GKTxQzyQuSHQUkfdsXPaNAIp4EZM=;
        b=SuEyYnvOzpCA/u70nmMkS6dUDnLjbOi2u+VAN5dFSwRtScPBT8VrXCnDlXiqyzHOKo
         VkDt3HlzIP6Xu8fYx/HPoB9akoKlJ/y5i+0EMQC23anM4usaOG9YtzEwNGfCu54MrKZM
         +gs5T45mfb9o18nXjq3+c5n8CIBWf9+lq/pKbIJ4KqEAGOQt7wnU1szEkIVrWIsd4Yaa
         vudyFUc/aruliW8nPizfm94GfwdUpRazKOwN5VCg0MmLNPX+FltG+j1yUw1UYD/opLNI
         vgjgfGF5bDmjiE7hxVksN+T7xuaGsGd17N4r8cqNXv1Oet380izbokbsM709Wc8C5jic
         h9XQ==
X-Gm-Message-State: AOJu0YwNRQcsReOvAy6HtQ8vEmoMd6sar3mXZ+7unw6jnVTHVv6ScyQp
        MVOhBfL/1DudGpDUZIhUF8c=
X-Google-Smtp-Source: AGHT+IFJ/wtqJXz1Ev1z72p844hiz4D67zHKEpksvqLwSOU16v0cPYNyW9y/ItUG21qg/gDUD23GOg==
X-Received: by 2002:a05:6a21:3285:b0:13d:b318:5c70 with SMTP id yt5-20020a056a21328500b0013db3185c70mr3159975pzb.19.1692354569305;
        Fri, 18 Aug 2023 03:29:29 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:28 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 4/8] drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP enlightened guest
Date:   Fri, 18 Aug 2023 06:29:14 -0400
Message-Id: <20230818102919.1318039-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
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

Reviewed-by: Dexuan Cui <decui@microsoft.com>
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

