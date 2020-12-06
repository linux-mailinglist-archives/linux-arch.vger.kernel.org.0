Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19A2D013D
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFGrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLFGrT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:47:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA0C0613D0;
        Sat,  5 Dec 2020 22:46:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t37so6282764pga.7;
        Sat, 05 Dec 2020 22:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KErC084960zylpgBzu6sNKs0fZH4q0CEV9pS/Y92fMk=;
        b=WZ0YOdWM99tTNMqetvJ00R9XyIJFk9JVKFf4csd9oFNljnQpcZF57h4ZEbvhpvYjnR
         6Zo96G/kxbXqvDoegET+qo6/kt6KhGQ1MinnsPZqNjDjAYD+d48SyexFSyDBCltNbHB+
         6ANQzrjh/qRDh0WkFZy0otxyXyj94yAaNXqnYy+7kiRYGumZX8GT+Q86EdxJ6K3wmmgX
         +uqEMYxJy7NSqBSuO2q9LL90cfg4f8LXNQJfa6uJdKTFvqpwQfQFZrsgX6+dDvRiETIH
         iuKXpoLDtAWadh/v0DcKY61dWxa5rZzSFgH4hgoh58Ow65Ns9udE0awDe/6fJMAix3dI
         TeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KErC084960zylpgBzu6sNKs0fZH4q0CEV9pS/Y92fMk=;
        b=eohtjsqEffeG5M3Ym6pfdAKpCe+lJQM86hlmCPitYiZnx4++Py6t7iPOVBjXaDdLY5
         9vjSr6Up+d1lXYm3uI8SmipU6/1HWEdcARgUcji5MwnO1vm2OQewpB7IN+4MC+W7ui2b
         RvhDVtFHkY4rzSPbvfxSyzuA1zlU1e9xHJVQWpSl7YGbIZIDWcdo4FG6744t+VbD89mY
         xiFOn1g1+vwxTBprvZm1BXOXLfghnO0sXklXq+zJOpYwlW0YgmTybhgtorXqtAGZ32xY
         BXoV7eiQhdp4fPhB8KdTt0aViGni4X5KbDjAfEr8q7wktyQQK8DsUlVjzN4Eb14oqpUT
         SIkg==
X-Gm-Message-State: AOAM533Na6dq8lfh/2oE6GnuY1xd2FwqgvZZa9dfuGLnaFJIW+/rjThL
        ZdH0GWsZm7//ceee7vlFCJU=
X-Google-Smtp-Source: ABdhPJwU4blJQE9tPken6vT+PayJ4NYtxO4wG95HD18NcOiSKdZZ7oJIy3MQLkRZF72hLLBUMvGzNg==
X-Received: by 2002:a62:188a:0:b029:19a:cdab:9841 with SMTP id 132-20020a62188a0000b029019acdab9841mr11085031pfy.12.1607237198971;
        Sat, 05 Dec 2020 22:46:38 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id b4sm6843717pju.33.2020.12.05.22.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:46:38 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:46:24 +0900
From:   Levi Yun <ppbuk5246@gmail.com>
To:     akpm@linux-foundation.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        arnd@arndb.de, jpoimboe@redhat.com, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        mhiramat@kernel.org, jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        glider@google.com, orson.zhai@unisoc.com,
        takahiro.akashi@linaro.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
Message-ID: <20201206064624.GA5871@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
And add le support about find_last_bit and find_last_zero_bit.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/find_bit.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 4a8751010d59..f9dda2bf7fa9 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -90,7 +90,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif
 
-#if !defined(find_next_and_bit)
+#ifndef find_next_and_bit
 unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -141,7 +141,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (size) {
 		unsigned long val = BITMAP_LAST_WORD_MASK(size);
-		unsigned long idx = (size-1) / BITS_PER_LONG;
+		unsigned long idx = (size - 1) / BITS_PER_LONG;
 
 		do {
 			val &= addr[idx];
@@ -156,6 +156,27 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(find_last_bit);
 #endif
 
+#ifndef find_last_zero_bit
+unsigned long find_last_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (size) {
+		unsigned long val = BITMAP_LAST_WORD_MASK(size);
+		unsigned long idx = (size - 1) / BITS_PER_LONG;
+
+		do {
+			val &= ~addr[idx];
+			if (val)
+				return idx * BITS_PER_LONG + __fls(val);
+
+			val = ~0ul;
+		} while (idx--);
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_last_zero_bit);
+#endif
+
 #ifdef __BIG_ENDIAN
 
 #ifndef find_next_zero_bit_le
@@ -176,6 +197,45 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
+static unsigned long _find_last_bit_le(const unsigned long *addr,
+		unsigned long size, unsigned long invert)
+{
+	if (size) {
+		unsigned long val = BITMAP_LAST_WORD_MASK(size);
+		unsigned long tmp;
+		unsigned long idx = (size - 1) / BITS_PER_LONG;
+
+	val = swab(val);
+
+		do {
+			tmp = swab(addr[idx]);
+			tmp ^= invert;
+			val &= tmp;
+			if (val)
+				return idx * BITS_PER_LONG + __fls(val);
+
+			val = ~0ul;
+		} while (idx--);
+	}
+	return size;
+}
+
+#ifndef find_last_zero_bit_le
+unsigned long find_last_zero_bit_le(const unsigned void *addr, unsigned long size)
+{
+	return _find_last_bit_le(addr, size, ~0UL);
+}
+EXPORT_SYMBOL(find_last_zero_bit_le);
+#endif
+
+#ifdef find_last_bit_le
+unsigned long find_last_bit_le(const unsigned void *addr, unsigned long size)
+{
+	return _find_last_bit_le(addr, size, 0UL);
+}
+EXPORT_SYMBOL(find_last_bit_le);
+#endif
+
 #endif /* __BIG_ENDIAN */
 
 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
-- 
2.27.0
