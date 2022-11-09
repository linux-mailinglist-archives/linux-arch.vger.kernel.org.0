Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D8623510
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiKIUyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKIUyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51B21E19;
        Wed,  9 Nov 2022 12:54:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso3031647pjc.0;
        Wed, 09 Nov 2022 12:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHfQ2xg7TSoUMJoNFBa3Rt6P1l7onXyfXsIWqOdHwnM=;
        b=RoWVDilVrKK3rtGd+U699PreMvaGOIMTIX/XykJMqP42PVj5Iq81ahH3L4F5hFZd0A
         5vwnAKhGAyYFY1inoHLhxMpldICCqv39wySi8jY72iSrUdv7kVHC1+SzUzGZqdjtt/lo
         J+DKeLS4leA20VZkn3g1/ZNeD9reIEbRSspL6Vz7NjMQVMiW6wfLnWgR39NFn1t+Gbi3
         8T39p8AGxmUs/k4xhYo9RmMr68dFWHgosRw2b5nfUx4HJBVZuA6ch7OGhI69k+qGwISx
         e3pBmQMTB0YSeHhn9/A6CeHiKhO0ebf7eZ6hAsdavCsn5Alxat+YYvoLQy5PRJI2crN0
         CT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHfQ2xg7TSoUMJoNFBa3Rt6P1l7onXyfXsIWqOdHwnM=;
        b=L+X2+X/21Qy++Ah1vVGwZ+DObeOIB9mfh+Q1C+DSUO3jrHY21IC92ZwlCF+zK2+/e0
         81SG5EuLORYBtlECmhWQE3dZaBL/6Wv8JZCtYiHwWB+bjGxbnud/GqY2Hg4Mbwl+5C5k
         ernDPY8WpjFrChXhevEQw480korWiTDjgerLQT42ihQ2JI4TP4AgEkn2CQOZB/WGaDDg
         ILhcMb4k1aimx2zr5Aw8JFqqXlnUlBWVTgWnu1JP1Rmwk03xKuM7+qhkQ9nOlumRb62b
         5CQDUY7lz9BwE6qbWl1xtGMp7ERje1a9hlz5eErgKUQY4HWbJ6EHSqPsroHwYxz4EgmC
         nfOQ==
X-Gm-Message-State: ACrzQf3rvB9zYjQgnB2Vx8PSSKCTwiqqSP4dkRx9+rwFTBIkx4xYtR7X
        izZglTbAk5UheEH5JqDgUtw=
X-Google-Smtp-Source: AMsMyM5JzC6xTKJnfugh/fefFqIJHxrJc+UP+NLYmexS0BeRNfMrmpTXylZsm2XxZ0ULmf4HQIg2HQ==
X-Received: by 2002:a17:902:7688:b0:187:403c:7a2b with SMTP id m8-20020a170902768800b00187403c7a2bmr43513901pll.85.1668027253050;
        Wed, 09 Nov 2022 12:54:13 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:12 -0800 (PST)
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
Subject: [RFC PATCH 12/17] Drivers: hv: vmbus: Decrypt vmbus ring buffer
Date:   Wed,  9 Nov 2022 15:53:47 -0500
Message-Id: <20221109205353.984745-13-ltykernel@gmail.com>
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

