Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE5D12B5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfJIP1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43599 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIP1c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id y204so855295yby.10;
        Wed, 09 Oct 2019 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSdPkLvnnsMdiZ+6XfR6tWFXWqzKs2oliNxvPIoDunQ=;
        b=eNviB35I7i63+r1g+2iDyKbCH56ABSueAeX/QFiRyX1Veje41eJbUiLkr6ugAfNFo1
         uLANxIbk7WiyFJT9Ri8QIrsHeBQW39EwsLKzC3iylHW7tnmwEPUdXw41MmOBJ/GJ0Jmo
         hOXq/hWVVsyK7K+/kIx33X0jkkphbou9C6O4lCHo+b3Uo8stCJehY2a94z9Wx0YDxn2Z
         k4HgdR3pTepYvq1w6pd0mK1QPuaMiVAfevFknU+Jc+FZvxHFadGcUbiF09XXGiBXyaDQ
         qTvrQVDF4gZs92snLr5h9QKmKn3npTOBwoRnGZmS5TOOVA9adwYm3PuK9ixc6q1WjlVQ
         uGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSdPkLvnnsMdiZ+6XfR6tWFXWqzKs2oliNxvPIoDunQ=;
        b=N5/55FiYNln4Dt/ORQlv5zwpGaN/Qwu1WUcawBMsd/fRtXRWipG+0B78zxlQ3lj0fv
         NA4N8UtAsakO9j/bIMdxDWoaIfJwYRCxQQSEKh0O/ZeK55hArXJqmH/UKPThbqDBeMdr
         C+XNCKCx1lC0l1TMEvYHjTGV6Ta8lUlEpUOH/RTCHH3TK0tUGvPsmxH+ueURAS2+g+HE
         Dfe+00cdfFIcJRZMOGd+0VWKASR+ErVIFv24c04nt9jtOlR2prNAi4btCipfCNy2+VhS
         lJaGS17O33DooXP0k6xLEnAgxKRJsIDD69TSB/uywx6qJTQSDaEuVqtnogxj7oKc/SPk
         P89Q==
X-Gm-Message-State: APjAAAXySnjTsgmGSUFx4A7+BcVb+qDR/nRZRFIx98isfM9kUWmBmFAl
        Z0m8MmJj+CLjDn2NR+rqRd8=
X-Google-Smtp-Source: APXvYqzbYaOJ/4RGKB2EynkFqV+aKl+67zvtQakjDDx6Y9Kun1tIgsnf9lipFkBfOWSYYIcKG4itUA==
X-Received: by 2002:a25:830b:: with SMTP id s11mr2317054ybk.230.1570634850866;
        Wed, 09 Oct 2019 08:27:30 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:29 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 00/14] Introduce the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:26:58 -0400
Message-Id: <cover.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes in v17:
  - Move bitmap_get_value8/bitmap_set_value8 to include/linux/bitmap.h
  - add style changes suggested by Andy Shevchenko to intel_soc_dts_iosf

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
 drivers/gpio/gpio-uniphier.c               |  16 ++-
 drivers/gpio/gpio-ws16c48.c                |  73 ++++----------
 drivers/thermal/intel/intel_soc_dts_iosf.c |  31 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
 include/asm-generic/bitops/find.h          |  17 ++++
 include/linux/bitmap.h                     |  35 +++++++
 include/linux/bitops.h                     |   5 +
 lib/find_bit.c                             |  14 +++
 lib/test_bitmap.c                          |  65 ++++++++++++
 18 files changed, 328 insertions(+), 363 deletions(-)


base-commit: 8c550e94b8835170593169a45b5ba30d3fc72a70
-- 
2.23.0

