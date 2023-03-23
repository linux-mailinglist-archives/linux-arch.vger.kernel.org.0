Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1817A6C72F6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCWWUH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCWWUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C522385A;
        Thu, 23 Mar 2023 15:20:04 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 6D2C9733;
        Thu, 23 Mar 2023 22:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D2C9733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610003; bh=sKGqOrWJA71ARwk29FqcItJLbTRHc7B6f2O5jNNhG9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqW/q98zaAIcwV/xip11UzIEk6AyMj9kiVmHFYhQ2AtDWeBzaZSHtNmoYSTE8vLUN
         4GbhRY1BN9oNtZutnrDbRacfzmhXhdMxXlS2hAfBMmRFfhZop58X67bn0UaJJzevqh
         VtdLow9GEZBGBHleaE1ufbJn3G92OwjXT0k9CVczc6VsbtogCus8z/sYgIt+bNBwLQ
         6u/yPulnrW5l6v2KddVCp+b85d0+5XuTdzNHULQY9PllSzHONrm9N7+wYeIN82BmJc
         ZPCU62GVhDb29J6+Xe2q8lfQU8UXvBIKtaOr649tyU5QTg/aF/4bpj7dyfj4bW7aFY
         xxXpmMYNCkWnA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/6] docs: move xtensa documentation under Documentation/arch/
Date:   Thu, 23 Mar 2023 16:19:44 -0600
Message-Id: <20230323221948.352154-3-corbet@lwn.net>
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
Documentation/xtensa into arch/ and fix all in-tree references.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arch/index.rst                 | 2 +-
 Documentation/{ => arch}/xtensa/atomctl.rst  | 0
 Documentation/{ => arch}/xtensa/booting.rst  | 0
 Documentation/{ => arch}/xtensa/features.rst | 0
 Documentation/{ => arch}/xtensa/index.rst    | 0
 Documentation/{ => arch}/xtensa/mmu.rst      | 0
 arch/xtensa/include/asm/initialize_mmu.h     | 2 +-
 7 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{ => arch}/xtensa/atomctl.rst (100%)
 rename Documentation/{ => arch}/xtensa/booting.rst (100%)
 rename Documentation/{ => arch}/xtensa/features.rst (100%)
 rename Documentation/{ => arch}/xtensa/index.rst (100%)
 rename Documentation/{ => arch}/xtensa/mmu.rst (100%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 64a5de81c425..208a8e67599c 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -25,4 +25,4 @@ implementation.
    ../sh/index
    ../sparc/index
    x86/index
-   ../xtensa/index
+   xtensa/index
diff --git a/Documentation/xtensa/atomctl.rst b/Documentation/arch/xtensa/atomctl.rst
similarity index 100%
rename from Documentation/xtensa/atomctl.rst
rename to Documentation/arch/xtensa/atomctl.rst
diff --git a/Documentation/xtensa/booting.rst b/Documentation/arch/xtensa/booting.rst
similarity index 100%
rename from Documentation/xtensa/booting.rst
rename to Documentation/arch/xtensa/booting.rst
diff --git a/Documentation/xtensa/features.rst b/Documentation/arch/xtensa/features.rst
similarity index 100%
rename from Documentation/xtensa/features.rst
rename to Documentation/arch/xtensa/features.rst
diff --git a/Documentation/xtensa/index.rst b/Documentation/arch/xtensa/index.rst
similarity index 100%
rename from Documentation/xtensa/index.rst
rename to Documentation/arch/xtensa/index.rst
diff --git a/Documentation/xtensa/mmu.rst b/Documentation/arch/xtensa/mmu.rst
similarity index 100%
rename from Documentation/xtensa/mmu.rst
rename to Documentation/arch/xtensa/mmu.rst
diff --git a/arch/xtensa/include/asm/initialize_mmu.h b/arch/xtensa/include/asm/initialize_mmu.h
index 9793b49fc641..574795a20d6f 100644
--- a/arch/xtensa/include/asm/initialize_mmu.h
+++ b/arch/xtensa/include/asm/initialize_mmu.h
@@ -43,7 +43,7 @@
 #if XCHAL_HAVE_S32C1I && (XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RC_2009_0)
 /*
  * We Have Atomic Operation Control (ATOMCTL) Register; Initialize it.
- * For details see Documentation/xtensa/atomctl.rst
+ * For details see Documentation/arch/xtensa/atomctl.rst
  */
 #if XCHAL_DCACHE_IS_COHERENT
 	movi	a3, 0x25	/* For SMP/MX -- internal for writeback,
-- 
2.39.2

