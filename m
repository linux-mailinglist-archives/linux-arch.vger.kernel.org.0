Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EF71A247
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjFAPRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjFAPQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8B128;
        Thu,  1 Jun 2023 08:16:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso650394b3a.1;
        Thu, 01 Jun 2023 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632595; x=1688224595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RKpz5HBE9JLrRBFLWv7AJFc4wm2/SCXversK+BtfEc=;
        b=rpNN7jcMESOKM8JeCjmCDw6hCumBxuYudKtp04D9Tyln1yQ5Ydo4A3XiFhHw9MjoyV
         DpNkjj5yiXVxiOIRaviptlRexiDZvCOsw+U5equZ1TKfHV5mNsW0bRYIMRCDcKSMr2Ig
         C2X/7NPBdfJaH/imNWXRsof1chGIG98UG7Y7SAHuOHva5SjCZCzBVpjeytB3wWIVjjw1
         e1rUcZEVNE/0iB2IFAI9NtYh/r6XGLdoHKGT5KOd4miUbjYcrhIdI02kHQnZhp7nInF9
         AtP7CSXCK8WSc4PIOMV3P+KjsZAy8eMxpEXCVkPaiTNamh6gp1lW3qv5/UqSBm/P7C2K
         HyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632595; x=1688224595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RKpz5HBE9JLrRBFLWv7AJFc4wm2/SCXversK+BtfEc=;
        b=I3HQ/oidP3HAj6uHvDy420TXbaRJINunDUk3/6qu/21ZEtTGxtYHsjrDL0pa/kEhIr
         DXPGPpn5Z64eqq6JhvZUlJUzXXYzjlc8M//sWSI9qr/HTq7I4iO/rEAqwa3mGmshhWEn
         xwq5KxW+gyA+zZ+XBBkC/9RLPUFzCoTeXdLIscx/Uf0OuSKm1AT1UCwZBFVmlPbUUeSW
         bMX8yEOdHKGsLDZfgw2xVz2cyGeB8tyMId/37C0wj4KGO3pdnVptQZ6LZYRKhLYvoHas
         9ps41LC507P724NX7Ig6DtU0M4G0ZZSvVIoBtmuVQLqj4IGjRlpP0/hgiUIscNL+JUK4
         MSOg==
X-Gm-Message-State: AC+VfDwWQK0gxC196hAz8ldjdvt7tm0TlH12PJQd5ILGCexqo/3PaXlp
        ftaqVPaJgnPgPFRiFzbO3PU=
X-Google-Smtp-Source: ACHHUZ6+k6qwbrlrb3tURCy5l1ZxZwb66uyeE6LdfD1jaKfFdMseINCm8KeMkTpE8JQs4pGUX7M88w==
X-Received: by 2002:a05:6a20:158b:b0:110:6146:1040 with SMTP id h11-20020a056a20158b00b0011061461040mr7581033pzj.4.1685632595368;
        Thu, 01 Jun 2023 08:16:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:35 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 6/9] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Thu,  1 Jun 2023 11:16:19 -0400
Message-Id: <20230601151624.1757616-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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

