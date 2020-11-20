Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE22BB449
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgKTSqz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 13:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKTSqy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 13:46:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E8C0613CF;
        Fri, 20 Nov 2020 10:46:54 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q34so8019702pgb.11;
        Fri, 20 Nov 2020 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yy8mAP2XRxcUpsdCsTm+KdTXMmpuQJot11SefIetIN0=;
        b=ujvfeniSWlxcgqZRespio3sYte4Z6dmDMzdy7bcj6Ktnrv/AjG740aaFTs+OaM0yjg
         qlQEpc+tl+oeyTPEWfA+zKBs6kCTfikyvOzwGQxxF5t4lF1tByVQZcR2LrkyMIZ9F6L1
         l1R5lprWjmotlbC+Lk4ZNLDUcqx0WsEe9TZdk6khc4Xnwp0FuuMFpVvwfwkxlSU2gv6k
         Kkgy3z2bFWjOH4uZ1RGGtwaBSuETHsHaBVrWuied6lj0RBCsUh/FlY8cdsnc2IBdKEmj
         +qlq+EeiPekrq3A+CItfdJ198nhbuj/zi3kpNtnjcBwsPkSLuWqrqBduO1n8z2FVygDQ
         XbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy8mAP2XRxcUpsdCsTm+KdTXMmpuQJot11SefIetIN0=;
        b=PPDpuHh7igIVqRQ62PGf+DkFGk5V1dIrI8kB/7EhwJ7CtLxh0LbkYf2y9v5ixT92Ro
         npNrw0FkrBbZUkdvP2ike8r3H1vqiyAZbkv9pFeOP9vMtSwdwiGya5yX2Edxz0iq9u33
         mxFIKGGyDhiv2ycupkZ4L/5dvWojWR/tDqRJm6dQ/qn9s2s4B5vTtJTjCBLGl+vDG9Z/
         h/unSgRPahGaYZPZezbn3Zhv0vUmc2ySWB7vpTjdDiiDUztNKvDVGMTt2aYSDWYCQCtv
         hb2fySPHCgHhVHuBlroddQvG0N+MlK0VXTgusRbu/FEMbfOJycz7mBzclfoiF/GHmfjY
         hzlQ==
X-Gm-Message-State: AOAM5306Z01PQFU23uh3MOxnUR0UN+PZYB7imnE8BGhBjJpU7Y7av4hU
        n3IcGR06VHcYkYndj3W0TKs=
X-Google-Smtp-Source: ABdhPJw68hakH3pf9zGUb/sx7gPTEd3v2MhxOVO81lDAR6CmRc++87rAP18uKr94XDKv67IXSwoTbA==
X-Received: by 2002:a63:ef4d:: with SMTP id c13mr17996932pgk.147.1605898014325;
        Fri, 20 Nov 2020 10:46:54 -0800 (PST)
Received: from syed ([223.225.2.215])
        by smtp.gmail.com with ESMTPSA id e8sm4667303pjr.30.2020.11.20.10.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:46:53 -0800 (PST)
Date:   Sat, 21 Nov 2020 00:16:35 +0530
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
Subject: [RESEND PATCH 4/4] gpio: xilinx: Add extra check if sum of widths
 exceed 64
Message-ID: <5581771d86df1abaf33545ccd60caf4db7ad3c5e.1605893643.git.syednwaris@gmail.com>
References: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605893641.git.syednwaris@gmail.com>
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

