Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE76D0F7A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjC3T41 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjC3T4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 15:56:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC11027D;
        Thu, 30 Mar 2023 12:56:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E3520736;
        Thu, 30 Mar 2023 19:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E3520736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680206179; bh=fPptF/2dGz/Wan4WLtji8eDcbWKccMVsa6o9HoFeN34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liiGAhtwvwx+jHQZ4PmbMD6nlDYiTXyG5CyiTKgohqsHsYfgco1yUwbm6TbEbXMfM
         hXcDCoyYhKkAvoHVz95VBtwUdivBUvmgm467maMjGdpaSlw5QzrhvNmCDy55MovhJH
         igBmSY3wQj0GTbiI6xhLXWU4rZh9hZAJVnSC9OW3vHYnElhwXbEUAt7aBAJGf+7Qp1
         hm4S3RCgH9DOQRWwBwG/6PYLC/AyT4YUCa6V7j/soY3Z/pRjk7OXD+HNIAHFhytF+x
         CJ0Axy4wMW9FmHgnxzmmuwTOY9ecHiHzniFrIHIl4D8QJCFq9X3/tzQxbT92KfrBp4
         NmQxBnpw3Fmkg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 1/4] docs: Move arc architecture docs under Documentation/arch/
Date:   Thu, 30 Mar 2023 13:56:01 -0600
Message-Id: <20230330195604.269346-2-corbet@lwn.net>
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
Documentation/arc into arch/ and fix all in-tree references.

Cc: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/{ => arch}/arc/arc.rst      | 0
 Documentation/{ => arch}/arc/features.rst | 0
 Documentation/{ => arch}/arc/index.rst    | 0
 Documentation/arch/index.rst              | 2 +-
 MAINTAINERS                               | 2 +-
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{ => arch}/arc/arc.rst (100%)
 rename Documentation/{ => arch}/arc/features.rst (100%)
 rename Documentation/{ => arch}/arc/index.rst (100%)

diff --git a/Documentation/arc/arc.rst b/Documentation/arch/arc/arc.rst
similarity index 100%
rename from Documentation/arc/arc.rst
rename to Documentation/arch/arc/arc.rst
diff --git a/Documentation/arc/features.rst b/Documentation/arch/arc/features.rst
similarity index 100%
rename from Documentation/arc/features.rst
rename to Documentation/arch/arc/features.rst
diff --git a/Documentation/arc/index.rst b/Documentation/arch/arc/index.rst
similarity index 100%
rename from Documentation/arc/index.rst
rename to Documentation/arch/arc/index.rst
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index ccb4d10fc1b6..2aeff47a0014 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -9,7 +9,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
-   ../arc/index
+   arc/index
    ../arm/index
    ../arm64/index
    ../ia64/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 64ea94536f4c..78ff43f63753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20185,7 +20185,7 @@ M:	Vineet Gupta <vgupta@kernel.org>
 L:	linux-snps-arc@lists.infradead.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git
-F:	Documentation/arc/
+F:	Documentation/arch/arc
 F:	Documentation/devicetree/bindings/arc/*
 F:	Documentation/devicetree/bindings/interrupt-controller/snps,arc*
 F:	arch/arc/
-- 
2.39.2

