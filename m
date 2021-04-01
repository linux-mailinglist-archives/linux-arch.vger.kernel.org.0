Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A580C350B34
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDAAcf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhDAAcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D635C06175F;
        Wed, 31 Mar 2021 17:32:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l6so366672qtq.2;
        Wed, 31 Mar 2021 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C20LX74l80irmi256Fwsi1jw671yttyeLQ2jw+WrTcM=;
        b=RS/chnDkCdQyueD/TO4h/bIDNgnA4o/xS6tSCgjYHQeYHlX2mXzqibCq9sE+BRBI1L
         c5uTbzx03Mb5EMxyh6HPQsWxOwD6s0tprC0v2UYZXn5NJkBHj4EeMZu1s4swZlCGPpfU
         oATPYLPqErdn2Oqj1V5W/w2ibASNmKxU9lkYgsTeYxYRUJQHbyyub8YZC4C5Vz7wnDCs
         uaJSPNEjzoSAKo2/MbaW5INSJl7XVSCIzrPX0eA+v1iJZASYTs3wHWfQX5uHDEtbB/22
         klv1ee74IYsE2Eh8HXQfqUiu2+FDkZTzzLFw/6uqaNmlO6MK5kT0t/OZuZDHeg+tydUW
         aUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C20LX74l80irmi256Fwsi1jw671yttyeLQ2jw+WrTcM=;
        b=drfyPx56Ik84ug/q+sex/qZhBYbVpuD1MDToRmIKNroWnJjvch7HBQFFCseODOOpOm
         qHD9Im/tzQ1Ri3RpS2nfOrHM/hD6P2Rgwm5xZvgoGZFNyjal1F4g9cmdH2MqDoINaYfk
         JPCgbVYZw5oilt3HleKwh7KQe8lJhlYU5n9hS+veam5NQirIXmjZ9oNtFPMniEC+MnV+
         vD+TyW23ZAJmzu3GdWspIIMZCJYQzaJr7SZ8y2SjiaNVgA0DXtvR2ugH/SHR4BJh0PMh
         BrHq439XRxaiZtJ0vXkf81sjUWOzDuGspkmL30iIM78HyFAUBxRGAzWeOTSzJjFgTzVW
         gHyQ==
X-Gm-Message-State: AOAM533FbLNHALm0BXFB+t7q0NYGJCPa7rHGGSV4N5RZCX+4OxDj1onP
        0wUeuprH1Dj1p6npB6chzzpvMZXuiwFHyA==
X-Google-Smtp-Source: ABdhPJz7RKTFKh3oP/3IhWgH3Vleaf73gUSrxN4TJF7CtYGdG2/m3SLKOA6O7R2O35yCAc2jdVVvdw==
X-Received: by 2002:ac8:6d2b:: with SMTP id r11mr4834397qtu.245.1617237122424;
        Wed, 31 Mar 2021 17:32:02 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 85sm2811154qkf.58.2021.03.31.17.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:02 -0700 (PDT)
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
Subject: [PATCH 06/12] tools: sync small_const_nbits() macro with the kernel
Date:   Wed, 31 Mar 2021 17:31:47 -0700
Message-Id: <20210401003153.97325-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sync implementation with the kernel and move the macro from
tools/include/linux/bitmap.h to tools/include/asm-generic/bitsperlong.h

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/asm-generic/bitsperlong.h | 3 +++
 tools/include/linux/bitmap.h            | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
index 8f2283052333..2093d56ddd11 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -18,4 +18,7 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 4aabc23ec747..330dbf7509cc 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -22,9 +22,6 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len);
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-- 
2.25.1

