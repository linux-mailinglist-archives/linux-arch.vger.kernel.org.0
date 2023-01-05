Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7026465ECE2
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjAENYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 08:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAENYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 08:24:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5195E0EB;
        Thu,  5 Jan 2023 05:24:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnnHc0FDqz4y0B;
        Fri,  6 Jan 2023 00:24:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672925052;
        bh=OSrLexRH0yAsb5qST90MoTX51vfdeiMji+XTnquxx4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcSOFdnfJkqg973Yj8od+KLuNgioMrbMpfYqEmAbOzD9d9Oe3WTzxXzx0gJJZuALw
         9ABoRfTgnZKTpsNjtk62xNu+80BKfXOl/0ACARfQLR326UjPiA/CHJ5+1k9jtdLnwi
         ZOIE+LyejRC2XvTqF39E2vsgIfijxviU2y3aanMsaNceXVo1k9LAUWDIx8tv98NvoW
         /2V2YR/Rk67IkSGdD4deik6oDJBXVl3ok3nIq5FuSFoAcVgYqs5cFSaJaugXAD0UMd
         4/LuMfDSMwhW2QCJyAmqlKLFCjWIr4aNfYbCaMK/m/lifGd2tjR4DdZRr1b4kHVFtz
         hgJ0f0Etdbwiw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <schwab@linux-m68k.org>,
        ardb@kernel.org, <nathan@kernel.org>
Subject: [PATCH 3/3] powerpc/vmlinux.lds: Don't discard .comment
Date:   Fri,  6 Jan 2023 00:23:49 +1100
Message-Id: <20230105132349.384666-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105132349.384666-1-mpe@ellerman.id.au>
References: <20230105132349.384666-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Although the powerpc linker script mentions .comment in the DISCARD
section, that has never actually caused it to be discarded, because the
earlier ELF_DETAILS macro (previously STABS_DEBUG) explicitly includes
.comment.

However commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and
riscv") introduced an earlier use of DISCARD as part of the RO_DATA
macro. With binutils < 2.36 that causes the DISCARD directives later in
the script to be applied earlier, causing .comment to actually be
discarded.

It's confusing to explicitly include and discard .comment, and even more
so if the behaviour depends on the toolchain version. So don't discard
.comment in order to maintain the existing behaviour in all cases.

Fixes: 83a092cf95f2 ("powerpc: Link warning for orphan sections")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a4c6efadc90c..958e77a24f85 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -411,7 +411,7 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .comment)
+		*(.glink .iplt .plt)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
-- 
2.39.0

