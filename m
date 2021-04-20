Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5F365A4B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhDTNi2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 09:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhDTNi1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Apr 2021 09:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A69B6113C;
        Tue, 20 Apr 2021 13:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618925876;
        bh=UlQ0FBFsDr4ODbTFSXPy69eUKK+0YYAXdTX//RlJ41c=;
        h=From:To:Cc:Subject:Date:From;
        b=gwcM3ibBCh9KFA73MXiOekuiNcAJLtZFiZqnuCXM7m/SyRz+JvbVUSiWpYeNJshRx
         mMTv9sF1eGfonecI2ub7KcXqAf1i+YfE/PZI449ys8zG2iJPTDNlJ0t83r1gZKts4h
         pQwbO+lfQbMqlpnEmIgYdV6+mAXfy+OwGidHNLEMRnRE+d2xs256/wkv8UC0ZKFyPz
         ENxdYXUxv60+kDtUYWI+iG5X2qSsZOMh3Kav9VrIShcO6eAGScREe9mUZ5Tcpl5yYh
         AmvpRlar+6k/ahU6qWU9yQv3tDAElujPXLqogCxCOeklmel/0z/kV2qs3L14daZHnY
         nrgwPUPsELP0A==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/3] nds32: Cleanup deprecated function strlen_user
Date:   Tue, 20 Apr 2021 13:37:07 +0000
Message-Id: <1618925829-90071-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

$ grep strlen_user * -r
arch/csky/include/asm/uaccess.h:#define strlen_user(str) strnlen_user(str, 32767)
arch/csky/lib/usercopy.c: * strlen_user: - Get the size of a string in user space.
arch/ia64/lib/strlen.S: // Please note that in the case of strlen() as opposed to strlen_user()
arch/mips/lib/strnlen_user.S: *  make strlen_user and strnlen_user access the first few KSEG0
arch/nds32/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user * str);
arch/nios2/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user *str);
arch/riscv/include/asm/uaccess.h:extern long __must_check strlen_user(const char __user *str);
kernel/trace/trace_probe_tmpl.h:static nokprobe_inline int fetch_store_strlen_user(unsigned long addr);
kernel/trace/trace_probe_tmpl.h:                        ret += fetch_store_strlen_user(val + code->offset);
kernel/trace/trace_uprobe.c:fetch_store_strlen_user(unsigned long addr)
kernel/trace/trace_kprobe.c:fetch_store_strlen_user(unsigned long addr)
kernel/trace/trace_kprobe.c:            return fetch_store_strlen_user(addr);

See grep result, nobody uses it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 010ba5f..d4cbf06 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -260,7 +260,6 @@ do {									\
 
 extern unsigned long __arch_clear_user(void __user * addr, unsigned long n);
 extern long strncpy_from_user(char *dest, const char __user * src, long count);
-extern __must_check long strlen_user(const char __user * str);
 extern __must_check long strnlen_user(const char __user * str, long n);
 extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
                                            unsigned long n);
-- 
2.7.4

