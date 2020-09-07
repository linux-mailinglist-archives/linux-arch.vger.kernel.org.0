Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040DD25FD51
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgIGPmi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:42:38 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgIGPjm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:39:42 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YlB-1kHFJl1bQp-0036HK; Mon, 07 Sep 2020 17:39:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ARM: uaccess: add __{get,put}_kernel_nofault
Date:   Mon,  7 Sep 2020 17:36:49 +0200
Message-Id: <20200907153701.2981205-9-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vhDXkYrCeda2vKjbh+Q4FentVDFDq4/M0f8j1HJaMDjPUEj4biF
 FNuNnE7m3lYUDFq5lvaNHNrtQT8V8XYLhGzPF9FYnowPNRQlVPylAAG+lAQgueieM1Asuyt
 Q9a5SXuR3eLHWV1gSOoO/f3wjBFLb06myluLz8K1eFS3q7DlriOGnLeiI4NNawUZbc2UsEI
 ruys5w5wOYMPt50gtOWwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+BB7hcsMQ6E=:jaRjOuD8GncINvOH8JRBAi
 u3OzJySJHsYn6GOriinALXjomtSRM0q1Gh+QQyMzvqiwoBNMClLtQsKTEg1eM7Iwwdb87CvuG
 KDrRL2ZnUU+/Ux/q/X0CyfqcSpQ2bsN1jgkX1/7CYP/Ic2yinYOM9Po1pJTk7VGD0nKnGH9at
 3f+jpHhtpfXP19Ct5njO+tpFk3yvHFwKWlnZOPn78Ww0Il/vCMGjZqVATqyAY/hoEMmw2/Can
 lIWQAASiP+FCrYbGdX5L98AQy9eiX2/oXi7LQLkGOTuEJ4eXDyG3W2F8RH/F8+Uix00V2fXlg
 U7hSwTNcqDoObnPNoQ3q0mYL3cg58eg1MZbyfG0YLwfZPQWD0YBxwaqIcXEFfz2UtHm8E7Mc/
 zcMOmIRSatZufj+w1Jzdnmrw5hkzoZKIDyrfABG0E5BFqdVW2YVLWYUZzvOEvrQw9B5LGSzAG
 he6RSaUv6ZRS/0SFRK2SE7U3GfnVhvLExBj5XeSKUWxs4Xpnwf+fL40nkvp/Rl5y8QgLdLxa0
 Le6u/nxmAoywdCoAIm8Z8ggEwf3x0Cen32CqSs0yFtI58rKFyb9UFUYka1/2A9NOoq+culPFj
 Va1JHpLFqlr+5BQJ0gZ1tTfPrwsu1AAC3j7kgqzEzK+c8vGnlZd1IomcZpsaUsOjC3E1Br1h9
 jfBcOFdfb2vWahrW5wRdJQ3fV8n/JVdT2oJPtdwwZxNqiSTTT6PrZe4UsUG6lXiAUuCYdQfvs
 +v3f4On/g3MxyrvtcpWu1+FJToB2CyJ1vI1BSbmHIVCSvMEZhRPGb5uC6DVSGx4pD+I4LzQGh
 OXqFmdW+23srClJx/QQdiMtPod6uJ47by6i9gMGEdMIehsPABuSJDyNyaBp8x/bB4lG4dyX
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

