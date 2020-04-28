Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4591BBED2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD1NQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 09:16:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44196 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgD1NQz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49BMcN4J7Jz9v0DC;
        Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tZ696ccJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UgvCY0KN0IY2; Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49BMcN3DPWz9v0D9;
        Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588079812; bh=uI9Ui2HzQEfNGrmOOyGMT9HmBbcvnao0kBvyV0cXwes=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=tZ696ccJCjTNT30zuKCU4FPtR8kT4yN4PhJDU1leZmitbqQlXkwgVvApDfOiCq647
         4/LWGWb95wycCso8i7xm1MBaoamK1r4Kn/MlJxI8Gc+579AW76fcmyfO51lG7eexTi
         xp99JTgiAqDxWq/Rd8kCGTymwik+xjNFJh0wcvt4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E07CB8B828;
        Tue, 28 Apr 2020 15:16:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UoafEZMJBl87; Tue, 28 Apr 2020 15:16:53 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A10448B82C;
        Tue, 28 Apr 2020 15:16:53 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6CD66658AD; Tue, 28 Apr 2020 13:16:53 +0000 (UTC)
Message-Id: <1ab6a62c356c3bec35d1623563ef9c636205bcda.1588079622.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 7/8] lib/vdso: force inlining of
 __cvdso_clock_gettime_common()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue, 28 Apr 2020 13:16:53 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When adding gettime64() to a 32 bit architecture (namely powerpc/32)
it has been noticed that GCC doesn't inline anymore
__cvdso_clock_gettime_common() because it is called twice
(Once by __cvdso_clock_gettime() and once by
__cvdso_clock_gettime32).

This has the effect of seriously degrading the performance:

Before the implementation of gettime64(), gettime() runs in:

	clock-gettime-monotonic-raw:    vdso: 1003 nsec/call
	clock-gettime-monotonic-coarse:    vdso: 592 nsec/call
	clock-gettime-monotonic:    vdso: 942 nsec/call

When adding a gettime64() entry point, the standard gettime()
performance is degraded by 30% to 50%:

	clock-gettime-monotonic-raw:    vdso: 1300 nsec/call
	clock-gettime-monotonic-coarse:    vdso: 900 nsec/call
	clock-gettime-monotonic:    vdso: 1232 nsec/call

Adding __always_inline() to __cvdso_clock_gettime_common()
regains the original performance.

In terms of code size, the inlining increases the code size
by only 176 bytes. This is in the noise for a kernel image.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af4b924..7938d3c4901d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -210,7 +210,7 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static __maybe_unused int
+static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
-- 
2.25.0

