Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717244B88FA
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiBPNR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:17:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiBPNRJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:17:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F36350;
        Wed, 16 Feb 2022 05:16:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51105CE26F3;
        Wed, 16 Feb 2022 13:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47582C340F1;
        Wed, 16 Feb 2022 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645017413;
        bh=+iR2qnnFcrsCPQoMglxV/90U3LFjDlY0u/606L67UPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvFA19KgOFHw//5AD53hF0IwW2eLEb8iC830WFN6MdVoW4fyh5i/2kJHpxFd7pdlD
         7UX6fEewGCq+cZvaT2PObS6XOZnZypDPzvRcYa/W0nzWewDgb+0xXamh2omZfLYFmr
         8N4H7mpvMOTDqe2QPH8s/NhnVxUv6/h988kxIKpvMvfqvjGNNvINW6t4henTJIKwJt
         jzLnL5Fc+Su69zkh5g1Nf3EInYTi+sp1khBbBbK8Lt97/7IVApa2FzdwQAvU7AyEeL
         nEYQi1fYgk8k2uZixKdw/j3+QwXzCx+3pjcEKGsjL9tNOzijYs/MTwOK3SPeQjakHj
         3w2JGHUIm9rGg==
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
Subject: [PATCH v2 07/18] nios2: drop access_ok() check from __put_user()
Date:   Wed, 16 Feb 2022 14:13:21 +0100
Message-Id: <20220216131332.1489939-8-arnd@kernel.org>
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

Unlike other architectures, the nios2 version of __put_user() has an
extra check for access_ok(), preventing it from being used to implement
__put_kernel_nofault().

Split up put_user() along the same lines as __get_user()/get_user()

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nios2/include/asm/uaccess.h | 56 +++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index ca9285a915ef..a5cbe07cf0da 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -167,34 +167,44 @@ do {									\
 	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
 }
 
-#define put_user(x, ptr)						\
+#define __put_user_common(__pu_val, __pu_ptr)				\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
-	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
-	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
-		switch (sizeof(*__pu_ptr)) {				\
-		case 1:							\
-			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
-			break;						\
-		case 2:							\
-			__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err); \
-			break;						\
-		case 4:							\
-			__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err); \
-			break;						\
-		default:						\
-			/* XXX: This looks wrong... */			\
-			__pu_err = 0;					\
-			if (copy_to_user(__pu_ptr, &(__pu_val),		\
-				sizeof(*__pu_ptr)))			\
-				__pu_err = -EFAULT;			\
-			break;						\
-		}							\
+	switch (sizeof(*__pu_ptr)) {					\
+	case 1:								\
+		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
+		break;							\
+	case 2:								\
+		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
+		break;							\
+	case 4:								\
+		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
+		break;							\
+	default:							\
+		/* XXX: This looks wrong... */				\
+		__pu_err = 0;						\
+		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
+			sizeof(*__pu_ptr)))				\
+			__pu_err = -EFAULT;				\
+		break;							\
 	}								\
 	__pu_err;							\
 })
 
-#define __put_user(x, ptr) put_user(x, ptr)
+#define __put_user(x, ptr)						\
+({									\
+	__auto_type __pu_ptr = (ptr);					\
+	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	__put_user_common(__pu_val, __pu_ptr);				\
+})
+
+#define put_user(x, ptr)						\
+({									\
+	__auto_type __pu_ptr = (ptr);					\
+	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
+		__put_user_common(__pu_val, __pu_ptr) :			\
+		-EFAULT;						\
+})
 
 #endif /* _ASM_NIOS2_UACCESS_H */
-- 
2.29.2

