Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA823376C31
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhEGWMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhEGWMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:12:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 016BE61157;
        Fri,  7 May 2021 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425493;
        bh=59qmX/8bNt05Y62LGNDKy0eALe4d0WbxN5MMLh0uyE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ0dWtAPuQc4xytTkom0IuIRDlu8kCPMbS4FEd4n+I7aA8+09N6WNcp9heHqFL1Mt
         Dl8lIQj3Qy13jdeZVFW+i/uy/FkBT2gZBxHQQzZ31l6uWDiwOknxt3gNlhc1L1dxKq
         rEPUR+VQHN6R7kRcxW7E/ftw3mORtNsP8iFQO4viTlRsrmH0fVaawsPKf7ikXgzGay
         VhKNQnIzrl93hO9XmnwHqXubyl8hHxrvdn6esem4wWlm6DI9OMkozuwLblqnl7mlvN
         QqYGLD6trN9zARPGVpc7cry8c7hguYaziG5fVdanJ9EQQDAQEsa/8l6Va40u6j85iP
         omFidlrYMG+XQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 08/12] partitions: msdos: fix one-byte get_unaligned()
Date:   Sat,  8 May 2021 00:07:53 +0200
Message-Id: <20210507220813.365382-9-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
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

