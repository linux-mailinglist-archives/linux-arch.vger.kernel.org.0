Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E001ED856
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFCWDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgFCWDs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 18:03:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1822C08C5C0;
        Wed,  3 Jun 2020 15:03:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so4741336ljh.7;
        Wed, 03 Jun 2020 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+XTLQsKZQTaS9x71LzVKV5AjJXygW6lHQ5XJHRgP84=;
        b=dUUV7Qbai/yDpIobYnOkyFTEKHStSfOTL7JXeJnkrMY43Tl9uo52DQH9zRrvUzx/w3
         GSZGZ/WndxwyE4L03kLVW7iMNw5BGG66juvXScuxw+cwNGWAD0o9Pzf5Wa4C05LE+kz3
         6edGMjmh6RHvltFZxAgm+XvnXFZAPos/2Eipstk8yrbceVQhvIuHmHF5KAZRo6fz4rm9
         a+2BjnmwdwcQCkd8sQjxHLCuOBx8wG4RwUG+hU+8BFkjaGnKrIUhXCoNxb1yxFazlnPl
         p18p+lmGavi7O1UfJ8w0C8LpyeWAMLu8UCXLK4Wb5OZ2OHpbkW8UcrS6MlvrQTRI2RUN
         1QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+XTLQsKZQTaS9x71LzVKV5AjJXygW6lHQ5XJHRgP84=;
        b=BUqyLVlE1JmjTO/HIx/bbnySSBLTt2A9LNpgshzWELQkv8KmI5nBwkN36TVeeUYSaY
         IzQ/2k3gDwDgfssQqBn9Izv0VHICd2cbFKBs4OLflBkDNOOKfhlEjYqLSwtpgNmS30KV
         4aMP317bP31klVgwqlvCTgBknLHE3Wk3KSI9MF1AnpTyqrFYC/ltgWBzvjZF9wiZ+zy+
         A/H8kFLG+tv/YjMWEYoTJPsDWCFgFn1YTiaOjdd92iq0f6qj+cj75vQ/BPHIG9/BpE/c
         Ijzjhp3Af4441ZmA3Nyv9dl+Q0rPsNaNH/oeeKK0SwGHTxBcHu+ye4AdpqvMdGFUCSY6
         hYMQ==
X-Gm-Message-State: AOAM530BP1XttWRNUjh4c/aBWmOo1Fpp4emWEf18aH+UOoeTUyk0s9gZ
        FwrKiREeQmZ0oWMrPVvcF9HDqVayVAA=
X-Google-Smtp-Source: ABdhPJyP9AiP4JeY72sPHecrHeTUQlgX6Z1xUv01fOjjXP/M4bAb8Ix7LABoB5UKJcg/KxXYvkwJZg==
X-Received: by 2002:a2e:8ec1:: with SMTP id e1mr573114ljl.23.1591221826167;
        Wed, 03 Jun 2020 15:03:46 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id c7sm794800ljj.109.2020.06.03.15.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 15:03:45 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] linux/bits.h: fix unsigned less than zero warnings
Date:   Thu,  4 Jun 2020 00:02:26 +0200
Message-Id: <20200603220226.916269-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200603215314.GA916134@rikard>
References: <20200603215314.GA916134@rikard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
an unsigned unknown high bit, some gcc versions warn due to the
comparisons of the high and low bit in GENMASK_INPUT_CHECK.

To silence the warnings, cast the inputs to int before doing the
comparisons. The only valid inputs to GENMASK() and GENMASK_ULL() are
are 0 to 31 or 63. Anything outside this is undefined due to the shifts
in GENMASK()/GENMASK_ULL(). Therefore, casting the inputs to int do not
change the values for valid known inputs. For unknown values, the check
does not change anything since it's a compile-time check only.

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
 include/linux/bits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 4671fbf28842..293d1ee71a48 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -21,9 +21,10 @@
 #if !defined(__ASSEMBLY__) && \
 	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
 #include <linux/build_bug.h>
+/* Avoid Wtype-limits warnings by casting the inputs to int */
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.27.0

