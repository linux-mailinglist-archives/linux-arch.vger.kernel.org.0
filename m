Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6E3BA06A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhGBMez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 08:34:55 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41651 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhGBMey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 08:34:54 -0400
Received: by mail-ej1-f42.google.com with SMTP id b2so15878161ejg.8;
        Fri, 02 Jul 2021 05:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4puU0S79nYZVJxL5330o71fJ7BCxyuoFiktDEi3Ycs=;
        b=G8FKl5fhTxHwOR0rGYgi3IkEc3cbBP5z3W8XuXrgShfuhqcg7eDGRdFrnjhPjhLtPC
         /vmeInZ77PC+5dMb+AL0/9xebCGV+62606RHfugB423iKtlF78aPlD5DhdAMRs1kHCg4
         T2VxBy+a76XEaedo674FRRgvMHcE8NGkIBvA/rdKy7EVJkwVvaFToXc7rOhDr0Dg9Ch4
         xe65V5rCdQC5d0XvYGwGsefyin4rAYtdEHOgUgHp2ev79/JnJ5ojLoX4YQRJhRnOrpQ1
         KuyuFFualQU5e/dRUzOdLcnhi4zQ1tYKoWGn9x3MVD1MLjazqKFFoaj7wgRS2R5RvaTZ
         BbkQ==
X-Gm-Message-State: AOAM530Kc22Fx6ZmlHQJtIMYAsXlJSQpt1ZpLbEm2a1mXAjJYFd9eerr
        sCCpzOHS0M6VPBspT2ZfTsYKZhaMi+hC/A==
X-Google-Smtp-Source: ABdhPJzVbfW2f5ok3CMI+LmMsoURAHir44e7S77s4RVSljg6S5X+t1PvRrH04Og7dFUH6Z5AD+3Xug==
X-Received: by 2002:a17:906:2bd9:: with SMTP id n25mr5046575ejg.513.1625229140622;
        Fri, 02 Jul 2021 05:32:20 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-182-89-242.retail.telecomitalia.it. [80.182.89.242])
        by smtp.gmail.com with ESMTPSA id c3sm1290189edy.0.2021.07.02.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:32:20 -0700 (PDT)
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
Subject: [PATCH v2 2/3] lib/string: optimized memmove
Date:   Fri,  2 Jul 2021 14:31:52 +0200
Message-Id: <20210702123153.14093-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702123153.14093-1-mcroce@linux.microsoft.com>
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When the destination buffer is before the source one, or when the
buffers doesn't overlap, it's safe to use memcpy() instead, which is
optimized to use a bigger data size possible.

This "optimization" only covers a common case. In future, proper code
which does the same thing as memcpy() does but backwards can be done.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/string.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index caeef4264c43..108b83c34cec 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -975,19 +975,13 @@ EXPORT_SYMBOL(memcpy);
  */
 void *memmove(void *dest, const void *src, size_t count)
 {
-	char *tmp;
-	const char *s;
+	if (dest < src || src + count <= dest)
+		return memcpy(dest, src, count);
+
+	if (dest > src) {
+		const char *s = src + count;
+		char *tmp = dest + count;
 
-	if (dest <= src) {
-		tmp = dest;
-		s = src;
-		while (count--)
-			*tmp++ = *s++;
-	} else {
-		tmp = dest;
-		tmp += count;
-		s = src;
-		s += count;
 		while (count--)
 			*--tmp = *--s;
 	}
-- 
2.31.1

