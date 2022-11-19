Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD8630B6A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiKSDsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiKSDrG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB88BFF67;
        Fri, 18 Nov 2022 19:46:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m14so6119104pji.0;
        Fri, 18 Nov 2022 19:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHfQ2xg7TSoUMJoNFBa3Rt6P1l7onXyfXsIWqOdHwnM=;
        b=p7wzlQcXuRaSIC6PeeE++lmR7XnrDFVT5YTYvnC4lth3AZIUOaMSkbgVGFQqOKOtz1
         q/kfQynPzZLbZtNfW+R3Vs6Uprf/d1Ub4tp0hdsMRVMHNBNiXVVdoldrZN6vD7leJ46N
         ks3cVYzKSAEozqNDHUx0mQZnacluhbffwbLvSF58+MQkXZO3xFecGg9/xhPTfMm9oBVh
         lQHQ6zon6yB6Ve8DW352Gxi85rH6/MSzEdWS7rpv3BxYYvd5hbrFaGPGMSO24pUhqrLa
         nzZGkTN9VwCi+nojCKLDkLlUsvyPaaZR3NfA0KCUsn/xkOyfgRvz2dLA4GS/mGffCLcb
         fm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHfQ2xg7TSoUMJoNFBa3Rt6P1l7onXyfXsIWqOdHwnM=;
        b=cay6VYGaXIabscLFgUGcnVM4RmP0AiKFKfXXC7InbUBAr8Z5TaTSxMJq5zEl3UbZWE
         rzU8A7JltSZivoC/i391Y2a3VKz1wfun2LI30CgugS1wHp6vQ8i32WDM3fZBm5cGySGd
         eGNCPBA8ELx97GUcjiksctWk6nuHHM2wCv3QthElGyKO4/vrdtyTzoHP1XyXcDL8hxjs
         AygV52KgAmE42McMPh9i0DfmKZxNUA4pmEY/3dWQq2U7f5cqJoVVMb6UIgpOLG9aidCm
         bWUl3+8XgUv/C7Nlpb2oj4bxAmMz7uTKizcpH08a1ndlqmbCVK1wTX2F1KS8xTNEq3BW
         2/iQ==
X-Gm-Message-State: ANoB5plTy0SW38+qQJTnbAPBNc5SuPazyfdTU6eFUS1zgnh6VtoZQ6fY
        EAnSQs266Ufe/Z5UhEcZdIQ=
X-Google-Smtp-Source: AA0mqf7Klwt7zuSS5Bc0Ck/gVlzg6wPps8ApHYVA792N13f9ScivIPhHN4zDt0S1CpfGCmrimlbxdw==
X-Received: by 2002:a17:902:d88d:b0:186:cb27:4e01 with SMTP id b13-20020a170902d88d00b00186cb274e01mr2334256plz.139.1668829613896;
        Fri, 18 Nov 2022 19:46:53 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:53 -0800 (PST)
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
Subject: [RFC PATCH V2 11/18] Drivers: hv: vmbus: Decrypt vmbus ring buffer
Date:   Fri, 18 Nov 2022 22:46:25 -0500
Message-Id: <20221119034633.1728632-12-ltykernel@gmail.com>
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

The ring buffer is remapped in the hv_ringbuffer_init()
and it should be with decrypt flag in order to share it
with hypervisor in sev-snp enlightened guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/ring_buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 59a4aa86d1f3..391995c76be7 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/io.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
@@ -233,14 +234,18 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 		ring_info->ring_buffer = (struct hv_ring_buffer *)
 			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
+				hv_isolation_type_en_snp() ?
+				pgprot_decrypted(PAGE_KERNEL_NOENC) :
 				PAGE_KERNEL);
 
+		if (hv_isolation_type_en_snp())
+			memset(ring_info->ring_buffer, 0x00, page_cnt * PAGE_SIZE);
+
 		kfree(pages_wraparound);
 		if (!ring_info->ring_buffer)
 			return -ENOMEM;
 	}
 
-
 	ring_info->ring_buffer->read_index =
 		ring_info->ring_buffer->write_index = 0;
 
-- 
2.25.1

