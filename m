Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5F2BB445
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 19:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgKTSqC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 13:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKTSqB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 13:46:01 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF5C0613CF;
        Fri, 20 Nov 2020 10:46:01 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so8051326pgl.3;
        Fri, 20 Nov 2020 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRfbcvxICboodQKlXinezNDbNPHvNn9T8ybYNIuKq0c=;
        b=U9H+SThKzcEXd9tLGPr811jW2dYlCQuUZfL61AUO7ajIgdPvGvKGXBWcN7Ra8DTx9j
         0IJbTG2lt8H/Y4tot+GSwwCHrSeXYDJaZ77HbBh4iTv0Z7PzuCPMANeH1TiRTxNi9j6I
         g8JhYvlJPpERfX/sZtajXIakUE/v8dZ5xrGUI/wyEO3BqYogh98HU+VvSYVZ6UKnt+XX
         Qx1nKnHDgCT/c/uorufeMkl3ppRNTP8mSvhB5MLNO9p/nOtvRe0UbZg4XOaGp0yhzRSy
         xK9ohdt74h/xzeY1bp9d9A7AK1F9u2v2uM4SGKlqiE2dP2FWsQOQ0aaLO3MOsvvltgYD
         chGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRfbcvxICboodQKlXinezNDbNPHvNn9T8ybYNIuKq0c=;
        b=DKwNJeIF2/JeaWnIHJUcQuQCBAOeOSGytW9d5Y6NV8V7yqkK5dhsauvHuVL9O7CZHv
         RKfBQ+INVjYWc3oYAp9hNdDbxpttZXYq8rSrQn8oEnOsVgNW+aS77cixDq4iQnH/mkXl
         HCDFHxBLAcZKd6Fd9kFeCyHiQexyYFxksE3LnsLR91JPe5lGf2BI+fRakJz7VqQ1FAWN
         ZfLxUQs6aZQjZOMZYRKFMCzS0E8aZjMsicTAnnYEGMuj/ocejvkvzKzWH7CePtVzKjvJ
         xULVj0LmFL1krgCu2RAUz05Li5LMjhH3Vc+EAxR41lK/6cLkYnJLTGvOSaVLEsA0aOog
         /Ozg==
X-Gm-Message-State: AOAM530mdU/1uFQh1JJ/CBuiuQ2XqG9Zue1xI+UqYKhjoARcjgvEj9WC
        +yAy6VzA+CwCo6P3D/oPClg=
X-Google-Smtp-Source: ABdhPJyWXZsEhH6jt/PDfBCjCATNuUdMTae2dGTKO861W53YNzTXD212XNGggD+wyA3731udHYZC4A==
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr12202439pjh.228.1605897961351;
        Fri, 20 Nov 2020 10:46:01 -0800 (PST)
Received: from syed ([223.225.2.215])
        by smtp.gmail.com with ESMTPSA id h16sm4397847pfo.185.2020.11.20.10.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:46:00 -0800 (PST)
Date:   Sat, 21 Nov 2020 00:15:41 +0530
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
Subject: [RESEND PATCH 3/4] gpio: xilinx: Modify bitmap_set_value() calls
Message-ID: <c509c26eb9903414bd730bdd344b7864aedaa6f1.1605893642.git.syednwaris@gmail.com>
References: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605893641.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modify the bitmap_set_value() calls. bitmap_set_value()
now takes an extra bitmap width as second argument and the width of
value is now present as the fourth argument.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpio-xilinx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index ad4ee4145db4..05dae086c4d0 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -151,16 +151,16 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	spin_lock_irqsave(&chip->gpio_lock[0], flags);
 	spin_lock(&chip->gpio_lock[1]);
 
-	bitmap_set_value(old, state[0], 0, width[0]);
-	bitmap_set_value(old, state[1], width[0], width[1]);
+	bitmap_set_value(old, 64, state[0], width[0], 0);
+	bitmap_set_value(old, 64, state[1], width[1], width[0]);
 	bitmap_replace(new, old, bits, mask, gc->ngpio);
 
-	bitmap_set_value(old, state[0], 0, 32);
-	bitmap_set_value(old, state[1], 32, 32);
+	bitmap_set_value(old, 64, state[0], 32, 0);
+	bitmap_set_value(old, 64, state[1], 32, 32);
 	state[0] = bitmap_get_value(new, 0, width[0]);
 	state[1] = bitmap_get_value(new, width[0], width[1]);
-	bitmap_set_value(new, state[0], 0, 32);
-	bitmap_set_value(new, state[1], 32, 32);
+	bitmap_set_value(new, 64, state[0], 32, 0);
+	bitmap_set_value(new, 64, state[1], 32, 32);
 	bitmap_xor(changed, old, new, 64);
 
 	if (((u32 *)changed)[0])
-- 
2.29.0

