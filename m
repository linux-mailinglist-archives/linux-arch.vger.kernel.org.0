Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40632CB21D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 02:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLBBLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 20:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgLBBLC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 20:11:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBCC0613D4;
        Tue,  1 Dec 2020 17:10:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so234339wrn.1;
        Tue, 01 Dec 2020 17:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gPWc5D6e1GbpYB/CmI0kFszGPjzeM9t3g37edwAeP7g=;
        b=OLB5gsaPMk4U4WrTg3s5l9IPokqxNliCGjhNk7Ax3U8nSORTJjVWTHreFtVbMOisOq
         KL+OGKi+mWJCJQNZ4sS3X9uZ1JIDhnZtN7oCBkqGJ4uw5jwfqW71ceD3AemdYN32eesg
         A/nkkaIn/aBgS6lU7Pl26qxqXyYK8OZmsTyuxw+4yzujv4SYJIH+OxcW73yZyQS5phO1
         FANIhv2noIZZeLzWLWCmmKm6ZZDJ/USDmnc5aJHBhjmLImFprX1S0r2b2Xsr6if7pGEa
         uvCOn+xqVFgbI5zG2tCsbjNspT1QzHnKe+SUVHfBiQUOj1DlLEoENreQuqZaws9Z3vdC
         aPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gPWc5D6e1GbpYB/CmI0kFszGPjzeM9t3g37edwAeP7g=;
        b=toE9T7X3BThq+JPwdfsof7y8BGnHDXyrzDQje2PmqcS4hAvMed9VVQgJi3bCseP4Td
         HV1SspQ8hauYk8u8P/iivRLrHiPeRHww76VA5q7pv4vMMkvM9QQBhrrLpxoxAyjnF/C+
         2szWqVHhfCVguDmAFR4HQNgMBSwXX3iARMBKCawP+Yw2Xd2EUujCArsi49qWJOz+0a/Q
         x4vZ6ZPUA0SEfHNamuKRnR3RxJ/IPYSEWcxOXPbNg5cav8Ht+BP87KWzWr/gNNEnwdZ9
         vOaZ1FGkDOfQj1Sfg5eev41m6T4nk0O8w+OCjig/lIxz6+EFzCvIc8KIDHuavxa0v1Eo
         n3NQ==
X-Gm-Message-State: AOAM531ca3geL7TMEe1h9e20s3BHHLJJu9jxnSDyh95svqiMcieXXT7z
        Kgjo0lG5NWUrmWA2RrVvn5ciieMDe7TmeG88dXmBNAouDAw=
X-Google-Smtp-Source: ABdhPJxZj3qbjYMBFz+P2HHQx4mNVoIVuE8PCFS3Et8Fug5OQjdg3Y8oPsfFEOXuoZYcDtb8ALNFJmWmFVVf5KSZKks=
X-Received: by 2002:adf:f70b:: with SMTP id r11mr7346794wrp.133.1606871420516;
 Tue, 01 Dec 2020 17:10:20 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 2 Dec 2020 10:10:09 +0900
Message-ID: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
Subject: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
To:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Inspired find_next_*bit function series, add find_prev_*_bit series.
I'm not sure whether it'll be used right now But, I add these functions
for future usage.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 fs/ufs/util.h                     |  24 +++---
 include/asm-generic/bitops/find.h |  69 ++++++++++++++++
 include/asm-generic/bitops/le.h   |  33 ++++++++
 include/linux/bitops.h            |  34 +++++---
 lib/find_bit.c                    | 126 +++++++++++++++++++++++++++++-
 5 files changed, 260 insertions(+), 26 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 4931bec1a01c..7c87c77d10ca 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -2,7 +2,7 @@
 /*
  *  linux/fs/ufs/util.h
  *
- * Copyright (C) 1998
+ * Copyright (C) 1998
  * Daniel Pirkl <daniel.pirkl@email.cz>
  * Charles University, Faculty of Mathematics and Physics
  */
@@ -263,7 +263,7 @@ extern int ufs_prepare_chunk(struct page *page,
loff_t pos, unsigned len);
 /*
  * These functions manipulate ufs buffers
  */
-#define ubh_bread(sb,fragment,size) _ubh_bread_(uspi,sb,fragment,size)
+#define ubh_bread(sb,fragment,size) _ubh_bread_(uspi,sb,fragment,size)
 extern struct ufs_buffer_head * _ubh_bread_(struct
ufs_sb_private_info *, struct super_block *, u64 , u64);
 extern struct ufs_buffer_head * ubh_bread_uspi(struct
ufs_sb_private_info *, struct super_block *, u64, u64);
 extern void ubh_brelse (struct ufs_buffer_head *);
@@ -296,7 +296,7 @@ static inline void *get_usb_offset(struct
ufs_sb_private_info *uspi,
                                   unsigned int offset)
 {
        unsigned int index;
-
+
        index = offset >> uspi->s_fshift;
        offset &= ~uspi->s_fmask;
        return uspi->s_ubh.bh[index]->b_data + offset;
@@ -411,9 +411,9 @@ static inline unsigned _ubh_find_next_zero_bit_(
                offset = 0;
        }
        return (base << uspi->s_bpfshift) + pos - begin;
-}
+}

-static inline unsigned find_last_zero_bit (unsigned char * bitmap,
+static inline unsigned __ubh_find_last_zero_bit(unsigned char * bitmap,
        unsigned size, unsigned offset)
 {
        unsigned bit, i;
@@ -453,7 +453,7 @@ static inline unsigned _ubh_find_last_zero_bit_(
                            size + (uspi->s_bpf - start), uspi->s_bpf)
                        - (uspi->s_bpf - start);
                size -= count;
-               pos = find_last_zero_bit (ubh->bh[base]->b_data,
+               pos = __ubh_find_last_zero_bit(ubh->bh[base]->b_data,
                        start, start - count);
                if (pos > start - count || !size)
                        break;
@@ -461,7 +461,7 @@ static inline unsigned _ubh_find_last_zero_bit_(
                start = uspi->s_bpf;
        }
        return (base << uspi->s_bpfshift) + pos - begin;
-}
+}

 #define ubh_isblockclear(ubh,begin,block)
(!_ubh_isblockset_(uspi,ubh,begin,block))

@@ -483,7 +483,7 @@ static inline int _ubh_isblockset_(struct
ufs_sb_private_info * uspi,
                mask = 0x01 << (block & 0x07);
                return (*ubh_get_addr (ubh, begin + (block >> 3)) &
mask) == mask;
        }
-       return 0;
+       return 0;
 }

 #define ubh_clrblock(ubh,begin,block) _ubh_clrblock_(uspi,ubh,begin,block)
@@ -492,8 +492,8 @@ static inline void _ubh_clrblock_(struct
ufs_sb_private_info * uspi,
 {
        switch (uspi->s_fpb) {
        case 8:
-               *ubh_get_addr (ubh, begin + block) = 0x00;
-               return;
+               *ubh_get_addr (ubh, begin + block) = 0x00;
+               return;
        case 4:
                *ubh_get_addr (ubh, begin + (block >> 1)) &= ~(0x0f <<
((block & 0x01) << 2));
                return;
@@ -531,9 +531,9 @@ static inline void ufs_fragacct (struct
super_block * sb, unsigned blockmap,
 {
        struct ufs_sb_private_info * uspi;
        unsigned fragsize, pos;
-
+
        uspi = UFS_SB(sb)->s_uspi;
-
+
        fragsize = 0;
        for (pos = 0; pos < uspi->s_fpb; pos++) {
                if (blockmap & (1 << pos)) {
diff --git a/include/asm-generic/bitops/find.h
b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..ca18b2ec954c 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -16,6 +16,20 @@ extern unsigned long find_next_bit(const unsigned
long *addr, unsigned long
                size, unsigned long offset);
 #endif

+#ifndef find_prev_bit
+/**
+ * find_prev_bit - find the prev set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the prev set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_prev_bit(const unsigned long *addr, unsigned long
+               size, unsigned long offset);
+#endif
+
 #ifndef find_next_and_bit
 /**
  * find_next_and_bit - find the next set bit in both memory regions
@@ -32,6 +46,22 @@ extern unsigned long find_next_and_bit(const
unsigned long *addr1,
                unsigned long offset);
 #endif

+#ifndef find_prev_and_bit
+/**
+ * find_prev_and_bit - find the prev set bit in both memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the prev set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_prev_and_bit(const unsigned long *addr1,
+               const unsigned long *addr2, unsigned long size,
+               unsigned long offset);
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
@@ -46,6 +76,20 @@ extern unsigned long find_next_zero_bit(const
unsigned long *addr, unsigned
                long size, unsigned long offset);
 #endif

+#ifndef find_prev_zero_bit
+/**
+ * find_prev_zero_bit - find the prev cleared bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number of the prev zero bit
+ * If no bits are zero, returns @size.
+ */
+extern unsigned long find_prev_zero_bit(const unsigned long *addr, unsigned
+               long size, unsigned long offset);
+#endif
+
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT

 /**
@@ -80,6 +124,31 @@ extern unsigned long find_first_zero_bit(const
unsigned long *addr,

 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */

+#ifndef find_last_bit
+/**
+ * find_last_bit - find the last set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The number of bits to search
+ *
+ * Returns the bit number of the last set bit, or size.
+ */
+extern unsigned long find_last_bit(const unsigned long *addr,
+                                  unsigned long size);
+#endif
+
+#ifndef find_last_zero_bit
+/**
+ * find_last_zero_bit - find the last cleared bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ *
+ * Returns the bit number of the first cleared bit.
+ * If no bits are zero, returns @size.
+ */
+extern unsigned long find_last_zero_bit(const unsigned long *addr,
+                                        unsigned long size);
+#endif
+
 /**
  * find_next_clump8 - find next 8-bit clump with set bits in a memory region
  * @clump: location to store copy of found clump
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..d0bd15bc34d9 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -27,6 +27,24 @@ static inline unsigned long
find_first_zero_bit_le(const void *addr,
        return find_first_zero_bit(addr, size);
 }

+static inline unsigned long find_prev_zero_bit_le(const void *addr,
+               unsigned long size, unsigned long offset)
+{
+       return find_prev_zero_bit(addr, size, offset);
+}
+
+static inline unsigned long find_prev_bit_le(const void *addr,
+               unsigned long size, unsigned long offset)
+{
+       return find_prev_bit(addr, size, offset);
+}
+
+static inline unsigned long find_last_zero_bit_le(const void *addr,
+               unsigned long size)
+{
+       return find_last_zero_bit(addr, size);
+}
+
 #elif defined(__BIG_ENDIAN)

 #define BITOP_LE_SWIZZLE       ((BITS_PER_LONG-1) & ~0x7)
@@ -41,11 +59,26 @@ extern unsigned long find_next_bit_le(const void *addr,
                unsigned long size, unsigned long offset);
 #endif

+#ifndef find_prev_zero_bit_le
+extern unsigned long find_prev_zero_bit_le(const void *addr,
+               unsigned long size, unsigned long offset);
+#endif
+
+#ifndef find_prev_bit_le
+extern unsigned long find_prev_bit_le(const void *addr,
+               unsigned long size, unsigned long offset);
+#endif
+
 #ifndef find_first_zero_bit_le
 #define find_first_zero_bit_le(addr, size) \
        find_next_zero_bit_le((addr), (size), 0)
 #endif

+#ifndef find_last_zero_bit_le
+#define find_last_zero_bit_le(addr, size) \
+       find_prev_zero_bit_le((addr), (size), (size - 1))
+#endif
+
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5b74bdf159d6..124c68929861 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -50,6 +50,28 @@ extern unsigned long __sw_hweight64(__u64 w);
             (bit) < (size);                                    \
             (bit) = find_next_zero_bit((addr), (size), (bit) + 1))

+#define for_each_set_bit_reverse(bit, addr, size) \
+       for ((bit) = find_last_bit((addr), (size));             \
+            (bit) < (size);                                    \
+            (bit) = find_prev_bit((addr), (size), (bit)))
+
+/* same as for_each_set_bit_reverse() but use bit as value to start with */
+#define for_each_set_bit_from_reverse(bit, addr, size) \
+       for ((bit) = find_prev_bit((addr), (size), (bit));      \
+            (bit) < (size);                                    \
+            (bit) = find_prev_bit((addr), (size), (bit - 1)))
+
+#define for_each_clear_bit_reverse(bit, addr, size) \
+       for ((bit) = find_last_zero_bit((addr), (size));        \
+            (bit) < (size);                                    \
+            (bit) = find_prev_zero_bit((addr), (size), (bit)))
+
+/* same as for_each_clear_bit_reverse() but use bit as value to start with */
+#define for_each_clear_bit_from_reverse(bit, addr, size) \
+       for ((bit) = find_prev_zero_bit((addr), (size), (bit)); \
+            (bit) < (size);                                    \
+            (bit) = find_next_zero_bit((addr), (size), (bit - 1)))
+
 /**
  * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
  * @start: bit offset to start search and to store the current iteration offset
@@ -283,17 +305,5 @@ static __always_inline void __assign_bit(long nr,
volatile unsigned long *addr,
 })
 #endif

-#ifndef find_last_bit
-/**
- * find_last_bit - find the last set bit in a memory region
- * @addr: The address to start the search at
- * @size: The number of bits to search
- *
- * Returns the bit number of the last set bit, or size.
- */
-extern unsigned long find_last_bit(const unsigned long *addr,
-                                  unsigned long size);
-#endif
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 4a8751010d59..cbe06abd3d21 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -69,6 +69,58 @@ static unsigned long _find_next_bit(const unsigned
long *addr1,
 }
 #endif

+#if !defined(find_prev_bit) || !defined(find_prev_zero_bit) ||
         \
+       !defined(find_prev_bit_le) || !defined(find_prev_zero_bit_le)
||        \
+       !defined(find_prev_and_bit)
+/*
+ * This is a common helper function for find_prev_bit, find_prev_zero_bit, and
+ * find_prev_and_bit. The differences are:
+ *  - The "invert" argument, which is XORed with each fetched word before
+ *    searching it for one bits.
+ *  - The optional "addr2", which is anded with "addr1" if present.
+ */
+static unsigned long _find_prev_bit(const unsigned long *addr1,
+               const unsigned long *addr2, unsigned long nbits,
+               unsigned long start, unsigned long invert, unsigned long le)
+{
+       unsigned long tmp, mask;
+
+       if (unlikely(start >= nbits))
+               return nbits;
+
+       tmp = addr1[start / BITS_PER_LONG];
+       if (addr2)
+               tmp &= addr2[start / BITS_PER_LONG];
+       tmp ^= invert;
+
+       /* Handle 1st word. */
+       mask = BITMAP_LAST_WORD_MASK(start + 1);
+       if (le)
+               mask = swab(mask);
+
+       tmp &= mask;
+
+       start = round_down(start, BITS_PER_LONG);
+
+       while (!tmp) {
+               start -= BITS_PER_LONG;
+               if (start >= nbits)
+                       return nbits;
+
+               tmp = addr1[start / BITS_PER_LONG];
+               if (addr2)
+                       tmp &= addr2[start / BITS_PER_LONG];
+               tmp ^= invert;
+       }
+
+       if (le)
+               tmp = swab(tmp);
+
+       return start + __fls(tmp);
+}
+#endif
+
+
 #ifndef find_next_bit
 /*
  * Find the next set bit in a memory region.
@@ -81,6 +133,18 @@ unsigned long find_next_bit(const unsigned long
*addr, unsigned long size,
 EXPORT_SYMBOL(find_next_bit);
 #endif

+#ifndef find_prev_bit
+/*
+ * Find the prev set bit in a memory region.
+ */
+unsigned long find_prev_bit(const unsigned long *addr, unsigned long size,
+                           unsigned long offset)
+{
+       return _find_prev_bit(addr, NULL, size, offset, 0UL, 0);
+}
+EXPORT_SYMBOL(find_prev_bit);
+#endif
+
 #ifndef find_next_zero_bit
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
                                 unsigned long offset)
@@ -90,7 +154,16 @@ unsigned long find_next_zero_bit(const unsigned
long *addr, unsigned long size,
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif

-#if !defined(find_next_and_bit)
+#ifndef find_prev_zero_bit
+unsigned long find_prev_zero_bit(const unsigned long *addr, unsigned long size,
+                                unsigned long offset)
+{
+       return _find_prev_bit(addr, NULL, size, offset, ~0UL, 0);
+}
+EXPORT_SYMBOL(find_prev_zero_bit);
+#endif
+
+#ifndef find_next_and_bit
 unsigned long find_next_and_bit(const unsigned long *addr1,
                const unsigned long *addr2, unsigned long size,
                unsigned long offset)
@@ -100,6 +173,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(find_next_and_bit);
 #endif

+#ifndef find_prev_and_bit
+unsigned long find_prev_and_bit(const unsigned long *addr1,
+               const unsigned long *addr2, unsigned long size,
+               unsigned long offset)
+{
+       return _find_prev_bit(addr1, addr2, size, offset, 0UL, 0);
+}
+EXPORT_SYMBOL(find_prev_and_bit);
+#endif
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -141,7 +224,7 @@ unsigned long find_last_bit(const unsigned long
*addr, unsigned long size)
 {
        if (size) {
                unsigned long val = BITMAP_LAST_WORD_MASK(size);
-               unsigned long idx = (size-1) / BITS_PER_LONG;
+               unsigned long idx = (size - 1) / BITS_PER_LONG;

                do {
                        val &= addr[idx];
@@ -156,6 +239,27 @@ unsigned long find_last_bit(const unsigned long
*addr, unsigned long size)
 EXPORT_SYMBOL(find_last_bit);
 #endif

+#ifndef find_last_zero_bit
+unsigned long find_last_zero_bit(const unsigned long *addr, unsigned long size)
+{
+       if (size) {
+               unsigned long val = BITMAP_LAST_WORD_MASK(size);
+               unsigned long idx = (size - 1) / BITS_PER_LONG;
+
+               do {
+                       val &= ~addr[idx];
+                       if (val)
+                               return idx * BITS_PER_LONG + __fls(val);
+
+                       val = ~0ul;
+               } while (idx--);
+       }
+
+       return size;
+}
+EXPORT_SYMBOL(find_last_zero_bit);
+#endif
+
 #ifdef __BIG_ENDIAN

 #ifndef find_next_zero_bit_le
@@ -167,6 +271,15 @@ unsigned long find_next_zero_bit_le(const void
*addr, unsigned
 EXPORT_SYMBOL(find_next_zero_bit_le);
 #endif

+#ifndef find_prev_zero_bit_le
+unsigned long find_prev_zero_bit_le(const void *addr, unsigned
+               long size, unsigned long offset)
+{
+       return _find_prev_bit(addr, NULL, size, offset, ~0UL, 1);
+}
+EXPORT_SYMBOL(find_prev_zero_bit_le);
+#endif
+
 #ifndef find_next_bit_le
 unsigned long find_next_bit_le(const void *addr, unsigned
                long size, unsigned long offset)
@@ -176,6 +289,15 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 EXPORT_SYMBOL(find_next_bit_le);
 #endif

+#ifdef find_prev_bit_le
+unsigned long find_prev_bit_le(const void *addr, unsigned
+               long size, unsigned long offset)
+{
+       return _find_prev_bit(addr, NULL, size, offset, 0UL, 1);
+}
+EXPORT_SYMBOL(find_prev_bit_le);
+#endif
+
 #endif /* __BIG_ENDIAN */

 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
--
2.29.2
