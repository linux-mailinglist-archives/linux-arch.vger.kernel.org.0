Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27297646B3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfGJNCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 09:02:47 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJNCq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 09:02:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfqGN-1iQbak3EYz-00gD3I; Wed, 10 Jul 2019 15:02:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] vsyscall: use __iter_div_u64_rem()
Date:   Wed, 10 Jul 2019 15:01:53 +0200
Message-Id: <20190710130206.1670830-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VYafebV/Q7CLTnWZ3vcfCq05iJn/NVcnt1G0HsD21yoEzIkoekE
 GowoTPqBzup5f7V7xMLaEhy9kYVbaCnEXVORNGnVIa8I2H78SDiMxn8HQmhjaxAcq4M75O3
 n1F8e1rj/DWTM3EUk68i9Xc0Ao0x514ZBgN+xP1ILeAPJqVS+IE7IlGj8Aqn56bIoG9A/Xg
 UepIr9PkVYqdrblAse6ww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JDc5rbPPiV4=:XAvQ8JJ5XLRK8GSkrUMuz/
 HWUwAcw/PhALur/u6/ttxc3cm9gdCqtsTNP52XyBncxE2HOTgoKvR3otYj/sts/ORoquxdGsz
 BxR0NKAzNwmYughjAVvXKClqjgD9SEX8zpODX2NZzeOWv5JayFghv5E6qGgaoqyGUzUp2zsL3
 AFfZQWAAKs9U8Doq+EnhblZnFZbJYXw8DnzdtvE0+a0EI+0oJvQPPU6CQqkYAjNkYiDj8QDQX
 GPT2vGHj479BaPHnNRIyBq+aXw6GOQ70W/+rZFZqFpbNf7bjKtYCMBl6OTswrpqXDQp+/coNl
 BZopxI79m2Xxes8/GmUJYF4p8qmEYfePM39/G1O/ErJ5kzOaAOjI8gw4OiuEwN1z53/Fu09dN
 nH48rqsKfJVRCo3Fh0FlcWNbVVn23+3YoQOKj8/hkTeZD7tbcwbAEEniEIIFFeKeY6ZHmFkmm
 UGmKiaWSa2GilVF0BbvBv/m3EQ9PF61lukpTnI2cpAaXzUdFAOciz6he839Bk8PRkm/Gg4LgQ
 fL+LlDYge+e1k0KnTuY/I5ckYX8WuOZHZtN87AgdBPO9qsV8jeh6AjhErOfyeMSU0hUhP0KuZ
 DJ4x+nwBH3akGdENlotFLEuh8ogcq2IIk+eB9ge4Krbd/CjIhHt2VKGP7uZEuQR1Qv0qwqMTP
 kkZ6QFe/kMFjoAGKoKyw75KK4IjiMwWixw0j5uI706+1CfzNH3T3rEvOMoYcU4flZYNW+Ztej
 tMj9T/hBrnPCeLPBBi8Mb8K0S8H8UPmwftlyZA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 32-bit x86 when building with clang-9, the loop gets turned back into
an inefficient division that causes a link error:

kernel/time/vsyscall.o: In function `update_vsyscall':
vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'

Use the provided __iter_div_u64_rem() function that is meant to address
the same case in other files.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/vsyscall.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index a80893180826..8cf3596a4ce6 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec = nsec - NSEC_PER_SEC;
-		vdso_ts->sec++;
-	}
-	vdso_ts->nsec	= nsec;
+	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
 	if (__arch_use_vsyscall(vdata))
 		update_vdso_data(vdata, tk);
-- 
2.20.0

