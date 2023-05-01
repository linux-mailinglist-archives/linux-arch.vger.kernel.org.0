Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55206F2FAA
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjEAI55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjEAI5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02C10E7;
        Mon,  1 May 2023 01:57:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaef97652fso6860855ad.0;
        Mon, 01 May 2023 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931458; x=1685523458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9rBUX8zxYLON2WeixMYcynqQit4QqOsD7fiqT8bXlg=;
        b=ozIKeWZGvO83qG/cO/jf8e1+md4Qe61e7BWRvVR0LTuFi7buO0Fcf+2hPdnr2F/BMo
         GW5YSzUDtx5XEJfQIYgOqSRHQbZ/RBZEHR2pVmpOoz4GjvaqgkJcwFBqJxy08OoO3Bic
         tdHcV4Sy/lyzse6vbOHhgsE8qxwmQqW5+BaHlBG3C7EdnzL4Dv/tyJjgQN6a9OuYKNVO
         MCWO1nJo9qgFdJrLmOId9XwLXOcPEi5CLNQ7De6LavPg7EIzwtiph2AmG13Ky0LylGNk
         eUMGhnFeaxt1N8yN+1yDiaFipBvisaTZwRexB05/+8L/cLvQis8EFH0siEIG5V4QYznW
         OLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931458; x=1685523458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9rBUX8zxYLON2WeixMYcynqQit4QqOsD7fiqT8bXlg=;
        b=I2wOnIBDvhHP6A9BUkoAv1ek7a7Bm13o1BTXtYf3Ejj61fCJNenw2EhoVhnEses8kr
         vfv6RC8MprDlEHwhS3TOky+REa+i7PtZDPL7Ad0YEJgKl8AiZKGSyVD3w7F7m2MxFBKV
         sI0DEEINzpq4BnFqvP5bgPuq5f/7qtBXxmyAYxl2u76LTfmi9nxVR38WeuJyW0pw9f4T
         0OHH+qfMz7aYDc/8YVtpff0MtseMoq/Iz64150FS/6q2jHtTE9cqc0rbD+wX0cPPwRzC
         +K1hLmQgn1qDZ1wBEuxNaTuYU6m4M+V0o3Xuywa8bUXsD1u2Y9t3WrgexBIIct0wfiYB
         wFsQ==
X-Gm-Message-State: AC+VfDzlSOCFRIAqkVXlzvnJ7541ZM5BX1UUZq7fU//p4JCyUI38O7gS
        QviInTRJa5EYLatENCgBmd4=
X-Google-Smtp-Source: ACHHUZ4rmtLo9X5FX1EH2LFsyhl6zwT7dMFc8tmW7JszxA6dxI7beKMcYvQfYhI9ndI4WoY8Db80Yg==
X-Received: by 2002:a17:902:ec8a:b0:1a2:afdd:8476 with SMTP id x10-20020a170902ec8a00b001a2afdd8476mr16497385plg.2.1682931458294;
        Mon, 01 May 2023 01:57:38 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:37 -0700 (PDT)
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
Subject: [RFC PATCH V5 06/15] hv: vmbus: decrypt VMBus pages for sev-snp enlightened guest
Date:   Mon,  1 May 2023 04:57:16 -0400
Message-Id: <20230501085726.544209-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
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

VMBus post msg, synic event and message pages are shared
with hypervisor and so decrypt these pages in the sev-snp guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change sicne RFC V4:
       * Fix encrypt and free page order.

Change since RFC V3:
       * Set encrypt page back in the hv_synic_free()

Change since RFC V2:
       * Fix error in the error code path and encrypt
       	 pages correctly when decryption failure happens.
---
 drivers/hv/hv.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index de6708dbe0df..e0943db51acd 100644
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
+	int cpu, ret;
 	struct hv_per_cpu_context *hv_cpu;
 
 	/*
@@ -123,9 +124,33 @@ int hv_synic_alloc(void)
 				goto err;
 			}
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
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
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
@@ -143,8 +168,18 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		free_page((unsigned long)hv_cpu->synic_event_page);
-		free_page((unsigned long)hv_cpu->synic_message_page);
+		if (hv_isolation_type_en_snp()) {
+			if (!set_memory_encrypted((unsigned long)
+			    hv_cpu->synic_message_page, 1))
+				free_page((unsigned long)hv_cpu->synic_event_page);
+
+			if (!set_memory_encrypted((unsigned long)
+			    hv_cpu->synic_event_page, 1))
+				free_page((unsigned long)hv_cpu->synic_message_page);
+		} else {
+			free_page((unsigned long)hv_cpu->synic_event_page);
+			free_page((unsigned long)hv_cpu->synic_message_page);
+		}
 	}
 
 	kfree(hv_context.hv_numa_map);
-- 
2.25.1

