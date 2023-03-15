Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE16BBEAD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 22:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjCOVP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjCOVPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 17:15:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60D8C818;
        Wed, 15 Mar 2023 14:15:52 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 0A23744A;
        Wed, 15 Mar 2023 21:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0A23744A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678914951; bh=cMmlmnb7gOKAQJ/wbgOlJHiItUUHcn+mpPRcSPMfXLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DATlSj+enLcc+hVE2qTcBvcMt1jh76dc6vxZr7CFDISPU5HtD9UmjqSzUuOreig8l
         CDICiIIz9mz03jwJCHYqDcIXtRv4uCzN6W1uYtRtmJDy6l7K3YzoHbfu7ogfyBBTSA
         8o8SSuJIfw4SrbRCn8a0dLBzswhShkZiDteHVn/LALLq50WoIYQjmLj/na9uxyoJJC
         a19zxhJ635nJnVCfbp/WMN0iWONr0ki4cwL9lOWB/ay3m9uQTPLX7cdDOszj2YgZrq
         J9cmpLHeWrBRvAUZVl4bpDZmCAyRbCRWEJsqckg88fVdbTylNSqV7NZXhPCqBYuHPK
         IIg4ngsT+flcw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/2] docs: create a top-level arch/ directory
Date:   Wed, 15 Mar 2023 15:15:22 -0600
Message-Id: <20230315211523.108836-2-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315211523.108836-1-corbet@lwn.net>
References: <20230315211523.108836-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As the first step in bringing some order to our architecture-specific
documentation, create a top-level arch/ directory and move arch.rst as its
index.rst file.

There is no change in the rendered docs at this point.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch.rst       | 28 ----------------------------
 Documentation/arch/index.rst | 28 ++++++++++++++++++++++++++++
 Documentation/index.rst      |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/arch.rst
 create mode 100644 Documentation/arch/index.rst

diff --git a/Documentation/arch.rst b/Documentation/arch.rst
deleted file mode 100644
index 41a66a8b38e4..000000000000
--- a/Documentation/arch.rst
+++ /dev/null
@@ -1,28 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-CPU Architectures
-=================
-
-These books provide programming details about architecture-specific
-implementation.
-
-.. toctree::
-   :maxdepth: 2
-
-   arc/index
-   arm/index
-   arm64/index
-   ia64/index
-   loongarch/index
-   m68k/index
-   mips/index
-   nios2/index
-   openrisc/index
-   parisc/index
-   powerpc/index
-   riscv/index
-   s390/index
-   sh/index
-   sparc/index
-   x86/index
-   xtensa/index
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
new file mode 100644
index 000000000000..5f494e001eb4
--- /dev/null
+++ b/Documentation/arch/index.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+CPU Architectures
+=================
+
+These books provide programming details about architecture-specific
+implementation.
+
+.. toctree::
+   :maxdepth: 2
+
+   ../arc/index
+   ../arm/index
+   ../arm64/index
+   ../ia64/index
+   ../loongarch/index
+   ../m68k/index
+   ../mips/index
+   ../nios2/index
+   ../openrisc/index
+   ../parisc/index
+   ../powerpc/index
+   ../riscv/index
+   ../s390/index
+   ../sh/index
+   ../sparc/index
+   ../x86/index
+   ../xtensa/index
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 76d1a3ec9be3..9dfdc826618c 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -99,7 +99,7 @@ Architecture-specific documentation
 .. toctree::
    :maxdepth: 2
 
-   arch
+   arch/index
 
 
 Other documentation
-- 
2.39.2

