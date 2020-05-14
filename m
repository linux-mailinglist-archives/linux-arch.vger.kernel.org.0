Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2151D379A
	for <lists+linux-arch@lfdr.de>; Thu, 14 May 2020 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENRIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 May 2020 13:08:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55115 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgENRIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2020 13:08:21 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7E839200003;
        Thu, 14 May 2020 17:08:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] asm-generic: Update kernel documentation in io.h
Date:   Thu, 14 May 2020 19:08:18 +0200
Message-Id: <20200514170818.24598-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel documentation of:
* bus_to_virt()
* memcpy_fromio()
* memcpy_toio()
refers to older parameters.

Update it to fit the actual names.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..cb617baf8d47 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1051,8 +1051,8 @@ static inline void *bus_to_virt(unsigned long address)
 /**
  * memset_io	Set a range of I/O memory to a constant value
  * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
+ * @value:	The value to set the memory to
+ * @size:	The number of bytes to set
  *
  * Set a range of I/O memory to a given value.
  */
@@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #define memcpy_fromio memcpy_fromio
 /**
  * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * @buffer:		The (RAM) destination for the copy
+ * @addr:		The (I/O memory) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -1085,9 +1085,9 @@ static inline void memcpy_fromio(void *buffer,
 #define memcpy_toio memcpy_toio
 /**
  * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * @addr:		The (I/O memory) destination for the copy
+ * @buffer:		The (RAM) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.20.1

