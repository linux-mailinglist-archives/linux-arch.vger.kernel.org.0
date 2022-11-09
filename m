Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C06234FE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiKIUyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiKIUyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187913057C;
        Wed,  9 Nov 2022 12:54:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j12so18220865plj.5;
        Wed, 09 Nov 2022 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OVwfeSJzfcwy29SuQO6DhipoyIsaZzVhoPd/85YD4c=;
        b=FDTroFilQLGDfflzGjUgAatf0ynpsufMBvMTO2ZEAdxMmiSC4M/OK1UwnacuCWgnP3
         CJrE1effp7aJLou9UGFAcDkFXptac6YRUkroDZY+SHbELy1l2SovpUw0pr+Gamiezs/N
         Ib3+C+2cYr5zmlIzMoHB1Wv9YE6Ls6aqHrMZbKhaF0opvt5knPpJztMZhKqt3gquZyls
         FCDdgY217eFfguRSoMlBGvY9bjKVlJdlcSfilsOynxvXAq3jnJzGSAxYk4SjnKA9zV4J
         tXFS99yzSjhTAZdBC/T6vrOMqmzuMXZC6j2sOWeE0637hlNXW90pyYwY9V/ctfCWsrzC
         Zl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OVwfeSJzfcwy29SuQO6DhipoyIsaZzVhoPd/85YD4c=;
        b=tYwGy5TYDjIP/dRZi57IYL2doshpnJy2rohP2dqijhKUteL03fRnvrD4v0pug8L1iZ
         qqd+T6i1GkQXMUnWWq8QSp2hnWaMxpLi/GJYF6A733xTns8GcxiAkUqSgBXnLbe3M0Fq
         UQRvlVlBAi2QZ1Pri8LGy+rY+iVjd3pyseHDyPU0KuoR1ZUkxJV8c9D2o187AoCoM+MK
         IQYBSM4j/4y5tjAv9tWo1vadBcdd9Wz2qIzaqrzxc4gqpEAXHuANbbaWePkywSLZSe1/
         dhcz3j+2Dtc0dVZqUqxufBN/6DrGvS8aTU52qDNfkeXfBVhnpXu2HWlNGrJTUIvCm/3v
         e1qg==
X-Gm-Message-State: ACrzQf0jbB7gcIpgLwET8wwCDrVCRK7ee0vTkrBJtbt6sPLOrsc0/s8y
        Da7ih/aGSr2e29L60qlgsvE=
X-Google-Smtp-Source: AMsMyM51QnDjE8jacTonl20Ps/yrMWw1hYV4GJWuXRNnEuAYTMH5Cvr5nmHLalkrExw5ZbCVwEXPzA==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr65824831pjb.143.1668027243570;
        Wed, 09 Nov 2022 12:54:03 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:03 -0800 (PST)
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
Subject: [RFC PATCH 05/17] x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:40 -0500
Message-Id: <20221109205353.984745-6-ltykernel@gmail.com>
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

hv vp assist page is shared between sev snp guest and hyperv. Decrypt
the page when use it.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 29774126e931..4600c5941957 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -30,6 +30,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 #include <linux/swiotlb.h>
+#include <linux/set_memory.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -112,6 +113,11 @@ static int hv_cpu_init(unsigned int cpu)
 		}
 		WARN_ON(!(*hvp));
 		if (*hvp) {
+			if (hv_isolation_type_en_snp()) {
+				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1) != 0);
+				memset(*hvp, 0, PAGE_SIZE);
+			}
+
 			msr.enable = 1;
 			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 		}
@@ -228,6 +234,12 @@ static int hv_cpu_die(unsigned int cpu)
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
 		union hv_vp_assist_msr_contents msr = { 0 };
+
+		if (hv_isolation_type_en_snp())
+			WARN_ON_ONCE(set_memory_encrypted(
+				    (unsigned long)hv_vp_assist_page[cpu],
+				    1) != 0);
+
 		if (hv_root_partition) {
 			/*
 			 * For root partition the VP assist page is mapped to
-- 
2.25.1

