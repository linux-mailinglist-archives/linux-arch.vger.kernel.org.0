Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F446C72ED
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCWWUG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCWWUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79723123;
        Thu, 23 Mar 2023 15:20:03 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id D93F644A;
        Thu, 23 Mar 2023 22:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D93F644A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610003; bh=exL/Eca8MAqKl5rksOHF32zvppjMakfM5mkmNOwiCVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGZdQmjRbCQl8eeBxVnQ2zmA6jU8HwLhzhH/pPI4QeD81eLeUD9mck7lJ8jkoaaiZ
         slmrfV6R6GbwAvOI3D/S2ANdUJQv+HduycxwNrZGFEwJK3GnqQiu+uw0JmZfvZRNSq
         iBbWa2MyQYNjPU5FvcddL1D3XK8MmEGc7Tw+0ST2BjPxyRY/WLjkAsNqFLfyXLiukp
         AqRkfXuV5aYjqSyC2qTzhNK2RVJmwdD0rH6Nd0Dr3G+dcNt+n4CV0W2Jx8O3nu6rak
         zJGrHNec6Tg3MjRyqa+zPpqOaYw2ZNem/5m/bJcjfKP7EhTjbHHvb72e5IQgOj7uO2
         LXyyWYP4MDsIA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH 1/6] docs: zh_CN: create the architecture-specific top-level directory
Date:   Thu, 23 Mar 2023 16:19:43 -0600
Message-Id: <20230323221948.352154-2-corbet@lwn.net>
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

This mirrors commit 4f1bb0386dfc ("docs: create a top-level arch/
directory"), creating a top-level directory to hold architecture-specific
documentation.

Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 .../translations/zh_CN/{arch.rst => arch/index.rst}  | 12 ++++++------
 Documentation/translations/zh_CN/index.rst           |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/translations/zh_CN/{arch.rst => arch/index.rst} (72%)

diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/translations/zh_CN/arch/index.rst
similarity index 72%
rename from Documentation/translations/zh_CN/arch.rst
rename to Documentation/translations/zh_CN/arch/index.rst
index 690e173d8b2a..aa53dcff268e 100644
--- a/Documentation/translations/zh_CN/arch.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -8,12 +8,12 @@
 .. toctree::
    :maxdepth: 2
 
-   mips/index
-   arm64/index
-   riscv/index
-   openrisc/index
-   parisc/index
-   loongarch/index
+   ../mips/index
+   ../arm64/index
+   ../riscv/index
+   ../openrisc/index
+   ../parisc/index
+   ../loongarch/index
 
 TODOList:
 
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 7c3216845b71..299704c0818d 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -120,7 +120,7 @@ TODOList:
 .. toctree::
    :maxdepth: 2
 
-   arch
+   arch/index
 
 其他文档
 --------
-- 
2.39.2

