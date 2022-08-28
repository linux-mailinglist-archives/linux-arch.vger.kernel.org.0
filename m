Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B655A3B07
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiH1Cnw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiH1Cnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:43:39 -0400
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435F0101F3
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:43:24 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-01.nifty.com with ESMTP id 27S2eoMK015362
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:50 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gp030639;
        Sun, 28 Aug 2022 11:40:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gp030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654410;
        bh=eGfR+SEQRQYMntHzRLQYF+Hwh8rbACwjelshdo+fzFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02rQo8JopEgajO2tQ0CfaQYKeP+AOJ1x2LJhfrlPaUH2VP89Zn2bLl9/p74m2Zo7a
         sStaPDtSO/et6rxaxVF6p2LuLm4YTDUlnjw5lZIZR5Dw1pJpgE+pmSpYuOUBg7A6ty
         FeKHkj0SC/Zmx0sp28YQPQMFPpaeva0rzdT21T00I3ctEnpwmD40HpYe/ztcZk+Jwj
         /eP1xpRKm9cg3gi/hNhQUaluiK7Jrc8pmBN8+jBAVIsfuFSVl6P5Q39ANbz557FPI1
         en/boef0CrQwIsuC85HDHiDeNnjmO4lXQd7b12bWTmBGjz5MqEgtt80Igkdi2EF+2J
         y1/J/OP06sDxA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 07/15] scripts/mkcompile_h: move LC_ALL=C to '$LD -v'
Date:   Sun, 28 Aug 2022 11:39:55 +0900
Message-Id: <20220828024003.28873-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
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

Minimize the scope of LC_ALL=C like before commit 87c94bfb8ad3 ("kbuild:
override build timestamp & version").

Give LC_ALL=C to '$LD -v' to get the consistent version output, as commit
bcbcf50f5218 ("kbuild: fix ld-version.sh to not be affected by locale")
mentioned the LD version is affected by locale.

While I was here, I merged two sed invocations.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mkcompile_h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index f1a820d49e53..b76ccbbc094b 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -8,10 +8,6 @@ LD=$3
 # Do not expand names
 set -f
 
-# Fix the language to get consistent output
-LC_ALL=C
-export LC_ALL
-
 if test -z "$KBUILD_BUILD_USER"; then
 	LINUX_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
 else
@@ -23,8 +19,8 @@ else
 	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
 fi
 
-LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
-	      | sed 's/[[:space:]]*$//')
+LD_VERSION=$(LC_ALL=C $LD -v | head -n1 |
+		sed -e 's/(compatible with [^)]*)//' -e 's/[[:space:]]*$//')
 
 cat <<EOF
 #define UTS_MACHINE		"${UTS_MACHINE}"
-- 
2.34.1

