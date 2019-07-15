Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8068708
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfGOK10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 06:27:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:55870 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfGOK10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jul 2019 06:27:26 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hmyCS-0000zj-Bu; Mon, 15 Jul 2019 13:27:16 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
Date:   Mon, 15 Jul 2019 13:27:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Access to 'op' variable does not require pagefault_disable(),
'ret' variable should be initialized before using,
'oldval' variable can be replaced by constant.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/asm-generic/futex.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 8666fe7f35d7..e9a9655d786d 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -118,9 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret;
-
-	pagefault_disable();
+	int ret = 0;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -132,10 +130,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
-		*oval = oldval;
+		*oval = 0;
 
 	return ret;
 }
-- 
2.17.1

