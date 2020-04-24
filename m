Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421AC1B74B1
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgDXMYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 08:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgDXMYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 08:24:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B869C09B045;
        Fri, 24 Apr 2020 05:24:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so3502396pfv.8;
        Fri, 24 Apr 2020 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EZWTGR2wDApXn1qZCOfO8QQ0qwLL2b6F+ahGlWVDubE=;
        b=MEAAr4dysjyXTujdAdFnc96D2y8DQPhLqk17tYm4NicOHg94yLN+enU9TZcefycxMF
         xfu00/TW/q9DwhPW9mM7rxfO+YnvVnoMQ7HeauwHNXNV/IkclWHKTOYTOPNP/tI/1X7U
         pse4CKlZA7Evyu/NdxJajLTMTcJd0PpCTx9TpqC15jGa0THgjX0TAuVCPB78Dc3e9zX1
         PVPTGAYshT5/u7XcppcHY397NnqPNtVGn0VKENS9ZDRZzdfG5VT5idkD7muoAaTEFp4G
         b2MarLjwHM6XT7ZWwOhVX8ekN6g6HfnmJKu61VgAeH2s+qVXTs23ZVQhKgWRWIeoIZ9V
         1TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EZWTGR2wDApXn1qZCOfO8QQ0qwLL2b6F+ahGlWVDubE=;
        b=iHC8hxwZ+WCErLwN6TbFklgIXqzaIxmjVCMsJDwXDLAajTdCYui5zP3D1itgfnAHLt
         4xDkr7DKA1pOtVsrUk2yT+gCFzzYr0VCQRUn7tdO65iqxvAbDLAyIRplxhCdXVhKj+T6
         WaHSd4lik820eqBsDFDrf73CD/SkjhonyyL7yshX/GxvUTSTgAy7ODT0DUsJgFnpdedG
         SetPYdFiW5ae+D0Hu0cslPaHH8xivUjL48fkuRLSSRWxY8QourApR7m3Mjuhox1+bx8R
         kpzbsCGQhP7ZL0tMN0rgweZo2ysyPaphwRL1v7vAzVpoULVWGJvA96DZ5mXmsQ1kn9SP
         XkXQ==
X-Gm-Message-State: AGi0PuaHSNr+F/WFbp4Nt6cyrVM9D/2A1G2wYjWccx+qhCFOhzh3sk0v
        m1S7oBg1T8NzCpS98S/Nen8=
X-Google-Smtp-Source: APiQypJ/bDxFy3P4vG/L+xY5hQN6UgcBmpz0Oy4ArCtE5VFPb+XAJMmVLhzSVnO2QcZz5nZQ6W4blg==
X-Received: by 2002:a62:b611:: with SMTP id j17mr9266856pff.214.1587731058449;
        Fri, 24 Apr 2020 05:24:18 -0700 (PDT)
Received: from syed ([106.223.101.26])
        by smtp.gmail.com with ESMTPSA id g9sm4845622pgj.89.2020.04.24.05.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:24:17 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:54:07 +0530
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
Subject: [PATCH 0/6] Introduce the for_each_set_clump macro
Message-ID: <20200424122407.GA5523@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset introduces a new generic version of for_each_set_clump. 
The previous version of for_each_set_clump8 used a fixed size 8-bit
clump, but the new generic version can work with clump of any size but
less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
in several GPIO drivers.

The earlier 8-bit for_each_set_clump8 facilitated a
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

But with the new for_each_set_clump the clump size can be different from 8 bits.
Moreover, the clump can be split at word boundary in situations where word 
size is not multiple of clump size. Following are examples showing the working 
of new macro for clump sizes of 24 bits and 6 bits.

Example 1:
clump size: 24 bits, Number of clumps (or ports): 10
bitmap stores the bit information from where successive clumps are retrieved.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x000000aa000000aa;
        0xbbbbabcdeffedcba;  /* Least significant bits */

Different iterations of for_each_set_clump:-
'offset' is the bit position and 'clump' is the 24 bit clump from the
above bitmap.
Iteration first:        offset: 0 clump: 0xfedcba
Iteration second:       offset: 24 clump: 0xabcdef
Iteration third:        offset: 48 clump: 0xaabbbb
Iteration fourth:       offset: 96 clump: 0xaa
Iteration fifth:        offset: 144 clump: 0xff
Iteration sixth:        offset: 168 clump: 0xaaaaaa
Iteration seventh:      offset: 216 clump: 0xff
Loop breaks because in the end the remaining bits (0x00aa) size was less
than clump size of 24 bits.

In above example it can be seen that in iteration third, the 24 bit clump
that was retrieved was split between bitmap[0] and bitmap[1]. This example 
also shows that 24 bit zeroes if present in between, were skipped (preserving
the previous for_each_set_macro8 behaviour). 

Example 2:
clump size = 6 bits, Number of clumps (or ports) = 3.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x0f00000000000000;
        0x0000000000000ac0;  /* Least significant bits */

Different iterations of for_each_set_clump:
'offset' is the bit position and 'clump' is the 6 bit clump from the
above bitmap.
Iteration first:        offset: 6 clump: 0x2b
Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
Here 6 * 3 is clump size * no. of clumps.

Syed Nayyar Waris (6):
  bitops: Introduce the the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thermal: Utilize for_each_set_clump macro
  bitops: Remove code related to for_each_set_clump8
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize for_each_set_clump macro

 drivers/gpio/gpio-104-dio-48e.c            |   8 +-
 drivers/gpio/gpio-104-idi-48.c             |   4 +-
 drivers/gpio/gpio-74x164.c                 |   4 +-
 drivers/gpio/gpio-gpio-mm.c                |   8 +-
 drivers/gpio/gpio-max3191x.c               |   4 +-
 drivers/gpio/gpio-pca953x.c                |   4 +-
 drivers/gpio/gpio-pci-idio-16.c            |   8 +-
 drivers/gpio/gpio-pcie-idio-24.c           |   8 +-
 drivers/gpio/gpio-pisosr.c                 |   4 +-
 drivers/gpio/gpio-thunderx.c               |  12 ++-
 drivers/gpio/gpio-uniphier.c               |   4 +-
 drivers/gpio/gpio-ws16c48.c                |   8 +-
 drivers/gpio/gpio-xilinx.c                 |  64 +++++++-------
 drivers/thermal/intel/intel_soc_dts_iosf.c |   6 +-
 include/asm-generic/bitops/find.h          |  12 +--
 include/linux/bitmap.h                     |  60 +++++++++----
 include/linux/bitops.h                     |   9 +-
 lib/find_bit.c                             |  12 +--
 lib/test_bitmap.c                          | 136 ++++++++++++++++++++++++-----
 19 files changed, 253 insertions(+), 122 deletions(-)

-- 
2.7.4

