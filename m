Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECA1B3B93
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVJi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 05:38:56 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:59276 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVJi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 05:38:56 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 05:38:55 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 73336108499;
        Wed, 22 Apr 2020 17:29:19 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] io: correct documentation mismatches for io memcpy
Date:   Wed, 22 Apr 2020 02:29:05 -0700
Message-Id: <20200422092905.39529-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCQ0tCQkJCT01OQk9JT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6TTo5Ijg2GgE2AzVKGTod
        IUMwFDxVSlVKTkNMTk9MTE1KTENLVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlIQks3Bg++
X-HM-Tid: 0a71a138641b9374kuws73336108499
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Minor mismatches exist between funtion documentations and parameter
definitions.

Function definition lines are as following:
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)

static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 include/asm-generic/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..63131ec4857f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
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
2.17.1

