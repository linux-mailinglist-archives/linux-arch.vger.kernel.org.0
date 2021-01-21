Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44512FDEEB
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAUA5e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbhAUAHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:07:23 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A2C0613D3;
        Wed, 20 Jan 2021 16:06:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 19so94770qkm.8;
        Wed, 20 Jan 2021 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJyAeNkICLzobewilotYyvHX3yTrS03Tp5qJyqqjL0g=;
        b=irEJfFhw75j0zxYyv1AJTNPEoITdlEq7ViAShlWlaluOp16XsYOBe6kv5B7Gs1yMLk
         Bz23HPNwKq9hVgiS9Lw7ph5GtM0TcGmHGx+oH45vktz+664CXPQi1TO/hEq9zM6h9NZq
         Lwr3XWL12PINo5J6vj1wK5NrvFfXCIORz9SJ8bFDJvoSm1w2qvvgNAoGaUcd3IEzHNkF
         ZL5nkVm220A+txnXZm4wu7L+y3gptXZ/92SG1hq1S4viIF8WD5qSDGqgvgBCl8NJzPcC
         aq4ZTVsaLNOM3QREMOhSzOhjSQ24ZjeKjWnlUCytjGkn3cF9+HIS6gVrTTedDSNAqdhe
         HGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJyAeNkICLzobewilotYyvHX3yTrS03Tp5qJyqqjL0g=;
        b=VMEjCdl2RT1bj9Cf96mLdproxdrqH3B7bw80CJrb4z/JK30Est0yLEZcbeb3Of/frk
         OxWD+K/NLT0KMAf65ir7rhyCNNlj+O25hzgzcdlD8s0+dfdXdpba+AjScQRDpCYNsBys
         +flD6HbgP8VPS8zs4n7Hgh/QwIJ1jCpGr8Kp1jbmp/QAO1Uq0sE0Rpvi7uXw0oowaZ5D
         X0D2K2W78Mg5Deh9jAZqdQ8dmS08ydcrt0hmd8a2ztP10Mujsrz96eOpSaVZH1aeZKba
         soPABRJTWDtc87OkaqHm8Ngp0mTFVSL+9cQCJXGJOe2dpy2q27jU6dk0lzdBHwc+hlUa
         7FRg==
X-Gm-Message-State: AOAM531m4FMs5BJdqqvqOe8OkiZSDAQveWxntZ1WY4yc3+T6COJsnyqC
        xtarV26HYQ45seoU4m7S4zY=
X-Google-Smtp-Source: ABdhPJwK96z5HSohBB4jgawql1ys9+J+U8m5f6SbrirOJTJj1+oKcKeFV63KJtEdZZ6RU5gOTh2EvA==
X-Received: by 2002:a37:4286:: with SMTP id p128mr3589516qka.337.1611187597005;
        Wed, 20 Jan 2021 16:06:37 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id j124sm2505020qkf.113.2021.01.20.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:36 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/6] arch: rearrahge headers inclusion order in asm/bitops for m68k and sh
Date:   Wed, 20 Jan 2021 16:06:25 -0800
Message-Id: <20210121000630.371883-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k and sh include bitmap/find.h prior to ffs/fls headers. New
fast-path implementation in find.h requires ffs/fls. Reordering
the order of headers inclusion helps to prevent compile-time
implicit-function-declaration error.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
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

