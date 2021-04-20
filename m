Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A724365A51
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhDTNij (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 09:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhDTNib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Apr 2021 09:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C162A613B2;
        Tue, 20 Apr 2021 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618925880;
        bh=VFw9ONtxEh8n9vqM/Or+LuOw1+hn0em8H5ATOgbnS+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlmJ9oUnOaUG0SKy86JB8b13UBIIrh1HY/j/mviNQgtGUxvEbLNvz8lRSWXfDJ55M
         jWVxrSXIah/JpxNM/O7Uz71jcVqyM7i/4c4O3k/m2Oom8Sc/3vvFehmKzLGMnV+q/m
         rYeKXk5y8J3VEaavpJw1kV31DypinrMAPUWQhazQ/h8N/QlGzM9x1uu4GWwsLZ/Wcr
         kdQVDSFpznwem3nzBQBz5pCowdRrrshTnwnAZgngera/PHMh21+EmZ/Nw5Q4c658bu
         MttwyRAOghh1R/loUHqtxD21C3bZMkZrKGN4NG0NTD64ltZGK6W10mO4/ZTfka2fxs
         JNoOhPla7dT+Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/3] riscv: Cleanup deprecated function strlen_user
Date:   Tue, 20 Apr 2021 13:37:09 +0000
Message-Id: <1618925829-90071-3-git-send-email-guoren@kernel.org>
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
 arch/riscv/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 824b2c9..4297f43 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -372,7 +372,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
-extern long __must_check strlen_user(const char __user *str);
 extern long __must_check strnlen_user(const char __user *str, long n);
 
 extern
-- 
2.7.4

