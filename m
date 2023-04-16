Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0834A6E3A97
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDPReV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjDPReR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 13:34:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31035A5;
        Sun, 16 Apr 2023 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681666439; bh=jDQ5fjNeCWA8O/H00VoE007YWcDXHB9QzsSVJ4CDNiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g71LmMzXni0+ATxaSwgJnDEXtx9mIIeCjU+FLC3qDd0a9MTG3EEzvIIzSqhlMbOxR
         9X3S7GKGq+FOe5v6wGrQpPAmwBGNyC1lcs4xwNegac5c7ER8WhD6sOcpPyNl3emHHQ
         oqtadtGZ7HKDow/tpsVITGldKJTopleQeO/1dJJg=
Received: from ld50.lan (unknown [101.228.138.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E42A860142;
        Mon, 17 Apr 2023 01:33:58 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] LoongArch: Add opcodes of bounds-checking instructions
Date:   Mon, 17 Apr 2023 01:33:25 +0800
Message-Id: <20230416173326.3995295-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416173326.3995295-1-kernel@xen0n.name>
References: <20230416173326.3995295-1-kernel@xen0n.name>
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

