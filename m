Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F94B8940
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiBPNSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:18:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiBPNSM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:18:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36623DFF0;
        Wed, 16 Feb 2022 05:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97E41CE26F2;
        Wed, 16 Feb 2022 13:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29850C36AEA;
        Wed, 16 Feb 2022 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645017454;
        bh=vo9dsIEQPQMwDE1F9151Sj8jUgLpMoSWAhLaZqQrPZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBOJyeVG43t32e6bfIFQr2JNVmm/3CNnrSPgqp1aywEBs/TnQkH6UoCiuwvYMO5MT
         lwj96h6bIunw0aUrOBHuzAKda33BuKaGijgF6GnixzSz0Sdjj9nkHeXMHqnuG3V0jx
         44u9TnpCcEvGf+Vd6ksaKYU1m1gu9FHVMuqt7U7Z/oHjVq7rSyW4eH2Jx7Z461guOE
         mcS1xOazBw3oe3viFMv1lFKhgYJQk0K4Po3WN6QX2wQnkyybT7djomYdy6S5JuLuay
         gvNVGTV6/HrfYqwdbeOKnPWvh89RBj9KN27iwj3K2hOs52sURTV04KxU5EHc02P7Ol
         oUX9kkXIU5HPQ==
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
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 11/18] arm64: simplify access_ok()
Date:   Wed, 16 Feb 2022 14:13:25 +0100
Message-Id: <20220216131332.1489939-12-arnd@kernel.org>
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

arm64 has an inline asm implementation of access_ok() that is derived from
the 32-bit arm version and optimized for the case that both the limit and
the size are variable. With set_fs() gone, the limit is always constant,
and the size usually is as well, so just using the default implementation
reduces the check into a comparison against a constant that can be
scheduled by the compiler.

On a defconfig build, this saves over 28KB of .text.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/uaccess.h | 34 ++++++++++----------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 2e20879fe3cf..199c553b740a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -26,6 +26,14 @@
 #include <asm/memory.h>
 #include <asm/extable.h>
 
+static inline int __access_ok(const void __user *ptr, unsigned long size)
+{
+	unsigned long limit = TASK_SIZE_MAX;
+	unsigned long addr = (unsigned long)ptr;
+
+	return (size <= limit) && (addr <= (limit - size));
+}
+
 /*
  * Test whether a block of memory is a valid user space address.
  * Returns 1 if the range is valid, 0 otherwise.
@@ -33,10 +41,8 @@
  * This is equivalent to the following test:
  * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
  */
-static inline unsigned long __range_ok(const void __user *addr, unsigned long size)
+static inline int access_ok(const void __user *addr, unsigned long size)
 {
-	unsigned long ret, limit = TASK_SIZE_MAX - 1;
-
 	/*
 	 * Asynchronous I/O running in a kernel thread does not have the
 	 * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
@@ -46,29 +52,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
 		addr = untagged_addr(addr);
 
-	__chk_user_ptr(addr);
-	asm volatile(
-	// A + B <= C + 1 for all A,B,C, in four easy steps:
-	// 1: X = A + B; X' = X % 2^64
-	"	adds	%0, %3, %2\n"
-	// 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
-	"	csel	%1, xzr, %1, hi\n"
-	// 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
-	//    to compensate for the carry flag being set in step 4. For
-	//    X > 2^64, X' merely has to remain nonzero, which it does.
-	"	csinv	%0, %0, xzr, cc\n"
-	// 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
-	//    comes from the carry in being clear. Otherwise, we are
-	//    testing X' - C == 0, subject to the previous adjustments.
-	"	sbcs	xzr, %0, %1\n"
-	"	cset	%0, ls\n"
-	: "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
-
-	return ret;
+	return likely(__access_ok(addr, size));
 }
 
-#define access_ok(addr, size)	__range_ok(addr, size)
-
 /*
  * User access enabling/disabling.
  */
-- 
2.29.2

