Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9B4F0F31
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377451AbiDDGWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357155AbiDDGWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:33 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57F377E9;
        Sun,  3 Apr 2022 23:20:31 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bp008244;
        Mon, 4 Apr 2022 15:20:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bp008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053205;
        bh=AibnhiOX0rfEwfkAILcnM2PzOi/J+jq6D5Fuzdi0fro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k63ucyOl0RQy5imVlGzYsp3c84dHD6pqsryc/kkjRRQ8rpVcHFVlXBxunwh7OmW2H
         gvocXzgPrK22FWM8YNjR/d/7AAiLVTfpBshPJwVT1NSLwAJAlI4OfL0HRW0GvBh849
         L6f48TVwA9qw1j5G+5HgFw3DIv8ED6wCImzJR8U21II0jybFA3oDzYbeSzK3898Up5
         3Mdka2nOtr+gsLl1TN8IFDONSFbefQ/n/bqdM7xa7cqHfPbQPfy+bEtTtjD/vhR9DG
         EBtz++annCjeukz036uvD87qdRauwZiodSVeRR9mrkfFNzCPV+MzPsfnGPElCfF3fQ
         lauOJy2FgdjlA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/8] sparc: add asm/stat.h to UAPI compile-test coverage
Date:   Mon,  4 Apr 2022 15:19:46 +0900
Message-Id: <20220404061948.2111820-7-masahiroy@kernel.org>
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
ARCH=sparc because of the errors like follows:

  In file included from <command-line>:
  ./usr/include/asm/stat.h:11:2: error: unknown type name 'ino_t'
     11 |  ino_t   st_ino;
        |  ^~~~~
    HDRTEST usr/include/asm/param.h
  ./usr/include/asm/stat.h:12:2: error: unknown type name 'mode_t'
     12 |  mode_t  st_mode;
        |  ^~~~~~
  ./usr/include/asm/stat.h:14:2: error: unknown type name 'uid_t'
     14 |  uid_t   st_uid;
        |  ^~~~~
  ./usr/include/asm/stat.h:15:2: error: unknown type name 'gid_t'
     15 |  gid_t   st_gid;
        |  ^~~~~

The errors can be fixed by prefixing the types with __kernel_.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/include/uapi/asm/stat.h | 12 ++++++------
 usr/include/Makefile               |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/stat.h b/arch/sparc/include/uapi/asm/stat.h
index 732c41720e24..e03d6f8ec301 100644
--- a/arch/sparc/include/uapi/asm/stat.h
+++ b/arch/sparc/include/uapi/asm/stat.h
@@ -8,11 +8,11 @@
 /* 64 bit sparc */
 struct stat {
 	unsigned int st_dev;
-	ino_t   st_ino;
-	mode_t  st_mode;
+	__kernel_ino_t st_ino;
+	__kernel_mode_t st_mode;
 	short   st_nlink;
-	uid_t   st_uid;
-	gid_t   st_gid;
+	__kernel_uid_t st_uid;
+	__kernel_gid_t st_gid;
 	unsigned int st_rdev;
 	long    st_size;
 	long    st_atime;
@@ -51,8 +51,8 @@ struct stat64 {
 /* 32 bit sparc */
 struct stat {
 	unsigned short	st_dev;
-	ino_t		st_ino;
-	mode_t		st_mode;
+	__kernel_ino_t	st_ino;
+	__kernel_mode_t	st_mode;
 	short		st_nlink;
 	unsigned short	st_uid;
 	unsigned short	st_gid;
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 9d9dea32e3a0..e2615b9b0402 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -70,7 +70,6 @@ no-header-test += linux/bpf_perf_event.h
 endif
 
 ifeq ($(SRCARCH),sparc)
-no-header-test += asm/stat.h
 no-header-test += asm/uctx.h
 no-header-test += asm/fbio.h
 endif
-- 
2.32.0

