Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3661F0FA3
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jun 2020 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFGUeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Jun 2020 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUeX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2020 16:34:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC51C08C5C3;
        Sun,  7 Jun 2020 13:34:22 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so8945730lfh.2;
        Sun, 07 Jun 2020 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVGN1pbBMj1LI0YMFYQuoWlroMgiHGZyjGcnKUmCbDY=;
        b=nBx1SIw/ZoH2JQeVJyeovJqFLEb7QHnssBx26NsAP9PZsz4QRMT9Ze7EmC4O14gyiK
         EHb0T3eMX1xFbkT5yB5R6k870415wlK1bjDIUE1rnqdGoEFdX/J8pQ4uwQxOk9pTqZGu
         vsmruhpHqSB4cHDHukJy28poSVR/F2oEWyRRK9NM7YEFnrjBCY9icZksP3A+EOtLZzJH
         aTK06pfXxNu8ZL9ITDciKFyOAXQfkDYaJqS7A8i/tF5eUWZe618G+b2TSkeb40uSV3Sd
         e97K0qg8zJ5eWR4SRCty70/M263wFNP1JMfUOyz2zlw/Tdf4yZ1ZRQMLUbQurX0IHF2o
         7s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVGN1pbBMj1LI0YMFYQuoWlroMgiHGZyjGcnKUmCbDY=;
        b=PNeo5nDAAei97UYwSBA1r+Yth/DFlNB+Rnwuf2NNJF1Nopa4hYl5L4IDq/NhSliVbc
         2miSpznm0uI+87nenBVgeLZQ+tjQUkvdwoGpUuy6Wvxm2YYW9EZFWXM5Yz/geAVY+WeX
         iicalOLE6Rp5cwX9wewFOJ8VqD78EhOdPjyDpFFg7iGEANhu5ZsNASzfro1CWEEKE16q
         Im8CiTixw/rOCDkaSXjnh9Sa8G+9LaInbM/jNHKQZpuJAKYJo0ygxcw0c2du3nF5/Gm6
         Ww78oRlIV7KX9s3vU5l+9lbVVt7+8g1j2LbaGd05rT8Wy1P0PNQ3oneCul18+C0natTZ
         AzJw==
X-Gm-Message-State: AOAM530xUYINpLm1rVKm7znwxsUauLqR2U0nTkFl1UK3IhzV59PLBgRQ
        iZ3U69boyTc5m7EzagJmjAk=
X-Google-Smtp-Source: ABdhPJwNl/Aap6OU/hpC/S3C18mQPxQNKuqoEkSx/13yYZ0cl4WkbW2UiFG9vcSpvPQUCdvCB5DRfA==
X-Received: by 2002:a19:6c4:: with SMTP id 187mr10829587lfg.1.1591562061231;
        Sun, 07 Jun 2020 13:34:21 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id j133sm3850029lfd.58.2020.06.07.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:34:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: [PATCH v2 1/2] linux/bits.h: fix unsigned less than zero warnings
Date:   Sun,  7 Jun 2020 22:34:10 +0200
Message-Id: <20200607203411.70913-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604233003.GA102768@rikard>
References: <20200604233003.GA102768@rikard>
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
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
v1->v2
* Change to require both high and low bit to be constant expressions
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

