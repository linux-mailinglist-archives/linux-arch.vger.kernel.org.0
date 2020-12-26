Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D292E2D76
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgLZGne (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgLZGne (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:43:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0704C061757;
        Fri, 25 Dec 2020 22:42:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lb18so3322043pjb.5;
        Fri, 25 Dec 2020 22:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3tUiYozXBW5Qe16hKGeSkVlx2ZAlF5KcbW/IWUDcrE=;
        b=Y+jYyhZIrl33rTudnDWCeJuYlsr2ea2ErrO1LdMrwxZbvo1kJ6tr19nHCpksC7vzqg
         ZodJBBj+2G2mO0giDgagGXjSqSybkjRXfn0SRXdgmFQh5GuQg3OBCMuEexzaG6re+BGo
         6bpTo93iEHogngUQfgNKV4eo/Wh4EkYR8x2U1Eel7YXhjhNzeHZq+mYO2NYPaP9UPj4x
         O36qEXpDnF9Yt+tyEZSofozNFnlcLH78eGz7iFU0eXCmd33XxIhQR/bQSOECX0AJyp/0
         cDnU1gcm9RqrH8JBXv14W223I+tPw5ZscbVu5CPuJcVOJr9bsRaYWcfk16nJiCO4Bv4G
         iCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3tUiYozXBW5Qe16hKGeSkVlx2ZAlF5KcbW/IWUDcrE=;
        b=qwgUmYsj8D1e3kmYlPnaJJ/Zp6cYqB6IzDU9fAkuQkTZAG477O6bwZ9919gdnmQTi8
         5IDYK/ovwLr3nkNldSJ5X95sl2UxHWTmu9PpKgyTbcsIsHXw6BAE8zQ2ATEA4o//BLjQ
         GNqRY8tQXFnzxbV9s+ema5LI6pbFo9IoqBpY7ZBVIgPbVnK/deRsJCMLfZETowHLkHB+
         G6wmlACKkK08TvUoDjglt+F6n94aT2FzTNi08yNlwSlG3re7q1CZ7nS0/c6RZ8EFURJk
         r36WIKsxIUHCGYRfi/XQkzQVXYs2Xg1dZaV12cCCO8UebBw21jDN6NZX6gv0sD0gesra
         uCyw==
X-Gm-Message-State: AOAM531navUwFve00WGkR+t7TN6bXEHGsBckMYttf7U6TGEgdWg97nBJ
        Aqlepi1uacI91oZvqV1KI9Y=
X-Google-Smtp-Source: ABdhPJyVNdjYpXWKUu1rWy5l1gkffrE01YUrVfTrURPZ8kZ2TJtOmHuTgrMkVMCYaA78yqj0vb/Pmg==
X-Received: by 2002:a17:90a:a2a:: with SMTP id o39mr11396424pjo.161.1608964973609;
        Fri, 25 Dec 2020 22:42:53 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id j23sm12420079pgj.34.2020.12.25.22.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:42:53 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:12:37 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/5] clump_bits: Introduce the for_each_set_clump macro
Message-ID: <bc7bf5556fce464179550c67fbec121626d08e85.1608963095.git.syednwaris@gmail.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This macro iterates for each group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to
the bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value() and bitmap_set_value() functions are introduced to
respectively get and set a value of n-bits in a bitmap memory region.
The n-bits can have any size from 1 to BITS_PER_LONG. size less
than 1 or more than BITS_PER_LONG causes undefined behaviour.
Moreover, during setting value of n-bit in bitmap, if a situation arise
that the width of next n-bit is exceeding the word boundary, then it
will divide itself such that some portion of it is stored in that word,
while the remaining portion is stored in the next higher word. Similar
situation occurs while retrieving the value from bitmap.

GCC gives warning in bitmap_set_value(): https://godbolt.org/z/rjx34r
Add explicit check to see if the value being written into the bitmap
does not fall outside the bitmap.
The situation that it is falling outside would never be possible in the
code because the boundaries are required to be correct before the
function is called. The responsibility is on the caller for ensuring the
boundaries are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/clump_bits.h | 101 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 drivers/gpio/clump_bits.h

diff --git a/drivers/gpio/clump_bits.h b/drivers/gpio/clump_bits.h
new file mode 100644
index 000000000000..72ef772b83c8
--- /dev/null
+++ b/drivers/gpio/clump_bits.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CLUMP_BITS_H
+#define __CLUMP_BITS_H
+
+/**
+ * find_next_clump - find next clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ * @clump_size: clump size in bits
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+extern unsigned long find_next_clump(unsigned long *clump,
+				      const unsigned long *addr,
+				      unsigned long size, unsigned long offset,
+				      unsigned long clump_size);
+
+#define find_first_clump(clump, bits, size, clump_size) \
+	find_next_clump((clump), (bits), (size), 0, (clump_size))
+
+/**
+ * bitmap_get_value - get a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ *
+ * Returns value of nbits located at the @start bit offset within the @map
+ * memory region.
+ */
+static inline unsigned long bitmap_get_value(const unsigned long *map,
+					      unsigned long start,
+					      unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+	unsigned long value_low, value_high;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
+	else {
+		value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+		value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+		return (value_low >> offset) | (value_high << space);
+	}
+}
+
+/**
+ * bitmap_set_value - set value within a memory region
+ * @map: address to the bitmap memory region
+ * @nbits: size of map in bits
+ * @value: value of clump
+ * @value_width: size of value in bits (must be between 1 and BITS_PER_LONG inclusive)
+ * @start: bit offset of the value
+ */
+static inline void bitmap_set_value(unsigned long *map, unsigned long nbits,
+				    unsigned long value, unsigned long value_width,
+				    unsigned long start)
+{
+	const unsigned long index = BIT_WORD(start);
+	const unsigned long length = BIT_WORD(nbits);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+
+	value &= GENMASK(value_width - 1, 0);
+
+	if (space >= value_width) {
+		map[index] &= ~(GENMASK(value_width - 1, 0) << offset);
+		map[index] |= value << offset;
+	} else {
+		map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
+		map[index + 0] |= value << offset;
+
+		if (index + 1 >= length)
+			__builtin_unreachable();
+
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + value_width);
+		map[index + 1] |= value >> space;
+	}
+}
+
+/**
+ * for_each_set_clump - iterate over bitmap for each clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ * @clump_size: clump size in bits
+ */
+#define for_each_set_clump(start, clump, bits, size, clump_size) \
+	for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
+
+#endif /* __CLUMP_BITS_H */
-- 
2.29.0

