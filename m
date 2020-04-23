Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6F1B5128
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 02:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDWAKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 20:10:12 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:10449 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWAKM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 20:10:12 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 33A2B101147;
        Thu, 23 Apr 2020 08:10:07 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v2] io: correct documentation mismatches for io memcpy
Date:   Wed, 22 Apr 2020 17:09:45 -0700
Message-Id: <20200423000945.118231-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VDTUtLS0tKSEhOSk9PWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Ijo*Gjg0KAE8MTEPT0sL
        UR0KCRVVSlVKTkNMTUtLTUtCTklDVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlDSkI3Bg++
X-HM-Tid: 0a71a45ec8ae9374kuws33a2b101147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Minor mismatches exist between funtion documentations and parameter
definitions. Also a dash '-' is needed between a function name and
its description.

Function definitions are as following:
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)
static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * Dashes added between the function names and their descriptions.

 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..b6a9131ec4d4 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1066,10 +1066,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #ifndef memcpy_fromio
 #define memcpy_fromio memcpy_fromio
 /**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_fromio -	Copy a block of data from I/O memory
+ * @buffer:		The (RAM) destination for the copy
+ * @addr:		The (I/O memory) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -1084,10 +1084,10 @@ static inline void memcpy_fromio(void *buffer,
 #ifndef memcpy_toio
 #define memcpy_toio memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_toio -	Copy a block of data into I/O memory
+ * @addr:		The (I/O memory) destination for the copy
+ * @buffer:		The (RAM) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.17.1

