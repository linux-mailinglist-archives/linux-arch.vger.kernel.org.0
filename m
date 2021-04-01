Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA035209E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhDAUcd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhDAUcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 16:32:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAFC0613E6;
        Thu,  1 Apr 2021 13:32:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t5so1647079qvs.5;
        Thu, 01 Apr 2021 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrRmoKrgox5TdPF5v5CxQyEmXDXtni/IJFJUUVdCAgc=;
        b=a2HX9LLYYbw0SBHdBm5Ey466W/mYdcoPD2OEs7MlsBSUI3W200E+8yuJ4AYQd6/fLz
         aF3sMs/TQrP/xt2ABtPwXSyULTLmcOZFK8qjJuPiFlyE3jThTflADO/0jHBcCjnwRjwQ
         Po3BwOI1VhAIpKwTRsM71VgV+h8tOfcLRWq30sTukmdUfXSX89Lu5i/u6UTE/oCuj9vA
         tFgHCLpkF8ltRrjt21gLw/7u5kSPmYhRi9lcwyDf82MC/6DrerYCv4xC+JLMccg0uBQC
         pt5UvdBMdJT9vZDXxefuFgY/78jfBTm0JbcFdQFEY6u1xmtvzCiKmvDpdQHNc18kAxWr
         QGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrRmoKrgox5TdPF5v5CxQyEmXDXtni/IJFJUUVdCAgc=;
        b=qVhgogcAtJmetfPasl+jng8ed9J7qvMDG76uS3BSkqx0bb4u5wYn5ht/65KMK7+hc5
         GHPAuE3Bm1Bs0y4j405woUvVD0fzQ6wVstwn3Irs4WraqiVyOBQxTeXqxeousy9NT6HU
         xbYKoByIIVK6569EXpHY4HPvg2y35wYWcIR1gbLcba01lnyzLfkP1m+6ztNgliQ3GeMu
         ynJmXIiaACE55vSwM937NdX0QUwtKb526SAxn8i9hGwvYAjtuYgqTe/f4fTHIM84mvpg
         0DhgGDvx2/aD8XSE0kZHa2/SoI+q13M7d8F9GYo7RyJ6+dOf8zUVN7lrichWZmfgxowA
         snXw==
X-Gm-Message-State: AOAM533OEbTOUc6Iw4D6fDfsvBCCb2HNTze5QlFwoXNM53XM/dWQJTCq
        gXGq0TZ5/IuzXH1BxtcwEuM=
X-Google-Smtp-Source: ABdhPJwv9FqVwsX5szrMtboAEThcjgirdWnzdo0IDWvh2Xlx2gJNw8gf0DcpQJoqFGub6qBVWdWHZQ==
X-Received: by 2002:ad4:4cc8:: with SMTP id i8mr9799347qvz.56.1617309151291;
        Thu, 01 Apr 2021 13:32:31 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o36sm4516969qtd.89.2021.04.01.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 13:32:30 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] h8300: rearrange headers inclusion order in asm/bitops
Date:   Thu,  1 Apr 2021 13:32:28 -0700
Message-Id: <20210401203228.124145-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch fixes [next-20210401] commit a5145bdad3ff ("arch: rearrange
headers inclusion order in asm/bitops for m68k and sh"). h8300 has 
similar problem, which was overlooked by me.

h8300 includes bitmap/{find,le}.h prior to ffs/fls headers. New fast-path
implementation in find.h requires ffs/fls. Reordering the headers inclusion
sequence helps to prevent compile-time implicit function declaration error.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/h8300/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 7aa16c732aa9..c867a80cab5b 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -9,6 +9,10 @@
 
 #include <linux/compiler.h>
 
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/fls64.h>
+
 #ifdef __KERNEL__
 
 #ifndef _LINUX_BITOPS_H
@@ -173,8 +177,4 @@ static inline unsigned long __ffs(unsigned long word)
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/fls.h>
-#include <asm-generic/bitops/__fls.h>
-#include <asm-generic/bitops/fls64.h>
-
 #endif /* _H8300_BITOPS_H */
-- 
2.25.1

