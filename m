Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9D2BB43E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 19:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgKTSo1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 13:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgKTSo0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 13:44:26 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84439C0613CF;
        Fri, 20 Nov 2020 10:44:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so5298990plr.9;
        Fri, 20 Nov 2020 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cK5F4d0qMv8rWJ7QrP6ojZzILBcMD6l3/NGR5/zHn7g=;
        b=JDmUnio1aSGCqFrCLxgQawip7qmMCTVk/WxT1wywIs4ubhldWhE81sZ8HL1BspCcwU
         ZpXoOLh3nCOau9q+oL5oYYEGs5uhiuybwEUGN9OAEaENpAUNux57VoeF6h5n+9PsMQ+b
         QsQK08JsbIq94vZ2aE47GM5BtKOGOp99nCI5PXeQogU3Hbb1Y9fxQxHDf8nH/0F+a+zf
         0mMAjPimAH6SC4apd3jbLAlpXpPttDSNZrbvcf/YR+zI1Rn3UoKvs36bIhpW2T70FMxn
         4RBwnlgYg4jrjFhgHjWtOKXBgHx0+MGYyjNrd+SyLGK9sfbjpHbKruTMeZSM5VnNI/tm
         1qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cK5F4d0qMv8rWJ7QrP6ojZzILBcMD6l3/NGR5/zHn7g=;
        b=NpodfHcm35Khl0pIHR0+YgAK2h5AzRIFSz+1zod5mafyAKUvdRbcBsNRlU1f1BNVAd
         9p7MtIAqt2y0KDjHCFUhD/I21gYZEn47s65EIpRTIx75kajs0Kt3VW/1EYgP+6eEqlYv
         5jkmDkE4F8SLPeYRSu8Z1txgyQPZIG6iLmZ58RC7ja30KVGQnFSr2YaJCnIJ3BblpbVQ
         GUZPTYpmX2w453Apoxx1bR6jpBUwd2d1UjQVqEZWaHrhRHUZR7cZ9w6LSc70vq7uMe/u
         ElUMOEctW7tlwctY40jx736WvIhv7oCY8gMpMaswEBER1VKDztbPqFwV7xmRSCzjdkya
         93pg==
X-Gm-Message-State: AOAM532lmecvf9x/yU0kDEQVVLqb6vVc78kod9hbhv7OjGLgDMJQm6Xq
        kW79thPrqArkUBYEgRGrJjU=
X-Google-Smtp-Source: ABdhPJz4LuKXhDhCCts6c4qxBuonU2yyA62xYcyZVA/6Ht5a1UW44vjUMzTXOBHxjTCPcprZwATb3Q==
X-Received: by 2002:a17:902:8609:b029:d8:fc3c:b01a with SMTP id f9-20020a1709028609b02900d8fc3cb01amr14765755plo.36.1605897865137;
        Fri, 20 Nov 2020 10:44:25 -0800 (PST)
Received: from syed ([223.225.2.215])
        by smtp.gmail.com with ESMTPSA id n10sm3988016pgb.45.2020.11.20.10.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:44:24 -0800 (PST)
Date:   Sat, 21 Nov 2020 00:14:04 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [RESEND PATCH 2/4] lib/test_bitmap.c: Modify for_each_set_clump test
Message-ID: <27dfda9e32e6f7d0ba9399209c70e5c3c73d0113.1605893642.git.syednwaris@gmail.com>
References: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605893641.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modify the test where bitmap_set_value() is called. bitmap_set_value()
now takes an extra bitmap-width as second argument and the width of
value is now present as the fourth argument.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 lib/test_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 1c5791ff02cb..7fafe6a0bc08 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -656,8 +656,8 @@ static void __init prepare_test_data(unsigned int index)
 	unsigned long width = 0;
 
 	for (i = 0; i < clump_test_data[index].count; i++) {
-		bitmap_set_value(clump_test_data[index].data,
-			clump_bitmap_data[(clump_test_data[index].offset)++], width, 32);
+		bitmap_set_value(clump_test_data[index].data, 256,
+			clump_bitmap_data[(clump_test_data[index].offset)++], 32, width);
 		width += 32;
 	}
 }
-- 
2.29.0

