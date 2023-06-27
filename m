Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018E73F2B7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjF0D3D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0D2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344622115;
        Mon, 26 Jun 2023 20:23:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25f0e0bbcaaso1934878a91.3;
        Mon, 26 Jun 2023 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836180; x=1690428180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RKpz5HBE9JLrRBFLWv7AJFc4wm2/SCXversK+BtfEc=;
        b=akngYKBlJ50MAGPqRAGc1r0u1GU6Eqd/kAPm+PCdK8pSl+BholJ8W5Lz/XKnrwxX/f
         XnfqQZCHFL4E3BVGKY1SMlHs+NQCxB9766HYFgLJNBCA3n+GCUq9PX3hcptZdmN/GDK0
         eTp9qy4HkSuMUg7ntO6H+3RPeDxLRQiG7+OJP1ePF1Yv3QhuQVsG52hTKdJaNcqZSxNK
         BKLbEut+IXrScoi0AeaKz3UqI2w/QVgciZFaj/fKtxcWnAi1BRBz1StRmLXlilAAK0uy
         8I6YPeJAJwukwzJWe+IQJvM4W19WDMFMZ+Grkr6xjMFE0uoIkwKl4JiHb6muyR0mc1Xq
         nP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836180; x=1690428180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RKpz5HBE9JLrRBFLWv7AJFc4wm2/SCXversK+BtfEc=;
        b=KZ5lrT1SWyVJJc4vNXmzflQch5kP/Y35+31v3Xhx0X+p3q5aacs/+sol4vKtNQFqjs
         9QMk+eYyiGnGCVVbkEChKzDeP9Ictr+DBDNmlHwAV3i9z9OVm+yRj+f/qwlYeve4vHBg
         43RB0gp+kgcY3ilsDTVjwBOQrCR14ynAqgYEWOo5az+kbLIHNS9lVLsbbkYIDeiWTzMU
         1hVAj7wGjEH33tvvSpQea61ztlAMulC5xkKOFezVNyiZctWzDgPkJQNPq9nzinBg/LjZ
         /CNbXpftntwT9IBGdetvzOLZQZGjrZHiNW2NEkiq9dma/zikBDXjyAn8AZLuBGIoAMWJ
         6d4Q==
X-Gm-Message-State: AC+VfDz5o/OZTZJai/t7Z+Ta1Kj9xy52gdbqy7QyenfciypMcrMPPXPL
        eaUazSZmgh9rKP2EU3pHayw=
X-Google-Smtp-Source: ACHHUZ61fTXrRa2PBCfDuHA3HaSxtIC2ROCo1URXZD186AaP5V7GRRgKnQ/505qIAD0Sk4grMj0tZA==
X-Received: by 2002:a17:90a:354:b0:263:14fc:f9a6 with SMTP id 20-20020a17090a035400b0026314fcf9a6mr787598pjf.14.1687836180547;
        Mon, 26 Jun 2023 20:23:00 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:23:00 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 6/9] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Mon, 26 Jun 2023 23:22:44 -0400
Message-Id: <20230627032248.2170007-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bcd9042a0c9f..66e29a19770b 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
-- 
2.25.1

