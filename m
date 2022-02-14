Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435CE4B56C6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiBNQhq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:37:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356595AbiBNQhc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:37:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292B4D633;
        Mon, 14 Feb 2022 08:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3B7614DA;
        Mon, 14 Feb 2022 16:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3700C340EF;
        Mon, 14 Feb 2022 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856643;
        bh=JepNdDlcl+vjLJWkKWFbQ8vIdC8P4ZqTHDtlQLygTvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yg/pItSQEzs71U/F185pU77Adjq+Wuerpy4kR6BgmvnTJ6TSm1zrt/F8Hi0vGnBb+
         /8Qj5B7b7QxWzSyj+YeaQuhTnchKrNXCzC5slLNGTccGG7g8bl+2UbzUrHWSpXGIt7
         xOg1fig8QiFMO5I3dgU5J+VFGv9rj3JE/Q8LpSpGVH3h3UIE6QskDu0wdEwCOfzQ3s
         aEs8d4j4C6ZkWevO+OIcqOgq9ygDqYeks1ido77hfRKhPW+Q6EC6HRyawN1COLV7LZ
         IgymdocysjOODUy7N4XtW+MjvAWPMlGA3mGuN1K+i4O4Oyp887hWbHPbK6Uy2BO2A4
         4Bp3sWpanrwTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 09/14] m68k: drop custom __access_ok()
Date:   Mon, 14 Feb 2022 17:34:47 +0100
Message-Id: <20220214163452.1568807-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While most m68k platforms use separate address spaces for user
and kernel space, at least coldfire does not, and the other
ones have a TASK_SIZE that is less than the entire 4GB address
range.

Using the generic implementation of __access_ok() stops coldfire
user space from trivially accessing kernel memory, and is probably
the right thing elsewhere for consistency as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/uaccess.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index d6bb5720365a..64914872a5c9 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -10,19 +10,6 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <asm/extable.h>
-
-/* We let the MMU do all checking */
-static inline int __access_ok(const void __user *addr,
-			    unsigned long size)
-{
-	/*
-	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
-	 * for TASK_SIZE!
-	 * Removing this helper is probably sufficient.
-	 */
-	return 1;
-}
-#define __access_ok __access_ok
 #include <asm-generic/access_ok.h>
 
 /*
-- 
2.29.2

