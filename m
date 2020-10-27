Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1276029A6FE
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 09:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895106AbgJ0Iwp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 04:52:45 -0400
Received: from casper.infradead.org ([90.155.50.34]:34970 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895105AbgJ0Iwo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 04:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Aakq5ONajagRQRWUZGCHnMSkynNLLZQ4DCSJugWWUH0=; b=KVvc9euKLp49L1tVLI9ZMxp2Wz
        biMq3A2nuCumBvuYlInpMqo5NWa7xCVsMUhrpANCh6VA5CJ0cnJw/WkERnXhDqnefnWKbWuRRUPnl
        nalwnOxRxJ43N4GEUIuh9mekPijAFin6CBxZUmlYx97sL2Y8g6AJfYS6ifvnjLAQRZNnsX1Yshh+i
        VU9HassfXOpSVmxOCYd2ERk2Xqu1yK3S1Qud85PsS6FvYCL1/Q3MPE8bkuBbBPfRl3bw9JZM5h1gp
        JT8mCtLu1uwhWF3gN6PKBn/a4oeWlq9nhs3gKQ7+eCZi+nGWL+ehFT9BNSwnjvqnAApByr2IINZz+
        Km8bzm2g==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXKiV-0003bR-Hq; Tue, 27 Oct 2020 08:52:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     arnd@arndb.de
Cc:     palmerdabbelt@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] asm-generic: mark __{get,put}_user_fn as __always_inline
Date:   Tue, 27 Oct 2020 09:50:17 +0100
Message-Id: <20201027085017.3705228-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Without the explicit __always_inline, some RISC-V configs place the
functions out of line, triggering the BUILD_BUG_ON checks in the
function.

Fixes: 11129e8ed4d9 ("riscv: use memcpy based uaccess for nommu again")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 45f9872fd74759..4973328f3c6e75 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -12,7 +12,8 @@
 #ifdef CONFIG_UACCESS_MEMCPY
 #include <asm/unaligned.h>
 
-static inline int __get_user_fn(size_t size, const void __user *from, void *to)
+static __always_inline int
+__get_user_fn(size_t size, const void __user *from, void *to)
 {
 	BUILD_BUG_ON(!__builtin_constant_p(size));
 
@@ -37,7 +38,8 @@ static inline int __get_user_fn(size_t size, const void __user *from, void *to)
 }
 #define __get_user_fn(sz, u, k)	__get_user_fn(sz, u, k)
 
-static inline int __put_user_fn(size_t size, void __user *to, void *from)
+static __always_inline int
+__put_user_fn(size_t size, void __user *to, void *from)
 {
 	BUILD_BUG_ON(!__builtin_constant_p(size));
 
-- 
2.28.0

