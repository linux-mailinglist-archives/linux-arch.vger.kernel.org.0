Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FCD2BB1A6
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 18:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgKTRoc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 12:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgKTRoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 12:44:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B6C0613CF;
        Fri, 20 Nov 2020 09:44:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v5so4505477pff.10;
        Fri, 20 Nov 2020 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hi9uk/RnK2qikIp5Ta8zDeedw+sgUsy072kCvbu3OAk=;
        b=QDC7QPauoVYghkpLisf1ERkSoDvE2EIChywIyEeFhDEQK7GKRCZuyWiOHP7R6Yp1kZ
         woEDBAhtY6me4FRcPr/9aa0NsYqlwLZmSVQWfn8v00e8/PyxDL+8BlmuqGXemsIinzsl
         Fgj3tv17Y50meY23U4Wv2U4GI4y5QzyVYSanBKoKW85oEjCYH1woIFpQwhl55MuV5E5O
         gVuJxafbH9ypuK15Qa0jocofBHAsyh3DEwopZiSC3K8uOxwT2mme9RjSv9UuNqdOvbRu
         otECAFt/nAyN+EN+Zqg8UeaHnjct/wQnU/fe01XEbnLCKR6PcUZ4s3UKU9N8Xv0tUpWM
         Klcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hi9uk/RnK2qikIp5Ta8zDeedw+sgUsy072kCvbu3OAk=;
        b=EbYbOWnNMnOQxZm/KdNr+SOp7QQEPqYhqfr7E3ZuEaY0rXw6BcCwd9XAI8Rox3BNLV
         rnI6VxiUSGa1IOKGZzhgJJyAmNufLs4U6+1R2CfKukbrIXO3aINvoDys4cHB6LzNU617
         o3Sab48HsKrE8MBcXLvle024MbzvibHu+QBqZBmUOK3uIpX3HF/q41xrNY5uwq6xZqAf
         3BwejEXEFaltpIzp6kG2xgeY7bjY+/tBzQiCqTjaMsmo1UXqhw+1+K7zt0oY9+ZxXGUJ
         LfIvdMgMRF5jc7W104a0QlLSzH2Xu+fAQcuzxtyPriV5kzgRZvedljN6FIsp6MVwF+Fh
         IoSg==
X-Gm-Message-State: AOAM531NFfUF+pv7b7jyzdXROvi7dJ4qkRhQw8ZkisV0zkxkdWHtKX46
        dsWavCj1V/GJa1zXLYE1bagrjD6f8m0=
X-Google-Smtp-Source: ABdhPJw0Ph+8gEp39vu5oRbXsIpntL+0UVpGgalE8k8+pB7jwbuWuodB1W5TPYIc+Nib9USv/hJk/A==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr11356536pjb.94.1605894271579;
        Fri, 20 Nov 2020 09:44:31 -0800 (PST)
Received: from syed ([2401:4900:2e82:cfda:fc82:287b:3e19:db98])
        by smtp.gmail.com with ESMTPSA id d10sm4571693pjj.38.2020.11.20.09.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:44:31 -0800 (PST)
Date:   Fri, 20 Nov 2020 23:14:16 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] bitmap: Modify bitmap_set_value() to check bitmap length
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
This is just to suppress the GCC -Wtype-limits warnings.

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

