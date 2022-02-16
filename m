Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFE4B892D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiBPNSh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:18:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiBPNRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:17:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6966293B42;
        Wed, 16 Feb 2022 05:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44D81616B4;
        Wed, 16 Feb 2022 13:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB5FC340F1;
        Wed, 16 Feb 2022 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645017443;
        bh=MxlH7OSdWg2oRBDys6vsaBDtcNFNrqae9GgCDj46MDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjI1N/Ysf6UohThwc+VXydeUqwNugfP8doF9H67EicATD6oaAkDsrCNS3AC/ubFNd
         ziBIxKGEAeyq4Bw3XdZgjBuNcKHeB1enctrHaLGU2ykGVgZHDsnbC5Wzwde0sZPsGo
         WD7WBQJHRS/PhCcVbk/s6TQX9q0zFJnPZsK3bgY0sTLsXoxe2RYo46AhoXLG6T8vLY
         ptfvBD5j0ki8uiIVLlwxNojr8S73bqQ6CnNgAESnFCyQrATHgA3qg0Clpwhp7O6ene
         UNjiTeS5j4av8zOGlm3gJWoU7z2Cw6gaTV6tNodGA/Zj7EYErzSRxKmSguUvyWCtWL
         X2GGlpG3o7PVg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
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
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 10/18] m68k: fix access_ok for coldfire
Date:   Wed, 16 Feb 2022 14:13:24 +0100
Message-Id: <20220216131332.1489939-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
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

Using the default implementation of __access_ok() stops coldfire
user space from trivially accessing kernel memory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/uaccess.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index 79617c0b2f91..8eb625e75452 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -12,14 +12,21 @@
 #include <asm/extable.h>
 
 /* We let the MMU do all checking */
-static inline int access_ok(const void __user *addr,
+static inline int access_ok(const void __user *ptr,
 			    unsigned long size)
 {
+	unsigned long limit = TASK_SIZE;
+	unsigned long addr = (unsigned long)ptr;
+
 	/*
 	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
 	 * for TASK_SIZE!
+	 * Removing this helper is probably sufficient.
 	 */
-	return 1;
+	if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
+		return 1;
+
+	return (size <= limit) && (addr <= (limit - size));
 }
 
 /*
-- 
2.29.2

