Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521B6C72FC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCWWUL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCWWUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDD23C4A;
        Thu, 23 Mar 2023 15:20:05 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 284C560A;
        Thu, 23 Mar 2023 22:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 284C560A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610005; bh=+0XuBNmYI/uTGGbCJlwRybw3b+1jSLhxWtJILEeD8QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6OULu4dZ1Avon0MHKeaDVtsj6srwkc+uDbGvLC9Kj+irkhwQ4wJvpGxgBdUeStXW
         wwMpG3e+y+hHgAFzLK1uv0o1PDrk+cVWXw2x9acFUfbDrMeVv/1xASq6zUlse82tmL
         LFCBrSLG2489DbJ1wGi3RraDtLds8d/wnr5CcTpLBRbHzPX1LOTOh4lVK5MKP5jVgy
         07ZIe7efj0sKPs4807SPcQPho7pHExxecYNjPMjlGuKQwrHx3wFdjnJUI+RWObUjg9
         lGa2JeAQTHLxZMMUNLOyjUcJC+P8snU+eNKoSPSWMGmKdnK4NGlaH1qd0wr1xbEWeb
         casqSalBXY1KA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH 5/6] docs: move openrisc documentation under Documentation/arch/
Date:   Thu, 23 Mar 2023 16:19:47 -0600
Message-Id: <20230323221948.352154-6-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323221948.352154-1-corbet@lwn.net>
References: <20230323221948.352154-1-corbet@lwn.net>
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
Documentation/openrisc into arch/ and fix all in-tree references.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                                  | 2 +-
 Documentation/{ => arch}/openrisc/features.rst                | 0
 Documentation/{ => arch}/openrisc/index.rst                   | 0
 Documentation/{ => arch}/openrisc/openrisc_port.rst           | 0
 Documentation/{ => arch}/openrisc/todo.rst                    | 0
 Documentation/translations/zh_CN/arch/index.rst               | 2 +-
 .../translations/zh_CN/{ => arch}/openrisc/index.rst          | 4 ++--
 .../translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst  | 4 ++--
 Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst | 4 ++--
 MAINTAINERS                                                   | 2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename Documentation/{ => arch}/openrisc/features.rst (100%)
 rename Documentation/{ => arch}/openrisc/index.rst (100%)
 rename Documentation/{ => arch}/openrisc/openrisc_port.rst (100%)
 rename Documentation/{ => arch}/openrisc/todo.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst (88%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 792f58e30f25..65945daa40fe 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -17,7 +17,7 @@ implementation.
    ../m68k/index
    ../mips/index
    ../nios2/index
-   ../openrisc/index
+   openrisc/index
    ../parisc/index
    ../powerpc/index
    ../riscv/index
diff --git a/Documentation/openrisc/features.rst b/Documentation/arch/openrisc/features.rst
similarity index 100%
rename from Documentation/openrisc/features.rst
rename to Documentation/arch/openrisc/features.rst
diff --git a/Documentation/openrisc/index.rst b/Documentation/arch/openrisc/index.rst
similarity index 100%
rename from Documentation/openrisc/index.rst
rename to Documentation/arch/openrisc/index.rst
diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
similarity index 100%
rename from Documentation/openrisc/openrisc_port.rst
rename to Documentation/arch/openrisc/openrisc_port.rst
diff --git a/Documentation/openrisc/todo.rst b/Documentation/arch/openrisc/todo.rst
similarity index 100%
rename from Documentation/openrisc/todo.rst
rename to Documentation/arch/openrisc/todo.rst
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index aa53dcff268e..7e59af567331 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -11,7 +11,7 @@
    ../mips/index
    ../arm64/index
    ../riscv/index
-   ../openrisc/index
+   openrisc/index
    ../parisc/index
    ../loongarch/index
 
diff --git a/Documentation/translations/zh_CN/openrisc/index.rst b/Documentation/translations/zh_CN/arch/openrisc/index.rst
similarity index 79%
rename from Documentation/translations/zh_CN/openrisc/index.rst
rename to Documentation/translations/zh_CN/arch/openrisc/index.rst
index 9ad6cc600884..da21f8ab894b 100644
--- a/Documentation/translations/zh_CN/openrisc/index.rst
+++ b/Documentation/translations/zh_CN/arch/openrisc/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/openrisc/index.rst
+:Original: Documentation/arch/openrisc/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
similarity index 97%
rename from Documentation/translations/zh_CN/openrisc/openrisc_port.rst
rename to Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
index b8a67670492d..cadc580fa23b 100644
--- a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst
+++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/openrisc/openrisc_port.rst
+:Original: Documentation/arch/openrisc/openrisc_port.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/openrisc/todo.rst b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
similarity index 88%
rename from Documentation/translations/zh_CN/openrisc/todo.rst
rename to Documentation/translations/zh_CN/arch/openrisc/todo.rst
index 63c38717edb1..1f6f95616633 100644
--- a/Documentation/translations/zh_CN/openrisc/todo.rst
+++ b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/openrisc/todo.rst
+:Original: Documentation/arch/openrisc/todo.rst
 
 :翻译:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index cf4eb913ea12..64ea94536f4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15638,7 +15638,7 @@ S:	Maintained
 W:	http://openrisc.io
 T:	git https://github.com/openrisc/linux.git
 F:	Documentation/devicetree/bindings/openrisc/
-F:	Documentation/openrisc/
+F:	Documentation/arch/openrisc/
 F:	arch/openrisc/
 F:	drivers/irqchip/irq-ompic.c
 F:	drivers/irqchip/irq-or1k-*
-- 
2.39.2

