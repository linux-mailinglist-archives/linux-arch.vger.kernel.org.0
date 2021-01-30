Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2A3097F9
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhA3TTm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhA3TTG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:19:06 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E3C0617AA;
        Sat, 30 Jan 2021 11:17:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h16so8199777qth.11;
        Sat, 30 Jan 2021 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrAmvRDdAl33DSpHjA5XcZUSXoY21DiogAG2ynD5om4=;
        b=L+wtCVRFdftJyNxjUlUwxHuQlSPoxvr5f2BonNocXlpsvaf/fvDLsiMHi9/7BF3FGR
         fHu6SEBjHfH8sfr/JaSox1NriSUIomGNYee4IpTGDot1p0gKtEWupimgUcsq+szRfhMr
         4SMOqF7Bon6i2dh+bAA7Ysw8t0USZuAuTvkwoY1N37RocgQKZJbyN+AY3IQcBRTc2nsr
         Kix1n0bx94WY/AsEmbZiniBZEhmY+4vCCMIgFPXx89BnBhqxuXW5+pLzQS8OJufuSaCC
         yXaVWiChJiEhRR+u6YLCtcSNTngngB3P++/hy2e4cmyMN21K6Qnmm0CaLPxqVo6m0Ug9
         5+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrAmvRDdAl33DSpHjA5XcZUSXoY21DiogAG2ynD5om4=;
        b=P5VFyinEWz1WiCaVGIdqgDb3VqSfvJR8o/1ZdClj8SmGYufzY7FT73RsGX4UH48lhw
         4Zb+w0gOksXwELQKZa3FdzUyOuzmIumOqfwVGHZny/HOe5L61HiyJWCDqLt+nBdMBAuh
         xBh+uk/73PfJC3ILhrURZ4yZbt6KZVXxsDLC/Pml2esreqKFkCni2+QO7Yp0xEGOR7ac
         q/Q6hYFYqNQB/BEoSOrCx4cpTBs5a3nx2dgPHW5tZT8BU+GRFoporu76KaxayOUwhH2b
         MBTUAxYgq3A41RQnTg+RWWFXDOquCCrm5E7IWENfG8rIIpDfnq9mvD4ptIfXvg71se3F
         tLnQ==
X-Gm-Message-State: AOAM530yxWIYTBiL5glJ6t5TqEsfpa9uK33UDtalT6hxtUJf55gFYegK
        eKOSuOMFUO0Jcp5MMlBu2X8=
X-Google-Smtp-Source: ABdhPJxa36sZmDJPtqezzoP0XV3lQt1JIdIaV55LPu5GsSt6faVQkre3cX+Co4z+sh8UeZZYW8rJww==
X-Received: by 2002:a05:622a:303:: with SMTP id q3mr9077138qtw.235.1612034250704;
        Sat, 30 Jan 2021 11:17:30 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id u65sm9498777qkb.58.2021.01.30.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:30 -0800 (PST)
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
Subject: [PATCH 7/8] lib: add fast path for find_next_*_bit()
Date:   Sat, 30 Jan 2021 11:17:18 -0800
Message-Id: <20210130191719.7085-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to bitmap functions, find_next_*_bit() users will benefit
if we'll handle a case of bitmaps that fit into a single word. In the
very best case, the compiler may replace a function call with a
single ffs or ffz instruction.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h       | 30 +++++++++++++++++++++++++
 include/asm-generic/bitops/le.h         | 21 +++++++++++++++++
 tools/include/asm-generic/bitops/find.h | 30 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 7ad70dab8e93..8bd7a33a889d 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -20,6 +20,16 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }
 #endif
@@ -40,6 +50,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
 }
 #endif
@@ -58,6 +78,16 @@ static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
 }
 #endif
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 21305f6cea0b..18ebcf639d7f 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -5,6 +5,7 @@
 #include <asm-generic/bitops/find.h>
 #include <asm/types.h>
 #include <asm/byteorder.h>
+#include <linux/swab.h>
 
 #if defined(__LITTLE_ENDIAN)
 
@@ -37,6 +38,16 @@ static inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	if (SMALL_CONST(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
 }
 #endif
@@ -46,6 +57,16 @@ static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	if (SMALL_CONST(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
 }
 #endif
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 9fe62d10b084..eff868bd22f8 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -20,6 +20,16 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }
 #endif
@@ -40,6 +50,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
 }
 #endif
@@ -58,6 +78,16 @@ static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
 }
 #endif
-- 
2.25.1

