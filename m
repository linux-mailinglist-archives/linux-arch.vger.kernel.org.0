Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB4777DA7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjHJQGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjHJQFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:05:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA52D4F;
        Thu, 10 Aug 2023 09:04:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bcad794ad4so8394075ad.3;
        Thu, 10 Aug 2023 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683467; x=1692288267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mqb14LBzHQf18FY7xszQiIf830qOZYbv6/JECgr54c=;
        b=ZNHK/PMcRaN1J6Uwf4XvlEjTLZCToZf9+yZtIIKSo2ubf0ljKFrx4TdG7NOe2sYyeC
         jz0rw/20j1wNn6bldu7tUiSDG9FUZEsB+X5CzBM/h9nbaMORoxB7m7mjTW6HZBlQ1067
         BgfRCPq7aWZyRej58WS+zzrakA7vsarfhWebuMQXw0CiLZpNSawGbE+jUlCitD9jkRby
         kNTjkOIEIkz0Yr2MI0L+vXOdQ2/et/UnqT8/OhDy414bX9KC7+Ndf4V/KSttvI4plofV
         VDUFc0Vl9CMlU374RSqMIAzgW5XBHHcoeCYApzABGsexevW/8CYgxEyE/OnwF35xU0zq
         cMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683467; x=1692288267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mqb14LBzHQf18FY7xszQiIf830qOZYbv6/JECgr54c=;
        b=b2KO+1iIdagmWjBizj2MkYJV7z/ei53Zjk/5RShhGIVdv00W9IxCP2xtKlEPrkauLz
         ZxkGxIvoU5W0VsjOcA6S2bRvyGeLcw1MaCCluR0HA3gjzUqz0lyUEBMr8mHqjWFYHm4D
         AxQOeGezf1XXWMMSCxxKOsstGkIvL6lodfoMKOAyiJ0DLF9mhQ0NVwfy/1ohyoNXoVp0
         YwLKt5a1KZkRy4lEm7ybJI3vGVsBS6ovCGSQvOY25gUncDCpMOmdGWghTKNoLDbh+KAu
         YNwwkZq7mqYNhag4LMuc7haExwUoHcAKSzKgFRA0Pg5Uu2sj7xoibclnqprXAjHEgU5V
         Fojg==
X-Gm-Message-State: AOJu0YymlRpIOpnmgbnR1cd1pMj1mm6bI0KDwO9iWMcTg5OxzC1AHEWC
        t4M2+rUfR1gnOiW+LuG2Nh4=
X-Google-Smtp-Source: AGHT+IGDfkOHwca5fPXnRlQEUslRBVsuebVN6Yg0yPLbPoFIvui+C5xDRGe4A7a1SRGUhSlWRjQa5g==
X-Received: by 2002:a17:902:9009:b0:1bb:d280:5e0b with SMTP id a9-20020a170902900900b001bbd2805e0bmr2062451plp.18.1691683467253;
        Thu, 10 Aug 2023 09:04:27 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:26 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V5 4/8] drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP enlightened guest
Date:   Thu, 10 Aug 2023 12:04:07 -0400
Message-Id: <20230810160412.820246-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
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

