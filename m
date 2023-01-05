Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF765ECE3
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 14:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAENYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 08:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAENYS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 08:24:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA5392C4;
        Thu,  5 Jan 2023 05:24:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnnHZ0LZYz4xFv;
        Fri,  6 Jan 2023 00:24:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672925051;
        bh=kXnkF0b/OaOC5Nxi/u3bSyBpk6+JvzMFBPMrXrjtg/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=JpMYYfH2FCrnCTfmelT45DFH0gd2VP33Kgl71fHMREtAS9q0VH2osMQNv3zucxG1H
         TqZsHEHL49sW2gJDZ0Ai/nQRFQZoIo7Yq7GU9XxGHza1s33SGTZLhPrb/x7Jibp1Wi
         Sdaj7JIZdSE6+RvzyssDKYUaRrZvrUI49nm2MuSh7Y2XTnQiRUbc3drSCBa+0974Qo
         LLXfNYkXx5usjlSk8JaN+FTZZZOP1vd09olfmjU9Rihl7SsHlyY3kUVg56Upqw5sj6
         7ZGu5K7Zagh5rVJJWxaCRyVgxyIttibIvIJB7kBMIMveYRd7Y3dJJ7urgaxZgJX3G8
         26AXbPyrkSoyQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <schwab@linux-m68k.org>,
        ardb@kernel.org, <nathan@kernel.org>
Subject: [PATCH 1/3] powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT
Date:   Fri,  6 Jan 2023 00:23:47 +1100
Message-Id: <20230105132349.384666-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The powerpc linker script explicitly includes .exit.text, because
otherwise the link fails due to references from __bug_table and
__ex_table. The code is freed (discarded) at runtime along with
.init.text and data.

That has worked in the past despite powerpc not defining
RUNTIME_DISCARD_EXIT because DISCARDS appears late in the powerpc linker
script (line 410), and the explicit inclusion of .exit.text
earlier (line 280) supersedes the discard.

However commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and
riscv") introduced an earlier use of DISCARD as part of the RO_DATA
macro (line 136). With binutils < 2.36 that causes the DISCARD
directives later in the script to be applied earlier [1], causing
.exit.text to actually be discarded at link time, leading to build
errors:

  '.exit.text' referenced in section '__bug_table' of crypto/algboss.o: defined in
  discarded section '.exit.text' of crypto/algboss.o
  '.exit.text' referenced in section '__ex_table' of drivers/nvdimm/core.o: defined in
  discarded section '.exit.text' of drivers/nvdimm/core.o

Fix it by defining RUNTIME_DISCARD_EXIT, which causes the generic
DISCARDS macro to not include .exit.text at all.

1: https://lore.kernel.org/lkml/87fscp2v7k.fsf@igel.home/

Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8c3862b4c259..c5ea7d03d539 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -8,6 +8,7 @@
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	0
+#define RUNTIME_DISCARD_EXIT
 
 #define SOFT_MASK_TABLE(align)						\
 	. = ALIGN(align);						\
-- 
2.39.0

