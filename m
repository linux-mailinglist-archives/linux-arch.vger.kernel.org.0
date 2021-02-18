Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9705E31E4F6
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBREIP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhBREG4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:56 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121AC06121D;
        Wed, 17 Feb 2021 20:05:25 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 2so385549qvd.0;
        Wed, 17 Feb 2021 20:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12ov5Wc2VLYqBN6pji2I8kDJUvO1aq9EkiflVHQIASU=;
        b=gM1892Gp7EhVkJlC1YDQrEi+eVz/l3odoEPeC60+u3x0JmB7+bV23A9RxMC2b2Qa4n
         2t9KQC2WEpA+40SQFez5eQycP5lpCkx+w6Fct1NfqkKWzPEANXdWiDoUvU0hBvS18i1/
         Xdmn8EP/A9mrsSyldp1oB+3q8X7Xbq12KSIykPl7IcSNTKJvPdqzpbEyJrdD7U0fzbZC
         CvKuQ1mXZuMUGzFxEM3PKpiRtBYGsNNpUgp3ICRQ2QfyPxN+/yDVTrETekwD/rXSbBmq
         nDmTM+HCSpfbkOxzTdK/8a6CC0BJA8GEJ1+PrbiQPfPuktiUSULTAfdC8gb7DA3P+S6v
         G/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12ov5Wc2VLYqBN6pji2I8kDJUvO1aq9EkiflVHQIASU=;
        b=sgn+bRP5O0daGADuv9bFHVj4Al9D7BWzINiPsHbUQ5tm5llANbFW3gdJPTuXFcSah+
         w2u6Bi4/1jtt6Toz6q3NXvemBx9f/xyulnoE22nMW6PhyXMkbMVkCleSbWp8uqFZwqhU
         uD0unuRA/bazJDIOvIK0kus0tQ9aH1mkklLOBxbgc6/ajMyi55A5pCm3cViqH/q2bEyJ
         2tiRYTTdDJibvNi+Ncb7sRf1UmEGTJTvc+ibuJWfOJSYjueatRnWu9GvduBFbWD3VI90
         DZd4S5XWPrybOjePbkStdbPdZDilTDHwNMEl95lhEI8DUdgwrNVyV7SGxAB4/rJ/JTPJ
         01ig==
X-Gm-Message-State: AOAM5320sfhLcoHaoIG3DoS/vZ7Qqf9VjyFpqi8ak7yVGGA6PmVdq+SH
        PIs2LCOY3Rr9paAWrHQb/90jp39PTbrFPA==
X-Google-Smtp-Source: ABdhPJxrSRuP+gTwPyAKuBZNi9wigb9Ulmo6Vw2o4RPWDN6boR/FDUrfh2GsiQQ7m2PZ9eioTSr4zw==
X-Received: by 2002:a0c:c345:: with SMTP id j5mr2423906qvi.13.1613621124700;
        Wed, 17 Feb 2021 20:05:24 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id u27sm3171707qku.82.2021.02.17.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:24 -0800 (PST)
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
Subject: [PATCH 08/14] lib/Kconfig: introduce FAST_PATH option
Date:   Wed, 17 Feb 2021 20:05:06 -0800
Message-Id: <20210218040512.709186-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series introduces fast paths for find_bit() routines. It is
beneficial for typical systems, but those who limited in I-cache
may be concerned about increasing the .text size of the Image.

To address this concern, one can disable FAST_PATH option in the config
and some save memory.

The effect of this option on my arm64 next-20210217 build is:

Before:
	Sections:
	Idx Name          Size      VMA               LMA               File off  Algn
	  0 .head.text    00010000  ffff800010000000  ffff800010000000  00010000  2**16
			  CONTENTS, ALLOC, LOAD, READONLY, CODE
	  1 .text         0115e3a8  ffff800010010000  ffff800010010000  00020000  2**16
			  CONTENTS, ALLOC, LOAD, READONLY, CODE
	  2 .got.plt      00000018  ffff80001116e3a8  ffff80001116e3a8  0117e3a8  2**3
			  CONTENTS, ALLOC, LOAD, DATA
	  3 .rodata       007a72ca  ffff800011170000  ffff800011170000  01180000  2**12
			  CONTENTS, ALLOC, LOAD, DATA
	  ...

After:
	Sections:
	Idx Name          Size      VMA               LMA               File off  Algn
	  0 .head.text    00010000  ffff800010000000  ffff800010000000  00010000  2**16
			  CONTENTS, ALLOC, LOAD, READONLY, CODE
	  1 .text         011623a8  ffff800010010000  ffff800010010000  00020000  2**16
			  CONTENTS, ALLOC, LOAD, READONLY, CODE
	  2 .got.plt      00000018  ffff8000111723a8  ffff8000111723a8  011823a8  2**3
			  CONTENTS, ALLOC, LOAD, DATA
	  3 .rodata       007a772a  ffff800011180000  ffff800011180000  01190000  2**12
			  CONTENTS, ALLOC, LOAD, DATA
	  ...

Notice that this is the cumulive effect on already existing fast paths
controlled by SMALL_CONST() together with ones added by this series.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitsperlong.h | 4 ++++
 lib/Kconfig                       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 0eeb77544f1d..209e531074c1 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -23,6 +23,10 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#ifdef CONFIG_FAST_PATH
 #define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
+#else
+#define SMALL_CONST(n) (0)
+#endif
 
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/lib/Kconfig b/lib/Kconfig
index a38cc61256f1..7a1b9c8d2a32 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -39,6 +39,13 @@ config PACKING
 
 	  When in doubt, say N.
 
+config FAST_PATH
+	bool "Enable fast path code generation"
+	default y
+	help
+	  This option enables fast path optimization with the cost of increasing
+	  the text section.
+
 config BITREVERSE
 	tristate
 
-- 
2.25.1

