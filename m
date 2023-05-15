Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C8703599
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbjEORAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbjEOQ7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD0A7EEA;
        Mon, 15 May 2023 09:59:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so8921038a91.1;
        Mon, 15 May 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169980; x=1686761980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zQXnge0b5ZqyPL5Rd5uANtDut+QBzK0iKFoX0pFkxQ=;
        b=BvU+b2eSYafA1CZTNC996wjbIPyvv1JH75praEmQOdo9/xKZDc9oZ/t4Rp2Lc/ZYF6
         ir/dYi8ZeZgOtkG+k9ct1MCVTw7eHFUParr+xk87Cntnv1XY/978lHlR2sQN/rRNQgz6
         4hA9Bt/5l0BT9Kq+Q29ui+v/3Ril4eZ6u9RqKb6lbmcM587rs9MQ4XOCqOyiHnxoH2IN
         1FfBen7YgCx8lobJKl4Gf9Ek/cNN6z6U2UswRbm71IrEx95MfPo5QF98+M10wbbHv++P
         zPZay86Z8Ce7g6e8SGZ6smJSqPLehsNMzv4jkrXVUqbpzR3kjFqgEp83+/FXj8Q3BYKk
         wTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169980; x=1686761980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zQXnge0b5ZqyPL5Rd5uANtDut+QBzK0iKFoX0pFkxQ=;
        b=ePbo/n/qJlwO1ejG2DZXwJGJdb/azBz/oZ2hLXUIk84Me835TLZ6lIbpeF8EspeBiB
         /QWZ2d8NgQl+USgG1JmTy3tly7qwG9l7bg09IaARo4E65KTtjrKsgBWIPQeYbhQCbDl5
         AFe0GheVU1fsI16BY3jZVboDIC3zSoCuJXCNdTi1aVdbeexFgyuAiu9iBrZC14Wfe+8R
         9NcJ2/bZqUHS2zKf/wfPKEH3p2G+SNmwfA4ytK7Gvku++SxAsW9HkPldOd7bHzucbb/l
         0TtVnGIz2Kg79f1lZ2dpSzhXvxBW0a4tP5KWFj/4z/isLWJARIckJrk09CpqNrMgX3PI
         WkEQ==
X-Gm-Message-State: AC+VfDzxm3WYSr9S62V3EctHTTUl3W13S095GqqLizLfP3jEKjTLa5Y5
        +s/AxIn7jXMndNsc4Z2KIu8=
X-Google-Smtp-Source: ACHHUZ6dorhuumzAo51DEW+/w6COB7KAFcyeCLzVuXhP+J+cY7L3VU0HQor4oOFTEtyhZzzIOAmnbQ==
X-Received: by 2002:a17:90a:de91:b0:24b:2f85:13eb with SMTP id n17-20020a17090ade9100b0024b2f8513ebmr33622082pjv.30.1684169980288;
        Mon, 15 May 2023 09:59:40 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:39 -0700 (PDT)
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
Subject: [RFC PATCH V6 10/14] hv: vmbus: Mask VMBus pages unencrypted for sev-snp enlightened guest
Date:   Mon, 15 May 2023 12:59:12 -0400
Message-Id: <20230515165917.1306922-11-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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

VMBus post msg, synic event and message pages is necessary to
shared with hypervisor and so mask these pages unencrypted in
the sev-snp guest.

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
 drivers/hv/hv.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index de6708dbe0df..d29bbf0c7108 100644
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
@@ -123,9 +124,29 @@ int hv_synic_alloc(void)
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
+err_decrypt_event_page:
+	set_memory_encrypted((unsigned long)
+		hv_cpu->synic_message_page, 1);
+
 err:
 	/*
 	 * Any memory allocations that succeeded will be freed when
@@ -143,8 +164,18 @@ void hv_synic_free(void)
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

