Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87A3B3A4D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhFYBEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 21:04:50 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38812 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYBEt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 21:04:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id q14so11164898eds.5;
        Thu, 24 Jun 2021 18:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzhxbsS0xblHmbaMS57RZ4S8yZ1GoCabsZyCXQhJYrY=;
        b=OXmtYmhaQeM1/5f9+cwH8ULEqu997Y/E/zhaUOq2ATxYovQcOZordtUE1OC1acZbbU
         an2Uz9mAvUvk/cC9GRWNVX69HTH2EphxpktmwP0uBZCIHfbXv5c/+i5iXB7qvlWlmUyG
         hpEl+ghKLkgk0YsFs8HDZbJWLfeTk2kyVzm7R6taUk5eSqaUChSGfkgTdLuYrp67gngT
         l4JvvQcIR2XqU9GeYQcSzNiNjuLr+rezHl7whXyztWJqiXKVtVi+COYExDsCW+31uOf4
         plRZ2pEq0sCwZgBDVWenJLqUKy88Gxa7i7B6Vc/UUvprd9NSKQDoCHAi82pFFabPqD22
         D0Tg==
X-Gm-Message-State: AOAM532j3kuO4Y9iv1k9ByyircZ2CoQc9GMMoWwrU4cg73r30kV8cWQJ
        GzBAJw/efpH68KyaOu9c+SXPrGieN0jh4A==
X-Google-Smtp-Source: ABdhPJzUlanwgvJ9sy/0XoJxNoRpkQdc4Ar2JfL2/NSyHYMU4NhXrSCqoGE3LIUdsSRwDZUL/8ERpA==
X-Received: by 2002:a05:6402:35c3:: with SMTP id z3mr10939073edc.346.1624582947742;
        Thu, 24 Jun 2021 18:02:27 -0700 (PDT)
Received: from msft-t490s.home (host-95-251-17-240.retail.telecomitalia.it. [95.251.17.240])
        by smtp.gmail.com with ESMTPSA id yc29sm1921909ejb.106.2021.06.24.18.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 18:02:26 -0700 (PDT)
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
Subject: [PATCH 1/3] lib/string: optimized memcpy
Date:   Fri, 25 Jun 2021 03:01:58 +0200
Message-Id: <20210625010200.362755-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625010200.362755-1-mcroce@linux.microsoft.com>
References: <20210625010200.362755-1-mcroce@linux.microsoft.com>
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

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/string.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 546d59711a12..15e906f97d9e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -33,6 +33,24 @@
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
 
+#define MIN_THRESHOLD (sizeof(long) * 2)
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
+static const unsigned int bytes_long = sizeof(long);
+static const unsigned int word_mask = bytes_long - 1;
+
 #ifndef __HAVE_ARCH_STRNCASECMP
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -878,16 +896,73 @@ EXPORT_SYMBOL(memset64);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
+
+#ifdef __BIG_ENDIAN
+#define MERGE_UL(h, l, d) ((h) << ((d) * 8) | (l) >> ((bytes_long - (d)) * 8))
+#else
+#define MERGE_UL(h, l, d) ((h) >> ((d) * 8) | (l) << ((bytes_long - (d)) * 8))
+#endif
+
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
+		for (; d.as_uptr & word_mask; count--)
+			*d.as_u8++ = *s.as_u8++;
+
+		distance = s.as_uptr & word_mask;
+	}
 
+	if (distance) {
+		unsigned long last, next;
+
+		/*
+		 * s is distance bytes ahead of d, and d just reached
+		 * the alignment boundary. Move s backward to word align it
+		 * and shift data to compensate for distance, in order to do
+		 * word-by-word copy.
+		 */
+		s.as_u8 -= distance;
+
+		next = s.as_ulong[0];
+		for (; count >= bytes_long + word_mask; count -= bytes_long) {
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
+		for (; count >= bytes_long; count -= bytes_long)
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

