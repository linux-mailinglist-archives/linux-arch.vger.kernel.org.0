Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF66D0F7F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjC3T43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjC3T40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 15:56:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9710A87;
        Thu, 30 Mar 2023 12:56:20 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E6D137F8;
        Thu, 30 Mar 2023 19:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E6D137F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680206180; bh=EtkcblHy6iVZKm3WEuaF/oTESZjrcPaB7ngZEgjiI0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTxNdjzJiCLemvV+za0zGb2MMa6bzZ6GBdP5BXseUsJxmWk0jXFSy4B084GcKiFOi
         fFXK16GAQ3Yh0nmZ/MgQKWRjA6gseXmh2dYEqoQMjUvI1peEz1diAyyWJU1qt0fCFs
         XGZDFRGaRnDXIAdoyK/I9z/o+pX0hbcbDLT5SXmRHI25ijhmOwhU4aGXNDVsGZuG05
         8QAthcUaHTRthlKwTGfrgpMwP9ukdGxL9mLToo6XBNsS9vMkAky+Y4yqNowLxGgpK3
         LjMX9bzVLfQH7OSMpzMrLXYAmqgZfJ5mdDtg6fscTcbiZaiTmx5Y1DdN3WmSXx+nXe
         cDdKtKDRUpNTA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH 3/4] docs: move parisc documentation under Documentation/arch/
Date:   Thu, 30 Mar 2023 13:56:03 -0600
Message-Id: <20230330195604.269346-4-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330195604.269346-1-corbet@lwn.net>
References: <20230330195604.269346-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Documentation/parisc into arch/ and fix all in-tree references.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                                    | 2 +-
 Documentation/{ => arch}/parisc/debugging.rst                   | 0
 Documentation/{ => arch}/parisc/features.rst                    | 0
 Documentation/{ => arch}/parisc/index.rst                       | 0
 Documentation/{ => arch}/parisc/registers.rst                   | 0
 Documentation/translations/zh_CN/arch/index.rst                 | 2 +-
 .../translations/zh_CN/{ => arch}/parisc/debugging.rst          | 2 +-
 Documentation/translations/zh_CN/{ => arch}/parisc/index.rst    | 2 +-
 .../translations/zh_CN/{ => arch}/parisc/registers.rst          | 2 +-
 MAINTAINERS                                                     | 2 +-
 10 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/{ => arch}/parisc/debugging.rst (100%)
 rename Documentation/{ => arch}/parisc/features.rst (100%)
 rename Documentation/{ => arch}/parisc/index.rst (100%)
 rename Documentation/{ => arch}/parisc/registers.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/debugging.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/index.rst (88%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/registers.rst (99%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 77e287c3eeb9..6839cd46850d 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -18,7 +18,7 @@ implementation.
    ../mips/index
    nios2/index
    openrisc/index
-   ../parisc/index
+   parisc/index
    ../powerpc/index
    ../riscv/index
    ../s390/index
diff --git a/Documentation/parisc/debugging.rst b/Documentation/arch/parisc/debugging.rst
similarity index 100%
rename from Documentation/parisc/debugging.rst
rename to Documentation/arch/parisc/debugging.rst
diff --git a/Documentation/parisc/features.rst b/Documentation/arch/parisc/features.rst
similarity index 100%
rename from Documentation/parisc/features.rst
rename to Documentation/arch/parisc/features.rst
diff --git a/Documentation/parisc/index.rst b/Documentation/arch/parisc/index.rst
similarity index 100%
rename from Documentation/parisc/index.rst
rename to Documentation/arch/parisc/index.rst
diff --git a/Documentation/parisc/registers.rst b/Documentation/arch/parisc/registers.rst
similarity index 100%
rename from Documentation/parisc/registers.rst
rename to Documentation/arch/parisc/registers.rst
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index 7e59af567331..908ea131bb1c 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -12,7 +12,7 @@
    ../arm64/index
    ../riscv/index
    openrisc/index
-   ../parisc/index
+   parisc/index
    ../loongarch/index
 
 TODOList:
diff --git a/Documentation/translations/zh_CN/parisc/debugging.rst b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
similarity index 97%
rename from Documentation/translations/zh_CN/parisc/debugging.rst
rename to Documentation/translations/zh_CN/arch/parisc/debugging.rst
index 68b73eb57105..9bd197eb0d41 100644
--- a/Documentation/translations/zh_CN/parisc/debugging.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/parisc/debugging.rst
+:Original: Documentation/arch/parisc/debugging.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/parisc/index.rst b/Documentation/translations/zh_CN/arch/parisc/index.rst
similarity index 88%
rename from Documentation/translations/zh_CN/parisc/index.rst
rename to Documentation/translations/zh_CN/arch/parisc/index.rst
index 0cc553fc8272..848742539550 100644
--- a/Documentation/translations/zh_CN/parisc/index.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/parisc/index.rst
+:Original: Documentation/arch/parisc/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/parisc/registers.rst b/Documentation/translations/zh_CN/arch/parisc/registers.rst
similarity index 99%
rename from Documentation/translations/zh_CN/parisc/registers.rst
rename to Documentation/translations/zh_CN/arch/parisc/registers.rst
index d2ab1874a602..caf5f258248b 100644
--- a/Documentation/translations/zh_CN/parisc/registers.rst
+++ b/Documentation/translations/zh_CN/arch/parisc/registers.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/parisc/registers.rst
+:Original: Documentation/arch/parisc/registers.rst
 
 :翻译:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c515abc269f2..02720bc91481 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15834,7 +15834,7 @@ W:	https://parisc.wiki.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-parisc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jejb/parisc-2.6.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
-F:	Documentation/parisc/
+F:	Documentation/arch/parisc/
 F:	arch/parisc/
 F:	drivers/char/agp/parisc-agp.c
 F:	drivers/input/misc/hp_sdc_rtc.c
-- 
2.39.2

