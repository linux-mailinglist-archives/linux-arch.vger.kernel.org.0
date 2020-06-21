Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D92028D7
	for <lists+linux-arch@lfdr.de>; Sun, 21 Jun 2020 07:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFUFmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Jun 2020 01:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFmR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jun 2020 01:42:17 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C74C061794;
        Sat, 20 Jun 2020 22:42:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m26so7791317lfo.13;
        Sat, 20 Jun 2020 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRKag/4LPSl5Xnsnl9sXPhKHWLjT9dMGxtuILiA1ji8=;
        b=bHHamA0pKBbnulIdEuqz8qHkzFIHj+PifiHFGg0049fXDXHj+Mj7WI9ztirmz+HNT0
         krHTPTUKsEl8qhfKMdkhyGG+xMnPfTsVRHCUbXSp+UJjelTH4UHAq8PqsrMh24fZvD5w
         8D4Knh+ueUYb1qynIGy2MRJcrhIPOk2g+dVoyTY5YEHSvEShyB7qmgdLuHxNYKcRhD92
         0Y0TDPkuzMIbkAuYBrH5birnoCPSZSegQYMeG4UZjr6Fzb7nKl3WN1hW5z+VfHAbnfUW
         JxgZbMlvBGpuHO+QJbdGq9nLeRpNymW4BBeE1HfWygGlVUoolsRovAkMaFAx+ly7755L
         tgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRKag/4LPSl5Xnsnl9sXPhKHWLjT9dMGxtuILiA1ji8=;
        b=oYD+RZoR+SwZJ9XdXVWsbG/eOvUlSOSO4vgf/Rr3mwDGMngBGj8XL7vC3HhBEGbL2B
         fqipsm+9GWCzYtIxAxgBz5rhCpXbh5b8++Xf+MEYE4vMFZJKaCJHoRR0+8Bz243JG0Zb
         Tlg8LcuIPCk5DJG1dtGso9dJQ3DX0Kt/Apk8RhFpK1GmRpRYTYeLvZNwPtXc2crkvr3p
         e0gGHWkrWWQyy9ihL5lcbnwc9Zyqk0+RiYxPZ6C4XR/yOB71esS2Exl1XjxENLTXXdS0
         OmBmv/piJ49zWd4IsWOUXYmLWYqbf7Z+dSgNiwwUi/IPP+Szl4EAYOsAyidhD8CHZiF9
         aU/g==
X-Gm-Message-State: AOAM532csROqvKLytXM0mNrqn/c1VdTRtPHmjY/wLiqN2yKv8WQvnjR6
        tHfqBYPMislBzlOnbmOy4UY=
X-Google-Smtp-Source: ABdhPJwjMyYu4fZwYzbnhbK/7YJm2rB4RHQwOSH447wnhCnvAuhaqa23B80WJJZ1xEBy/LtZzBRrbw==
X-Received: by 2002:ac2:447a:: with SMTP id y26mr6147470lfl.146.1592718135329;
        Sat, 20 Jun 2020 22:42:15 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id i22sm1990323ljb.50.2020.06.20.22.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:42:14 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        rikard.falkeborn@gmail.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
Date:   Sun, 21 Jun 2020 07:42:09 +0200
Message-Id: <20200621054210.14804-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
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
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
v3-v4
Added Emils Reviewed-by.

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

