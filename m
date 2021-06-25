Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051D13B3A4F
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhFYBEv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 21:04:51 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43868 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhFYBEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 21:04:50 -0400
Received: by mail-ej1-f48.google.com with SMTP id nb6so12401122ejc.10;
        Thu, 24 Jun 2021 18:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5d1bwUaSuG/f6mTu6ru/WOtu9a5hLw1cNtYO/dabh8E=;
        b=CjKz94yHeYEmEKt1OkiIOBRmUasTa4EZgS+7uMnN3enZT8Yr3zjXeglsLkCN8t/VNm
         zZrhiZIJuU6/eGbuNs7lfZlPglcIUW7E9IGJ851y/3w4MqDxx/BQrosR9QCCGtnBUUWM
         tzvuwKL2+cRtOFAJRoED1e4HZMfOouL4bj8XthPRM74h7p65t8iKmWTMBFk00ztwPN4n
         bQbniRQf9uTy+bFmTyCj1TOQJZb4iljHmRMk2jED8WdWCqky1khQQW37DHUPCbdUW+VR
         ++yCDWI3WGddTs5CoVe+KTNYj11svMKeLWLsEaSafP8V9dSb6C/vzTmEgD+NDkaC6SZX
         5Slw==
X-Gm-Message-State: AOAM530lKX6AggpuUsjFYCNaDm2eSnX+6+TfWLHIs3as2OnL4jZFX613
        8FeF4GNRCoyIttaQPgprHCSnW4qvu7jYtw==
X-Google-Smtp-Source: ABdhPJxINwo0+vWL6bmf2rOXNOQTpbhqaRuhL6BUfM1PoIYKKfYvwU+5wDopzTUQ2tk9MFuhlrmHSA==
X-Received: by 2002:a17:906:30d0:: with SMTP id b16mr8028751ejb.495.1624582949235;
        Thu, 24 Jun 2021 18:02:29 -0700 (PDT)
Received: from msft-t490s.home (host-95-251-17-240.retail.telecomitalia.it. [95.251.17.240])
        by smtp.gmail.com with ESMTPSA id yc29sm1921909ejb.106.2021.06.24.18.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 18:02:28 -0700 (PDT)
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
Subject: [PATCH 2/3] lib/string: optimized memmove
Date:   Fri, 25 Jun 2021 03:01:59 +0200
Message-Id: <20210625010200.362755-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625010200.362755-1-mcroce@linux.microsoft.com>
References: <20210625010200.362755-1-mcroce@linux.microsoft.com>
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
index 15e906f97d9e..69adec252597 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -976,19 +976,13 @@ EXPORT_SYMBOL(memcpy);
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

