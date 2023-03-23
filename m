Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677236C72F7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCWWUI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjCWWUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C72386A;
        Thu, 23 Mar 2023 15:20:04 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 01630740;
        Thu, 23 Mar 2023 22:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 01630740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610004; bh=eXvOcnCVWEcAAlbhOrBfaAqzmDDbnhKNFXWeX9mfadU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QucedCzXvmmEH1mUyowYrc/jeJ3leta3yYs4n/eaCSnTOl8lcr0+HYHhsKWFvHttW
         nZEcPcwcp+BYucGn9dH4qAGHuky6JyNF1tS+GvYK60oVWWE6kIpTiIITl7D+a1YN6s
         NzeoDvlWPEPWhOTBg2N92II72Bh/H+WKTzMvNeEZEcZ1QRi1NxDJ67hTHOn08+1U89
         DGcSkcmD/ppzTjbTgkqBg7Tpf01vM1RniqEZDPW764syr3WInPwHzIZri+IHteMQGc
         FQxBAYz122JAA9rLKR57F7lO0dF3dxmnRN/Ju+Cz2QvauIJ0EY+ha0c4Wdza93Eh2h
         NAJnleMqQ+Gtw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3/6] docs: move sparc documentation under Documentation/arch/
Date:   Thu, 23 Mar 2023 16:19:45 -0600
Message-Id: <20230323221948.352154-4-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323221948.352154-1-corbet@lwn.net>
References: <20230323221948.352154-1-corbet@lwn.net>
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
Documentation/sparc into arch/ and fix all in-tree references.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                         | 2 +-
 Documentation/{ => arch}/sparc/adi.rst               | 0
 Documentation/{ => arch}/sparc/console.rst           | 0
 Documentation/{ => arch}/sparc/features.rst          | 0
 Documentation/{ => arch}/sparc/index.rst             | 0
 Documentation/{ => arch}/sparc/oradax/dax-hv-api.txt | 0
 Documentation/{ => arch}/sparc/oradax/oracle-dax.rst | 0
 drivers/sbus/char/oradax.c                           | 2 +-
 8 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{ => arch}/sparc/adi.rst (100%)
 rename Documentation/{ => arch}/sparc/console.rst (100%)
 rename Documentation/{ => arch}/sparc/features.rst (100%)
 rename Documentation/{ => arch}/sparc/index.rst (100%)
 rename Documentation/{ => arch}/sparc/oradax/dax-hv-api.txt (100%)
 rename Documentation/{ => arch}/sparc/oradax/oracle-dax.rst (100%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 208a8e67599c..8ec614488bd2 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -23,6 +23,6 @@ implementation.
    ../riscv/index
    ../s390/index
    ../sh/index
-   ../sparc/index
+   sparc/index
    x86/index
    xtensa/index
diff --git a/Documentation/sparc/adi.rst b/Documentation/arch/sparc/adi.rst
similarity index 100%
rename from Documentation/sparc/adi.rst
rename to Documentation/arch/sparc/adi.rst
diff --git a/Documentation/sparc/console.rst b/Documentation/arch/sparc/console.rst
similarity index 100%
rename from Documentation/sparc/console.rst
rename to Documentation/arch/sparc/console.rst
diff --git a/Documentation/sparc/features.rst b/Documentation/arch/sparc/features.rst
similarity index 100%
rename from Documentation/sparc/features.rst
rename to Documentation/arch/sparc/features.rst
diff --git a/Documentation/sparc/index.rst b/Documentation/arch/sparc/index.rst
similarity index 100%
rename from Documentation/sparc/index.rst
rename to Documentation/arch/sparc/index.rst
diff --git a/Documentation/sparc/oradax/dax-hv-api.txt b/Documentation/arch/sparc/oradax/dax-hv-api.txt
similarity index 100%
rename from Documentation/sparc/oradax/dax-hv-api.txt
rename to Documentation/arch/sparc/oradax/dax-hv-api.txt
diff --git a/Documentation/sparc/oradax/oracle-dax.rst b/Documentation/arch/sparc/oradax/oracle-dax.rst
similarity index 100%
rename from Documentation/sparc/oradax/oracle-dax.rst
rename to Documentation/arch/sparc/oradax/oracle-dax.rst
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index e300cf26bc2a..d698ca506cca 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -18,7 +18,7 @@
  * the recommended way for applications to use the coprocessor, and
  * the driver interface is not intended for general use.
  *
- * See Documentation/sparc/oradax/oracle-dax.rst for more details.
+ * See Documentation/arch/sparc/oradax/oracle-dax.rst for more details.
  */
 
 #include <linux/uaccess.h>
-- 
2.39.2

