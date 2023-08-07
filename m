Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D802772988
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHGPnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHGPnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219CFBD;
        Mon,  7 Aug 2023 08:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3FBA61E57;
        Mon,  7 Aug 2023 15:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E264C433CD;
        Mon,  7 Aug 2023 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422983;
        bh=6F2ehvB66Ms9jWF39bnYTV60WrC8vf/eA8/nBR/P3/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+/9FYqc7NzkxY9qtFa4pV3rcoAGj2HuuiUDQkDo+UljP3mFGXHSNZa2wCU4BMcIH
         noEeQhEYoG6f0j+3J0mNWhY8asx0KhMGNnfVs2NMBYFPeHVF02IZ6hR9kKD3p936U7
         HEzSWFWS2vCFS013B+7H/G1lZsF56vgYRnflEMbtnazOgEWN+pV5xU0Hzywd0wu1kl
         hYeMs4dKXpB+Aqg7PJWyhhdVjS3yn1lbK9mJzF9EzRar6Gt9J+hMqqkOl6SFSHi11J
         LEfp6QasWWLkKkwudx31Hjz7MVSh7fWWGBZ6Wn6R7qb4C3fZKekBldpgz+pUgx55ae
         YnIKf9qV8llQA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] loongarch: remove <asm/export.h>
Date:   Tue,  8 Aug 2023 00:42:50 +0900
Message-Id: <20230807154250.998765-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807154250.998765-1-masahiroy@kernel.org>
References: <20230807154250.998765-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All *.S files under arch/loongarch/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 6b222f227342..93783fa24f6e 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += dma-contiguous.h
-generic-y += export.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
-- 
2.39.2

