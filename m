Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743672A0A57
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgJ3PuC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgJ3Pts (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:48 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5308F22253;
        Fri, 30 Oct 2020 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072986;
        bh=dw+FNOj9rldGYjGgvqnlK7d2jveyytjZONsX8DAT/q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0a5HNrBIRQUBu6ig7nuv+MepNXNQ24+T16k0PcALBnQZR4OF92jeVXmuZSrRVNd6
         XZ5W5D//tVylebaXnmmw2zHAt37AnRO8154mQwRo1xA0cfvtRiA++v20bomKsCI+V5
         yyEMPB23AsmMXSFWEGc+XVUndufFs2TfKX+nvOUg=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 8/9] ARM: uaccess: add __{get,put}_kernel_nofault
Date:   Fri, 30 Oct 2020 16:49:18 +0100
Message-Id: <20201030154919.1246645-8-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These mimic the behavior of get_user and put_user, except
for domain switching, address limit checking and handling
of mismatched sizes, none of which are relevant here.

To work with pre-Armv6 kernels, this has to avoid TUSER()
inside of the new macros, the new approach passes the "t"
string along with the opcode, which is a bit uglier but
avoids duplicating more code.

As there is no __get_user_asm_dword(), I work around it
by copying 32 bit at a time, which is possible because
the output size is known.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/uaccess.h | 123 ++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index a13d90206472..4f60638755c4 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -308,11 +308,11 @@ static inline void set_fs(mm_segment_t fs)
 #define __get_user(x, ptr)						\
 ({									\
 	long __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err);				\
+	__get_user_err((x), (ptr), __gu_err, TUSER());			\
 	__gu_err;							\
 })
 
-#define __get_user_err(x, ptr, err)					\
+#define __get_user_err(x, ptr, err, __t)				\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
 	unsigned long __gu_val;						\
@@ -321,18 +321,19 @@ do {									\
 	might_fault();							\
 	__ua_flags = uaccess_save_and_enable();				\
 	switch (sizeof(*(ptr))) {					\
-	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
-	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
-	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
+	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
+	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
+	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
 	default: (__gu_val) = __get_user_bad();				\
 	}								\
 	uaccess_restore(__ua_flags);					\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 } while (0)
+#endif
 
 #define __get_user_asm(x, addr, err, instr)			\
 	__asm__ __volatile__(					\
-	"1:	" TUSER(instr) " %1, [%2], #0\n"		\
+	"1:	" instr " %1, [%2], #0\n"			\
 	"2:\n"							\
 	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
@@ -348,40 +349,38 @@ do {									\
 	: "r" (addr), "i" (-EFAULT)				\
 	: "cc")
 
-#define __get_user_asm_byte(x, addr, err)			\
-	__get_user_asm(x, addr, err, ldrb)
+#define __get_user_asm_byte(x, addr, err, __t)			\
+	__get_user_asm(x, addr, err, "ldrb" __t)
 
 #if __LINUX_ARM_ARCH__ >= 6
 
-#define __get_user_asm_half(x, addr, err)			\
-	__get_user_asm(x, addr, err, ldrh)
+#define __get_user_asm_half(x, addr, err, __t)			\
+	__get_user_asm(x, addr, err, "ldrh" __t)
 
 #else
 
 #ifndef __ARMEB__
-#define __get_user_asm_half(x, __gu_addr, err)			\
+#define __get_user_asm_half(x, __gu_addr, err, __t)		\
 ({								\
 	unsigned long __b1, __b2;				\
-	__get_user_asm_byte(__b1, __gu_addr, err);		\
-	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
+	__get_user_asm_byte(__b1, __gu_addr, err, __t);		\
+	__get_user_asm_byte(__b2, __gu_addr + 1, err, __t);	\
 	(x) = __b1 | (__b2 << 8);				\
 })
 #else
-#define __get_user_asm_half(x, __gu_addr, err)			\
+#define __get_user_asm_half(x, __gu_addr, err, __t)		\
 ({								\
 	unsigned long __b1, __b2;				\
-	__get_user_asm_byte(__b1, __gu_addr, err);		\
-	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
+	__get_user_asm_byte(__b1, __gu_addr, err, __t);		\
+	__get_user_asm_byte(__b2, __gu_addr + 1, err, __t);	\
 	(x) = (__b1 << 8) | __b2;				\
 })
 #endif
 
 #endif /* __LINUX_ARM_ARCH__ >= 6 */
 
-#define __get_user_asm_word(x, addr, err)			\
-	__get_user_asm(x, addr, err, ldr)
-#endif
-
+#define __get_user_asm_word(x, addr, err, __t)			\
+	__get_user_asm(x, addr, err, "ldr" __t)
 
 #define __put_user_switch(x, ptr, __err, __fn)				\
 	do {								\
@@ -425,7 +424,7 @@ do {									\
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
-		__put_user_nocheck_##__size(x, __pu_addr, __err);	\
+		__put_user_nocheck_##__size(x, __pu_addr, __err, TUSER());\
 	} while (0)
 
 #define __put_user_nocheck_1 __put_user_asm_byte
@@ -433,9 +432,11 @@ do {									\
 #define __put_user_nocheck_4 __put_user_asm_word
 #define __put_user_nocheck_8 __put_user_asm_dword
 
+#endif /* !CONFIG_CPU_SPECTRE */
+
 #define __put_user_asm(x, __pu_addr, err, instr)		\
 	__asm__ __volatile__(					\
-	"1:	" TUSER(instr) " %1, [%2], #0\n"		\
+	"1:	" instr " %1, [%2], #0\n"		\
 	"2:\n"							\
 	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
@@ -450,36 +451,36 @@ do {									\
 	: "r" (x), "r" (__pu_addr), "i" (-EFAULT)		\
 	: "cc")
 
-#define __put_user_asm_byte(x, __pu_addr, err)			\
-	__put_user_asm(x, __pu_addr, err, strb)
+#define __put_user_asm_byte(x, __pu_addr, err, __t)		\
+	__put_user_asm(x, __pu_addr, err, "strb" __t)
 
 #if __LINUX_ARM_ARCH__ >= 6
 
-#define __put_user_asm_half(x, __pu_addr, err)			\
-	__put_user_asm(x, __pu_addr, err, strh)
+#define __put_user_asm_half(x, __pu_addr, err, __t)		\
+	__put_user_asm(x, __pu_addr, err, "strh" __t)
 
 #else
 
 #ifndef __ARMEB__
-#define __put_user_asm_half(x, __pu_addr, err)			\
+#define __put_user_asm_half(x, __pu_addr, err, __t)		\
 ({								\
 	unsigned long __temp = (__force unsigned long)(x);	\
-	__put_user_asm_byte(__temp, __pu_addr, err);		\
-	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err);	\
+	__put_user_asm_byte(__temp, __pu_addr, err, __t);	\
+	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err, __t);\
 })
 #else
-#define __put_user_asm_half(x, __pu_addr, err)			\
+#define __put_user_asm_half(x, __pu_addr, err, __t)		\
 ({								\
 	unsigned long __temp = (__force unsigned long)(x);	\
-	__put_user_asm_byte(__temp >> 8, __pu_addr, err);	\
-	__put_user_asm_byte(__temp, __pu_addr + 1, err);	\
+	__put_user_asm_byte(__temp >> 8, __pu_addr, err, __t);	\
+	__put_user_asm_byte(__temp, __pu_addr + 1, err, __t);	\
 })
 #endif
 
 #endif /* __LINUX_ARM_ARCH__ >= 6 */
 
-#define __put_user_asm_word(x, __pu_addr, err)			\
-	__put_user_asm(x, __pu_addr, err, str)
+#define __put_user_asm_word(x, __pu_addr, err, __t)		\
+	__put_user_asm(x, __pu_addr, err, "str" __t)
 
 #ifndef __ARMEB__
 #define	__reg_oper0	"%R2"
@@ -489,12 +490,12 @@ do {									\
 #define	__reg_oper1	"%R2"
 #endif
 
-#define __put_user_asm_dword(x, __pu_addr, err)			\
+#define __put_user_asm_dword(x, __pu_addr, err, __t)		\
 	__asm__ __volatile__(					\
- ARM(	"1:	" TUSER(str) "	" __reg_oper1 ", [%1], #4\n"	) \
- ARM(	"2:	" TUSER(str) "	" __reg_oper0 ", [%1]\n"	) \
- THUMB(	"1:	" TUSER(str) "	" __reg_oper1 ", [%1]\n"	) \
- THUMB(	"2:	" TUSER(str) "	" __reg_oper0 ", [%1, #4]\n"	) \
+ ARM(	"1:	str" __t "	" __reg_oper1 ", [%1], #4\n"  ) \
+ ARM(	"2:	str" __t "	" __reg_oper0 ", [%1]\n"      ) \
+ THUMB(	"1:	str" __t "	" __reg_oper1 ", [%1]\n"      ) \
+ THUMB(	"2:	str" __t "	" __reg_oper0 ", [%1, #4]\n"  ) \
 	"3:\n"							\
 	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
@@ -510,7 +511,49 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
-#endif /* !CONFIG_CPU_SPECTRE */
+#define HAVE_GET_KERNEL_NOFAULT
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	const type *__pk_ptr = (src);					\
+	unsigned long __src = (unsigned long)(__pk_ptr);		\
+	type __val;							\
+	int __err = 0;							\
+	switch (sizeof(type)) {						\
+	case 1:	__get_user_asm_byte(__val, __src, __err, ""); break;	\
+	case 2: __get_user_asm_half(__val, __src, __err, ""); break;	\
+	case 4: __get_user_asm_word(__val, __src, __err, ""); break;	\
+	case 8: {							\
+		u32 *__v32 = (u32*)&__val;				\
+		__get_user_asm_word(__v32[0], __src, __err, "");	\
+		if (__err)						\
+			break;						\
+		__get_user_asm_word(__v32[1], __src+4, __err, "");	\
+		break;							\
+	}								\
+	default: __err = __get_user_bad(); break;			\
+	}								\
+	*(type *)(dst) = __val;						\
+	if (__err)							\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	const type *__pk_ptr = (dst);					\
+	unsigned long __dst = (unsigned long)__pk_ptr;			\
+	int __err = 0;							\
+	type __val = *(type *)src;					\
+	switch (sizeof(type)) {						\
+	case 1: __put_user_asm_byte(__val, __dst, __err, ""); break;	\
+	case 2:	__put_user_asm_half(__val, __dst, __err, ""); break;	\
+	case 4:	__put_user_asm_word(__val, __dst, __err, ""); break;	\
+	case 8:	__put_user_asm_dword(__val, __dst, __err, ""); break;	\
+	default: __err = __put_user_bad(); break;			\
+	}								\
+	if (__err)							\
+		goto err_label;						\
+} while (0)
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check
-- 
2.27.0

