Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89033806BD
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhENKFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232919AbhENKFt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22781613BC;
        Fri, 14 May 2021 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986678;
        bh=59qmX/8bNt05Y62LGNDKy0eALe4d0WbxN5MMLh0uyE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJeJt9KiXSVd7Gjq10XACURQrKMRUKIA5Xi5HhXtHAF3CHfLFnIb47YVbTZ+sxreQ
         k4cGHJDE3p+eWz2chSFug4b80fJK3B/bEOgdL13hEDEfIscA9883HjawAPUbbPS1ZO
         NnRVZcIe/8XSfBiNSYROKJ59f3nrZ+qPB/t94c+KRhmlJZGsn28nLmyL647z+bhsGO
         sSDKnb0TC3CGNCOhIsdqzBG1+aqYOxmP12bKiDXKftDCLXUUPBQbm1ONjGxie8/j5P
         F9XIrsm90TU4dQQTq6HpLjeJkpiiMJ1WDj2eTIkhBdEgTL3BIz/y0hPjKS9cheoKoX
         7/LYqK0DGl9Zw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] partitions: msdos: fix one-byte get_unaligned()
Date:   Fri, 14 May 2021 12:00:56 +0200
Message-Id: <20210514100106.3404011-9-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A simplification of get_unaligned() clashes with callers that pass
in a character pointer, causing a harmless warning like:

block/partitions/msdos.c: In function 'msdos_partition':
include/asm-generic/unaligned.h:13:22: warning: 'packed' attribute ignored for field of type 'u8' {aka 'unsigned char'} [-Wattributes]

Remove the get_unaligned() call and just use the byte directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/partitions/ldm.h   | 2 +-
 block/partitions/msdos.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index d8d6beaa72c4..1a77ff09cc5f 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -85,7 +85,7 @@ struct parsed_partitions;
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
+#define SYS_IND(p)		((p)->sys_ind)
 
 struct frag {				/* VBLK Fragment handling */
 	struct list_head list;
diff --git a/block/partitions/msdos.c b/block/partitions/msdos.c
index 8f2fcc080264..d78549d7619d 100644
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -38,7 +38,7 @@
  */
 #include <asm/unaligned.h>
 
-#define SYS_IND(p)	get_unaligned(&p->sys_ind)
+#define SYS_IND(p)	(p->sys_ind)
 
 static inline sector_t nr_sects(struct msdos_partition *p)
 {
-- 
2.29.2

