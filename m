Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7175078DC71
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjH3Spt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbjH3JrD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 05:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602161A4;
        Wed, 30 Aug 2023 02:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3265615A0;
        Wed, 30 Aug 2023 09:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3CFC433C8;
        Wed, 30 Aug 2023 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693388820;
        bh=kTGYHnWJ3gzPlhXKqsUN9bUzT388h/9DiQuE8wCZUho=;
        h=From:To:Cc:Subject:Date:From;
        b=FWT31d/f0mCee+oe2RpoHRWuy7BaEhYxxWMFJaiZAN6CR0tJNLANokteDrW4eThQT
         UsOJ9R3xmuZnfB53mDG1PFU06C6Uzfw799Fvw4pPcHf0ydZ2LVE4PfRIVvQDj3IxEz
         v96Ot9FTGUw18MLSYOyr1QZi7pYgKSwO3iupMAf2vW5QPYJq/aZ5s0i8rG1/4vE5Lf
         ZmmwbstV/QOF5y0CgCw08qsJNiWaelMqn4uDThCdEnSNZ6oIEkTJstTcI1ch67J8ZZ
         0nHWIdtBAOEyXw43Yr9XLEJTl76oU3bUR7rY/bV4QDJ2IFu8xMXH7VDFFxqMhCewJt
         ppQ5UqdKp34aw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, linux@roeck-us.net
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Fixup compile error
Date:   Wed, 30 Aug 2023 05:46:53 -0400
Message-Id: <20230830094653.2833443-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

Add header file for asmlinkage macro.

Error log:
In file included from arch/csky/include/asm/ptrace.h:7,
                 from arch/csky/include/asm/elf.h:6,
                 from include/linux/elf.h:6,
                 from kernel/extable.c:6:
arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
   43 | asmlinkage void do_trap_unknown(struct pt_regs *regs);
      |           ^~~~~

Fixes: c8171a86b274 ("csky: Fixup -Wmissing-prototypes warning")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/traps.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
index 1e7d303b91e9..732c4aaa2e26 100644
--- a/arch/csky/include/asm/traps.h
+++ b/arch/csky/include/asm/traps.h
@@ -3,6 +3,8 @@
 #ifndef __ASM_CSKY_TRAPS_H
 #define __ASM_CSKY_TRAPS_H
 
+#include <linux/linkage.h>
+
 #define VEC_RESET	0
 #define VEC_ALIGN	1
 #define VEC_ACCESS	2
-- 
2.36.1

