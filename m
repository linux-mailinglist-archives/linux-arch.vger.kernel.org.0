Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80249343516
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhCUVze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhCUVzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF2C061574;
        Sun, 21 Mar 2021 14:55:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so8742230qkc.5;
        Sun, 21 Mar 2021 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7JdQMPMgs8V6p2mIbAAMliZc+Q/jwU8V02vmoeVTgc=;
        b=i8nKqZlbUpoWJrvA3SGtK3S4Wou/OIZTIBqJKR2kMwz57vvwN260GX9fz7ZKc/Oi7W
         Oukvw0Lzn4khAl7Wa9hsqTxkyqeR6WuClBj+5Dp0p6Z5zsi6URFoDMD0Oqyk32+ittC+
         q9dVt88Ppi5tjEA1uXwij/Mk8/HpX5YN18Yb2tM5M/tSKb/wV1rLBDo3F4h3kZREtI41
         BPeQlUVdBsTzjl/ULZUpHP9SIGLooSSUT2l/UmILOkCX61J52d6CVvWiUlUIOiKIk3M7
         Wk79OQtKwAPqq765O+tlhjw/LGOOm/ddQ4qZZXzD6gHmyTkcTqSuEKKrD1oM48cKXKNY
         xL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7JdQMPMgs8V6p2mIbAAMliZc+Q/jwU8V02vmoeVTgc=;
        b=C9IdFAmxIGFFrQ7wtiff8pgNjMKiwzdK70EqhlCCY53u8nmALyvA3GqU4j6MCOWQSv
         l0uH2zNK8Plu0xvOd1nsOLTMbV3ycA+DQGKTOrqOa8oNh77gAJnh19FQTQO+/o0gNREF
         SvD59MLTIBedSZtHw7AL+UR6+99uzboNpwECFO7luwZiS4nBO+K1zr0yrci9CqKHD3S2
         C4T6ZadL+2CcMCRSnvx+MfFBaxeb13NQX9PIOmC9nWpzBkOG9DtuO0UeqGvQpBn06LcK
         do302ujhOHkLHcl/B7Rfb9fpTImfL8gPo/AxkwhyLJ0vh8mneJzqx9XpfKovi9FmOphT
         T5Pg==
X-Gm-Message-State: AOAM533n+Jtg/ETeVUrJQqLWZJcd7L2ZB5ngHRfyGLM+IUvzeMnfsUb0
        w00t+6FjNWUw528VJDdR9cO46ACrHKA=
X-Google-Smtp-Source: ABdhPJxaXv9Xf37vBcTUmnfJmYRsajKHGinABLTlOhmsEfI1G0L3rHUlebwGQFQrpLkVUe5VpYtLfQ==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr8274855qkg.168.1616363701088;
        Sun, 21 Mar 2021 14:55:01 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id s19sm9365819qks.130.2021.03.21.14.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 01/12] tools: disable -Wno-type-limits
Date:   Sun, 21 Mar 2021 14:54:46 -0700
Message-Id: <20210321215457.588554-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GENMASK(h, l) may be passed with unsigned types. In such case, type-limits
warning is generated for example in case of GENMASK(h, 0).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/scripts/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 84dbf61a7eca..15e99905cb7d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -38,6 +38,7 @@ EXTRA_WARNINGS += -Wswitch-enum
 EXTRA_WARNINGS += -Wundef
 EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
+EXTRA_WARNINGS += -Wno-type-limits
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-- 
2.25.1

