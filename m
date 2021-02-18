Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE731E4FD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBREIi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBREHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:07:05 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E3C061224;
        Wed, 17 Feb 2021 20:05:28 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x14so992121qkm.2;
        Wed, 17 Feb 2021 20:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/4S7LKqScJemznNw5zpAMo2LpQEMVSK1lx74u88L8E=;
        b=GYd46QJ+oJ/OGZaSr9nWwEUqzlbyRm/1o84ManClVrZwd4tv9PeTdMv8IQ5G1Z207z
         /oK0EkR88dgK67Pr3qCcpjUvAJgnOV3ouLgJaRaxXKIrmGyEy70rZkoiN6/YKWXUq3jO
         oQ9lFz2b80eQxsI07WYG/py9Bq+dqmAJnH46dJqGUlFRWs5oY9g3vgNR396xDpPNtk33
         L5nu+Rs6iCubHXvcioXMj7D737P+EVZkD2F9xSJIpb/Rx9HCLix2IzR4EiWXVWwuedDm
         mWpJEeHfTDuB7Rdd09ZQxJWUVYLaATLiLw6+BcTp6TQrlauoV2ZRiQ7O5qEZuRkIcz4b
         /qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/4S7LKqScJemznNw5zpAMo2LpQEMVSK1lx74u88L8E=;
        b=Ttgjo5nE6pu/reEAf42qKl7V+vn5tpTmKK3CA1m3FDz1n9ceDBZCZ8+EYpbYKVDAiS
         RdcKvvi2dQ+onf9NrOgxP1Rzyf5MgH3pZ7dUxgE8i0kAiC/mD+S0WR8INGVlOWWKMfto
         J1YXcgSwF38/O3TzFkcXc5PMVYnORVnAX/k+u15sDQDsoScW5QoITO8u07XBxhr9P3DT
         ajvLp/aUKVLr+Aiiw1gpe4pQMv1PcteQF9Sba9hGlbqQiJTsf0ay6bdwsHp4HgZQCG2O
         IqbwiqgTKi7aIf7qOLWv2pjZbPu0Ff+pxThXpH9F6MFsjGaNBNPcsWTEzBMmxoAMQl7M
         32pg==
X-Gm-Message-State: AOAM531xLitWqWKntys3Wm1JzzS4RGWVT0na6DUtTIIbjbfgBfgvCcT2
        YEb8Nq0587hJeyoY4EQRFDozIc3V3TmxWw==
X-Google-Smtp-Source: ABdhPJwqLW9dD0u6WaV4WJMbZta3+pAWwUzqVQnTlK1xeZU70MAuaFTwanHg5zK34akToJSnUpB8WA==
X-Received: by 2002:a37:4ecd:: with SMTP id c196mr2513316qkb.264.1613621127718;
        Wed, 17 Feb 2021 20:05:27 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id t19sm3230755qke.109.2021.02.17.20.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:27 -0800 (PST)
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
Subject: [PATCH 11/14] lib: add fast path for find_next_*_bit()
Date:   Wed, 17 Feb 2021 20:05:09 -0800
Message-Id: <20210218040512.709186-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to bitmap functions, find_next_*_bit() users will benefit
if we'll handle a case of bitmaps that fit into a single word. In the
very best case, the compiler may replace a function call with a few
instructions.

This is the quite typical find_next_bit() user:

	unsigned int cpumask_next(int n, const struct cpumask *srcp)
	{
		/* -1 is a legal arg here. */
		if (n != -1)
			cpumask_check(n);
		return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
	}
	EXPORT_SYMBOL(cpumask_next);

On ARM64 if CONFIG_FAST_PATH is disabled it generates:
	0000000000000000 <cpumask_next>:
	   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
	   4:   11000402        add     w2, w0, #0x1
	   8:   aa0103e0        mov     x0, x1
	   c:   d2800401        mov     x1, #0x40                       // #64
	  10:   910003fd        mov     x29, sp
	  14:   93407c42        sxtw    x2, w2
	  18:   94000000        bl      0 <find_next_bit>
	  1c:   a8c17bfd        ldp     x29, x30, [sp], #16
	  20:   d65f03c0        ret
	  24:   d503201f        nop

If CONFIG_FAST_PATH is enabled:
	0000000000000140 <cpumask_next>:
	 140:   11000400        add     w0, w0, #0x1
	 144:   93407c00        sxtw    x0, w0
	 148:   f100fc1f        cmp     x0, #0x3f
	 14c:   54000168        b.hi    178 <cpumask_next+0x38>  // b.pmore
	 150:   f9400023        ldr     x3, [x1]
	 154:   92800001        mov     x1, #0xffffffffffffffff         // #-1
	 158:   9ac02020        lsl     x0, x1, x0
	 15c:   52800802        mov     w2, #0x40                       // #64
	 160:   8a030001        and     x1, x0, x3
	 164:   dac00020        rbit    x0, x1
	 168:   f100003f        cmp     x1, #0x0
	 16c:   dac01000        clz     x0, x0
	 170:   1a800040        csel    w0, w2, w0, eq  // eq = none
	 174:   d65f03c0        ret
	 178:   52800800        mov     w0, #0x40                       // #64
	 17c:   d65f03c0        ret

find_next_bit() call is replaced with 6 instructions. (And I suspect
we can improve the GENMASK() for better code generation.) find_next_bit()
itself is 41 instructions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h | 30 ++++++++++++++++++++++++++++++
 include/asm-generic/bitops/le.h   | 21 +++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
-- 
2.25.1

