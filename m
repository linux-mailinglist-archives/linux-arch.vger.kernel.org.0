Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE665E9CD4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiIZJD4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiIZJDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:03:52 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB815FEC;
        Mon, 26 Sep 2022 02:03:48 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28Q92Ynw010468;
        Mon, 26 Sep 2022 18:02:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28Q92Ynw010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182954;
        bh=vOokxY9/Q6O2CIQTX++Z+fzHzOEujKRRSlPjeQx37qg=;
        h=From:To:Cc:Subject:Date:From;
        b=wwLob6sUK239m5mQ0sWVhJHJAhy3WxF24el+zPJgSRgzaFMkJwiu58h8vq3dwwk2O
         R+iuxR2l9iIcxYGYHOEXjqp7mnLEQbbi5+Ug9E7mBzjowrfd35qT87vH28hbKwTl/P
         tKDIq0/yERc0zblCb7mzU5qf3a7SirrUovVAC926H2OylEF9Rq7Q2IQw84tdlwcSxp
         6SFtKkTMsWV3xh9ZzQMnrpPwcV//22NDOH+xCiaX34togfjr00Ftz6NzSmARg0YdC+
         BDBln12UViv4ctwivTvcnSO2kn/BlVTE3MHNDk4xqSXjKOQrSdBBFJUM7SCKG8k32O
         UHabeh425CJ5A==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/5] mksysmap: update comment about __crc_*
Date:   Mon, 26 Sep 2022 18:02:25 +0900
Message-Id: <20220926090229.643134-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit 7b4537199a4a ("kbuild: link symbol CRCs at final link,
removing CONFIG_MODULE_REL_CRCS"), __crc_* symbols never become
absolute.

Keep ignoring __crc_*, but update the comment.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mksysmap | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index ad8bbc52267d..bc5396e255d8 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -37,8 +37,8 @@
 
 # readprofile starts reading symbols when _stext is found, and
 # continue until it finds a symbol which is not either of 'T', 't',
-# 'W' or 'w'. __crc_ are 'A' and placed in the middle
-# so we just ignore them to let readprofile continue to work.
-# (At least sparc64 has __crc_ in the middle).
-
+# 'W' or 'w'.
+#
+# Ignored prefixes:
+#  __crc_               - modversions
 $NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( \.L\)\|\( L0\)' > $2
-- 
2.34.1

