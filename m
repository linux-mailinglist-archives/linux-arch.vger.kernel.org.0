Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3185370B599
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEVHAr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEVHAq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 03:00:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0026CA
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af177f12d1so51127541fa.0
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738839; x=1687330839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=LO7QAWEi3XWWfPv7Pu1gIWoRWXD05Svn0aUWe9ia+PVPpBGbWgIXoeSqDhEuCZ9m1V
         N7o2yMOT/bX3Zg0bXymvaKcRueAICvYEskWgjbbJN9M8kpsCCxGIu7sMq+djqX9iletp
         NNTzhji7kSJp8V/MfSbC+Y92IAyKCek6VdF0BjOskhtqU5NAtJBK4rohlpMp63KwGw95
         x2q9EZhMOloZtzIwKBd0/W0MNFje2NGvy7nJs88/cnXEdWaUPK14XY5ambA4t3lPz/d1
         gK7IocWkrX/JFXWArNaIuBZ9filDa0aW6ZCzB0E/m9A3+MAjwUl8TtQ/V31Mqm4/e4+r
         ORhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738839; x=1687330839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=L8D9y77s/ebQpjyUCaVDQWo8qCbEdVA2gPml6kwJA567m597oXLzFtFceZXoub4Wy5
         IDLuI8pDDVLeH0WSU6EzRKrjYU6ow+CEEMFvp7dMMPcHC6tzcnots3moQHiLeeSF9WM9
         mDyWkCDlYSueVulZzB14dgoolkjGiQww2aPBt5dfO433/rEeYMoxty+z+I0tKU1fyFez
         ipDzhdu+fnTcelA/Ur3L5ehEkYOQSDlA0IM+amwSKAeY+EYtaCX8n7qSmzXxH6Ef1PmX
         ceUinKIUuEBMiC0fCHqxi6+raP5XCmE+jW1KlXgx2lMAgm6DMJfgzBWHz2fQwPLbeRsk
         /lTw==
X-Gm-Message-State: AC+VfDyMRy4F7r764Kj/518ACAbpz6qr5eeovCHKmyIWtb7J4FiCcZsR
        JW6lBfEOh1Br+viBH0Fv0q5nYsgErF3K53L/Xvw=
X-Google-Smtp-Source: ACHHUZ5fhAxOzMZFylf4oH/BOTWU2svs5luxPEM0mg62x9kQVW/D8jNnFWsE7tHE4XG4rlDSfMayYw==
X-Received: by 2002:a2e:a0cf:0:b0:2ad:89ed:aa40 with SMTP id f15-20020a2ea0cf000000b002ad89edaa40mr3349235ljm.9.1684738839020;
        Mon, 22 May 2023 00:00:39 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:36 +0200
Subject: [PATCH v2 01/12] fs/proc/kcore.c: Pass a pointer to
 virt_addr_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-1-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The virt_addr_valid() should be passed a pointer, the current
code passing a long unsigned int is just exploiting the
unintentional polymorphism of these calls being implemented
as preprocessor macros.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25b44b303b35..75708c66527f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -199,7 +199,7 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	if (!virt_addr_valid(ent->addr))
+	if (!virt_addr_valid((void *)ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */

-- 
2.34.1

