Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A6350B3A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhDAAch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhDAAcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4EC06175F;
        Wed, 31 Mar 2021 17:32:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j7so349670qtx.5;
        Wed, 31 Mar 2021 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rib+8cPzfkPDLYasfg8PUHyrKUJ4lS7U+r1MeE1lPMk=;
        b=Fk/Ci2T7eZZrNt4/qybRiq+nHIOKdGGY5a5FKgUHevi+qKsKEa4YKTZmt9UeRWzl1k
         P+ncnBcowX1IQfW8HX9Dlx0c/W317alz1vo5p/3CZqTH57FbLYmx2q4tCUTGDKkecT2m
         T6k2bQXrB/uao2aj4IxXnqDt12oAf9prYVO9I9jXH/bRt7n9aG/KoAVgvuO44z5XY03j
         j+Jf4zmqXREHntJPbjiO1+T6n1dLDKa3ebJ7sorgESsYnct2YFHMEUAPLduaQMCJ2TF/
         XpyFSHWRd+Ldgxo5Wiic3KHVYKW9wJOKOoyKiJvuKa+NFkFP3ohy0489dY+FXgq6PLk/
         r9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rib+8cPzfkPDLYasfg8PUHyrKUJ4lS7U+r1MeE1lPMk=;
        b=sOftraDm3YnmDScsbeI+wdWfaxyosWfTGxRS98IZ8liaLMeN1hJ/LurFboOQvrfMfa
         DF7GP2Mbate7ZfXZ+4390mkvDQr/8m84qvAOUCCV+GA8eqkhoKdxQFzPHyehsGpaIyXc
         rfpNKBBcPW8+2nT9xe2+gVo0JNPa+5BG+ektg3ncqT93h/L2GvsJaP9Z4xxKdCtRnH0F
         aMFFAvXsXfiU1kUgNICUs6JTeRc01Jrekq/06gBlgXxK/wr8Bw3wMuTwptHcZlCDpj7R
         RGqllQdOIZvKoQG4mWvW1tU0hZtqBHCQPtXiVFBnnNKO+9rqpTEnKjHf+O55CB0p0Du1
         uIaw==
X-Gm-Message-State: AOAM53373LbPDY9UwoQfAYaJQSKJWjlsjRs4+44ywpisQJRUzXAIsidD
        lYCpvZaKezdnIVycdhjhtlyvKoVGgouENA==
X-Google-Smtp-Source: ABdhPJwePK3IMz1LcSBinw2JoEu3uiov+twK67s6xzlqCyeQQ2dn/5/I1PIo1yJYxzFARls6K98m7Q==
X-Received: by 2002:a05:622a:205:: with SMTP id b5mr4837901qtx.186.1617237125637;
        Wed, 31 Mar 2021 17:32:05 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id s28sm2707880qkj.73.2021.03.31.17.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:05 -0700 (PDT)
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
Subject: [PATCH 09/12] lib: add fast path for find_next_*_bit()
Date:   Wed, 31 Mar 2021 17:31:50 -0700
Message-Id: <20210401003153.97325-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to bitmap functions, find_next_*_bit() users will benefit
if we'll handle a case of bitmaps that fit into a single word inline.
In the very best case, the compiler may replace a function call with
a few instructions.

This is the quite typical find_next_bit() user:

	unsigned int cpumask_next(int n, const struct cpumask *srcp)
	{
		/* -1 is a legal arg here. */
		if (n != -1)
			cpumask_check(n);
		return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
	}
	EXPORT_SYMBOL(cpumask_next);

Currently, on ARM64 the generated code looks like this:
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

After applying this patch:
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

find_next_bit() call is replaced with 6 instructions. find_next_bit()
itself is 41 instructions plus function call overhead.

Despite inlining, the scripts/bloat-o-meter report smaller .text size
after applying the series:
	add/remove: 11/9 grow/shrink: 233/176 up/down: 5780/-6768 (-988)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/bitops/find.h | 30 ++++++++++++++++++++++++++++++
 include/asm-generic/bitops/le.h   | 21 +++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 7ad70dab8e93..4148c74a1e4d 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -20,6 +20,16 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	if (small_const_nbits(size)) {
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
+	if (small_const_nbits(size)) {
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
+	if (small_const_nbits(size)) {
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
index 21305f6cea0b..5a28629cbf4d 100644
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
+	if (small_const_nbits(size)) {
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
+	if (small_const_nbits(size)) {
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

