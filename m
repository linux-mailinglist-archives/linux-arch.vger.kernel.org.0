Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E383D2D85A2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Dec 2020 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438132AbgLLKDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Dec 2020 05:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407318AbgLLJyb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Dec 2020 04:54:31 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6230C0619D2;
        Sat, 12 Dec 2020 01:33:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so8663011pfg.8;
        Sat, 12 Dec 2020 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f1FArQJwKvbV3BehyF4qEYRVrF15VQjMltXB6x2VXEs=;
        b=VfglcvXKb3iG6utIOpUfYAhtiw18RAnZXn+8XlkXEyYi23SGNxEmGpmMtBJvmqNiwQ
         OIQVaVut6CGtqNUs5pftpzY7bdxIAlVW1LvP4gMmfgXjyMaswbb6tUjYn+9zZfiruEFA
         mVK1h31PnUfdKRNRvEaYnwUF48Kl1mFGBH2NyQpeJcN0xSx6z6Nxyn5a12Vcal50Z5Ok
         1Cfqn72/66gvm3CAtIdmMP1WxOTYjRXNIu7G3e0rGQoeyWyeQ7EaluvMLFqhKYXeCUzB
         DCxEh/eOh9yijgAQ1PRTyvWD/TDKrFRMUgDxrAVcuRCzruLk4W4bdqjBZ9UPI3xc96+e
         pYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f1FArQJwKvbV3BehyF4qEYRVrF15VQjMltXB6x2VXEs=;
        b=fqL6xJ6LPwjx0Y8DCFCQP46olE0HivZZbLJogXxOGVxAToumlDtOkCIeX6lrtMGlof
         zGQQPOXMdc/EoijgU8jXIViQvF8SQ0O4UXmOAdMXqrcXRtsdW6ezlaF5129U480szFzF
         ZRGDsilFm0lvZH13rOKRUW/xRY6Tfs/2ABfgxM9hcqQoIi+w9h2535+lSSYfQJtfwvmt
         4BjHjuDUBgmc75J5Rlaqq+F1xD7kuKPcCWAuMzPM/cmFhyYEXxMfbYW5QdCDmB7AtRez
         9Av+fV6fLMdWfa3yEmo0K5hOqF2gtrlAlJ12C/80AdnF30ZdxjrJoEUJuLyIN7EkwGXt
         jKWg==
X-Gm-Message-State: AOAM532+GeF9etmQ4JvHGL4UQaY/bxkgpXwHFa4QecwltoFxLWYCAWy8
        BjKj6M9ZA9zER0d50kyhjw0=
X-Google-Smtp-Source: ABdhPJz5b/yhDHG5uH6YU/ZzFV4elj98QRD5Y6ho7DQz8+eoqDrOz5qWPGF+glH9iqDCk2RFt6pbNw==
X-Received: by 2002:a63:d401:: with SMTP id a1mr15671694pgh.42.1607765617145;
        Sat, 12 Dec 2020 01:33:37 -0800 (PST)
Received: from syed ([106.202.80.219])
        by smtp.gmail.com with ESMTPSA id g9sm13902333pgk.73.2020.12.12.01.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Dec 2020 01:33:36 -0800 (PST)
Date:   Sat, 12 Dec 2020 15:03:15 +0530
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
Subject: [PATCH v2 0/2] Modify bitmap_set_value() to suppress compiler warning
Message-ID: <cover.1607765147.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

The purpose of this patchset is to suppress the compiler warning (-Wtype-limits).

In function bitmap_set_value(), add explicit check to see if the value being
written into the bitmap does not fall outside the bitmap.
The situation that it is falling outside is never possible in the code
because the boundaries are required to be correct before the function is
called. The responsibility is on the caller for ensuring the boundaries
are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Michal,
What do you think of [PATCH 2/2]? Is the conditional check needed, and also does
returning -EINVAL look good?

Changes in v2:
 - [Patch 1/2]: Squashed earlier three patches into one.

Syed Nayyar Waris (2):
  bitmap: Modify bitmap_set_value() to check bitmap length
  gpio: xilinx: Add extra check if sum of widths exceed 64

 drivers/gpio/gpio-xilinx.c | 18 ++++++++++++------
 include/linux/bitmap.h     | 35 +++++++++++++++++++++--------------
 lib/test_bitmap.c          |  4 ++--
 3 files changed, 35 insertions(+), 22 deletions(-)


base-commit: b640c4e12bbe1f0b6383c3ef788a89e5427c763f
-- 
2.29.0

