Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E495831E4E7
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhBREGn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhBREGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:42 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F593C06178C;
        Wed, 17 Feb 2021 20:05:20 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gi9so357119qvb.10;
        Wed, 17 Feb 2021 20:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJENUVTTVrzVSsRoDJyoUWRsHsS22gYzvu4pIcEBs2g=;
        b=cNJUvLFqphk0K/lqrq0Qjn312xs1KS/3LK1bGTa2ELl9lD7az5WCGmCXVfKWK+5r7c
         ZtT/USGeWcVn+HKxgmLxPOP6UQFVJa0PNXbaO2nRqBjcowYlIBCFPW+Wm2l9qlhw77u1
         wuWJqmcMjZkG/GtkEqRpgYv3CHz5W1SqXk/E8aHXvVIEqht/2dCNBJo/HaIJgBI3bD8V
         7iyCFP+tN1/YPyLgotriolwMI25DHmzh7EEBv5kFZXhMHrYOaTOA4EyqiED4CbbuCdgB
         rnw6Qc4epf9pIxgL22Qq6Ml0RJxgZXdCSZC3ssNnoYSlLO/wxAIUBmo8ZDv9P2bxhu8o
         eEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJENUVTTVrzVSsRoDJyoUWRsHsS22gYzvu4pIcEBs2g=;
        b=ItCQAu2cpvijbPc1IWJm+S9uLmT+StUFPh5LP6SMBDx50hYKuR9NUFnXvtxqOhs3Ei
         X6N/lDUGxBMTzBIofy0hLWylVLcF6D7iKJ9TD7zgrUT9e13LkYxahqRa2xXheOnLwhss
         gw1CXHq1B8viVrI/bFZIzsUNm/H3c8EptfLMadFw9658kBptRnEmcrTaIHUQKOfn0Nzm
         oY7+j/z5D0+g91ergNWc4P2lq27L+5Tn2rIWF79j8ss5CUdHcn/oyq3wJLaM9DlP1Z5b
         bUfrFEN7uc31JUwpIaFO0fnc9Wdn2WLl2kjL83o0PpMz6olXiQgawzjKVE13+CIOG9a9
         yjmA==
X-Gm-Message-State: AOAM531lrX0gMcoWOnp96H1gSn5dlBp/cbbmg6xaxsu5UTOgcq1IuOnZ
        0o74dO/7mG+Ip8xCE9WSuDG3Tcr3J4seOQ==
X-Google-Smtp-Source: ABdhPJy0+QbSdvRColmCZHyYPmh/qO2RwqalAYB5I6htKRTN4sc2ZFQ9tkLgGhBq4G8GGqGf5zkcMg==
X-Received: by 2002:a0c:fb41:: with SMTP id b1mr2589507qvq.26.1613621119021;
        Wed, 17 Feb 2021 20:05:19 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id e92sm2554283qtd.96.2021.02.17.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:18 -0800 (PST)
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
Subject: [PATCH 03/14] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Wed, 17 Feb 2021 20:05:01 -0800
Message-Id: <20210218040512.709186-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k and sh include bitmap/find.h prior to ffs/fls headers. New fast-path
implementation in find.h requires ffs/fls. Reordering the headers inclusion
sequence helps to prevent compile-time implicit-function-declaration error.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/bitops.h | 4 ++--
 arch/sh/include/asm/bitops.h   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 10133a968c8e..093590c9e70f 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -440,8 +440,6 @@ static inline unsigned long ffz(unsigned long word)
 
 #endif
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #if defined(CONFIG_CPU_HAS_NO_BITFIELDS)
@@ -531,4 +529,6 @@ static inline int __fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops/find.h>
+
 #endif /* _M68K_BITOPS_H */
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 450b5854d7c6..792bbe1237dc 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -58,7 +58,6 @@ static inline unsigned long __ffs(unsigned long word)
 	return result;
 }
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
@@ -69,4 +68,6 @@ static inline unsigned long __ffs(unsigned long word)
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
+#include <asm-generic/bitops/find.h>
+
 #endif /* __ASM_SH_BITOPS_H */
-- 
2.25.1

