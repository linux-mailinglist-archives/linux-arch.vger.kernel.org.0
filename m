Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C82FDE47
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbhAUA6U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392380AbhAUAKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:10:21 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF35C061798;
        Wed, 20 Jan 2021 16:06:42 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id r9so360682qtp.11;
        Wed, 20 Jan 2021 16:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJvVbTcrFXhal00Em+TPrjdhMeNVT/fqvfLLy70dJMA=;
        b=vWXwiNJ+21L5NEAcfTJmnhSL+ca7W/dNzSA0tHOF6ctG1i3z5n4FSbFYnxtaZrR9Kh
         QjVy8Jh2Am8Z92TXHZRypNlqkefGFQtSusL0K++LpxONvZDQo0eFqK0oJ2lEl/45CRM1
         u+pm8Va4XWVGO98mkSD0pse4jEYTHvwGD4OpmsCDndOSgyLTmdLPsYNKy5TQeJKlnZiU
         cOj2LpXcBUQxU9GLNF1y7Ow0FoeuexvQ9aJoIesaEW0rOnSykNBIVw4hcnehcN9f02h3
         4ixz1k+SkNiIJDj6EREawv9zhd17ejqFPmosZtYBPyBNPcps75wadIV5QKB3IX0TgQDW
         n+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJvVbTcrFXhal00Em+TPrjdhMeNVT/fqvfLLy70dJMA=;
        b=RdbEY0Wz9gyhu0zdEWBmgd+ttu6FLfMO0QAKKNKt4mI9mKpbJiCfv8zwdo+/pPYG9M
         5bmyRMf+vD59IBIy4ea/RYhtKzSAIjQp/2GOEEaGwm1HoGnSNFjHxUVDTmy9zT0JDlow
         CpV0wDyn4WlNeVKEYqilQALcIMIqiXPD/da4j6HHzrKeUKRRPW2564R3Fxwy4lMAwtNk
         VD/c9/UeTtJPWkeNWfCbD5c+0wvZqffkfKM2IC83LKyQ+ytbMF+qmiMJZDvy95zJW79Y
         z9iff+Ye1RHM6lc0GZVw77IickfdvZ66SjQ0mXsZ/4IuxxI+WKmy1WEC7urUs2vAekh+
         unkg==
X-Gm-Message-State: AOAM531Z/+i7/8jR7tLRpJaH8O7M036wAPFAvByjVw2EBl5I/wQ0cZ6e
        UbWDrPTFOHNxno3wR4xHhMM=
X-Google-Smtp-Source: ABdhPJzyA0gTkmmj57pbH5DOx/IkC97OqDS83dP13BmJv9Nnz4vmLR/AQG7HSaZwFjqG70KYKkP4DA==
X-Received: by 2002:ac8:5e83:: with SMTP id r3mr11322397qtx.261.1611187601929;
        Wed, 20 Jan 2021 16:06:41 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id i41sm2421673qtc.33.2021.01.20.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:41 -0800 (PST)
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
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 5/6] lib: add fast path for find_next_*_bit()
Date:   Wed, 20 Jan 2021 16:06:29 -0800
Message-Id: <20210121000630.371883-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
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
 include/asm-generic/bitops/find.h | 39 +++++++++++++++++++++++++++++++
 include/asm-generic/bitops/le.h   | 28 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 7ad70dab8e93..d45096069011 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -20,6 +20,18 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr & BITMAP_FIRST_WORD_MASK(offset)
+				& BITMAP_LAST_WORD_MASK(size);
+
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }
 #endif
@@ -40,6 +52,18 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & *addr2 & BITMAP_FIRST_WORD_MASK(offset)
+				      & BITMAP_LAST_WORD_MASK(size);
+
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
 }
 #endif
@@ -58,6 +82,21 @@ static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
+	if (small_const_nbits(size)) {
+		unsigned long val, idx;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr | ~BITMAP_FIRST_WORD_MASK(offset);
+		if (val == ~0UL)
+			return size;
+
+		idx = ffz(val);
+
+		return idx < size ? idx : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
 }
 #endif
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 4cf44ea16ec0..f4a76d3d145f 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -5,6 +5,7 @@
 #include <asm/types.h>
 #include <asm/byteorder.h>
 #include <asm-generic/bitops/find.h>
+#include <linux/swab.h>
 
 #if defined(__LITTLE_ENDIAN)
 
@@ -37,6 +38,21 @@ static inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	if (small_const_nbits(size)) {
+		unsigned long val = *(const unsigned long *)addr, idx;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) | ~BITMAP_FIRST_WORD_MASK(offset);
+		if (val == ~0UL)
+			return size;
+
+		idx = ffz(val);
+
+		return idx < size ? idx : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
 }
 #endif
@@ -46,6 +62,18 @@ static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	if (small_const_nbits(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) & BITMAP_FIRST_WORD_MASK(offset)
+				& BITMAP_LAST_WORD_MASK(size);
+
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
 }
 #endif
-- 
2.25.1

