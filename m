Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3B6C72F1
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCWWUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCWWUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB823D99;
        Thu, 23 Mar 2023 15:20:06 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id D3CED845;
        Thu, 23 Mar 2023 22:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3CED845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610006; bh=rsDSg4mYvFmVgpSxVekYd+TcSXV5fNk9ODWCs9zntmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPiUUuy+mDNP1JupNnClvXBOF9+M9rw3YKNbQzP6w9Q+awaf/j/T9Q6OQ/cNVtlW6
         BFSuWLmZRj3/oTkIFMkr/oy6kEu6D2KzExUjuWLf81+PK8aNJx+QKv3UaG57LnD5Kj
         slFIvgrB2fUO/+ZZXL/cRNWrbLvFvVqfNxFYN4gUMXvKDBEfj81XW/aG8jbn3EyoSn
         nwp31ZQJZRiaF3dfrkudo+SpT4wDUW4kqnsg7PqsGE2UKe1o2UwiOwmODLs084aQlg
         +ub6erX52awqq34eSmkIl5J1iOU7Wpjnt/nJ6qS0Dqc+EWfQ7dWLJkkO0PEajs4aRE
         T+ljhvWb8pLcA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/6] docs: move nios2 documentation under Documentation/arch/
Date:   Thu, 23 Mar 2023 16:19:48 -0600
Message-Id: <20230323221948.352154-7-corbet@lwn.net>
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
Documentation/nios2 into arch/ and fix all in-tree references.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                | 2 +-
 Documentation/{ => arch}/nios2/features.rst | 0
 Documentation/{ => arch}/nios2/index.rst    | 0
 Documentation/{ => arch}/nios2/nios2.rst    | 0
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => arch}/nios2/features.rst (100%)
 rename Documentation/{ => arch}/nios2/index.rst (100%)
 rename Documentation/{ => arch}/nios2/nios2.rst (100%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 65945daa40fe..ccb4d10fc1b6 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -16,7 +16,7 @@ implementation.
    ../loongarch/index
    ../m68k/index
    ../mips/index
-   ../nios2/index
+   nios2/index
    openrisc/index
    ../parisc/index
    ../powerpc/index
diff --git a/Documentation/nios2/features.rst b/Documentation/arch/nios2/features.rst
similarity index 100%
rename from Documentation/nios2/features.rst
rename to Documentation/arch/nios2/features.rst
diff --git a/Documentation/nios2/index.rst b/Documentation/arch/nios2/index.rst
similarity index 100%
rename from Documentation/nios2/index.rst
rename to Documentation/arch/nios2/index.rst
diff --git a/Documentation/nios2/nios2.rst b/Documentation/arch/nios2/nios2.rst
similarity index 100%
rename from Documentation/nios2/nios2.rst
rename to Documentation/arch/nios2/nios2.rst
-- 
2.39.2

