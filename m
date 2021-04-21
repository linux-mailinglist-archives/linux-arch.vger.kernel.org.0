Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425EA366780
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhDUJG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 05:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhDUJG2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98C0460BBB;
        Wed, 21 Apr 2021 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618995956;
        bh=1rD31JwPHch2tFBsYzB01NfYY1/f2nxyVqYPhVqfr38=;
        h=From:To:Cc:Subject:Date:From;
        b=Cka7YmHhBYg2CS342tjfOGEizj4JvEKputokhkK0jsTVIdjmUO1BXJkelOB8wBr7g
         MON3ZIDYj1zAs8Lklty073S1MS9y089ArRr1/VAfXUl3veYVVvcdIXwHZHNj/un7JW
         vu5EDGtnl1yFI1yh086f9QHDXjSshYidB0YpWxnruTVyDvvaTck1lhzW1zZmpoYi4b
         XuH/eGFk/IUkSvQXiRJhREiOjXm+CJVn8e3ZfIy/AYXebIRXAUSSOZuMtcDkNVRm1S
         nZDFXjqGpPouNYQIHApeSwQdJSxXmQGtjzfmboKg7UXpvYpuoSXaEpBE990PP0kxRr
         06hLg6K2aRACw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] asm-generic: uaccess.h: Fixup GENERIC_STRNCPY_FROM_USER & STRNLEN_USER
Date:   Wed, 21 Apr 2021 09:04:53 +0000
Message-Id: <1618995893-92100-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When arch include asm-generic/uaccess.h and enable GENERIC
STRNCPY_FROM_USER / STRNLEN_USER. Then, compile error.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 4973328..c02080d 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -243,6 +243,9 @@ static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
 
 extern int __get_user_bad(void) __attribute__((noreturn));
 
+#ifdef CONFIG_GENERIC_STRNCPY_FROM_USER
+long strncpy_from_user(char *dst, const char __user *src, long count);
+#else
 /*
  * Copy a null terminated string from userspace.
  */
@@ -265,7 +268,11 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#endif /* CONFIG_GENERIC_STRNCPY_FROM_USER */
 
+#ifdef CONFIG_GENERIC_STRNLEN_USER
+long strnlen_user(const char __user *src, long n);
+#else
 /*
  * Return the size of a string (including the ending 0)
  *
@@ -286,6 +293,7 @@ static inline long strnlen_user(const char __user *src, long n)
 		return 0;
 	return __strnlen_user(src, n);
 }
+#endif /* CONFIG_GENERIC_STRNLEN_USER */
 
 /*
  * Zero Userspace
-- 
2.7.4

