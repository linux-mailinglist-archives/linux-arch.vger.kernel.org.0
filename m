Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9E33CB22
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhCPBzN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhCPByn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835DC06174A;
        Mon, 15 Mar 2021 18:54:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 130so33772107qkh.11;
        Mon, 15 Mar 2021 18:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeKeCrL0MI2F9lqPgByT6M0Kwx7kgFjWSejiRp+cD7A=;
        b=HXxgkHr0JvsTJ5Wa9sQlGiMHMihYzgGAFCnL3MQ+2qXeYhptuIiviUUmyiEfleDf0j
         v+i+d2cqL3mT7r6O8VtPkORDY5JNnmZS7ZJ3fj1roGEEjMHHnod506svTGGx/d09JlOq
         4arQtiVKR4Amn2nf/sBf/NDLZ0pee8rvp/siORsD69EYEV+a83eY+jszpaXmqS3gm2P5
         g4tuFNAS+FyMaSRkxZYh9Ad5DxBkUd8jaRKwazX39QtsNRSvzYhQ7/Ha5jwImTX+REGi
         QbHlfQaeCRJ4/jEUSmUX01gGMfG653h7+hM7PcYlKI4PWGQAii74F+YuJCH6XXa59aVq
         OJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeKeCrL0MI2F9lqPgByT6M0Kwx7kgFjWSejiRp+cD7A=;
        b=I9JaKypicqZ4lMDO7GQBWxSxFl/axn3QLK96OX/I/zLbTbUOen0pSBa7GP5bA8QVBC
         4PxZJyiHqKDh+FOkkXq2qHSXBHSMfUhS0jhqTRmxbwn0PzMHaiF5bzeCSVFTBF2d8Wxw
         TXQ/9/IM4RNL2HrgbvKj5IUpQASskY9dftZxftAsOY7QH+sabyRSKRhQUxlSIukU1Uml
         /P46gFORIk5WV1wt1uBRSVn76UGMRr+U41CeKBkBhKwXlWnQsW3URThKevdbbomgUrM8
         bXsDqijJbwKmBPolYF7g47VDV5jovcg4RBviH+J920DPrUCUD5i35gh7OpDR8OH/U1V8
         b5Sw==
X-Gm-Message-State: AOAM530NLPjQ4c6HiG9uFePMhib2eNqgPl0WmVyl5R2hmTC2FFE+9fI8
        j2PBt7e5HhkSY3cdajsskb7My0b1vGA=
X-Google-Smtp-Source: ABdhPJy9Co64mtp6x2Wrb+LisAdAzh/bbO6eoIq/TEYaLoLBTtHdk+xfgISLKdYg2BBKazo07rRKfA==
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr26829500qkl.416.1615859682248;
        Mon, 15 Mar 2021 18:54:42 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id f136sm14189503qke.24.2021.03.15.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:42 -0700 (PDT)
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
Subject: [PATCH 13/13] MAINTAINERS: Add entry for the bitmap API
Date:   Mon, 15 Mar 2021 18:54:24 -0700
Message-Id: <20210316015424.1999082-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.

I'm an author of current implementation of lib/find_bit and an active
contributor to lib/bitmap. It was spotted that there's no maintainer for
bitmap API. I'm willing to maintain it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd20015696e..44f94cdd5a20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3151,6 +3151,22 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BITMAP API
+M:	Yury Norov <yury.norov@gmail.com>
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
+S:	Maintained
+F:	include/asm-generic/bitops/find.h
+F:	include/linux/bitmap.h
+F:	lib/bitmap.c
+F:	lib/find_bit.c
+F:	lib/find_find_bit_benchmark.c
+F:	lib/test_bitmap.c
+F:	tools/include/asm-generic/bitops/find.h
+F:	tools/include/linux/bitmap.h
+F:	tools/lib/bitmap.c
+F:	tools/lib/find_bit.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.25.1

