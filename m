Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAE4F0F30
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377457AbiDDGWj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377422AbiDDGWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:33 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8C377ED;
        Sun,  3 Apr 2022 23:20:30 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bk008244;
        Mon, 4 Apr 2022 15:20:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bk008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053202;
        bh=a1RDShE0uWC0OhbAt+4QzV+tQ/pdHe8WAiRE756c3W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJPyIo+5xtFjhpXfI/BagGdqzFGxiVFbkzFEFKe/4hq72+9HM+ofFhg3C+avRmDFi
         hza7CyscxdpcubFRlNiLS0kbH61rK+vhmw6kZAm7CaNkIeAEntqhg53Vk4rcNy1ywo
         x/TGhBjhkBk8txewXSq0PGSbyR19/mmt9p8GzRs5zqjnD5m+k2cYD2Xe4nTnoicemn
         47NSP1iNGOYi50tRjT1+05Skq/DjvIpW0r2NYOgLpzSCW6tUYxSVx6uVWAFxpyAllz
         3fTV+2QMQb9SQbK52ZNYV6nGQynwNpHpAMaAfT3YMuhr98ArpRyfEJ/QCVf2X7apei
         HNSlPD8YILMog==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/8] agpgart.h: do not include <stdlib.h> from exported header
Date:   Mon,  4 Apr 2022 15:19:41 +0900
Message-Id: <20220404061948.2111820-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 35d0f1d54ecd ("include/uapi/linux/agpgart.h: include stdlib.h in
userspace") included <stdlib.h> to fix the unknown size_t error, but
I do not think it is the right fix.

This header already uses __kernel_size_t a few lines below.

Replace the remaining size_t, and stop including <stdlib.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/agpgart.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/agpgart.h b/include/uapi/linux/agpgart.h
index f5251045181a..9cc3448c0b5b 100644
--- a/include/uapi/linux/agpgart.h
+++ b/include/uapi/linux/agpgart.h
@@ -52,7 +52,6 @@
 
 #ifndef __KERNEL__
 #include <linux/types.h>
-#include <stdlib.h>
 
 struct agp_version {
 	__u16 major;
@@ -64,10 +63,10 @@ typedef struct _agp_info {
 	__u32 bridge_id;	/* bridge vendor/device         */
 	__u32 agp_mode;		/* mode info of bridge          */
 	unsigned long aper_base;/* base of aperture             */
-	size_t aper_size;	/* size of aperture             */
-	size_t pg_total;	/* max pages (swap + system)    */
-	size_t pg_system;	/* max pages (system)           */
-	size_t pg_used;		/* current pages used           */
+	__kernel_size_t aper_size;	/* size of aperture             */
+	__kernel_size_t pg_total;	/* max pages (swap + system)    */
+	__kernel_size_t pg_system;	/* max pages (system)           */
+	__kernel_size_t pg_used;	/* current pages used           */
 } agp_info;
 
 typedef struct _agp_setup {
-- 
2.32.0

