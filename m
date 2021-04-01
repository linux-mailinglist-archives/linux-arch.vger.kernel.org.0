Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31591350B31
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhDAAc3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhDAAcB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A9C06175F;
        Wed, 31 Mar 2021 17:32:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so738267qkb.0;
        Wed, 31 Mar 2021 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uuPJmp4KPyBUDIxFDzyUQbihYygKnVYzuD8q2fLg24=;
        b=tnUuHzaTi5SHfRkAYnEcSS+yZMuArFiYAEsm6VW7UMu0JYpEEqe5parUy9bXUbzwBC
         PIHYusMQt+gL4hBuInRuwDFW1WYBwtsZPNWwkn7RxTjS/jnU1e8ryGBtiPcRliB2JCX2
         nvJGAmlPRl57ynCUgC4GquzSUGt3B0qQbvf19gndonphmYKUsB8eEgSyYSyjA8VZTfZY
         Z4wB7uBn3ImDRworXxm81JUcSLPKzD4kngXHvONLAQLJY2nTmz+OVphQCjgDBddnvUwC
         VbwgIlPRCegHF/+ZxOueMIj7GGB6n7EyjcuMFGu2Kdoleav4gOs8Pum1Qlm9wbDXhVaJ
         h4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uuPJmp4KPyBUDIxFDzyUQbihYygKnVYzuD8q2fLg24=;
        b=XiS3GV4XZ4rxcvUMr5hLOngkezmpQ+7+SVY+NIcha3JG9oEO9v0slhNyDnCaVn8IsA
         Rs4uxwZfb1LPGvpa0ahdRDXbFwhdzeOuAYHyRtTJ+/S0iaQQa7Qa23ckQxvuz26w1Lub
         tFGxP+KGiqc7/xvSDQGZe8qsNMk7/2TICHx/xfjst4TE1l3yb+1t47jCYKRW4bMyBhRP
         qDYWeXgpS31B1rB0O+pP9OTpGQ1rZfrC25wEYbALYyjDUhE/rYSw+kcMpuDIM2DJ5/KP
         8WD7WsGU1OjwUU6ikAH5gdI21GfqrUpiHplb1xA0ymKHYCmklzi/ee+cINOVWumJ9T8m
         luwg==
X-Gm-Message-State: AOAM530PmPqXTuo61iQ0E2FcR5veNSsoMEvT4F5oaAjfmLJnet/LJBcP
        FDZPRtvMvwtiaO3ukW016BOIOa+nJQN58Q==
X-Google-Smtp-Source: ABdhPJzRXLRztd90mQ6oRp5qrd6JMX1GHtY43/lsJOUZ6j2zuF1i9IOLQZIcrDBFEWY8J7Z4qQuhGw==
X-Received: by 2002:a37:4017:: with SMTP id n23mr5587513qka.338.1617237120204;
        Wed, 31 Mar 2021 17:32:00 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d2sm2329793qte.84.2021.03.31.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:31:59 -0700 (PDT)
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
Subject: [PATCH 04/12] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Wed, 31 Mar 2021 17:31:45 -0700
Message-Id: <20210401003153.97325-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
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
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

