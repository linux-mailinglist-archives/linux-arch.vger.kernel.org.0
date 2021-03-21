Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C1343522
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhCUVzi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhCUVzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ABC061574;
        Sun, 21 Mar 2021 14:55:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y5so7193461qkl.9;
        Sun, 21 Mar 2021 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAuTHkwSalBqH8EpHoooy9z28mwSmA5j1f0I3O8Qj8s=;
        b=aWNdkiyG1pnPbHlRbaAr9/G0mrj2MDD7/dCcLcAXV9sC7zJY4HLC0dO6nZ27EhbdCb
         goDlKHanaXmeLSCYIxXB6QsDjfaEzIPF5lS5mVCa8XUiYnK/zubJ9iuM4DMm3lAOrpVY
         n2Kag4YbXxQwjayeXdN2p+oZ1+Oq2lyK442ZZkrc0qE3ImRn0i+ITtzz7XJ0XBPhXDFf
         CagB4ah28FV4y7H2hc/Jt0VQ0dIAA1VM+OdQDFSCzUjSgwro1nrFlxTN3scPuF7mBgav
         qLt46+O2gFKytRr0xWIio/EJ71kIVaWueIcctkJmTB81xPKUQH7hsfinzStw+4FyySIl
         iLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAuTHkwSalBqH8EpHoooy9z28mwSmA5j1f0I3O8Qj8s=;
        b=dfgJV1Arrw1Sa7mrbj2i8uOyzyMoR5VEkLXl+f1W13g72D4OXvEG/rsTcVc0fSSasg
         eYNZIE1G7KjwZdRTNnrGy+7ddDNMz1sm7Qc8Nr00AxMdmtRlo76/jqQQ7o2ZcSCtuMFW
         ZUoiq1lDz6GW2S8VrQB71Mru/gc6x5dm8ynqt8vPMCa/w5u8HNO5O0WU+ykkS45Nzfzg
         uJHQMxStNOT9Zb4pvXg66ZPi7wEgF7noFams6iYS737nm8L7rbNNnTrRwvYfXIqMSQeh
         49B0otwTa3rtIsDnpPu1Xc50fPmUYioHy0gF9uH38iJ9xWlkWq/EXC4AfmHIv5Vqy/8o
         EacQ==
X-Gm-Message-State: AOAM531PWrfxg2n5PTb3Cw24+JXVi4uZg4HKpZKe2hWdKS9oJihOGvUZ
        U6Tv1vQwXBVdZgpi/7fbNH28M6Vb/Gk=
X-Google-Smtp-Source: ABdhPJxv5U9VxhI021Y3roE5aLS9UT0amOR8ySPsbHE9GRgTfrypz9UKZMr6B/vS/YSvcPAEQ71/BA==
X-Received: by 2002:ae9:ee07:: with SMTP id i7mr6920243qkg.233.1616363704020;
        Sun, 21 Mar 2021 14:55:04 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id v5sm7838933qtq.26.2021.03.21.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:03 -0700 (PDT)
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
Subject: [PATCH 04/12] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Sun, 21 Mar 2021 14:54:49 -0700
Message-Id: <20210321215457.588554-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k and sh include bitmap/{find,le}.h prior to ffs/fls headers. New
fast-path implementation in find.h requires ffs/fls. Reordering the
headers inclusion sequence helps to prevent compile-time implicit
function declaration error.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/bitops.h | 6 +++---
 arch/sh/include/asm/bitops.h   | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 10133a968c8e..7b414099e5fc 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -440,8 +440,6 @@ static inline unsigned long ffz(unsigned long word)
 
 #endif
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #if defined(CONFIG_CPU_HAS_NO_BITFIELDS)
@@ -525,10 +523,12 @@ static inline int __fls(int x)
 #define __clear_bit_unlock	clear_bit_unlock
 
 #include <asm-generic/bitops/ext2-atomic.h>
-#include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/le.h>
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops/find.h>
+
 #endif /* _M68K_BITOPS_H */
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 450b5854d7c6..3b6c7b5b7ec9 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -58,15 +58,16 @@ static inline unsigned long __ffs(unsigned long word)
 	return result;
 }
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
-#include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/find.h>
+
 #endif /* __ASM_SH_BITOPS_H */
-- 
2.25.1

