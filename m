Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83ED150C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfJIRPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46004 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIRPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:12 -0400
Received: by mail-yw1-f65.google.com with SMTP id x65so1075542ywf.12;
        Wed, 09 Oct 2019 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVcmQbIgO8Bg2squCswfoFzoHZk1ZImp7hwH+t3Cdzs=;
        b=BZT2HfrOpjnwnNeexB3vJTOZ3u75PJCvue+GCDNGylykHgeEeHKNIp5Wq94vpqrJnX
         fMQ5pldaRw1LzLzaEDc0DIDFT3B0KNFPcw4aG1Or3GhmzQ0xTLA/g8raRwjjkmX7BG7E
         xqiMLl+nspeSs38FPhPLtLo52STYCjtoS8x5KGwHLX/Y4vfNwgCOhnA48tmbMwhCcbzK
         LJvbOZcpMoXdTc0SbW98lg5uOdgUAWztFaYS/cTqoB4dLym5yYiyaQJRRIHTn91VjZg6
         5a8EgIEPE8gsBdjlaPrUYIkCu1+D37eo/Wne9iOhj/NtuLGUwPGwTUhNdVKenR8obiMr
         EOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVcmQbIgO8Bg2squCswfoFzoHZk1ZImp7hwH+t3Cdzs=;
        b=qfRswPSojKdy4FXFGUshA/Xyd77iVL8dT6kNM1K98Xp/hGZfgoZObydzYE7F45noD2
         ebZ50eHABEvu+W6g+Vw1uNHv1nfjzX6Gi9q0eIjUwlxA7nNPjUkbjHyAMGVKo9Bt7Vl2
         Totq8ntjoiJVtD+5PhnZFKP1YaG3yUzfOxyVUgqXSijn9rGIFLvfpThld9MwVzAdqjnM
         xV15sHT7e+v1r+at7WbY/gHxCBbbynX7oZx+BkEPFardravGJbGmkSn4v/muFcSC7kyw
         pfPCoaJafO33H5D0CsWA6lf1hBT43BA/8W6s8yzDPDxGGhqcWBf/8CouZ8FdHuc0gB7Q
         PlnQ==
X-Gm-Message-State: APjAAAVa3i/9lHU4VkNUiMhKYEc+V6xTBPBI7xPOeYu34EWCiL6B+C1G
        u/0MntMvIASs1j+OPjX3kzE=
X-Google-Smtp-Source: APXvYqz7VrUSju0wmZ6xxLXEKGzScsI+Sk8gHT+Ighn0lIDGhrprml4oetfj7n37v8J4f2H1yl7QtA==
X-Received: by 2002:a81:6dc8:: with SMTP id i191mr3556565ywc.16.1570641310674;
        Wed, 09 Oct 2019 10:15:10 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:09 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 00/14] Introduce the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:36 -0400
Message-Id: <cover.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes in v18:
  - Apply style change on gpio-uniphier as suggested by Masahiro Yamada

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump8 macro and utilizes it
in several GPIO drivers. The for_each_set_clump macro8 facilitates a
for-loop syntax that iterates over a memory region entire groups of set
bits at a time.

For example, suppose you would like to iterate over a 32-bit integer 8
bits at a time, skipping over 8-bit groups with no set bit, where
XXXXXXXX represents the current 8-bit group:

    Example:        10111110 00000000 11111111 00110011
    First loop:     10111110 00000000 11111111 XXXXXXXX
    Second loop:    10111110 00000000 XXXXXXXX 00110011
    Third loop:     XXXXXXXX 00000000 11111111 00110011

Each iteration of the loop returns the next 8-bit group that has at
least one set bit.

The for_each_set_clump8 macro has four parameters:

    * start: set to the bit offset of the current clump
    * clump: set to the current clump value
    * bits: bitmap to search within
    * size: bitmap size in number of bits

In this version of the patchset, the for_each_set_clump macro has been
reimplemented and simplified based on the suggestions provided by Rasmus
Villemoes and Andy Shevchenko in the version 4 submission.

In particular, the function of the for_each_set_clump macro has been
restricted to handle only 8-bit clumps; the drivers that use the
for_each_set_clump macro only handle 8-bit ports so a generic
for_each_set_clump implementation is not necessary. Thus, a solution for
large clumps (i.e. those larger than the width of a bitmap word) can be
postponed until a driver appears that actually requires such a generic
for_each_set_clump implementation.

For what it's worth, a semi-generic for_each_set_clump (i.e. for clumps
smaller than the width of a bitmap word) can be implemented by simply
replacing the hardcoded '8' and '0xFF' instances with respective
variables. I have not yet had a need for such an implementation, and
since it falls short of a true generic for_each_set_clump function, I
have decided to forgo such an implementation for now.

In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
introduced to get and set 8-bit values respectively. Their use is based
on the behavior suggested in the patchset version 4 review.

William Breathitt Gray (14):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
  gpio: uniphier: Utilize for_each_set_clump8 macro
  gpio: 74x164: Utilize the for_each_set_clump8 macro
  thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
  gpio: pisosr: Utilize the for_each_set_clump8 macro
  gpio: max3191x: Utilize the for_each_set_clump8 macro
  gpio: pca953x: Utilize the for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c            |  73 ++++----------
 drivers/gpio/gpio-104-idi-48.c             |  36 ++-----
 drivers/gpio/gpio-74x164.c                 |  19 ++--
 drivers/gpio/gpio-gpio-mm.c                |  73 ++++----------
 drivers/gpio/gpio-max3191x.c               |  19 ++--
 drivers/gpio/gpio-pca953x.c                |  17 ++--
 drivers/gpio/gpio-pci-idio-16.c            |  75 +++++---------
 drivers/gpio/gpio-pcie-idio-24.c           | 109 ++++++++-------------
 drivers/gpio/gpio-pisosr.c                 |  12 +--
 drivers/gpio/gpio-uniphier.c               |  13 +--
 drivers/gpio/gpio-ws16c48.c                |  73 ++++----------
 drivers/thermal/intel/intel_soc_dts_iosf.c |  31 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
 include/asm-generic/bitops/find.h          |  17 ++++
 include/linux/bitmap.h                     |  35 +++++++
 include/linux/bitops.h                     |   5 +
 lib/find_bit.c                             |  14 +++
 lib/test_bitmap.c                          |  65 ++++++++++++
 18 files changed, 325 insertions(+), 363 deletions(-)


base-commit: 8c550e94b8835170593169a45b5ba30d3fc72a70
-- 
2.23.0

