Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33A93BA068
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhGBMex (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 08:34:53 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:42893 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhGBMex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 08:34:53 -0400
Received: by mail-ej1-f52.google.com with SMTP id bg14so15839340ejb.9;
        Fri, 02 Jul 2021 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GMA6YAdsMJJ2OpDaPRDcSndU6vVBN1z0EV3RST4eEI=;
        b=tdHDAnN8mLx67OwjyzL/lwRXHQjXcxYK0YuHakgqO/hO/AOL0zgD+QQZ1ikHDWv2gB
         5fPjfUwGRkcgmKjfme624ZOsI2vZJP0lnaTIwrWL6ziaQA3ldOO7Ii7v6C66uQaDJ440
         Z3ADb9LxCptZmTVcOf3tYI/vAxr9yEdfdLEclWmi03REpA53NkPMnnW1wQQuMbHb0Zlh
         vFcWDbOFu6Tojh4hNP+gu+JvlWEu8pz4ZVNP2+iC8l+pUEWeyOoIsoVc8wDgh+eZGAim
         IG18BsOk/NU6ZlRYyn96yneqllevXVHYhX7fxN1JFL386mp6mxchrNuNiYP+ziUGIcYs
         njVg==
X-Gm-Message-State: AOAM531rnJZ+RmedfrFUy5OD5QKgckN8zRiiIlBMS0tOYdvNgaVSFswa
        A13HIDZx2jD4zYzCBciqhTIO/1azqho10w==
X-Google-Smtp-Source: ABdhPJyuBLxcG4vaaxi6RF9BBdfZtZkVEaNit0HDs+2ntcHzQ/RwrmfxN18YyFvI23EQTmjogWV32g==
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr5026096ejc.145.1625229139021;
        Fri, 02 Jul 2021 05:32:19 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-182-89-242.retail.telecomitalia.it. [80.182.89.242])
        by smtp.gmail.com with ESMTPSA id c3sm1290189edy.0.2021.07.02.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:32:18 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] lib/string: optimized memcpy
Date:   Fri,  2 Jul 2021 14:31:51 +0200
Message-Id: <20210702123153.14093-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702123153.14093-1-mcroce@linux.microsoft.com>
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Rewrite the generic memcpy() to copy a word at time, without generating
unaligned accesses.

The procedure is made of three steps:
First copy data one byte at time until the destination buffer is aligned
to a long boundary.
Then copy the data one long at time shifting the current and the next long
to compose a long at every cycle.
Finally, copy the remainder one byte at time.

This is the improvement on RISC-V:

original aligned:	 75 Mb/s
original unaligned:	 75 Mb/s
new aligned:		114 Mb/s
new unaligned:		107 Mb/s

and this the binary size increase according to bloat-o-meter:

Function     old     new   delta
memcpy        36     324    +288


Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/string.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 546d59711a12..caeef4264c43 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -33,6 +33,23 @@
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
 
+#define BYTES_LONG	sizeof(long)
+#define WORD_MASK	(BYTES_LONG - 1)
+#define MIN_THRESHOLD	(BYTES_LONG * 2)
+
+/* convenience union to avoid cast between different pointer types */
+union types {
+	u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+union const_types {
+	const u8 *as_u8;
+	const unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
 #ifndef __HAVE_ARCH_STRNCASECMP
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -869,6 +886,13 @@ EXPORT_SYMBOL(memset64);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCPY
+
+#ifdef __BIG_ENDIAN
+#define MERGE_UL(h, l, d) ((h) << ((d) * 8) | (l) >> ((BYTES_LONG - (d)) * 8))
+#else
+#define MERGE_UL(h, l, d) ((h) >> ((d) * 8) | (l) << ((BYTES_LONG - (d)) * 8))
+#endif
+
 /**
  * memcpy - Copy one area of memory to another
  * @dest: Where to copy to
@@ -880,14 +904,64 @@ EXPORT_SYMBOL(memset64);
  */
 void *memcpy(void *dest, const void *src, size_t count)
 {
-	char *tmp = dest;
-	const char *s = src;
+	union const_types s = { .as_u8 = src };
+	union types d = { .as_u8 = dest };
+	int distance = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		if (count < MIN_THRESHOLD)
+			goto copy_remainder;
+
+		/* Copy a byte at time until destination is aligned. */
+		for (; d.as_uptr & WORD_MASK; count--)
+			*d.as_u8++ = *s.as_u8++;
+
+		distance = s.as_uptr & WORD_MASK;
+	}
+
+	if (distance) {
+		unsigned long last, next;
 
+		/*
+		 * s is distance bytes ahead of d, and d just reached
+		 * the alignment boundary. Move s backward to word align it
+		 * and shift data to compensate for distance, in order to do
+		 * word-by-word copy.
+		 */
+		s.as_u8 -= distance;
+
+		next = s.as_ulong[0];
+		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
+			last = next;
+			next = s.as_ulong[1];
+
+			d.as_ulong[0] = MERGE_UL(last, next, distance);
+
+			d.as_ulong++;
+			s.as_ulong++;
+		}
+
+		/* Restore s with the original offset. */
+		s.as_u8 += distance;
+	} else {
+		/*
+		 * If the source and dest lower bits are the same, do a simple
+		 * 32/64 bit wide copy.
+		 */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*d.as_ulong++ = *s.as_ulong++;
+	}
+
+copy_remainder:
 	while (count--)
-		*tmp++ = *s++;
+		*d.as_u8++ = *s.as_u8++;
+
 	return dest;
 }
 EXPORT_SYMBOL(memcpy);
+
+#undef MERGE_UL
+
 #endif
 
 #ifndef __HAVE_ARCH_MEMMOVE
-- 
2.31.1

