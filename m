Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307D919D11D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbgDCHVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 03:21:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51428 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388959AbgDCHU5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 03:20:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48trvB2YTHz9vBLG;
        Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=GMUrKh2o; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YMD51g-Nr5Lu; Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48trvB0d7Pz9vBL8;
        Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585898454; bh=1wQkVsA7Zi109u9F0OAxJ5QFzUWbk9wgy/mhAUiF5cc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=GMUrKh2oqJNY/r/c7zo6ckS6nC/w1kebTVDqi58KhTQo6228A1mrJ7boPNoFcbnez
         GVSc9bOfWNKoIzZ7GHeBknKgAxehWQYkgBCnv+3ukOVXOqhdlBYPy+gzgQN3NFq70+
         oQuifIUyFAwq3EBkFNOM6QU7cdwCFx3yFUl6fCcE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8F9B8B944;
        Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PtNMU07A4GNu; Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 757E98B943;
        Fri,  3 Apr 2020 09:20:54 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4B84565700; Fri,  3 Apr 2020 07:20:54 +0000 (UTC)
Message-Id: <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
In-Reply-To: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to
 user_full_access_begin/end()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Date:   Fri,  3 Apr 2020 07:20:54 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now we have user_read_access_begin() and user_write_access_begin()
in addition to user_access_begin().

Make it explicit that user_access_begin() provides both read and
write by renaming it user_full_access_begin(). And the same for
user_access_end() which becomes user_full_access_end().

Done with following command, then hand splitted two too long lines.

sed -i s/user_access_begin/user_full_access_begin/g `git grep -l user_access_begin`

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: New, based on remark from Al Viro.
---
 arch/powerpc/include/asm/uaccess.h | 5 +++--
 arch/x86/include/asm/futex.h       | 4 ++--
 arch/x86/include/asm/uaccess.h     | 7 ++++---
 include/linux/uaccess.h            | 8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4427d419eb1d..7fe799e081f2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -456,14 +456,15 @@ extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 			   size_t len);
 
-static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check inline bool
+user_full_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
 		return false;
 	allow_read_write_user((void __user *)ptr, ptr, len);
 	return true;
 }
-#define user_access_begin	user_access_begin
+#define user_full_access_begin	user_full_access_begin
 #define user_access_end		prevent_current_access_user
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index f9c00110a69a..9eefea374bd4 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -56,7 +56,7 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_full_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
@@ -92,7 +92,7 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	int ret = 0;
 
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_full_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d8f283b9a569..8776e815f215 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -473,16 +473,17 @@ extern struct movsl_mask {
  * The "unsafe" user accesses aren't really "unsafe", but the naming
  * is a big fat warning: you have to not only do the access_ok()
  * checking before using them, but you have to surround them with the
- * user_access_begin/end() pair.
+ * user_full_access_begin/end() pair.
  */
-static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline bool
+user_full_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
 	__uaccess_begin_nospec();
 	return 1;
 }
-#define user_access_begin(a,b)	user_access_begin(a,b)
+#define user_full_access_begin(a,b)	user_full_access_begin(a,b)
 #define user_access_end()	__uaccess_end()
 
 #define user_access_save()	smap_save()
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 9861c89f93be..5be9bc930342 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -368,8 +368,8 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
-#ifndef user_access_begin
-#define user_access_begin(ptr,len) access_ok(ptr, len)
+#ifndef user_full_access_begin
+#define user_full_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
@@ -379,11 +379,11 @@ static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
 #ifndef user_write_access_begin
-#define user_write_access_begin user_access_begin
+#define user_write_access_begin user_full_access_begin
 #define user_write_access_end user_access_end
 #endif
 #ifndef user_read_access_begin
-#define user_read_access_begin user_access_begin
+#define user_read_access_begin user_full_access_begin
 #define user_read_access_end user_access_end
 #endif
 
-- 
2.25.0

