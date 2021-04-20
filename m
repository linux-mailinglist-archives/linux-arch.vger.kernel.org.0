Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1D365A4E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhDTNib (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 09:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232611AbhDTNi3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Apr 2021 09:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEC3161264;
        Tue, 20 Apr 2021 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618925878;
        bh=O9z7efZKEjE4x4pfxgdpmovrUqTVtXeSt4LE2x0L458=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWIY+sGZ5nyAwM8GWk0ey+jjoUR/nt8JI1rzXETzBGmjEGW8sIyCW+5DU6Bl7w7Gn
         T6IlsOnDVECBr3qcGhdPsRhWNljUrCoXVSzXG/pLnmjtHgTllLqQ1QpM3jUj7tgbSQ
         WdJY5UhyJX2T9g/ywtzOaQRPqaWVx+wEiADN7HKxvQkYIOL/Ps+dYYEL1I8EOPDwVW
         kQRFFuGbJJzz5LQhcvXsHj1NuyHrpwn7MuGi/mcWRCPTUXjppcnoomyOrNA9dUXAwv
         +BMIK2wUqyLWLkxkv4g9gr+7z8epYRNluujk8v0q4lZxr3ykjAWi0r8f3hx5o2Qtaf
         AZSeI+5FcvPfQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] nios2: Cleanup deprecated function strlen_user
Date:   Tue, 20 Apr 2021 13:37:08 +0000
Message-Id: <1618925829-90071-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618925829-90071-1-git-send-email-guoren@kernel.org>
References: <1618925829-90071-1-git-send-email-guoren@kernel.org>
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
 arch/nios2/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index a741abb..ba9340e 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -83,7 +83,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 
 extern long strncpy_from_user(char *__to, const char __user *__from,
 			      long __len);
-extern __must_check long strlen_user(const char __user *str);
 extern __must_check long strnlen_user(const char __user *s, long n);
 
 /* Optimized macros */
-- 
2.7.4

