Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD873F2AC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjF0D24 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF0D2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675942108;
        Mon, 26 Jun 2023 20:22:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso2944637a91.1;
        Mon, 26 Jun 2023 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836178; x=1690428178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCJn92OFxJwU4IHGtLWMi2EWhzMeBfc+oQquYxaIu1M=;
        b=JbFLkeTaVejKuX3CeuGv44gh+qkdefxVqrHJOKNTDrxVRruZIyb0M4GfupBU7MRgwl
         1QfqHrNFWnAlAX2c5vvQb8CfQ5RUudBYAnrzYxc3UQXsEwEMgi0RUWDwHVy0VABtOKzJ
         gbPlb/iif6JFZDpEhAtRTb9N5Tt2d0HR+RfKjSqDxf+JnVvRBjWqbhaOBBLlJ71VrfPk
         6AdarjmdqyR9xzmP60NECzv9U31LlPl+oShpHXyuo+sD0sAEmJdm9kH1mmMLbZ/7dlwa
         TITD2U9Vn+cNuhwpLsKNN9W75FiETCk5KH5caVuvoPwkLasWTxo6KJ0l3dhCITCJhW8h
         DpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836178; x=1690428178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCJn92OFxJwU4IHGtLWMi2EWhzMeBfc+oQquYxaIu1M=;
        b=bxyf/xcAFvF2H/2yffRdBnGLEff95l/d5hoPYUzA9wENdHJgqt53FbXJy6YyNuYZnZ
         1yIEzbArOapenrPdNRvjof+0ki9XJdHRaUmYhYT6PUXDL/EHTpux5GFJqyhM49xbv/TZ
         EVrOOn0eDwvS9Qk5c+IYNys3QdPf0qlRfPpDh0uZt6VQqNWXtuRih9pJ7/smmTKyApFh
         L2kmqnIBU+SCAcKz+E+a/MBqxsAcp6/esLZX/Tj8yiGpAZYCssK108Ktjd1aYd832iAQ
         2TCE+o+UF/6F5pAuaic/sHUwJ9SEHOzqP0B7sI4DWv3zhisQvxtE74B5ffvc5bTLlPPz
         /XEw==
X-Gm-Message-State: AC+VfDyL6h1iIPiq98LUkDECKVjtKlvC/EcnjhXXTl0Blj3oa/LwaFjW
        2dWViUsUthid/zsaIeIlyaY=
X-Google-Smtp-Source: ACHHUZ6xUaoHETrF0sYVECWCZl94G6tgLgn2yn3bb75M8xNPWyXBvNdjTmpYwLzROpQDxClSo7nrZw==
X-Received: by 2002:a17:90a:7042:b0:255:cddf:a0c8 with SMTP id f60-20020a17090a704200b00255cddfa0c8mr29171624pjk.41.1687836177773;
        Mon, 26 Jun 2023 20:22:57 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:57 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 4/9] drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP enlightened guest
Date:   Mon, 26 Jun 2023 23:22:42 -0400
Message-Id: <20230627032248.2170007-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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

Hypervisor needs to access input arg, VMBus synic event and
message pages. Mark these pages unencrypted in the SEV-SNP
guest and free them only if they have been marked encrypted
successfully.

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

