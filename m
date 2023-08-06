Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914E67715B4
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjHFPAU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFPAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F9E4B;
        Sun,  6 Aug 2023 08:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7ED461191;
        Sun,  6 Aug 2023 15:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9996DC433C7;
        Sun,  6 Aug 2023 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691334017;
        bh=HR0Bz/dmAfQzvaF/pOCNFeWKifK0fCORzeseh9i4jgs=;
        h=From:To:Cc:Subject:Date:From;
        b=D+sFR0cOFC2or++mvfQu7iagJdGut65d+Pa6dCFwfS0wbENgvZpXPmrkRZnpW2RH+
         ETFwKI+8HjaHGctZAbw6XnqPWV5viq2RJh9vwk3CDb4dekObECz3pi5zYaVxneCFKE
         2Cceg2OyrWxfeccI3tfZGg1LZfjk6xcTwQVHdORtGPyIbgS72KJY/kk36ikU0bxeMh
         QRB79uZSvGMvjIM2kTHGmcYMOO3B5GDIEsc9bB0HgDraJH7ultjZrANvsvpuZGoWue
         Oa8deVEatXJsydx3wPxG95PTSMh2HHZmsJDvmL7dyyjBgMrWbrdSfvsS91zJ3JGbQo
         XZFY7ovoJZx2A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] x86: remove unneeded #include <asm/export.h>
Date:   Sun,  6 Aug 2023 23:59:55 +0900
Message-Id: <20230806145958.380314-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

 arch/x86/entry/vdso/vsgx.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index d77d278ee9dd..37a3d4c02366 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/errno.h>
 #include <asm/enclu.h>
 
-- 
2.39.2

