Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB135FCA7E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJLSUu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJLSUd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 14:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E10B87E;
        Wed, 12 Oct 2022 11:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA9CB81B9D;
        Wed, 12 Oct 2022 18:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA2CC433D6;
        Wed, 12 Oct 2022 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665598768;
        bh=rToApNuA9+wNI2zgDEyjUglKN9v6Lh64lTtKi6m3TBE=;
        h=From:To:Cc:Subject:Date:From;
        b=m5lve6/xhs0u5xfmUGO8yjhbagSproghDuqCmE6x4APlXjShXuGUjC4D3YV0L0Xpy
         YP3Ygi958GeULJj/IB9g8XywkM4E85+aCDHOr9R12JlI6r7SKdnL5CYQBKtTMVaOZ6
         6VrBaw313J7VlbYOHO8U8Alr7AKOFJ5d6v6YpbVuvnqFPcYu2jt8oUX2DZTU2gCo+Y
         /JNHuQwWPKMbU0IcADcoFClgcakPTKgN0bp98BJ3uQ3bNGKZMfyIn3m2RbHHO+MDiy
         ycmw7euW9RLg59UDKovqZl/YncFRbnyQG7lifNICYIwSCEDMeBNnvOVCbALKCR0JCG
         KTKfRJbcchVjQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: raise minimum supported version of binutils to 2.25
Date:   Thu, 13 Oct 2022 03:18:41 +0900
Message-Id: <20221012181841.333325-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Binutils 2.23 was released in 2012. Almost 10 years old.

We already require GCC 5.1, released in 2015.

Bump the binutils version to 2.25, which was released one year before
GCC 5.1.

With this applied, some subsystems can start to clean up code.
Examples:
  arch/arm/Kconfig.assembler
  arch/mips/vdso/Kconfig
  arch/powerpc/Makefile
  arch/x86/Kconfig.assembler

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/process/changes.rst | 4 ++--
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 9844ca3a71a6..ef540865ad22 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -35,7 +35,7 @@ Rust (optional)        1.62.0           rustc --version
 bindgen (optional)     0.56.0           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
-binutils               2.23             ld -v
+binutils               2.25             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 pahole                 1.16             pahole --version
@@ -119,7 +119,7 @@ Bash 4.2 or newer is needed.
 Binutils
 --------
 
-Binutils 2.23 or newer is needed to build the kernel.
+Binutils 2.25 or newer is needed to build the kernel.
 
 pkg-config
 ----------
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 8766e248ffbb..4e5b45d9b526 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -14,7 +14,7 @@ fi
 
 case "$1" in
 binutils)
-	echo 2.23.0
+	echo 2.25.0
 	;;
 gcc)
 	echo 5.1.0
-- 
2.34.1

