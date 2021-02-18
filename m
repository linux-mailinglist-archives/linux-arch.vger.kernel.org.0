Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE631E4E1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBREGG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBREF6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:05:58 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B09C061786;
        Wed, 17 Feb 2021 20:05:17 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id t18so363531qvn.8;
        Wed, 17 Feb 2021 20:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjM51SO6l5RqBw16sI+XBv1f2Gk72M+10GN/T1hPkUw=;
        b=tQD4PA1ZBz9hxO1fyxA0bTFp7t+2ASMYO+EIZp4idJBNB/NBrvx1/7R2yVz8hvu4Z/
         GgydpSGyzq5aMZa7vLHYCFBJmhZzBc3ni4C0scnFIa5WP6TUGAwWIywJx36+b4GKL9/B
         8utCzLs3iZCzjoJFh0S8kZaopfa70aAph47r0N9yzQ9jd2u24vz0p2oiaumk5EK+uCuP
         ML5Wjjz1qQYUajAajveO0n4NbiPyaYHqpMBHDoiYhU59bel0CiLsMb8ZAPHP3q7n9Zk5
         3eJ4nfdMlY7wSImEMDwEL83hljZKbQ1PXze+s/jm8Ov4JNFm7oAZGzAsAg+kUIsrX2JJ
         nQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjM51SO6l5RqBw16sI+XBv1f2Gk72M+10GN/T1hPkUw=;
        b=hxMSJJBnsfxNxfkUv+M1uYZeZged0AMb31hVCWf9Ka0OT7rkv/oFC3sx/+ykbdDgvO
         va2PTbS5nBMKIofCMBlmPghUkOTiTyghFQtpPigUeDxb9zQrJ28RaTP836Zt5LdtACwo
         D/ji7YVAZVdmsKMgUHATHl6FpHw/4jOYm9t5+nrwUX/jyROVEefaalC1/WiwnYXiTLgx
         4jAxwrYwbx8Bg8OYNDef9BXauUhx9/bWXabSKh8vkC72f9C5pfgeZ17smGOE+nrqryNH
         o6nKcLqjqditxU+81rTKzhbu0B3qZC3Q0XIAoB9qQacQCj1M7Yiv13GcD5qb0vSLuqp3
         pGcQ==
X-Gm-Message-State: AOAM5306yBybS4z9zLYGzHKr8SNxsuc8Ml0gMnLaYGoXDO4mMkML9KrN
        ctoPxASfkScLXte9IZr4mD53yxfrg38nxg==
X-Google-Smtp-Source: ABdhPJzUGxM5w3clGHJ2cVX0U5vK1IU1016oKufuc6XJS0RDTugjR4Ry5eXkXQJ/RyYQCnMm/efkUA==
X-Received: by 2002:a05:6214:1643:: with SMTP id f3mr2726787qvw.4.1613621116807;
        Wed, 17 Feb 2021 20:05:16 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id g8sm3111922qki.119.2021.02.17.20.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:16 -0800 (PST)
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
Subject: [PATCH 01/14] tools: disable -Wno-type-limits
Date:   Wed, 17 Feb 2021 20:04:59 -0800
Message-Id: <20210218040512.709186-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
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
index 4255e71f72b7..457c9a31690f 100644
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

