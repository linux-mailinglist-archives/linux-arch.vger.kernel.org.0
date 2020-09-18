Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CA26FE60
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIRNZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 09:25:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRNZ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 09:25:29 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbC5g-1kuX4n2mK0-00bcmg; Fri, 18 Sep 2020 15:24:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
Date:   Fri, 18 Sep 2020 15:24:36 +0200
Message-Id: <20200918132439.1475479-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918132439.1475479-1-arnd@arndb.de>
References: <20200918132439.1475479-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YLB1Wku+uI0QYaSVbIU1rhwVZJ1zWa6Cu2ogMBGddA2kPGDffCO
 jG3htzBFq0C6TjASadbyF/2hpq28FzthYWwfMrWieZOMY2geD7uj5WI49eJGdNoAx2B1kCY
 n1h7WSvGhAbxUmuSs4zJzetfcvLm2trJQ3M1EaUvIHa4mAvw4wTFN6k3MMGj9ClVYQkwNrB
 OZ7BT5PlJbvq8DBE4b1sQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJPklbJZCUI=:jx9D1LRgLXmfjvqKbWS7Hn
 uEhEs8itMQPJB9RFbdhVEjSueeLctG3mfSCsxn/H9tMmIbexWMaVctJVC6k+SHeXxH3NVjADe
 BNzv37Frm+/QEk/mM3ye/Lc6nbjylCY2AoXDPCRNj3K1Gkdp6RzM7lQXBRx5DmKmhsdCn3Av3
 RhrknkF6SyaMDvzv9YaEwP2X3HMzx1qOgrKONxEes1JLxolY2t/Ovo7mCePIcA4nIkjYBJRFi
 zV1aNkpW0UR2OYQges8ADGPzrxVLiCYs2VJXW+i4zkCrHUlps7Aga0luIZhvC0EuKdBhOqgqY
 SRjlUl130DilSxWc36HZIjfMbvBoOr7AP2VtX9UGfZy7Q/3d//MCVJdcLVtLzhBHMBBCK/pxT
 b9oRJXoTjfFixzpPRn9+XuhxwVmy5HqChKsAKHKM8Ko/K+C4xI2SircsujKjYY/WTZNKiWSmn
 pGKOgt9XnmL4zCgYojIawSJp6WS0vn9JPaBPljuhXT7g4QQaWzXttIWfiDb9rRva8PJquSjXq
 drNMp3gQgL+CSZRElW8tLSpG1po+xJ96O3cjOQe0L8qU77JzlKUgqSbDrSY+4wcwwnp+neleX
 FvHEwnIfBvirSdZK4s82Q4MNDOGqLMP2vLH0M8Bf+xlL3eEGtEqjeR7rPaP4jDUaDA+P9svtS
 mL7KJgkds0O/ic4DL46WTzDXSldhyN+VfHvYQxWrAqB3ud7/zVJ3X/E4TISyK5t7U4NPXCF/H
 4SnidnLPA5k9qGnC6NjfNMC3I6wEE3tP+jO+c8jsZ9WTTQ5ROx8CsRdJN0xjTr8PPekEfL+/U
 /mMwAlj8qnwg3TrzzZcju1TPrbsLGw7I7i7TuDaULP7F4eu2UbKPuayrR9OnpBCA4D1K9dx
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

sys_move_pages() is an optional syscall, and once we remove
the compat version of it in favor of the native one with an
in_compat_syscall() check, the x32 syscall table refers to
a __x32_sys_move_pages symbol that may not exist when the
syscall is disabled.

Change the COND_SYSCALL() definition on x86 to also include
the redirection for x32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/syscall_wrapper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..5eacd35a7f97 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -171,12 +171,16 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, sys_##name)
+
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x32, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
+#define __X32_COND_SYSCALL(name)
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
@@ -253,6 +257,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	static long __do_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
+	__X32_COND_SYSCALL(name)					\
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-- 
2.27.0

