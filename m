Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0132BB436
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 19:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgKTSnW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 13:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbgKTSnW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 13:43:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC0C0613CF;
        Fri, 20 Nov 2020 10:43:21 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so5326692plo.0;
        Fri, 20 Nov 2020 10:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXCokNcFtmUFZk8OkEAohOIZoUd84BUeBegjeYFXaK0=;
        b=ArT35zTApfxrR1D++Yl4zdVcqMbNXWKgsa0paeogv6PsVQMX08hAhXuEAm5XltrVWc
         uZe7e7D6Wh40OS7WDxbltcmSugAp0AaEPsobXvyuFAX2K77ZisSUsaDjy7XaXa+H6pBy
         EtGUG/Og/DE0Uq5zQnMh1aat6V6ektoPy6gdfoYdKJo7Z3V9Yb54w1Q4EYmn8rIX6NYA
         gg7AQ3SyOFoUv3GbH/RlX0Hs2LdAijINN/hfenjEZvDP5+rp/8Dbt1q3insU0jt9KufL
         OyTutRqH2qjpuuJPYMyu1PxUd8ZQz6J0FOXX0vhHSmRf2Ewu5cMRJSlpMkRGp5QwGi+D
         jbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXCokNcFtmUFZk8OkEAohOIZoUd84BUeBegjeYFXaK0=;
        b=chHuOeIDvKczJdBeXUZ1u6kYIcjiQm9Yb5rohiIedMfvyy7FxVNFcNwJ0KdZaRsjvG
         3o2nUpwIKdmbhLM39sSGaVIJXIyOx9qvECyVKxcjimRI9RFuIiZEV8/+EtgvEXERJPD9
         8+D9049GHWNMCsKK63zdTkA+Sh0fdRQcQo3SN5+ndGNqdo8S/tja13e8y5lGpzlFtsyZ
         r2nbDENx5BP++dBx8wTLhsrD2Gku0TLBEjlOLtzf7FqmjrhLhrmlGEDsxzYwytQYsRFl
         lzVUkpm+9FQomfikX6Ijg8+TzSUXvfllDNytsQ5ThhviXZ0MQQAwkN7R3cV6KKMR+tLy
         jUdA==
X-Gm-Message-State: AOAM531bdBDL57x5xrbBDWJpVZj878Iw0qZGVDGkZ1mYp/xNjt9Y2Xp3
        0XvnpID72NYjwS5CBW6SRDlMS3HakaQ=
X-Google-Smtp-Source: ABdhPJzohs3MmB+IkhzVGQX6moCZPPkrpU7OcKdu237FnWfI5fZuik401VUybcFI/uigj/eyV0ODXw==
X-Received: by 2002:a17:902:bc46:b029:d6:d98a:1a68 with SMTP id t6-20020a170902bc46b02900d6d98a1a68mr14200054plz.63.1605897801482;
        Fri, 20 Nov 2020 10:43:21 -0800 (PST)
Received: from syed ([223.225.2.215])
        by smtp.gmail.com with ESMTPSA id p15sm5191603pjg.21.2020.11.20.10.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:43:20 -0800 (PST)
Date:   Sat, 21 Nov 2020 00:13:02 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [RESEND PATCH 1/4] bitmap: Modify bitmap_set_value() to check bitmap
 length
Message-ID: <b2011fb2e0438bdfd0b663b9f0456d0aef20f04b.1605893642.git.syednwaris@gmail.com>
References: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605893641.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit check to see if the value being written into the bitmap
does not fall outside the bitmap.
The situation that it is falling outside would never be possible in the
code because the boundaries are required to be correct before the function
is called. The responsibility is on the caller for ensuring the boundaries
are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/bitmap.h | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 386d08777342..efb6199ea1e7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -78,8 +78,9 @@
  *  bitmap_get_value(map, start, nbits)		Get bit value of size
  *                                              'nbits' from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
- *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
- *                                              of map at start
+ *  bitmap_set_value(map, nbits, value, value_width, start)
+ *                                              Set bit value of size value_width
+ *                                              to map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -610,30 +611,36 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 }
 
 /**
- * bitmap_set_value - set n-bit value within a memory region
+ * bitmap_set_value - set value within a memory region
  * @map: address to the bitmap memory region
- * @value: value of nbits
- * @start: bit offset of the n-bit value
- * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ * @nbits: size of map in bits
+ * @value: value of clump
+ * @value_width: size of value in bits (must be between 1 and BITS_PER_LONG inclusive)
+ * @start: bit offset of the value
  */
-static inline void bitmap_set_value(unsigned long *map,
-				    unsigned long value,
-				    unsigned long start, unsigned long nbits)
+static inline void bitmap_set_value(unsigned long *map, unsigned long nbits,
+				    unsigned long value, unsigned long value_width,
+				    unsigned long start)
 {
-	const size_t index = BIT_WORD(start);
+	const unsigned long index = BIT_WORD(start);
+	const unsigned long length = BIT_WORD(nbits);
 	const unsigned long offset = start % BITS_PER_LONG;
 	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
 	const unsigned long space = ceiling - start;
 
-	value &= GENMASK(nbits - 1, 0);
+	value &= GENMASK(value_width - 1, 0);
 
-	if (space >= nbits) {
-		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
+	if (space >= value_width) {
+		map[index] &= ~(GENMASK(value_width - 1, 0) << offset);
 		map[index] |= value << offset;
 	} else {
 		map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
 		map[index + 0] |= value << offset;
-		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+
+		if (index + 1 >= length)
+			__builtin_unreachable();
+
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + value_width);
 		map[index + 1] |= value >> space;
 	}
 }
-- 
2.29.0

