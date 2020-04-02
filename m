Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF84B19BCC6
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgDBHe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 03:34:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23971 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387585AbgDBHeW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 03:34:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48tFF71dHqz9txL4;
        Thu,  2 Apr 2020 09:34:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dH316VTH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cB3Z9uspnlX0; Thu,  2 Apr 2020 09:34:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48tFF70Y5dz9txKx;
        Thu,  2 Apr 2020 09:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585812859; bh=IXjiKlijLtzQuR/CNi0kS3j7+7PM/7fqUO8AWUmnzeg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dH316VTHpWXN0YwLXZ5i4UWGULcgudGp9mJnek1fhSl0Y/HsAU4fG8J2L9yvSuQ6J
         LtfleDEeqfOjrsgHyJgx32CxRiKk0g0FuYneuZ2HGj96JA8ujXYKOc3/PbwHswqtXy
         RHm7GnY1kAbKArKT/1gngRh5Jt3O3QfObjlI9G8U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 06BA88B76E;
        Thu,  2 Apr 2020 09:34:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CME2grp4VRse; Thu,  2 Apr 2020 09:34:19 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E8318B75E;
        Thu,  2 Apr 2020 09:34:19 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6E5E8656BF; Thu,  2 Apr 2020 07:34:19 +0000 (UTC)
Message-Id: <ebcf8256e02a7dffb292f3d800e264dce263cac5.1585811416.git.christophe.leroy@c-s.fr>
In-Reply-To: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND 4/4] powerpc/uaccess: Implement user_read_access_begin and
 user_write_access_begin
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Date:   Thu,  2 Apr 2020 07:34:19 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for selective read or write user access with
user_read_access_begin/end and user_write_access_begin/end.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  4 ++--
 arch/powerpc/include/asm/kup.h           | 14 +++++++++++++-
 arch/powerpc/include/asm/uaccess.h       | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c0ba22dc360..1617e73bee30 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -108,7 +108,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 	u32 addr, end;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	BUILD_BUG_ON(dir == KUAP_CURRENT);
+	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
 
 	if (!(dir & KUAP_WRITE))
 		return;
@@ -131,7 +131,7 @@ static __always_inline void prevent_user_access(void __user *to, const void __us
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
 
-	if (dir == KUAP_CURRENT) {
+	if (dir & KUAP_CURRENT_WRITE) {
 		u32 kuap = current->thread.kuap;
 
 		if (unlikely(!kuap))
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 92bcd1a26d73..c745ee41ad66 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -10,7 +10,9 @@
  * Use the current saved situation instead of the to/from/size params.
  * Used on book3s/32
  */
-#define KUAP_CURRENT	4
+#define KUAP_CURRENT_READ	4
+#define KUAP_CURRENT_WRITE	8
+#define KUAP_CURRENT		(KUAP_CURRENT_READ | KUAP_CURRENT_WRITE)
 
 #ifdef CONFIG_PPC64
 #include <asm/book3s/64/kup-radix.h>
@@ -101,6 +103,16 @@ static inline void prevent_current_access_user(void)
 	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
 }
 
+static inline void prevent_current_read_from_user(void)
+{
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
+}
+
+static inline void prevent_current_write_to_user(void)
+{
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_KUAP_H_ */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2f500debae21..4427d419eb1d 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -468,6 +468,28 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
 
+static __must_check inline bool
+user_read_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+	allow_read_from_user(ptr, len);
+	return true;
+}
+#define user_read_access_begin	user_read_access_begin
+#define user_read_access_end		prevent_current_read_from_user
+
+static __must_check inline bool
+user_write_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+	allow_write_to_user((void __user *)ptr, len);
+	return true;
+}
+#define user_write_access_begin	user_write_access_begin
+#define user_write_access_end		prevent_current_write_to_user
+
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
 #define unsafe_put_user(x, p, e) unsafe_op_wrap(__put_user_allowed(x, p), e)
-- 
2.25.0

