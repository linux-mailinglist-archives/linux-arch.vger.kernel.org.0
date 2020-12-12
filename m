Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3669B2D85AC
	for <lists+linux-arch@lfdr.de>; Sat, 12 Dec 2020 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438563AbgLLKFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Dec 2020 05:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407213AbgLLJyQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Dec 2020 04:54:16 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8CC0619D7;
        Sat, 12 Dec 2020 01:35:14 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id j13so3751306pjz.3;
        Sat, 12 Dec 2020 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yy8mAP2XRxcUpsdCsTm+KdTXMmpuQJot11SefIetIN0=;
        b=KVDtSO/0uKi/QiWrCU1zn8LcujpIvT+dkAK6HUZ93j38/Q+wLHDfplKTgdiVbzeMtl
         flByeS8IhAqGaM4xzRwM1ErjEBytK51Eg7hcFne7vL3kiWZmIyO/VkSa0yE+wUmO3MkY
         2ItDX5YGfJy/zCkHG/K1SNWKWcXmkK5BKcaxahXVVDp3319WZrlDHTa7JcZ6RGEnDo9L
         9KpEh5kKl8IsgVn++gvfaaAqXza+k2fziihzv68mnliqi6+CiuxyDxTLWh8bZelMx+Gf
         B4nt6ssW7RkPVJPXZbSRdJJKVmkaqHvOchQ0OstcveZPVYVbtQLpHlD3u/5ncYpbr69R
         TYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy8mAP2XRxcUpsdCsTm+KdTXMmpuQJot11SefIetIN0=;
        b=bk3+knL4U9bhqDBJwzaL/N0u2YblpCxS187ZdpUj15APvZMw4IwKWc4kLkmqO83zAa
         3Otn2ussVMKOqOV+XbJfRJbfDpbtFBOOY4WN6PBtJz+hFeIklolPTsUt2oq5JjbkhN7a
         mKxZmVIvsVZupdhv7YczlmkJTSyZf5I/P4v2qs8cubYa/OvrWN0yC0+nOGQxR10UCFG1
         Y6qIBUO4U9ltzX2GqihD8qItgyGlkCGpyZwUCPyLSH9xioC6JS+lE7TNR3EDTt3bCpjM
         fmy2IER1P9Cir8d/dfI4enBxxcHh0+wobBapv0qxoaHGfcsqXngfb2OmfCxh1GNUEIJ+
         SJ2g==
X-Gm-Message-State: AOAM531GKna2FmUudOuxsR/nl4eIPGChzNlDBx0yezYzLlAFMaeRhES7
        kk5V/etiCV9WxHiqY8GmnX8=
X-Google-Smtp-Source: ABdhPJwZWXWUNVkgyYTtW0SFPElBeAGEfsA9TkWsRluzgsAtKHm13tPqN0cj0s/4D2Wt4UMZB1edbw==
X-Received: by 2002:a17:90a:450c:: with SMTP id u12mr16772360pjg.93.1607765713923;
        Sat, 12 Dec 2020 01:35:13 -0800 (PST)
Received: from syed ([106.202.80.219])
        by smtp.gmail.com with ESMTPSA id s5sm13342405pfh.5.2020.12.12.01.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Dec 2020 01:35:13 -0800 (PST)
Date:   Sat, 12 Dec 2020 15:04:54 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] gpio: xilinx: Add extra check if sum of widths exceed
 64
Message-ID: <7049b151670d3cb3ca190185bb484a79b2d5d845.1607765148.git.syednwaris@gmail.com>
References: <cover.1607765147.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607765147.git.syednwaris@gmail.com>
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
index 05dae086c4d0..a2e92a1cf50b 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -340,6 +340,12 @@ static int xgpio_probe(struct platform_device *pdev)
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = chip->gpio_width[0] + chip->gpio_width[1];
+
+	if (chip->gc.ngpio > 64) {
+		dev_err(&pdev->dev, "invalid configuration: number of GPIO is greater than 64");
+		return -EINVAL;
+	}
+
 	chip->gc.parent = &pdev->dev;
 	chip->gc.direction_input = xgpio_dir_in;
 	chip->gc.direction_output = xgpio_dir_out;
-- 
2.29.0

