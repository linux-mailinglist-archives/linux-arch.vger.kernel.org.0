Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7233CB24
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhCPBzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhCPBym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB5C06174A;
        Mon, 15 Mar 2021 18:54:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 94so10636809qtc.0;
        Mon, 15 Mar 2021 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/xlmbsV2khAicNfPsBhpBoucnaza45eYV+jsblvUeM=;
        b=gdiwytAAQA2crYgd3Wxao/o4VmK34FSifWzpmkLA5GMCxbl7mpL76oNGxJcSczrCdR
         Argkc4WsWSzkuae9VmyK0lf/XJCUT9dbV0CLFufUpjg+M6/qRGtZ1OcHz1+nKHanA0I7
         3L+pwKlg1aRT0qYnEaQWXeZKLBc070RSfHjcmniezgIi84hYw5296QM3OSo6YSwvdijW
         idl8XQ6OmHUP0azJPR8EHmp0QZF05Nfkx0VEUZTsA251MLmQeCp8kA1NgK9qriidIZLB
         ntTv7jprl/2+BrwwhenNH7zjsjFc+7Z6C5uP2bt0ZWnK4ZirVeoNDc+sDbVk8sNoL1aH
         iiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/xlmbsV2khAicNfPsBhpBoucnaza45eYV+jsblvUeM=;
        b=WgplrV3dELsQh9FXbVKtPkR48UBoOYikzniY6xIlvlSO2zVfm2zRgTQkNYsLGsVDfl
         ineLyl0OvyN0O8bVMRT0t7FFe8vJMmZ6HnN2xVYOG4bhv54rmCuM27d5ScWeheBld/Ur
         xVGFtwds+CLvM9j3ul7I+6l1IuXkxAtdqMRyIzuJK+bcAiRNbFyG2gcQAAuHeshY1bql
         LfDXPWgS7xwT//yVy8obdP3Cvk89c1RhL/bxue8OUc6L2tCdLz6ResFoIbzHXv2N1zkm
         IV+obv0MG/ZB+Xr04SPy/0JXWdSf/XR8Lqmag+yvDLwAGZkokOojXKubc7JKRCNVB7k3
         MG1g==
X-Gm-Message-State: AOAM530CvAoOSp9DjzFmFMBy8zY2PJnGW5UHn+fldYsqSa1idcOC/UgU
        4bbUTyhI9jBJfRrIl3jx6NudqITyUjs=
X-Google-Smtp-Source: ABdhPJwcGsVvYwm7fNfqetUd8s+UxAadxtbmvN7vgr5oVbI3f8bjcklGwccRzRdcsbjp3ayVrgQmPA==
X-Received: by 2002:ac8:ec3:: with SMTP id w3mr26083044qti.72.1615859681320;
        Mon, 15 Mar 2021 18:54:41 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id p66sm14113040qkd.57.2021.03.15.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:41 -0700 (PDT)
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
Subject: [PATCH 12/13] tools: sync lib/find_bit implementation
Date:   Mon, 15 Mar 2021 18:54:23 -0700
Message-Id: <20210316015424.1999082-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add fast paths to find_*_bit() functions as per kernel implementation.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/asm-generic/bitops/find.h | 58 +++++++++++++++++++++++--
 tools/lib/find_bit.c                    |  4 +-
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 9fe62d10b084..bf807af1503f 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -5,6 +5,9 @@
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
+extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
 #ifndef find_next_bit
 /**
@@ -20,6 +23,16 @@ static inline
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
@@ -40,6 +53,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
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
@@ -58,6 +81,16 @@ static inline
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
@@ -72,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-extern unsigned long find_first_bit(const unsigned long *addr,
-				    unsigned long size);
+static inline
+unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr & BITS_FIRST(size - 1);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_bit(addr, size);
+}
 
 #endif /* find_first_bit */
 
@@ -87,7 +129,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size);
+static inline
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr | ~BITS_FIRST(size - 1);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit(addr, size);
+}
 #endif
 
 #endif /*_TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index c3378b291205..a77884ca30ec 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -83,7 +83,7 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 /*
  * Find the first set bit in a memory region.
  */
-unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
@@ -100,7 +100,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 /*
  * Find the first cleared bit in a memory region.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
-- 
2.25.1

