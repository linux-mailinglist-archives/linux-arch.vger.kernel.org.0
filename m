Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB90350B2D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhDAAc2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhDAAcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DEC06175F;
        Wed, 31 Mar 2021 17:32:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g15so672381qkl.4;
        Wed, 31 Mar 2021 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLaToynb34vCY0WsqTIIvNMqMj7JroWGIPG2ZoVyHKE=;
        b=svkDk5mWqO3glvN3JvTdqGbhsPi1i3X4XIYG7cJ3lkcUxRrO56OK5a8GY9lHQ1GFC7
         t1NyPdS1otoqYLAtMg+kil+wqOyRUYljX8ciwBerwR1q/+iUIMl+V+Cv4sOru3GKvmdU
         te23D4roPnb64Hwg+Cz5t8X0QqDN1/yugozifB5rsRiOpfFFPYxVPYwZ1cUlOAQz4qgw
         70wj4PZ0rW3nfeSUKllDAy5LZ6yg2xyJYR3lXPg6mF8DSiE7d5ew4etnMvXBl0FM5gQB
         kQJC2wf+kKUvdflRzsSNmO8hmTvUQC3V0O+CabwXR6rRyF5agZExh/XDQdJEupAjov9M
         Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLaToynb34vCY0WsqTIIvNMqMj7JroWGIPG2ZoVyHKE=;
        b=A5Nmc8xOAqkJERnEiX74SvQqgDUidYX+xAnruAGYh9TKwYjZN0zYNog3NvE/Ze0lzG
         x3WTqPZtYK+USm07WD/Mx/5zDrLvtZwRCndST/C+Pl/ZYLQB6PjjLApP5L2HOXtCO9Fv
         sVuyUFI1j3eFlcRYDcWB8DAr5+IUaQTXgJHTfUhrKWUMyt/VNL2GdMziKzYlAd8z0q/E
         JoFiuxFJ6cwv/+yU4x3PmPF2AxKmMfwZut0RI1ZSTUHlBBkQdqZFNAvTzmRvxhXYVGVg
         2OQk1fFbJLflN+6xtQkycbIKsWbm7S5bkB5xtHFWmLojzInBx1SAQkdZb3XHvdE7+Gu1
         IzuA==
X-Gm-Message-State: AOAM531OUUetbGlZ11EEqBgNhGMebVcc27fB6c42E7eZuswMNMGA02qp
        7Hw/WdgABmWQnDiPk7tFRVC70UDSrHgh0A==
X-Google-Smtp-Source: ABdhPJw97coW5dsJBqtNTv97nAQBCkwgRk5f6eH1cuZ+xulBrprB+U0oPI85rsK+uupFWl2CK1Gsww==
X-Received: by 2002:a37:42cb:: with SMTP id p194mr5536925qka.213.1617237119002;
        Wed, 31 Mar 2021 17:31:59 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id q125sm2785567qkf.68.2021.03.31.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:31:58 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
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
Subject: [PATCH 03/12] tools: sync BITMAP_LAST_WORD_MASK() macro with the kernel
Date:   Wed, 31 Mar 2021 17:31:44 -0700
Message-Id: <20210401003153.97325-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kernel version generates better code.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/linux/bitmap.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 7cbd23e56d48..4aabc23ec747 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -20,12 +20,7 @@ int __bitmap_equal(const unsigned long *bitmap1,
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-
-#define BITMAP_LAST_WORD_MASK(nbits)					\
-(									\
-	((nbits) % BITS_PER_LONG) ?					\
-		(1UL<<((nbits) % BITS_PER_LONG))-1 : ~0UL		\
-)
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-- 
2.25.1

