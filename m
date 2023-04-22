Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C896EBAC9
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDVR5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Apr 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDVR5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Apr 2023 13:57:22 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84582128;
        Sat, 22 Apr 2023 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1682186240; bh=jDQ5fjNeCWA8O/H00VoE007YWcDXHB9QzsSVJ4CDNiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0ssQLqncu6dO/ZY9pjb5fO4M4SIX2cROE3TP2QdRpKceN6oOGfJU2nyHESHx/CJv
         V99pe1/Qta82r/u9XGXJo75HYO08kQ46wgM/KbQw2W+0PbqwisBAODoazmpJ5wFSDA
         1IEL6aZLXE6A05lOcJJKuFz6Nl7orGmuTB3LjjwI=
Received: from ld50.lan (unknown [101.228.138.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E2DB660132;
        Sun, 23 Apr 2023 01:57:19 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: Add opcodes of bounds-checking instructions
Date:   Sun, 23 Apr 2023 01:57:04 +0800
Message-Id: <20230422175705.3444561-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422175705.3444561-1-kernel@xen0n.name>
References: <20230422175705.3444561-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

To be used later for extracting operands from faulting instructions that
fall under this category.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/inst.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index a04fe755d719..829646f633d2 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -121,6 +121,8 @@ enum reg2bstrd_op {
 };
 
 enum reg3_op {
+	asrtle_op	= 0x2,
+	asrtgt_op	= 0x3,
 	addw_op		= 0x20,
 	addd_op		= 0x21,
 	subw_op		= 0x22,
@@ -176,6 +178,30 @@ enum reg3_op {
 	amord_op	= 0x70c7,
 	amxorw_op	= 0x70c8,
 	amxord_op	= 0x70c9,
+	fldgts_op	= 0x70e8,
+	fldgtd_op	= 0x70e9,
+	fldles_op	= 0x70ea,
+	fldled_op	= 0x70eb,
+	fstgts_op	= 0x70ec,
+	fstgtd_op	= 0x70ed,
+	fstles_op	= 0x70ee,
+	fstled_op	= 0x70ef,
+	ldgtb_op	= 0x70f0,
+	ldgth_op	= 0x70f1,
+	ldgtw_op	= 0x70f2,
+	ldgtd_op	= 0x70f3,
+	ldleb_op	= 0x70f4,
+	ldleh_op	= 0x70f5,
+	ldlew_op	= 0x70f6,
+	ldled_op	= 0x70f7,
+	stgtb_op	= 0x70f8,
+	stgth_op	= 0x70f9,
+	stgtw_op	= 0x70fa,
+	stgtd_op	= 0x70fb,
+	stleb_op	= 0x70fc,
+	stleh_op	= 0x70fd,
+	stlew_op	= 0x70fe,
+	stled_op	= 0x70ff,
 };
 
 enum reg3sa2_op {
-- 
2.40.0

