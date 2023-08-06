Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A37715DC
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHFPUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFPUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E694114;
        Sun,  6 Aug 2023 08:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EDB611AD;
        Sun,  6 Aug 2023 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD49C433C7;
        Sun,  6 Aug 2023 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691335239;
        bh=KOXnwvX1pbEuDZKxMywuVeWv2AHBMmhq6q6qvyD+EXg=;
        h=From:To:Cc:Subject:Date:From;
        b=T3Rww3h0MONRUopoiW0RsLMcfMc+02d/kUgCgTd2/Dzd9LvVBT24QjWW4dm9wGAEO
         Em8iZTSDo9qTVS4xOq/Ihk+tNI52kTOsqW/tQaMiIJ6sKkqoJfgat3G8BasaCyOPWt
         Txxmfwgu3CECXggO0PGTIh2EnB9HErJfawy9xt10xjVB406zd9dlxk+XdZPpVRCRZ6
         lpGjzZfbSUN1CruwROKu+OIve2hnD8EYt7bxm7RZKO4798Xp/zVzQAhhnKdxGJUXOh
         AGrQ3DE5MoeGdBzRDAyEwvT+D/hyUIR+ImplPilmnBSHb9rhiLqDsBpb42cF7yoJ31
         pnUozV9LNNjuQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] s390: remove unneeded #include <asm/export.h>
Date:   Mon,  7 Aug 2023 00:16:38 +0900
Message-Id: <20230806151641.394720-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/mcount.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 71c5fa05e7f1..ae4d4fd9afcd 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -9,8 +9,6 @@
 #include <asm/ftrace.h>
 #include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
-#include <asm/export.h>
-
 
 #define STACK_FRAME_SIZE_PTREGS		(STACK_FRAME_OVERHEAD + __PT_SIZE)
 #define STACK_PTREGS			(STACK_FRAME_OVERHEAD)
-- 
2.39.2

