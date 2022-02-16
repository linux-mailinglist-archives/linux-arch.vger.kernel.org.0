Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D734B88FC
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiBPNR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:17:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiBPNRJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:17:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EEF66225;
        Wed, 16 Feb 2022 05:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64ADBCE26F6;
        Wed, 16 Feb 2022 13:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5098AC340F3;
        Wed, 16 Feb 2022 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645017403;
        bh=FL3MwLnWcBo8JSN1gcn5jt3T6ZS9T2mg8wS4azHPBik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2Mjm03t4E3XFheH9yqQ6BGU3tXKnLCiOO/OwTUtf1lgBYcrWial86jpIz7PtRFIw
         avWAsmqN07Ju1N9aZWFEK6djiU4xxVsrWrIldgYbLMAINPBCIE+Gm9knAbw2ZJ5YQU
         0At6HGqJSzJ5Apl70hqpM+UJUgnBEg8NWGL9S7AWW9MhT9XDK6p1AAJUM3JogLfwD2
         1lrWss7flCDtYrrnfWGqToUCjUhfOxjIFu9y4/66Sjvu+ZaCBq+vjebdXEQiJu+If4
         gZzt/RXBM8sHm8w1g75IDg7GXTr01G1sdmyHMVFaBZouzSWgTlBFAfWq558NJn3p1E
         Mzr/8UqWDZOoA==
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
Subject: [PATCH v2 06/18] x86: use more conventional access_ok() definition
Date:   Wed, 16 Feb 2022 14:13:20 +0100
Message-Id: <20220216131332.1489939-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The way that access_ok() is defined on x86 is slightly different from
most other architectures, and a bit more complex.

The generic version tends to result in the best output on all
architectures, as it results in single comparison against a constant
limit for calls with a known size.

There are a few callers of __range_not_ok(), all of which use TASK_SIZE
as the limit rather than TASK_SIZE_MAX, but I could not see any reason
for picking this. Changing these to call __access_ok() instead uses the
default limit, but keeps the behavior otherwise.

x86 is the only architecture with a WARN_ON_IN_IRQ() checking
access_ok(), but it's probably best to leave that in place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/uaccess.h | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 79c4869ccdd6..a59ba2578e64 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -16,33 +16,14 @@
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
  */
-static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size)
+static inline bool __access_ok(void __user *ptr, unsigned long size)
 {
 	unsigned long limit = TASK_SIZE_MAX;
+	unsigned long addr = ptr;
 
-	/*
-	 * If we have used "sizeof()" for the size,
-	 * we know it won't overflow the limit (but
-	 * it might overflow the 'addr', so it's
-	 * important to subtract the size from the
-	 * limit, not add it to the address).
-	 */
-	if (__builtin_constant_p(size))
-		return unlikely(addr > limit - size);
-
-	/* Arbitrary sizes? Be careful about overflow */
-	addr += size;
-	if (unlikely(addr < size))
-		return true;
-	return unlikely(addr > limit);
+	return (size <= limit) && (addr <= (limit - size));
 }
 
-#define __access_ok(addr, size)						\
-({									\
-	__chk_user_ptr(addr);						\
-	!__chk_range_not_ok((unsigned long __force)(addr), size);	\
-})
-
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()	\
-- 
2.29.2

