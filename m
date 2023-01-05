Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7B65ECE1
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjAENYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 08:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjAENYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 08:24:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49162003;
        Thu,  5 Jan 2023 05:24:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnnHb3ZNQz4xwl;
        Fri,  6 Jan 2023 00:24:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672925051;
        bh=QTsUQ1sYWKmE6XhlhLQnxBN+PbVBVcCR/OFSB37SXXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwSDQTP0O+RGc33AQz0bKGVZ720wPJAqF3y3BD82q9g+6UpcEYilbbDc/1Qwlzs3s
         z/o8mweLhXRCC3Allh/ld8NDQA1eMbdCrAzDgsqJDhTRAdEDxlSO4eEuSAGKtaBkaa
         nEClg+3ffaCE2j8FMP2VLdDUNog+WakODNizO0wM512Y1dZXgXaSkBetLefKvxyJgP
         tYCT72k4gQ11D5HxKp+iCi9LzOdPPGdfit1onVGKe7qP4X8AxQekj7lZ0YYOVGYK51
         UmR8N+0Yf88NvUJp6eKlxD8TJaSyX4Xo9ErJSn12aGnI3LtKhzsZLI+tCvMm+fqGck
         /WLZZk3urYKEw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <schwab@linux-m68k.org>,
        ardb@kernel.org, <nathan@kernel.org>
Subject: [PATCH 2/3] powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds
Date:   Fri,  6 Jan 2023 00:23:48 +1100
Message-Id: <20230105132349.384666-2-mpe@ellerman.id.au>
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

Relocatable kernels must not discard relocations, they need to be
processed at runtime. As such they are included for CONFIG_RELOCATABLE
builds in the powerpc linker script (line 340).

However they are also unconditionally discarded later in the
script (line 414). Previously that worked because the earlier inclusion
superseded the discard.

However commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and
riscv") introduced an earlier use of DISCARD as part of the RO_DATA
macro (line 137). With binutils < 2.36 that causes the DISCARD
directives later in the script to be applied earlier, causing .rela* to
actually be discarded at link time, leading to build warnings and a
kernel that doesn't boot:

  ld: warning: discarding dynamic section .rela.init.rodata

Fix it by conditionally discarding .rela* only when CONFIG_RELOCATABLE
is disabled.

Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c5ea7d03d539..a4c6efadc90c 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -411,9 +411,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }
-- 
2.39.0

