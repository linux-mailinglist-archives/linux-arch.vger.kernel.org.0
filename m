Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC203097EE
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhA3TSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhA3TS3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:29 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E4C06178A;
        Sat, 30 Jan 2021 11:17:26 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d85so12243793qkg.5;
        Sat, 30 Jan 2021 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntuXE/fozW4OYLIfk3AXud9KNO3wb9+RCyU1o10Z7KM=;
        b=lC5F1SCVrEruvlrh/kh9YAoptMUjB20RBPdNn+buQCNCol0Pl5FFtzTpSGtlq0QY/S
         9UPRCB4uZY/Gim3zRMiPfOQR8zqMwLDMdP2MYLSdZt20tCcpqikHc2JqVGlvB5edqZs/
         KVgJ/MSUQ5aT/W0pLKD0m8kk0nfHhbeBzeAhPC+2p7SXYZb1Lzi6ChbpJvpDe6kUa0kF
         OJr7TZ/K95t2EnCXw85RZ0+ViL4ovGt+lsoucWVk4SS8ImG3cSA4AxOBFQynaCSNeKDZ
         FWgBJOnAoWx5SISO6EUBdtSTnSe4CrcbuAxj2WQoVmKE6HX9AROvw1cY8D46Y8CxxoTy
         4DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntuXE/fozW4OYLIfk3AXud9KNO3wb9+RCyU1o10Z7KM=;
        b=ehhbf5B/e9cNRaPd/vLlP9ROiTLh5zYXXOWlNXvXgu9qUYWFvEdFZ9YAYbfNBDRcbW
         5UHfLd1I5JeVzYkwaWquuqvyCa8PHdjgdOjGAeNawPvISDZyPGNGf8q/W+xbLcgSL4Dw
         wf6tQ+csYJvYlAwSsCEb0u6+zMpmSL2oZczKyNhNU3buBPtBAaI8I6WAqT1iazJ3OVSz
         F7iwUw7EvYxtIOSrqbRfc2ggJ06xh+XeKPflCBldLRuCfv/WbD1vo/PNAAMK8m4uZZkB
         5mjzG6XLROhc3dlnNwyS6A5qXy43lk+Z3gH0Zsqlaqks8XVzSF3nOn4Hn4+8hK3quAjH
         TobQ==
X-Gm-Message-State: AOAM5338VupCeI13cKcv9d2vwGVeSZG6BFjTB/7F83WBCexEhGdBx7iv
        aNDhy2gxBpfXNfhXwN001cc=
X-Google-Smtp-Source: ABdhPJx5ye0hyB3XDk20/cxMd81qDa4z7RqncgU8gCSUs0Z/xZQRamNwnozhvHUcSEklf3mXW6GO/w==
X-Received: by 2002:a37:d03:: with SMTP id 3mr9720563qkn.45.1612034246048;
        Sat, 30 Jan 2021 11:17:26 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id z20sm8754156qki.93.2021.01.30.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:25 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 3/8] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Sat, 30 Jan 2021 11:17:14 -0800
Message-Id: <20210130191719.7085-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k and sh include bitmap/find.h prior to ffs/fls headers. New
fast-path implementation in find.h requires ffs/fls. Reordering
the headers inclusion sequence helps to prevent compile-time
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

