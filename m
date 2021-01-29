Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CED308EA5
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhA2Uqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhA2UqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:46:14 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A93C06174A;
        Fri, 29 Jan 2021 12:45:34 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so7714048qtw.4;
        Fri, 29 Jan 2021 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4O+2eAHItq530Za1BVox+dCW1ufg6RlD/AvF2OmkPic=;
        b=keYlUHg/cxCHBo5foiHRfFvy3ahz39Fl/M+XDHZMxa43DXCBjaZPSmxE/+WThOYBEL
         Vyr0+s2wisoFPhyKWfpDJpfcAY83sTAup0htX3/49GfsUEDApZrAoAwW5msUszoXUmEP
         Ee1rAoPkHYJNMjN/FDxxiLzNZ+xe3M2TZ8aPCAHIRqO9+4wERW6tpZhXKkZJO2yGS67h
         9Z6tQ16pRSUtby27IVXPFItmEH1VaEpNMa0fI0+UkrS7KaK/VHu08GVKrpdEZPzbIEvj
         9xbzLDWpoFY/9eyqxtke8mxcMJZOiJ4YSAcqsivougvSxotmAl3Uxwr7acTV/oGMIPIO
         CUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4O+2eAHItq530Za1BVox+dCW1ufg6RlD/AvF2OmkPic=;
        b=JDVLvdbZ98ksKkwaxdsvO6ljGZSqkO8Ux4tIo6Aufy00lSjC80HObM83pVVdkeDqaz
         ntqA6ZaExiqkHvgDyPpOPtpUjAFxu7KhUXDPHBBxTlaJQtiNtBcPuLlRGxdp43JeWL88
         Lsn0Eqi57RFadOwN3KqJZHRvFZjuX/5Z9kFZRfvrR/ksr0PLnqBaSV5wMFSRid7yK+rR
         lvCCApkq1KfgOqsliHZNlpV80qwUlFgT6jyKYRpOv9vynEldZ0scHcbVOkPw9N3b2jmg
         anLwr/npsrCiUG23QS56Hjj8IDTZioAAQauC+D/cChgX/Nh4OAHFTUCqdDAqFEH2GADb
         ml7Q==
X-Gm-Message-State: AOAM531C5xBhF3+qbrLDBxJov5xDYdBAx7OiRTGcYbW8rJeUHrvaInG0
        67/zCpPd2CLO4vfJL504604=
X-Google-Smtp-Source: ABdhPJwrQcreXpopfQh+czRd/qmFaU3nnNBoKQMTJuNicywcLpuVJea9soSa7h9jolviqUhwEiHarw==
X-Received: by 2002:ac8:1094:: with SMTP id a20mr5998989qtj.248.1611953133868;
        Fri, 29 Jan 2021 12:45:33 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id 193sm6946791qki.28.2021.01.29.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:45:33 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 1/6] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Fri, 29 Jan 2021 12:45:23 -0800
Message-Id: <20210129204528.2118168-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129204528.2118168-1-yury.norov@gmail.com>
References: <20210129204528.2118168-1-yury.norov@gmail.com>
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

