Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB3630B58
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKSDrc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiKSDq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:58 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7485BF827;
        Fri, 18 Nov 2022 19:46:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s196so6625641pgs.3;
        Fri, 18 Nov 2022 19:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkcTs/ArLjoTKDcTyzMU889nkY7DdVdas4PocmXRhm8=;
        b=mqftbILMyrMMSY0sRSnUOUKl4NdLFeLmvTIprm5l3ulZjOduQa+DKnjzXatyDsfod2
         5aMn9BhYRf4D7b3w6+k+76w5t/0HejkZAI76dYCA8Wk/r4lyaFcV54HtbPgllMGWHd6n
         G9UoXvtLawT5Jo/k3vj2l0JXU0KG+vo6jPGXihU6Z4mVDqj4y0IBpTVPcezUXYEA6Z6V
         cJuM5W6P/srgHZ328qfssz5u3cQCDzXXEWdhCkqf6JrXPuzveOosoYIxPREjoMgzQIP9
         QzfDes422LSjz86opbhLBm/QIXXRyGbJXmXvMJwHfD2VlJSjQatUdtiEOc8CmS54YSR3
         Vqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkcTs/ArLjoTKDcTyzMU889nkY7DdVdas4PocmXRhm8=;
        b=Q8EIYKAjGLtazXN2TjnoHVeHcx7At7JnNrw4ca7aJbgU5XyOrvHUHQI28CVqdQE/Di
         Wp+1oSSJpAmCfr2gdbi9ZWnDvPb/I7rlIcd3x5+a18rLfpqyqrXquL9s5vH/JXC70nhP
         qjQ0XW7IXXeo56uQ65p5EsCP03CtanpPnNg90pSIGqDYQFqYkQFbxAAxY13yneXnZ2ad
         Iz2LPrSp/Xlo69yMNFrO68rvl45G+1eGqAMeleXP98wtQZhGxUHD7QCtFOBnlTGSVxM+
         PNjasMSkxnkxP3FIiYBAtj2MDtsNkpwJIrTBqgYg+ioEd9COKf+C6HScU7lZ9qcKNTB/
         fcDg==
X-Gm-Message-State: ANoB5pmOqGI1VGeHAr/PuxHu7E9XXRO0SzMRutBZrASRH5QmPoVIqJaJ
        XxEEu0pgs8ILnWs3Vw+DhBc=
X-Google-Smtp-Source: AA0mqf4HTkeLEW7VU8wU9ICZbtzKyS4ZtKTO5JSSusDifWlB3yEYFfUMwdwkdGtSgPsQRfXJ5zEblQ==
X-Received: by 2002:a63:5308:0:b0:46f:cec6:8805 with SMTP id h8-20020a635308000000b0046fcec68805mr9278748pgb.612.1668829608401;
        Fri, 18 Nov 2022 19:46:48 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:47 -0800 (PST)
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
Subject: [RFC PATCH V2 07/18] clocksource: hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:21 -0500
Message-Id: <20221119034633.1728632-8-ltykernel@gmail.com>
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

Hyper-V tsc page is shared with hypervisor and it should be decrypted
in sev-snp enlightened guest when it's used.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bb47610bbd1c..aa68eebed5ee 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -364,7 +364,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-- 
2.25.1

