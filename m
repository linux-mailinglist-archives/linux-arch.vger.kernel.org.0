Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09845EAEB
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 11:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346682AbhKZKEL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 05:04:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376422AbhKZKCK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Nov 2021 05:02:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74E7C61038;
        Fri, 26 Nov 2021 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637920738;
        bh=tZGY6dNlK8/AMHNAonDLG4iu1hKpaY0sGMxToT3+ww8=;
        h=From:To:Cc:Subject:Date:From;
        b=UDh+vGEdTW6y2n4FeBdt5x5NVGQEI9O3V1xrUy/z6WM4RyGpxkN4QAdRcy1KqY/eu
         kVp9g08zhj8tp+ob6f2qHbp6cSr27rFguUj8REH5DCHTw4y3w8mItndi7+mFsN8dyW
         y+Thu/GwrtPuRuyjBdZpmLM9/zqmhYoIw7r2tq4VvBa+KvKf7DPkhfz1UVixRxvDlc
         IEycN/bEFEUZL2vWTIzv0A8tU0i9Mm+7LyysYCh5GX+Vjgry5d6mzX7E33zP+0MJh1
         cAVTAzcSo1YYrTH8Wl5EPJzIM66XH61bCEbXWygB4LQQOeEiHW9a3CGKZXJuom8paH
         sxOiEXStsF8Gw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] futex: Fix sparc32/m68k/nds32 build regression
Date:   Fri, 26 Nov 2021 10:58:40 +0100
Message-Id: <20211126095852.455492-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In one of the revisions of my futex cleanup series, I botched
up a rename of some function names, breaking sparc32, m68k
and nds32:

include/asm-generic/futex.h:17:2: error: implicit declaration of function 'futex_atomic_cmpxchg_inatomic_local_generic'; did you mean 'futex_atomic_cmpxchg_inatomic_local'? [-Werror=implicit-function-declaration]

Fix the macros to point to the correct functions.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 3f2bedabb62c ("futex: Ensure futex_atomic_cmpxchg_inatomic() is present")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/futex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 30e7fa63b5df..66d6843bfd02 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -14,9 +14,9 @@
  *
  */
 #define futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval) \
-	futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newval)
+	futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval)
 #define arch_futex_atomic_op_inuser(op, oparg, oval, uaddr) \
-	arch_futex_atomic_op_inuser_local_generic(op, oparg, oval, uaddr)
+	futex_atomic_op_inuser_local(op, oparg, oval, uaddr)
 #endif /* CONFIG_SMP */
 #endif
 
-- 
2.29.2

