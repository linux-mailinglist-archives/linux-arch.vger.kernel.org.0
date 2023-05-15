Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58E70358A
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbjEOQ77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243377AbjEOQ7s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC637AA4;
        Mon, 15 May 2023 09:59:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so9579552a91.1;
        Mon, 15 May 2023 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169973; x=1686761973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj1rg805VeXOzoRW2P320xFoUthoXwFzXIHBhX44V0E=;
        b=VTKVHLjOWHvcasfBNjghCkChlsRhIg/JX5bBH2I3XS7KpClIu2unj1wv5TWYaBarOn
         zipMJC0Zb4GH6fdn7Pdqaho0gd+5rSMtNoUiz+R5UvSdH0c3839ZpE0IP2AdGuJe1ssj
         SLWUUgA9TrOfRVZylWtSdzMaDIRvmQUp+kyAQa9BBKzJ19qY+cbPjdKYoo0gHg+45e/A
         lSt7AO4bbjL1TATAAkzsseIdt6ce9FrK6SyQg06vWnvXxTnyoWXuRrpnm9rRpxnP09mv
         B7vDBhi+JSYZEMhxPZdu6uVTOm1uKGOLA6VK4gVXqQmp36fJFxyBgVw/DHECF3opeAea
         D/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169973; x=1686761973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj1rg805VeXOzoRW2P320xFoUthoXwFzXIHBhX44V0E=;
        b=fBm8MZOc9PfFUdpwgQZQJ5WdjJcahb3ph1XCCfcfD4KkBfnMycqqMbVGIOyyo1uk+e
         EMtMxkJRTp3THfCSlMvCIXNuObXSGXwp81+/Hbx8jCVsF8qAQ0rJDLlILbTbinHOYpaD
         BhZCXwF+uslWTCuxSI6E+LwEQm/qaCjORl76LBOirdgHq3A2tW0qb2auAaI8pGMbxkTr
         rgWzAOc5tI594Ka2l63GsRjkh518stu7UPStnzU2d2nIyeamp4ZAe3/p7KPXpYbNQKQY
         WAyPengfmRaVKmJzXKMf0QtZTXzItiFJQzQeXECILUojF29OJW6zGvD1ktwqUGxwuxJh
         /zBg==
X-Gm-Message-State: AC+VfDxsbBxAR+bzzzgfYlWV1Vk1ooU6nyqxjUekgFfTDEQSucs7vAVE
        +QF9ttRg71Cw/KQs+aAOYBg=
X-Google-Smtp-Source: ACHHUZ43s6yfVrKt4NwTH4gtV3IDP9GaE1j4t6MKMEuL+TwJlQbJVog7ei/qZxfmZvmvHcYVpL2t1g==
X-Received: by 2002:a17:90a:6046:b0:252:89e6:dea9 with SMTP id h6-20020a17090a604600b0025289e6dea9mr15910674pjm.37.1684169973595;
        Mon, 15 May 2023 09:59:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:33 -0700 (PDT)
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
Subject: [RFC PATCH V6 06/14] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Mon, 15 May 2023 12:59:08 -0400
Message-Id: <20230515165917.1306922-7-ltykernel@gmail.com>
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

hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
So mark the page unencrypted in the SEV-SNP guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474f08e1..9f3e2d71d015 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -18,6 +18,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
+#include <asm/set_memory.h>
 #include <linux/kexec.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
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

