Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929516D0F82
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjC3T4b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjC3T41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 15:56:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B510408;
        Thu, 30 Mar 2023 12:56:21 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 9BBE9993;
        Thu, 30 Mar 2023 19:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9BBE9993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680206181; bh=8qKYwim6qzzDNM1Ego9KfkuJofkSbeI1sjSlRBWM9CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/kUoGqpKoyEYCz29zAodrRGvGKcUY0/n1kHOY/cYQSf4oq+nIbrrq1X+DuevahzK
         pZNMNQoScjO8tGcJloG2cL8Qwl9kiz2yeUMpyeQSEHP1deDhbYF465tzRpJk5ukmVA
         iVtd4Ets7v/e1fvDvPP28EIqaDjak5fJf3sxf5uOuH9Av+DyZZA2T0IMKA68kB0QYD
         UwVbhISHml+w3NUeXFmd9UY2ipbzWDOYl3sU0kRxKEw8Q1dP1qydrfZYwdtceH8101
         V2Zv+4YHVOsEx+54d6CJ8Xe8WsanOXp3NfKL53A8q5Axd7vxH8kYX7yqD6aklz1gqy
         wfdU8TRiHlvgw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/4] docs: move m68k architecture documentation under Documentation/arch/
Date:   Thu, 30 Mar 2023 13:56:04 -0600
Message-Id: <20230330195604.269346-5-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330195604.269346-1-corbet@lwn.net>
References: <20230330195604.269346-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.  Move
Documentation/m68k into arch/ and fix all in-tree references.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/kernel-parameters.rst            | 2 +-
 Documentation/arch/index.rst                               | 2 +-
 Documentation/{ => arch}/m68k/buddha-driver.rst            | 0
 Documentation/{ => arch}/m68k/features.rst                 | 0
 Documentation/{ => arch}/m68k/index.rst                    | 0
 Documentation/{ => arch}/m68k/kernel-options.rst           | 0
 Documentation/translations/zh_CN/arch/parisc/debugging.rst | 2 +-
 Documentation/translations/zh_CN/arch/parisc/index.rst     | 2 +-
 Documentation/translations/zh_CN/arch/parisc/registers.rst | 2 +-
 arch/m68k/Kconfig.machine                                  | 4 ++--
 10 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/{ => arch}/m68k/buddha-driver.rst (100%)
 rename Documentation/{ => arch}/m68k/features.rst (100%)
 rename Documentation/{ => arch}/m68k/index.rst (100%)
 rename Documentation/{ => arch}/m68k/kernel-options.rst (100%)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index c833eac3fe59..6385e3b9b879 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -131,7 +131,7 @@ parameter is applicable::
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
 			These options have more detailed description inside of
-			Documentation/m68k/kernel-options.rst.
+			Documentation/arch/m68k/kernel-options.rst.
 	MDA	MDA console support is enabled.
 	MIPS	MIPS architecture is enabled.
 	MOUSE	Appropriate mouse support is enabled.
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 6839cd46850d..80ee31016584 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -14,7 +14,7 @@ implementation.
    ../arm64/index
    ia64/index
    ../loongarch/index
-   ../m68k/index
+   m68k/index
    ../mips/index
    nios2/index
    openrisc/index
diff --git a/Documentation/m68k/buddha-driver.rst b/Documentation/arch/m68k/buddha-driver.rst
similarity index 100%
rename from Documentation/m68k/buddha-driver.rst
rename to Documentation/arch/m68k/buddha-driver.rst
diff --git a/Documentation/m68k/features.rst b/Documentation/arch/m68k/features.rst
similarity index 100%
rename from Documentation/m68k/features.rst
rename to Documentation/arch/m68k/features.rst
diff --git a/Documentation/m68k/index.rst b/Documentation/arch/m68k/index.rst
similarity index 100%
rename from Documentation/m68k/index.rst
rename to Documentation/arch/m68k/index.rst
diff --git a/Documentation/m68k/kernel-options.rst b/Documentation/arch/m68k/kernel-options.rst
similarity index 100%
rename from Documentation/m68k/kernel-options.rst
rename to Documentation/arch/m68k/kernel-options.rst
diff --git a/Documentation/translations/zh_CN/arch/parisc/debugging.rst b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
index 9bd197eb0d41..c6b9de6d3175 100644
--- a/Documentation/translations/zh_CN/arch/parisc/debugging.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
@@ -1,4 +1,4 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
 :Original: Documentation/arch/parisc/debugging.rst
 
diff --git a/Documentation/translations/zh_CN/arch/parisc/index.rst b/Documentation/translations/zh_CN/arch/parisc/index.rst
index 848742539550..9f69283bd1c9 100644
--- a/Documentation/translations/zh_CN/arch/parisc/index.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/index.rst
@@ -1,5 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
 :Original: Documentation/arch/parisc/index.rst
 
diff --git a/Documentation/translations/zh_CN/arch/parisc/registers.rst b/Documentation/translations/zh_CN/arch/parisc/registers.rst
index caf5f258248b..a55250afcc27 100644
--- a/Documentation/translations/zh_CN/arch/parisc/registers.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/registers.rst
@@ -1,4 +1,4 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
 :Original: Documentation/arch/parisc/registers.rst
 
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index e2f961208f18..28eebabfd34b 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -11,7 +11,7 @@ config AMIGA
 	help
 	  This option enables support for the Amiga series of computers. If
 	  you plan to use this kernel on an Amiga, say Y here and browse the
-	  material available in <file:Documentation/m68k>; otherwise say N.
+	  material available in <file:Documentation/arch/m68k>; otherwise say N.
 
 config ATARI
 	bool "Atari support"
@@ -23,7 +23,7 @@ config ATARI
 	  This option enables support for the 68000-based Atari series of
 	  computers (including the TT, Falcon and Medusa). If you plan to use
 	  this kernel on an Atari, say Y here and browse the material
-	  available in <file:Documentation/m68k>; otherwise say N.
+	  available in <file:Documentation/arch/m68k>; otherwise say N.
 
 config ATARI_KBD_CORE
 	bool
-- 
2.39.2

