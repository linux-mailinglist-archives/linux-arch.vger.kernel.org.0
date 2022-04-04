Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6424F0F44
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbiDDGWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377417AbiDDGWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:32 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED236E32;
        Sun,  3 Apr 2022 23:20:29 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bo008244;
        Mon, 4 Apr 2022 15:20:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bo008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053205;
        bh=PdbBnXvGqqA+FniCDgXg05k8pJcNIN9vip0pBgTchzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJMPxHJFUUv3FiXSITD4Z4GcTOwl0ot6nym5pD5crBXzIA9vZkfP+B1F0WurK52Tt
         K+moBR35Ld27Wi+FCQjA+KNnvDBRaSM+wPdnX8lbejsDa/YPmi3voHFaPUX3DWrwPx
         E+GYKJuEhTLZcG3BFx12qajmBCGXPnaCoM023VBrzLpUJOuQkYBZQ6xt4lGKeRKIug
         fB/x4okJYDOLuRAMqGHEk2euAlSC17xxisGufgIqtVD7Ftkrj+QhXIfkWgZBZDSpCC
         G7p3tzmLGng1WGANWaGYYDZg16AhQ0Hmx9FccmhMl/VKCvAgWsnAKZOmMqWmj0rd8+
         PjnTSLXuzibLg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/8] powerpc: add asm/stat.h to UAPI compile-test coverage
Date:   Mon,  4 Apr 2022 15:19:45 +0900
Message-Id: <20220404061948.2111820-6-masahiroy@kernel.org>
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

asm/stat.h is currently excluded from the UAPI compile-test for
ARCH=powerpc because of the errors like follows:

    HDRTEST usr/include/asm/stat.h
  In file included from <command-line>:32:
  ./usr/include/asm/stat.h:32:2: error: unknown type name 'ino_t'
     32 |  ino_t  st_ino;
        |  ^~~~~
  ./usr/include/asm/stat.h:35:2: error: unknown type name 'mode_t'
     35 |  mode_t  st_mode;
        |  ^~~~~~
  ./usr/include/asm/stat.h:40:2: error: unknown type name 'uid_t'
     40 |  uid_t  st_uid;
        |  ^~~~~
  ./usr/include/asm/stat.h:41:2: error: unknown type name 'gid_t'
     41 |  gid_t  st_gid;
        |  ^~~~~

The errors can be fixed by prefixing the types with __kernel_.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/include/uapi/asm/stat.h | 10 +++++-----
 usr/include/Makefile                 |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/stat.h b/arch/powerpc/include/uapi/asm/stat.h
index 7871055e5e32..a28c9a1201fa 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -29,16 +29,16 @@ struct __old_kernel_stat {
 
 struct stat {
 	unsigned long	st_dev;
-	ino_t		st_ino;
+	__kernel_ino_t	st_ino;
 #ifdef __powerpc64__
 	unsigned long	st_nlink;
-	mode_t		st_mode;
+	__kernel_mode_t	st_mode;
 #else
-	mode_t		st_mode;
+	__kernel_mode_t	st_mode;
 	unsigned short	st_nlink;
 #endif
-	uid_t		st_uid;
-	gid_t		st_gid;
+	__kernel_uid_t	st_uid;
+	__kernel_gid_t	st_gid;
 	unsigned long	st_rdev;
 	long		st_size;
 	unsigned long	st_blksize;
diff --git a/usr/include/Makefile b/usr/include/Makefile
index da280bdcb391..9d9dea32e3a0 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -66,7 +66,6 @@ no-header-test += linux/if_bonding.h
 endif
 
 ifeq ($(SRCARCH),powerpc)
-no-header-test += asm/stat.h
 no-header-test += linux/bpf_perf_event.h
 endif
 
-- 
2.32.0

