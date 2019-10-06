Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E84CD268
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfJFPLe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39968 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfJFPLe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id s7so207940ybq.7;
        Sun, 06 Oct 2019 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbtblgd/jJPBkocI+MwRuPHJhAT10ALT9hQEoN0MCo4=;
        b=pp0Vss3xZ2x2i3OiesE0HzbYZb1Ba6rMU6p/AmC99WBLaB24DpFCIZ/Pbh5rmUlmgU
         789dzs9gnGZ4m5nej4eyLhbiAc6b2qi3q0EsI1KIJfRPC3EiOYEhQWv9Me+JICnlFZVI
         L+cGI086edZssoONImyLsgv1cvGs53NZ83CNYkBuL303hI+X3cCQJ0cwz1uDPpI5MHQp
         4++e9laTjLX+5C5ofKZej0BCnJWYBwwRdchZs1gHnW1UkFQCHbfSvfeBcENs8l2dNWhi
         fOQq3sngZWTyUuex7wGfhand7B8AwkmwHZWso8ASQoYIfQQC/gaFSEJJ9SDRAVx+sV3I
         Dn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbtblgd/jJPBkocI+MwRuPHJhAT10ALT9hQEoN0MCo4=;
        b=tcnLSQzwXVWwadZ+iw+mRcMMisolUHTEzbT5BgYdLPVw1+nBwkz8mPMLHd8p5kFYoi
         bsX2He4hwLTnKPbG70p0Ks1zroRLJ2raBf+xP4FnTobjPIGCsFazgFtrpzYLtDw+eVu/
         FhYo1qTua0nKNvUEju4xaYNuGiScep9F3qq8zyyic/Rs1QR1oT+jTz66hlI+8XXy/pzs
         i8zxyg016oCMs0rcQ0DR1qTpEe2Gle7eA2GzMhJvlWh/t5Th2TGgYEQhbCx9DMx4pZoX
         WWrGiJl7EbEd/qw/WqbCGicRoQR7rlB+fqJnJQmTkgaJomnQvl85xaRvHvQdeVvzxBQU
         DB8g==
X-Gm-Message-State: APjAAAXgx/8cSHPKB+FAmsCE4QFReu6TUSJrM57hjPEvcVztq44K0xtl
        t+NZRhgL74cSWFtemeGsMSY=
X-Google-Smtp-Source: APXvYqzuLr7tNwFfzVIotQtIQRiBkdOuxRVp0bEL09oY03vVYasfb32PD0Z2/XiXhEWU81GBtjcSng==
X-Received: by 2002:a25:34d2:: with SMTP id b201mr7985252yba.232.1570374693292;
        Sun, 06 Oct 2019 08:11:33 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:32 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v16 00/14] Introduce the for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:10:57 -0400
Message-Id: <cover.1570374078.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes in v16:
  - Fix typo in max3191x patch ('offset' to 'bit' in bitmap_set_value8)

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
 drivers/thermal/intel/intel_soc_dts_iosf.c |  29 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
 include/asm-generic/bitops/find.h          |  50 ++++++++++
 include/linux/bitops.h                     |   5 +
 lib/find_bit.c                             |  14 +++
 lib/test_bitmap.c                          |  65 ++++++++++++
 17 files changed, 325 insertions(+), 362 deletions(-)


base-commit: 8c550e94b8835170593169a45b5ba30d3fc72a70
-- 
2.23.0

