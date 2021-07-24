Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305423D489E
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGXPwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 11:52:23 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:36986 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXPwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 11:52:22 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 11:52:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1627143876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VlraKBfCz4HcEEphEEUFJxpqY7WKDh5jCjkPEkIoSOo=;
        b=vraSgcfngtPJ5cG1c7K18mNFPKbUyQjtOynHdMdNi/mqG7QZjlTI4A9H+HrArp5Xd3oJW4
        3WH9aXK5UEKQeKJUTAwqd55zEujLFbycKYr8elquAXYlfNOQ2GlEpzNoQzAv3bBlJGGtvR
        5mXHQ5YkNe+mpvctxK67f4mfT4hjRBQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     b.a.t.m.a.n@lists.open-mesh.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Date:   Sat, 24 Jul 2021 18:24:29 +0200
Message-Id: <20210724162429.394792-1-sven@narfation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sparse will try to check casting of simple integer types which are marked
as __bitwise. This for example "disallows" simple casting of __be{16,32,64}
or __le{16,32,64} to other types. This is also true for pointers to
variables with this type.

But the new generic {get,put}_unaligned is doing that by (reinterpret)
casting the original pointer to a new (anonymous) struct pointer. This will
then create warnings like:

  net/batman-adv/distributed-arp-table.c:1461:19: warning: cast from restricted __be32 *
  net/batman-adv/distributed-arp-table.c:1510:23: warning: cast from restricted __be32 [usertype] *[assigned] magic
  net/batman-adv/distributed-arp-table.c:1588:24: warning: cast from restricted __be32 [usertype] *[assigned] yiaddr

The special attribute force must be used in such statements when the cast
is known to be safe to avoid these warnings.

Fixes: 803f4e1eab7a ("asm-generic: simplify asm/unaligned.h")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/asm-generic/unaligned.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..e2b23e5bf945 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -10,12 +10,13 @@
 #include <asm/byteorder.h>
 
 #define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	const struct { type x; } __packed *__pptr;				\
+	__pptr = (__force typeof(__pptr))(ptr);					\
 	__pptr->x;								\
 })
 
 #define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	struct { type x; } __packed *__pptr = (__force typeof(__pptr))(ptr);	\
 	__pptr->x = (val);							\
 } while (0)
 
-- 
2.30.2

