Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD515770460
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHDPX3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjHDPXJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADC49FD;
        Fri,  4 Aug 2023 08:23:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad356f03so15873355ad.1;
        Fri, 04 Aug 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162588; x=1691767388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=Ys4LxoTjJLJNlf1KghdOXawDjuuvqnxI01dSB1N/OH8xutrxveIeQ2p/n31GTSVIV/
         MwRtwaxer4ympeYbkdZ8VZCar3PRKMjoAQNOA6Vvbs2R7HPpQUnCs4GgcFNqSJw002B2
         dlpuGab5pM/nJLY3EM0u5EBAXsB6qM7blUGMz3GAdpkrthcQ4jl6GH/L0KScRt7yhGiH
         aTSWnNFr6PSEe5DLGsSEO7sQNi3EH8fcyQ6JJ4eMke1BLrJbb46Sm5JtI24cv09LuA8P
         2vBs5/nOnlPgPe2ZtaMzRTbDdZIoL5l7hzowfcpTWt69tkmSBfFgRC3DszqWnFU5Pv3m
         0Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162588; x=1691767388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=ZxZxlxl5qnfFe/h6bwPLjnONSuP05vuiFFwM9IAjihORpUfxl/eeF6cJu3YvGjWYwh
         qtajRlmMfoFKjInLef+kTrZv4CokPiorukq6ocVAp5WuMhBdnqXGQS+g/AGxzDExY0GS
         WVp+MmaQNzzFEhJG7Wz0pqp4LCxEP4YW733E3d/RALsf+1/BM5pw3VKlUKhj+cHtNdq8
         b67Qju3S2lOx4j8+bRZV7ouyytcvVJd5chHsKS1uZMAWAxhzsrt4iYthNebLJRkxHC62
         hZrEeJCTqoaZFp0vmmmFuChH85R1kN+eFLo1b6XoxW7eChI192B2Kljw3hRSRz6hW+tT
         +fCg==
X-Gm-Message-State: AOJu0YxHCIUWjO4tDqMmLJ43/gicABdSf6bDApQh6WjvuawJo2sAXCF3
        kEUDr+Fd8EGziQLaa+jcVCo=
X-Google-Smtp-Source: AGHT+IFpEi4BiDKfeWW3rJ6hpjwC8D0p6RtPRPyPaJwFwI+k2imnBx3VbM1Qew/5L/GMiSWYI+oi2w==
X-Received: by 2002:a17:902:b482:b0:1bb:a941:d940 with SMTP id y2-20020a170902b48200b001bba941d940mr1957448plr.15.1691162587729;
        Fri, 04 Aug 2023 08:23:07 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:07 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 6/9] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Fri,  4 Aug 2023 11:22:50 -0400
Message-Id: <20230804152254.686317-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

