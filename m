Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA606C72F3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCWWUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCWWUG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BD323A62;
        Thu, 23 Mar 2023 15:20:05 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 801017F9;
        Thu, 23 Mar 2023 22:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 801017F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610004; bh=GMFWdWYJCGmh8Kpc1j6SBPSjQaQPXeqtXldToZ39nMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfIrtwRnNh9NKjhq/v5mxWPI8KWmQkgtHQiTVQNrHULu3mMcJqsRQ3xHSUQYNCmBs
         /zf0zDPFkWvFIqY+ys1xzkC/otB1aJopNRl3+6hA2PUE7PiAxrY9m92McBFWDQ4eT0
         bbAnPLkCFW6+I3KQ0wHDzLyM686c3UKS1wiW6Qk5vQKhDecB7iOIb2/O+8AtgWGkdI
         w3qLO+U7uzDkbWXn6OQsSzuk/MdrvufhZyUAExKi4W8mSPRPulncCJbPAndtnsJxKd
         7353yEDuh5TCCqJ95Tyt0cdh8r7c7Vl8OJMRxWGfey5UsSx4zZPv9T256jXEn8EqFr
         laNjamGZ6raRw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 4/6] docs: move superh documentation under Documentation/arch/
Date:   Thu, 23 Mar 2023 16:19:46 -0600
Message-Id: <20230323221948.352154-5-corbet@lwn.net>
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
Documentation/sh into arch/ and fix all in-tree references.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                   | 2 +-
 Documentation/{ => arch}/sh/booting.rst        | 0
 Documentation/{ => arch}/sh/features.rst       | 0
 Documentation/{ => arch}/sh/index.rst          | 0
 Documentation/{ => arch}/sh/new-machine.rst    | 0
 Documentation/{ => arch}/sh/register-banks.rst | 0
 MAINTAINERS                                    | 2 +-
 arch/sh/Kconfig.cpu                            | 2 +-
 8 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{ => arch}/sh/booting.rst (100%)
 rename Documentation/{ => arch}/sh/features.rst (100%)
 rename Documentation/{ => arch}/sh/index.rst (100%)
 rename Documentation/{ => arch}/sh/new-machine.rst (100%)
 rename Documentation/{ => arch}/sh/register-banks.rst (100%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 8ec614488bd2..792f58e30f25 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -22,7 +22,7 @@ implementation.
    ../powerpc/index
    ../riscv/index
    ../s390/index
-   ../sh/index
+   sh/index
    sparc/index
    x86/index
    xtensa/index
diff --git a/Documentation/sh/booting.rst b/Documentation/arch/sh/booting.rst
similarity index 100%
rename from Documentation/sh/booting.rst
rename to Documentation/arch/sh/booting.rst
diff --git a/Documentation/sh/features.rst b/Documentation/arch/sh/features.rst
similarity index 100%
rename from Documentation/sh/features.rst
rename to Documentation/arch/sh/features.rst
diff --git a/Documentation/sh/index.rst b/Documentation/arch/sh/index.rst
similarity index 100%
rename from Documentation/sh/index.rst
rename to Documentation/arch/sh/index.rst
diff --git a/Documentation/sh/new-machine.rst b/Documentation/arch/sh/new-machine.rst
similarity index 100%
rename from Documentation/sh/new-machine.rst
rename to Documentation/arch/sh/new-machine.rst
diff --git a/Documentation/sh/register-banks.rst b/Documentation/arch/sh/register-banks.rst
similarity index 100%
rename from Documentation/sh/register-banks.rst
rename to Documentation/arch/sh/register-banks.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 250df8cee463..cf4eb913ea12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20125,7 +20125,7 @@ M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-sh@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
-F:	Documentation/sh/
+F:	Documentation/arch/sh/
 F:	arch/sh/
 F:	drivers/sh/
 
diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index fff419f3d757..336c54369636 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -85,7 +85,7 @@ config CPU_HAS_SR_RB
 	  that are lacking this bit must have another method in place for
 	  accomplishing what is taken care of by the banked registers.
 
-	  See <file:Documentation/sh/register-banks.rst> for further
+	  See <file:Documentation/arch/sh/register-banks.rst> for further
 	  information on SR.RB and register banking in the kernel in general.
 
 config CPU_HAS_PTEAEX
-- 
2.39.2

