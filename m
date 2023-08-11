Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0E779148
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjHKODp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHKODn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3D2D7B;
        Fri, 11 Aug 2023 07:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B7867363;
        Fri, 11 Aug 2023 14:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3921C433CD;
        Fri, 11 Aug 2023 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762620;
        bh=j+eOKQYti+AN7EczMgi60CP1M65iTD27prSKu2KILxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFca2cxkebiISpHQkQRzdb+UxNgasyUOKqgT46/xbyJZzh7SCIMOREecRSuDzEgQn
         oK/QDQO001KiF/9foe5meWYNB76P2p+myTvmQSCrRE1V2o6sNtPXtKjL2Nb5mfnRyc
         Z+vWOFS5v1sF6Cm4/XUQIgP+0g1S1aDY20cugUMRHn6zEVVuVn1taFPKInbnIWSdZF
         YRXa21egHU56n9g+2v20hCIJaKFsuRtRfqK3cy2bBEhNam3qIGIKDV/HIUR+l/EsmN
         SX88i0U+rLbmPLUK7nruN0EuGcx2Q3Bj5uY4tNDJZakmjWK/hflnfJOCoQ58CrmKtA
         +SLkrv//TPGoQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/9] Kbuild: only pass -fno-inline-functions-called-once for gcc
Date:   Fri, 11 Aug 2023 16:03:19 +0200
Message-Id: <20230811140327.3754597-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811140327.3754597-1-arnd@kernel.org>
References: <20230811140327.3754597-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang ignores the -fno-inline-functions-called-once option, but warns
when building with -Wignored-optimization-argument enabled:

clang: error: optimization flag '-fno-inline-functions-called-once' is not supported [-Werror,-Wignored-optimization-argument]

Move it back to using cc-option for this one.

Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bf5a6100cf66e..991c02f8e9ac0 100644
--- a/Makefile
+++ b/Makefile
@@ -967,7 +967,7 @@ endif
 
 # We trigger additional mismatches with less inlining
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
-KBUILD_CFLAGS += -fno-inline-functions-called-once
+KBUILD_CFLAGS += $(call cc-option,-fno-inline-functions-called-once)
 endif
 
 # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
-- 
2.39.2

