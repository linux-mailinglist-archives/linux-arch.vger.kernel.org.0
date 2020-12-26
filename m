Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2856D2E2D87
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLZGqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgLZGqR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:46:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB80C0613C1;
        Fri, 25 Dec 2020 22:45:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s21so3466632pfu.13;
        Fri, 25 Dec 2020 22:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnMHu5Qy0Jg58UtwP7Ds62Ap6snjXtPHHHu3PtC/XEo=;
        b=dlG38EeVZacFRmy6FQi7N0YYOYZ+6eAIjVXaWVZVoDb/X30UBODrFuDWaVxw513N8K
         xUDYQ9fPv2JiKVd2HvG0xPmmk6KiJkc/JLQbw/A4lV3uMc2DGf3BBqUxQm/GTD21rp0f
         jB3aM8+L0oUzFSmMGmw+x+dc4KwRPkv6ut5pScK989Usi2C65croYz/sMmZrlLINUaS/
         KjVTKVqhmd7HfIw098Fjn1Txo6kNLA8AQ83MALlX7V9ug7pk279QAuQnBUJ4NqK5laDQ
         77RwdH5b906TtQcQ7PyDn12ZgVu3GjU85rdDRDyjwOElwUX7IccZKgSnV6S61fB0+SGm
         lJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnMHu5Qy0Jg58UtwP7Ds62Ap6snjXtPHHHu3PtC/XEo=;
        b=QnRNIlA270Kaj/4nVOR3KBtkxYIL0iSqYTaq3ZAYfjm66tFmuihtc9GnkXUiLads0/
         D9Sl7RH+cu0GDl516+KZFwFd0WMMO6N/KIyrigrJCkou0ABVAtuna9AF7OiceRleDuVM
         sZ3NI2N3NTo1cH1IxvMGaf5VFPPZa5puYPrxPHpV1v38DT3M0dV7Mrd7TniN6Lf/GEbF
         I5rY1HD6kFHfo85eumjWWfAGjwpSLeN7OxzuGLecj+Rv+UIXTubOBMfCnAJjh8YnMi8K
         OEy6W3JgJOxM9nHR3QRbErNFnzbFgJNiEeamzlDBv51C2vovFYOlnEAU++5JZe4fJTMk
         2p9g==
X-Gm-Message-State: AOAM533p8qXUgQLWoBc6EqQrVJyoqEs40PNziYk24uSiZ5be0rZc62oT
        1J84BYw46xswGtS9pVKyk3E=
X-Google-Smtp-Source: ABdhPJws3YsPWlyumseJrN1/+szleyhO7fW1OuHDB/pTEgqDVu+reDMNMWH3EsSevnPoXVaiAEw6uw==
X-Received: by 2002:a63:cf56:: with SMTP id b22mr35606537pgj.16.1608965136522;
        Fri, 25 Dec 2020 22:45:36 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id cq15sm6935227pjb.27.2020.12.25.22.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:45:36 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:15:20 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 5/5] gpio: xilinx: Add extra check if sum of widths exceed 64
Message-ID: <fd642c0843d59a0091931fcf9baa19a9dbb6e2e7.1608963095.git.syednwaris@gmail.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add extra check to see if sum of widths does not exceed 64. If it
exceeds then return -EINVAL alongwith appropriate error message.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpio-xilinx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index d565fbf128b7..c9d740ac711b 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -319,6 +319,12 @@ static int xgpio_probe(struct platform_device *pdev)
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = chip->gpio_width[0] + chip->gpio_width[1];
+
+	if (chip->gc.ngpio > 64) {
+		dev_err(&pdev->dev, "invalid configuration: number of GPIO is greater than 64");
+			return -EINVAL;
+	}
+
 	chip->gc.parent = &pdev->dev;
 	chip->gc.direction_input = xgpio_dir_in;
 	chip->gc.direction_output = xgpio_dir_out;
-- 
2.29.0

