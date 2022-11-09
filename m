Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DF6234FC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiKIUyN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKIUyI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88727FC2;
        Wed,  9 Nov 2022 12:54:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 4so18272097pli.0;
        Wed, 09 Nov 2022 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkcTs/ArLjoTKDcTyzMU889nkY7DdVdas4PocmXRhm8=;
        b=CeIjZ46bLRYBnpVZLrKAf8VkB2W1fOZlOxGUusbBUQxlzUdpQx295TWnHxkpII0Dp2
         a4H0488JHcX4z9t2ap+TCFt+0s0XwfxrZRXZUjIOZe8AnpRAk0AwRuFX//F9gXKOszYA
         T+/Htx9zwd2Jqqu3gN/G+ijlEu1A3ndJtAgrCmMD5ZYOQluTQCYhg0AT9hoBZXkAiCGd
         ppN703MqxcJ737tvo38eXbZLJh1nks2XG/Wtf3ZihdT2y8ynqHYH3zmdf4bxAcsXQDO7
         AZycyyMGC3lkgrO5185z9qEuzk5YDbjCzjLZtSzBuHuOuMyNM7C2U8Vb54db+SlrFpWz
         CwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkcTs/ArLjoTKDcTyzMU889nkY7DdVdas4PocmXRhm8=;
        b=SxqA0dtK3lV9BO+wG8XicJQRX95FJ52nO5l53RvluDCUkUOEAgesxTWDl7oAfdhm9O
         qStzxX6+F4fB7RF+sqQP33gmY2Wl656M2kzNg37o1olQLIBHkHGpzuRKJxWaDFqfitti
         2XrE0EVxw9S04W0o8EkaFbHbO+bAoG29xBtrjZ+bUkkZoebYpb7QqcUZgyqi6WBOKnvw
         B9PExgCvh/v8Nqw7ABWsNhLC9nI07iQrNoFT0/yTvVYGtd5mb+dQy5WuaAWBbbDH8R+U
         FmfPJqJJ4tdSqELwVe3wbcGepTmJ46MT9IHf8vkQTvTsa0pQBazsmDLgBj7DSfb3qq8Z
         8wXQ==
X-Gm-Message-State: ACrzQf0I1gksN0049+tfC2bJueaeDJNQqeMk3Nc52z8uakyAxW0FfuEG
        YwpYjFnkZtvPGar5pHgFEpc=
X-Google-Smtp-Source: AMsMyM4Lh17BXRY4hReS0g1Y9xn/yYvWeYpDiIQNSS9wyJaw1QhFUrC/eKSI2lxJi7lcJO3aGVN31Q==
X-Received: by 2002:a17:902:b40b:b0:17f:628d:2a9 with SMTP id x11-20020a170902b40b00b0017f628d02a9mr1256339plr.70.1668027247697;
        Wed, 09 Nov 2022 12:54:07 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:07 -0800 (PST)
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
Subject: [RFC PATCH 08/17] clocksource: hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:43 -0500
Message-Id: <20221109205353.984745-9-ltykernel@gmail.com>
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

