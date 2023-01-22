Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF9676AAD
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjAVCqT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAVCqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1591A4BA;
        Sat, 21 Jan 2023 18:46:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c85so6559344pfc.8;
        Sat, 21 Jan 2023 18:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHCUEHp3mAbHZmlWLmQQYc0YJzSL3HZXdvwddGnkOCc=;
        b=ohzh5KtUBaY5tBTL+iy3zzV3Jw0Gc067IZMqxSpBcDwUUoamvPjeqJX7+DhPgS9gsr
         PxZqXNuOygoKSMFAJ7tXrYgBE/r8EUKAipdf7+sF8OmnfH5vKzuu2daJxduQKjjos3My
         a+fKiwyATUWJ/L5sd1SwuD5Jk6T3TYIM3juQXqEC043X9K/A7q0iahQOuFqbKYeA3mZH
         y8sgr7OK70Bdf7y8U17G8H5+ATQeegdhvJLjNpuKJz7y/Xlh79uiEjcZbVmeWtnFkJlG
         kFXWoFH76dpch3aSKiUvrE8bPgE18YgLRKdsq+YQo4Boda33rWYi59ou4gvp0MZOYABR
         +r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHCUEHp3mAbHZmlWLmQQYc0YJzSL3HZXdvwddGnkOCc=;
        b=CtjLkkuTFifA9KCBvYK0lI0yolzPssxiQLP2S5DQZBVYLyKAuOmc6OGzlD/Sg8box/
         EsuPNbrEP6ruGnZ0RuI/mUwHd/Z2IFPo2HHOr34ec3KUNhWiCvwPgUg5PHgStWF9tqHK
         20Pb5eLVGf54CD4bbmPxflWBpALMFEwWd+XA0nC/TJuCK3DgKLfGUDNKGOIe44iW3JYL
         YZCioNVg/fvtA/WRRViPkJPspp47swqGMyPBCOAioYCMleXrAOmA87wZCPvtXu64gp/O
         +EE1+JRT7HiJ0wT395Gdm8IymsR5xrnTHswILAZrVjwlyZyx80hRyxHSc9TMKMshJ/A0
         OCHw==
X-Gm-Message-State: AFqh2kolqCiKyj5xEX1bnMjBcZeSVis4UnutsIILw/dzzSSpyrwMaIRe
        RnjC/KlEsZHy3UC8gVvnB8M=
X-Google-Smtp-Source: AMrXdXto4cGvkFjx1YrN8a/m/MPWHwwzaLBtA1y93TPlRa3ZQX+QImrNF8XYtHA+bXpHs8tzvME18g==
X-Received: by 2002:a62:7b11:0:b0:586:e399:9cd4 with SMTP id w17-20020a627b11000000b00586e3999cd4mr40488569pfc.25.1674355574415;
        Sat, 21 Jan 2023 18:46:14 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:14 -0800 (PST)
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
Subject: [RFC PATCH V3 02/16] x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
Date:   Sat, 21 Jan 2023 21:45:52 -0500
Message-Id: <20230122024607.788454-3-ltykernel@gmail.com>
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

hv vp assist page is shared between sev snp guest and hyperv. Decrypt
the page when use it.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474f08e1..24154c1ee12b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,6 +29,7 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
+#include <linux/set_memory.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
 
 	}
 	if (!WARN_ON(!(*hvp))) {
+		if (hv_isolation_type_en_snp()) {
+			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
+			memset(*hvp, 0, PAGE_SIZE);
+		}
+
 		msr.enable = 1;
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
-- 
2.25.1

