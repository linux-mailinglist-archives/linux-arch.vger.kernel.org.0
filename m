Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974E1676ABC
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAVCq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAVCqV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC8241C5;
        Sat, 21 Jan 2023 18:46:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 20so6544918pfu.13;
        Sat, 21 Jan 2023 18:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypt8rOlpcZ57Jgj8tjQGhQ8hwNv0NioxEBqSRz1HFqM=;
        b=D+cfF0+q0ri2SJ63SThdYX9OYn9naocQhZotGE3aFblCXcxPKG6rdt+MWm4RfQtDTN
         BnjVFkRrD8OOHbYI5SQgtEYgqCVSfoyfZuI12ofbmulZ753D6dx05uvRJc02KMICe6yB
         7tjsD1HkoRDwvg2JKlt8FZz7MMpySG2KmtYz9pZO70OlOq6Vbhr+Sjw8lxPq2e6ygIFO
         x/1BYjtx2ASEEu1341hfQTG1EOkNOThpI+RXCgdovQhTSF1MyAwgzgNYeI9nysaDsySE
         PYYJc0mvdF4PWYGIrw5DQyr1ryOkQWn38IhSiC0STq/v7QfapptwrGsZXo2QWwV/8PJG
         /Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypt8rOlpcZ57Jgj8tjQGhQ8hwNv0NioxEBqSRz1HFqM=;
        b=bnUomJ/1u477QjxdeXd9lnmW35ggyDN2YktA9qVtS/nKBm4sR0P5jt6qorBNbzybtT
         b8sejJzS7KNb+TUXoAEwYxFFWc1fADTZA+Awbrb27nWm7kWcY2G3aZAf57iGIBjV/uVq
         M6WudQHmoqZYMejjQgkSjcNEpnCdua6GSwa40aGVLD5MgiQ47okjVAMbxsnYx/qsckim
         pv1Tb80BFyNi8zwp9+/+qXmftvjHIE4NOF0WrgUlX4kSOsj1lXetXFaZJRKPYhnLyU5J
         cdwBF0jPBphibXJ0KN3GapxE3m8F5lcM1cPFwc9x638TIT+o86TYNmcaIhhuAvnJA7//
         cC2w==
X-Gm-Message-State: AFqh2kqfLG/TagM07Z3KT4vW7/sDymETEpV6jqZVWFb3gk4o27Tv9Kan
        7yARnFf71o5AyO3zaw6cwOg=
X-Google-Smtp-Source: AMrXdXuZ/N8ZLDYZyqEoDk0CIevFERWDutOFClkUDxLpyb18/F0PowncaQPo+LPD1tiyrNCTEDgt4g==
X-Received: by 2002:a05:6a00:4519:b0:58d:f047:53b7 with SMTP id cw25-20020a056a00451900b0058df04753b7mr14257689pfb.3.1674355580161;
        Sat, 21 Jan 2023 18:46:20 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:19 -0800 (PST)
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
Subject: [RFC PATCH V3 06/16] x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
Date:   Sat, 21 Jan 2023 21:45:56 -0500
Message-Id: <20230122024607.788454-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
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

Vmbus post msg, synic event and message pages are shared
with hypervisor and so decrypt these pages in the sev-snp guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V2:
       * Fix error in the error code path and encrypt
       	 pages correctly when decryption failure happens.
---
 drivers/hv/hv.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 410e6c4e80d3..52edc54c8172 100644
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
-- 
2.25.1

