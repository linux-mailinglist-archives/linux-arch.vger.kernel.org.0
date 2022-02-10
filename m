Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846784B032C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiBJCQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:16:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBJCQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:16:00 -0500
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA9263D;
        Wed,  9 Feb 2022 18:16:01 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-02.nifty.com with ESMTP id 21A2CEfC020362;
        Thu, 10 Feb 2022 11:12:14 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVH1030193;
        Thu, 10 Feb 2022 11:11:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVH1030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459094;
        bh=EBMkOKAnMrvy5dowfLOIUWafGuf2A3oU3Qa+cTxHO/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1BY2Gf+SymejXVDtpcey2bI14xjnXX4aL9iVbP1R0ZP3WJB5Q3/XI6yedmJ55DrA
         ts2kwjfP9/8KwLWDbmhOF4Ab/iStomKwW5T4F5cg6+7YYgj9m50RArbDztuayQcoXw
         khhJHdVzjlpwvYP7sGL/c4Ofm1dKn/aMGsIH/WSJ3d1uEtgiDNQpy92ZaKaxw9RMPq
         DzKotF3ZvEHc/qdq67fKtICBtE3ayS8WNaAnnOmzHFGi0twtU/7vQHtJuC18QxI2L2
         iXxGCUivyutb1KWu30Y1VX+bhwTLMf1vaDVMWHYh2uAxEeevhkzl+pFyVU7tgWr7u+
         FWf66P+5ZS14A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/6] fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:27 +0900
Message-Id: <20220210021129.3386083-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210021129.3386083-1-masahiroy@kernel.org>
References: <20220210021129.3386083-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

linux/fsmap.h is currently excluded from the UAPI compile-test because
of the error like follows:

    HDRTEST usr/include/linux/fsmap.h
  In file included from <command-line>:
  ./usr/include/linux/fsmap.h:72:19: error: unknown type name ‘size_t’
     72 | static __inline__ size_t
        |                   ^~~~~~

The error can be fixed by replacing size_t with __kernel_size_t.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/fsmap.h | 2 +-
 usr/include/Makefile       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/fsmap.h b/include/uapi/linux/fsmap.h
index 91fd519a3f7d..c690d17f1d07 100644
--- a/include/uapi/linux/fsmap.h
+++ b/include/uapi/linux/fsmap.h
@@ -69,7 +69,7 @@ struct fsmap_head {
 };
 
 /* Size of an fsmap_head with room for nr records. */
-static inline size_t
+static inline __kernel_size_t
 fsmap_sizeof(
 	unsigned int	nr)
 {
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 717c7d4c89bb..9e35d022fd88 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -29,7 +29,6 @@ no-header-test += linux/am437x-vpfe.h
 no-header-test += linux/coda.h
 no-header-test += linux/cyclades.h
 no-header-test += linux/errqueue.h
-no-header-test += linux/fsmap.h
 no-header-test += linux/hdlc/ioctl.h
 no-header-test += linux/ivtv.h
 no-header-test += linux/kexec.h
-- 
2.32.0

