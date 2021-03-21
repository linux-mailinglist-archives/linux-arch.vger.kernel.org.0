Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44A5343530
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCUVzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhCUVzM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:12 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2DC061574;
        Sun, 21 Mar 2021 14:55:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 94so11047563qtc.0;
        Sun, 21 Mar 2021 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XStqP8D36CZJzw2TftI54Ck6LfKQaVMF+TC1pFq5UY=;
        b=boTqQ/9S6wam0P8nPn8btJusb093uXNIQ+5szswt4fPF0puRU1LwUoRPlSnbGlSVnf
         PG2rgmLg5ihl/HCy5l6yfzUd8TRaVTUDRyrRS1H1ZN87AK52jtsVD71/Pc/KZTdQLxDc
         Wp5oIZI69GG7YfRRGgLa4owGJIvKKbA9o8TvAOWvQvd/A3MKF5iNQOs6fjw6q9R7zHDp
         CMnjcoMcruP8lRHGDsx+Qwwphj2+AiLyk0LSQndypvb8zSM6Q53FFa3+B68Htng8VvfO
         3EZJAhcrCniYhwdqvXwn1cXMpcdyfjpVfAwsNMEci4jRkx3E9kV5CyaOmbXCN7Dxz73k
         xafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XStqP8D36CZJzw2TftI54Ck6LfKQaVMF+TC1pFq5UY=;
        b=jnRcepvG01cOaWeIsE+ib/BimKG58xKnhVPwEp5wOvA58s2svqLJWuNreKxoJIkwpA
         bMota5QQt4TBAryjgwKn196ea74EbVYAbkLZrHyfLUDCgno9S10M0nEfvBc+h3Dam1g0
         xQTqf8dXoBsi8qFDQMI2vimVJW212wcE+KmqKdQ/f6Gja4WZA0eSeC4TWxE8+N1bjl1X
         r8JLBecwsSxJV6f0ZOL3Y5LtAGAj7O35ML/6jqd+CKd415MDyKoxCVVs8AlQdC1h/BtR
         9w06aYyDt1qxCUtLbiWwek9rOVBlaDnucKgNQcW4J1QEzozzDqMTjmAaOLeL/gxVECb6
         pRww==
X-Gm-Message-State: AOAM533dkTkfKsccc+j11M6r1nwh6zeudnP1iNMTo98YVRlxv34kwJSw
        /THKMhnGt19uakB1WROiehF/4lS6HCA=
X-Google-Smtp-Source: ABdhPJzuEUoa9KmXdMY9wULzE4YA/lfRLKC+pxc4pScjCeblaVmy7HRsyA9lMPhMUxxsJ6k5t5/hJw==
X-Received: by 2002:ac8:6790:: with SMTP id b16mr7160203qtp.379.1616363711463;
        Sun, 21 Mar 2021 14:55:11 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id r133sm9655356qke.20.2021.03.21.14.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:11 -0700 (PDT)
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
Subject: [PATCH 12/12] MAINTAINERS: Add entry for the bitmap API
Date:   Sun, 21 Mar 2021 14:54:57 -0700
Message-Id: <20210321215457.588554-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38ee5c1a7c3a..62be169be25a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3163,6 +3163,22 @@ F:	Documentation/filesystems/bfs.rst
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
+F:	lib/find_bit_benchmark.c
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

