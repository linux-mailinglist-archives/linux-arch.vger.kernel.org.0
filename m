Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5874F0F3E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377454AbiDDGWi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbiDDGWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:33 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D423700C;
        Sun,  3 Apr 2022 23:20:29 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bn008244;
        Mon, 4 Apr 2022 15:20:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bn008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053204;
        bh=v8waAouIUGkxU/aNRA3BQI4iA3QkcGu9o6MGxOfVIVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAnV+HljdwWp89suOUT2tJIaStBnzQ2aDP/UptXIaBWZaTBmkkDIoxiSxtNfMFkvN
         xNcj77UAFLdBVdNtBtZV4ezLjIG4unzTbCG+tqECIRSJbOVVsC+ya/0PIit2ZG7XYI
         05S2ZBh5VtZD7wQKfdYC6uSxGIR3aFjr97NK4LK2xi3DHbByFDHJKFS9Yhu9cNd1ui
         xLA1dyeucfLD4nCbOdcG7CAuDNnJcftP+Ad4bt8EtpBnQsofZfucSoYForxIDcZ6bO
         cW+zukNVcBHbyWtqkj8/VTdFbgfwMln9RJIjRbU4YbXFUslB66ckN2YpLn6nydCxwL
         SkAUhtR6HmcOQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/8] mips: add asm/stat.h to UAPI compile-test coverage
Date:   Mon,  4 Apr 2022 15:19:44 +0900
Message-Id: <20220404061948.2111820-5-masahiroy@kernel.org>
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
ARCH=mips because of the errors like follows:

    HDRTEST usr/include/asm/stat.h
  In file included from <command-line>:32:
  ./usr/include/asm/stat.h:22:2: error: unknown type name 'ino_t'
     22 |  ino_t  st_ino;
        |  ^~~~~
  ./usr/include/asm/stat.h:23:2: error: unknown type name 'mode_t'
     23 |  mode_t  st_mode;
        |  ^~~~~~
  ./usr/include/asm/stat.h:25:2: error: unknown type name 'uid_t'
     25 |  uid_t  st_uid;
        |  ^~~~~
  ./usr/include/asm/stat.h:26:2: error: unknown type name 'gid_t'
     26 |  gid_t  st_gid;
        |  ^~~~~
  ./usr/include/asm/stat.h:58:2: error: unknown type name 'mode_t'
     58 |  mode_t  st_mode;
        |  ^~~~~~
  ./usr/include/asm/stat.h:61:2: error: unknown type name 'uid_t'
     61 |  uid_t  st_uid;
        |  ^~~~~
  ./usr/include/asm/stat.h:62:2: error: unknown type name 'gid_t'
     62 |  gid_t  st_gid;
        |  ^~~~~

The errors can be fixed by prefixing the types with __kernel_.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/include/uapi/asm/stat.h | 20 ++++++++++----------
 usr/include/Makefile              |  4 ----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/uapi/asm/stat.h b/arch/mips/include/uapi/asm/stat.h
index 3d2a3b71845c..8a8bb78883a4 100644
--- a/arch/mips/include/uapi/asm/stat.h
+++ b/arch/mips/include/uapi/asm/stat.h
@@ -19,11 +19,11 @@
 struct stat {
 	unsigned	st_dev;
 	long		st_pad1[3];		/* Reserved for network id */
-	ino_t		st_ino;
-	mode_t		st_mode;
+	__kernel_ino_t	st_ino;
+	__kernel_mode_t	st_mode;
 	__u32		st_nlink;
-	uid_t		st_uid;
-	gid_t		st_gid;
+	__kernel_uid_t	st_uid;
+	__kernel_gid_t	st_gid;
 	unsigned	st_rdev;
 	long		st_pad2[2];
 	long		st_size;
@@ -55,11 +55,11 @@ struct stat64 {
 
 	unsigned long long	st_ino;
 
-	mode_t		st_mode;
+	__kernel_mode_t	st_mode;
 	__u32		st_nlink;
 
-	uid_t		st_uid;
-	gid_t		st_gid;
+	__kernel_uid_t	st_uid;
+	__kernel_gid_t	st_gid;
 
 	unsigned long	st_rdev;
 	unsigned long	st_pad1[3];	/* Reserved for st_rdev expansion  */
@@ -96,11 +96,11 @@ struct stat {
 
 	unsigned long		st_ino;
 
-	mode_t			st_mode;
+	__kernel_mode_t		st_mode;
 	__u32			st_nlink;
 
-	uid_t			st_uid;
-	gid_t			st_gid;
+	__kernel_uid_t		st_uid;
+	__kernel_gid_t		st_gid;
 
 	unsigned int		st_rdev;
 	unsigned int		st_pad1[3]; /* Reserved for st_rdev expansion */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index a1a8403896cf..da280bdcb391 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -65,10 +65,6 @@ no-header-test += asm/sigcontext.h
 no-header-test += linux/if_bonding.h
 endif
 
-ifeq ($(SRCARCH),mips)
-no-header-test += asm/stat.h
-endif
-
 ifeq ($(SRCARCH),powerpc)
 no-header-test += asm/stat.h
 no-header-test += linux/bpf_perf_event.h
-- 
2.32.0

