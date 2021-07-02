Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF33BA06D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 14:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhGBMfB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 08:35:01 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:39597 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhGBMfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 08:35:00 -0400
Received: by mail-ej1-f52.google.com with SMTP id hp26so3136983ejc.6;
        Fri, 02 Jul 2021 05:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6ZDZDCvhi/aYSH4+o4WB0jbVOX9Yf7JZyqDclGvSvg=;
        b=RxLVEXFe1ZOqlo95ZCKImSbLkM93C3aTVIrD1jipfq0PYcGC6u0bMuOMcnaWXq/A03
         emTFg+3AwnvEffV2+CLG8riG2g1Zj1qlpm3ivBKQa3sWSCMbsKTcYeu9UxM3r13b0bcF
         Y0E2XzP6u2se5IvtQfeyULy3o2/HfsHkudXhGO8e8GxCl5uDkwo25DVa0++FYb0WqGm6
         mUjDmOMxf1Xho+0OLnDAnSH5aaZA+Ey9eXSbLYmhqqTT5as+tV68+j7T0HM8/IvALLe/
         64uIpW2YYHQdoVZUzIcOu7puQzd+g4ut+uSIi6MaLkkfun4/aE0ACtYSm4HwD3StG3Z6
         xFow==
X-Gm-Message-State: AOAM530GPvH1ItIC2Dn/8RJW6xAGRaPAEMzFaYX02BXsVQKvhB1k5rN3
        8t0sNg9dumy6lJM4lu+y2F7uZ/ab2nIN4Q==
X-Google-Smtp-Source: ABdhPJwQrfzQ1h6zczBdfLb25MTXk3GdnKc5nFaDGxDMgWYbUpCHG31dhKgZ9CSECScHKbbT4BunVg==
X-Received: by 2002:a17:906:9b86:: with SMTP id dd6mr4909110ejc.100.1625229142346;
        Fri, 02 Jul 2021 05:32:22 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-182-89-242.retail.telecomitalia.it. [80.182.89.242])
        by smtp.gmail.com with ESMTPSA id c3sm1290189edy.0.2021.07.02.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:32:21 -0700 (PDT)
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
Subject: [PATCH v2 3/3] lib/string: optimized memset
Date:   Fri,  2 Jul 2021 14:31:53 +0200
Message-Id: <20210702123153.14093-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702123153.14093-1-mcroce@linux.microsoft.com>
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The generic memset is defined as a byte at time write. This is always
safe, but it's slower than a 4 byte or even 8 byte write.

Write a generic memset which fills the data one byte at time until the
destination is aligned, then fills using the largest size allowed,
and finally fills the remaining data one byte at time.

On a RISC-V machine the speed goes from 140 Mb/s to 241 Mb/s,
and this the binary size increase according to bloat-o-meter:

Function     old     new   delta
memset        32     148    +116

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/string.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 108b83c34cec..264821f0e795 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -810,10 +810,38 @@ EXPORT_SYMBOL(__sysfs_match_string);
  */
 void *memset(void *s, int c, size_t count)
 {
-	char *xs = s;
+	union types dest = { .as_u8 = s };
 
+	if (count >= MIN_THRESHOLD) {
+		unsigned long cu = (unsigned long)c;
+
+		/* Compose an ulong with 'c' repeated 4/8 times */
+#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
+		cu *= 0x0101010101010101UL;
+#else
+		cu |= cu << 8;
+		cu |= cu << 16;
+		/* Suppress warning on 32 bit machines */
+		cu |= (cu << 16) << 16;
+#endif
+		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			/*
+			 * Fill the buffer one byte at time until
+			 * the destination is word aligned.
+			 */
+			for (; count && dest.as_uptr & WORD_MASK; count--)
+				*dest.as_u8++ = c;
+		}
+
+		/* Copy using the largest size allowed */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*dest.as_ulong++ = cu;
+	}
+
+	/* copy the remainder */
 	while (count--)
-		*xs++ = c;
+		*dest.as_u8++ = c;
+
 	return s;
 }
 EXPORT_SYMBOL(memset);
-- 
2.31.1

