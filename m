Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6E5FCA2F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJLSCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJLSCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 14:02:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760BFDB62;
        Wed, 12 Oct 2022 11:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 478F4B81B99;
        Wed, 12 Oct 2022 18:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88EFC433D7;
        Wed, 12 Oct 2022 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665597732;
        bh=ZF4qL49nEN3dgbNT5/iWT+wzWCTZQWUxR97n4OT4C50=;
        h=From:To:Cc:Subject:Date:From;
        b=Vdx99f4muWHSbtReYZ8NdrIvMzZk1MngJpsteWJAj8jCJRQNXu6su9b2vQlZRmmXy
         m2uH0S6HZ0OXZd+awxpSCnUgsrA4d6CfFydSNVA83/nQH5bUc8R2ye8HgvjsK6yo0X
         xpfQoO9mx0zev52U8nBAgB334pVe8pdPjnA4cZH0ZjSTiCvs2TIcIM8OYab43TWxkd
         Ouq0VeOZ/tn0ULrJtiFTcJ9CtSf+g6eTeK31PQ3+UlqftNGqEVAj9E21E63m9LupYb
         110+w9DTxdXlW/azN7e8tJXgo8DtvE2J+BAcscddZfVFQKQz8Izo+Bc5JBcSP6U1kx
         piEBUrtl+nSfA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 1/2] kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Thu, 13 Oct 2022 03:01:17 +0900
Message-Id: <20221012180118.331005-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

CONFIG_WERROR turns warnings into errors, which  happens only for *.c
files because -Werror is added to KBUILD_CFLAGS.

Adding it to KBUILD_CPPFLAGS makes more sense because preprocessors
understand the -Werror option.

For example, you can put a #warning directive in any preprocessed code.

    warning: #warning "this is a warning message" [-Wcpp]

If -Werror is added, it is promoted to an error.

    error: #warning "this is a warning message" [-Werror=cpp]

This commit moves -Werror to KBUILD_CPPFLAGS so it works in the same way
for *.c, *.S, *.lds.S or whatever needs preprocessing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 85a63a1d29b3..790760d26ea0 100644
--- a/Makefile
+++ b/Makefile
@@ -859,7 +859,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
 KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 
 KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
-- 
2.34.1

