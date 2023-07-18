Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244FD757232
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGRDXq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjGRDXa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:23:30 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9E10F3;
        Mon, 17 Jul 2023 20:23:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b91ad1f9c1so3467040a34.3;
        Mon, 17 Jul 2023 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650598; x=1692242598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=Z9ih0aA/PzLKRelAHQmbTO80qK68YQO4IevqyDH0xG02u8MrrOrsvshZKQeV0bfe+J
         UYc4pemypZweDyZngoa8pcj2wriAWBzCJbJcEi1O9+UYZolqFz3hmu0RWRNpy/7gBjpC
         oJRazKaJ/RoJwllA01phZbgTbLaQ77BQOkl/q21B6gklmc4kpzqfJiHw+Amvy//ewZgZ
         /+v66iPHoPjyhLLF16YfSTuQ1Mtf6mVsVquwleWz0+E5C/IAFF276MPcPnpTMEPLPQGx
         llkuQfYaNk3eZkAr/4X47GWex904s6gtfGqpc5eqKdmivaTkyT0f7XlqnceMJKT1j7ym
         +mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650598; x=1692242598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=cZmRmmsxWIFd5yDxoVSCu1SYuABtYD6aZF7jFXSMH1z7bukA/FUgCWOwPFhLmy4IT4
         9SIEcK1M3880LVmoa3nL4L0weMO3oXX/p5sccPoBkBR/z9fL6L82jXCxQ52koZogjOId
         /fbBExiA6PN3RsgathqWKFYcAezpkxHjq7MrAlb4Xya5PTsJNeTwboO86lclJfVgNwf2
         gSEMcmcjXdyQqmBnYP18mWAEAnovnl/VLCnbFbqJYaWo1isRisvuJFYD4gIsWwpDlw6j
         A9dyN6w82p6vyLmKWN9FDCK6OExjI8vu72CSNtHCDH9W0Krx2tsks+bg0Bvk588AvrDt
         G7yA==
X-Gm-Message-State: ABy/qLZjTJRn1Nbt7EkLqK7tnd44k9Pg0bqsfatkoY9D5nNIFVtH2eC3
        8oZoRX/YaO04bIlIeG0CKkA=
X-Google-Smtp-Source: APBJJlEkBpU3kWnFZvo6tCz8OhHgGE1n55LOPGpaijnqqDKDs4fCGQ+Zd9yQcYYwdzHxHKuOKYvs2w==
X-Received: by 2002:a05:6808:148d:b0:398:34da:daad with SMTP id e13-20020a056808148d00b0039834dadaadmr15016242oiw.51.1689650598402;
        Mon, 17 Jul 2023 20:23:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:18 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V3 6/9] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Mon, 17 Jul 2023 23:23:00 -0400
Message-Id: <20230718032304.136888-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718032304.136888-1-ltykernel@gmail.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
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

Hyper-V tsc page is shared with hypervisor and mark the page
unencrypted in sev-snp enlightened guest when it's used.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index e56307a81f4d..8ff7cd4e20bb 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -390,7 +390,7 @@ static __always_inline u64 read_hv_clock_msr(void)
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
-- 
2.25.1

