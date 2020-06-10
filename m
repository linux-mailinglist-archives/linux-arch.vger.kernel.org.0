Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089091F57EA
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jun 2020 17:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgFJPfD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jun 2020 11:35:03 -0400
Received: from sym2.noone.org ([178.63.92.236]:36876 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPfC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 11:35:02 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 11:35:02 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49hrWT3nHlzvjc1; Wed, 10 Jun 2020 17:29:25 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: Remove dead shift assignment in ffs/fls
Date:   Wed, 10 Jun 2020 17:29:25 +0200
Message-Id: <20200610152925.11963-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The shift assignment in the last if block of ffs/fls is never read,
remove it.

Found using clang scan-build.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/asm-generic/bitops/ffs.h       | 4 +---
 include/asm-generic/bitops/fls.h       | 4 +---
 tools/include/asm-generic/bitops/fls.h | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index e81868b2c0f0..bc5f1a8f83ca 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -32,10 +32,8 @@ static inline int ffs(int x)
 		x >>= 2;
 		r += 2;
 	}
-	if (!(x & 1)) {
-		x >>= 1;
+	if (!(x & 1))
 		r += 1;
-	}
 	return r;
 }
 
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
-- 
2.27.0

