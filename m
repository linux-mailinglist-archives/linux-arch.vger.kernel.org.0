Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0031F21C3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 00:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgFHWSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 18:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWSb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 18:18:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B8C08C5C2;
        Mon,  8 Jun 2020 15:18:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so11225759lfd.7;
        Mon, 08 Jun 2020 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hQkPROiISnXWALhr4YLCxsy0Vsz4rv9nG/scMPpoOI=;
        b=beUSOy2EhmTM9u/jVy9bfblUr19Lyu33DmAThiud5RSpYafm9+FT7bMYfNBm47IfUe
         tYC6OL4/VUqAAEpnu0jUde6sBLcrATzvGC64bNOf/+ep0+8N6bUatieNlGQ8G9x+75f+
         Pxh9TH77sY4dAap0RDkcrHPh4moQ9iIOizy+6myV2oO88TDu4pG63KbZavjK9lRKe8ef
         BtbQtrSMi8DMyFJZ7eb/zTRYNJrLuDzOjPS38jLLGYgVpw6+Ey1E8/D/wz8jkPpju0w+
         JmMWoqiQy7t6NRxNvT0xubl0XEDl6CmsrXIxPLpdxEkyWPZg4Y9iZ++x4sKFHFt3HB3+
         pE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hQkPROiISnXWALhr4YLCxsy0Vsz4rv9nG/scMPpoOI=;
        b=cy66omiuNwzk1Q2CX7Iby7RabWanNtl4nz/s8nY+Ys7WkTH6LXvRm23MVokesmPAlE
         K5RzGLw3KhRykGeRTL9xxRnxM9k6l85TUFtEAqqqTf3BHcn33GFUOOCNHGtem2nJEAbu
         qgUFEba+BNLNmENl2Pf7o7xRZ4uj4McJPIEDRUAODuGqu8itVCn2nmReCC/OIpo/Hp0q
         G+rwgthDjPU6hblTopC4AudX9dT3DGi9GXOJRLD+pyBVHUS4GOOEIvNw4Bd1EypxL59q
         Yr17WgMId9bv2qP7yWus91xpEDRRbV5lJD9Z1l8FUlKgVSe6Qm/vzSibC0L/am/5lhfw
         /+Qg==
X-Gm-Message-State: AOAM533L+Kb3z2+1/W1VAoTgNR7nyhOCSP1K1e5rLBMwQzNmCMdVHgtj
        +BLEQRzvsZF538tR1n9jhMA=
X-Google-Smtp-Source: ABdhPJwpKkUOMrWqo8P4ydPPvvIh9mpB3LIFOiikbjbunKK88RL3x6FOksf37Lt9t2xQNHJMcCa8wA==
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr13795896lfq.118.1591654708559;
        Mon, 08 Jun 2020 15:18:28 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id n1sm3966237ljg.131.2020.06.08.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 15:18:27 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com,
        yamada.masahiro@socionext.com
Subject: [PATCH v3 1/2] linux/bits.h: fix unsigned less than zero warnings
Date:   Tue,  9 Jun 2020 00:18:22 +0200
Message-Id: <20200608221823.35799-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608184222.GA899@rikard>
References: <20200608184222.GA899@rikard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
an unsigned unknown high bit, some gcc versions warn due to the
comparisons of the high and low bit in GENMASK_INPUT_CHECK.

To silence the warnings, only perform the check if both inputs are
known. This does not trigger any warnings, from the Wtype-limits help:

	Warn if a comparison is always true or always false due to the
	limited range of the data type, but do not warn for constant
	expressions.

As an example of the warning, kindly reported by the kbuild test robot:

from drivers/mfd/atmel-smc.c:11:
drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
|                            ^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|                                                              ^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|   ^~~~~~~~~~~~~~~~~~~
>> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
|                         ^~~~~~~

Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
v2-v3
Added Andys Reviewed-by.

v1->v2
Change to require both high and low bit to be constant expressions
instead of introducing somewhat arbitrary casts

 include/linux/bits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 4671fbf28842..35ca3f5d11a0 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -23,7 +23,8 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__builtin_constant_p(l) && __builtin_constant_p(h), \
+		(l) > (h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.27.0

