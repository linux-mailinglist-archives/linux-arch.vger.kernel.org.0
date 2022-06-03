Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DF53C64C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 09:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiFCHdl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiFCHdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 03:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087771DA5B;
        Fri,  3 Jun 2022 00:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98B30618E6;
        Fri,  3 Jun 2022 07:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80557C34114;
        Fri,  3 Jun 2022 07:33:29 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH V15 24/24] MAINTAINERS: Add maintainer information for LoongArch
Date:   Fri,  3 Jun 2022 15:20:53 +0800
Message-Id: <20220603072053.35005-25-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220603072053.35005-1-chenhuacai@loongson.cn>
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the maintainer information for the LoongArch (LA or LArch for short)
architecture.

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2316278d9db9..d0aaaacfc19a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11554,6 +11554,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
 
+LOONGARCH
+M:	Huacai Chen <chenhuacai@kernel.org>
+R:	WANG Xuerui <kernel@xen0n.name>
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
+F:	arch/loongarch/
+F:	drivers/*/*loongarch*
+F:	Documentation/loongarch/
+F:	Documentation/translations/zh_CN/loongarch/
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.27.0

