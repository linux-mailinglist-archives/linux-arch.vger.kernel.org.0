Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F3341B15
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSLHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 07:07:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11281 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhCSLGz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LN3rcpz9tx8x;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vgoaZZS2DZvn; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LN2vq6z9tx8v;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A2E08B977;
        Fri, 19 Mar 2021 12:06:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id txeP4JywZ2j8; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 399798B974;
        Fri, 19 Mar 2021 12:06:51 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A6175675FF; Fri, 19 Mar 2021 11:06:50 +0000 (UTC)
Message-Id: <b05bf434ee13c76bc9df5f02653a10db5e7b54e5.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 01/10] signal: Add unsafe_get_compat_sigset()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Fri, 19 Mar 2021 11:06:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the same way as commit 14026b94ccfe ("signal: Add
unsafe_put_compat_sigset()"), this time add
unsafe_get_compat_sigset() macro which is the 'unsafe'
version of get_compat_sigset()

For the bigendian, use unsafe_get_user() directly
to avoid intermediate copy through the stack.

For the littleendian, use a straight unsafe_copy_from_user().

This commit adds the generic fallback for unsafe_copy_from_user().
Architectures wanting to use unsafe_get_compat_sigset() have to
make sure they have their own unsafe_copy_from_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/compat.h  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/uaccess.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..5112c3e35782 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -465,6 +465,34 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 		unsafe_put_user(__s->sig[0], &__c->sig[0], label);	\
 	}								\
 } while (0)
+
+#define unsafe_get_compat_sigset(set, compat, label) do {		\
+	const compat_sigset_t __user *__c = compat;			\
+	compat_sigset_word hi, lo;					\
+	sigset_t *__s = set;						\
+									\
+	switch (_NSIG_WORDS) {						\
+	case 4:								\
+		unsafe_get_user(lo, &__c->sig[7], label);		\
+		unsafe_get_user(hi, &__c->sig[6], label);		\
+		__s->sig[3] = hi | (((long)lo) << 32);			\
+		fallthrough;						\
+	case 3:								\
+		unsafe_get_user(lo, &__c->sig[5], label);		\
+		unsafe_get_user(hi, &__c->sig[4], label);		\
+		__s->sig[2] = hi | (((long)lo) << 32);			\
+		fallthrough;						\
+	case 2:								\
+		unsafe_get_user(lo, &__c->sig[3], label);		\
+		unsafe_get_user(hi, &__c->sig[2], label);		\
+		__s->sig[1] = hi | (((long)lo) << 32);			\
+		fallthrough;						\
+	case 1:								\
+		unsafe_get_user(lo, &__c->sig[1], label);		\
+		unsafe_get_user(hi, &__c->sig[0], label);		\
+		__s->sig[0] = hi | (((long)lo) << 32);			\
+	}								\
+} while (0)
 #else
 #define unsafe_put_compat_sigset(compat, set, label) do {		\
 	compat_sigset_t __user *__c = compat;				\
@@ -472,6 +500,13 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 									\
 	unsafe_copy_to_user(__c, __s, sizeof(*__c), label);		\
 } while (0)
+
+#define unsafe_get_compat_sigset(set, compat, label) do {		\
+	const compat_sigset_t __user *__c = compat;			\
+	sigset_t *__s = set;						\
+									\
+	unsafe_copy_from_user(__s, __c, sizeof(*__c), label);		\
+} while (0)
 #endif
 
 extern int compat_ptrace_request(struct task_struct *child,
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index c7c6e8b8344d..c05e903cef02 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -397,6 +397,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
 #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
+#define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
-- 
2.25.0

