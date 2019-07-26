Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD376F1E
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfGZQaE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 12:30:04 -0400
Received: from foss.arm.com ([217.140.110.172]:47110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfGZQaE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 12:30:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A15152D;
        Fri, 26 Jul 2019 09:30:03 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5A603F71F;
        Fri, 26 Jul 2019 09:30:00 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org
Subject: [PATCH 1/2] mips: vdso: Fix source path
Date:   Fri, 26 Jul 2019 17:29:43 +0100
Message-Id: <20190726162944.12149-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726162944.12149-1-vincenzo.frascino@arm.com>
References: <MWHPR2201MB1277C33D971A9C8945812CFCC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
 <20190726162944.12149-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vdso library for o32 and n32 does not compile compile correctly
due to a wrong inclusion path for config-n32-o32-env.c resulting in
the error below:

cc1: fatal error: arch/mips/vdso/config-n32-o32-env.c:
No such file or dnirectory
compilation terminated.
arch/mips/vdso/Makefile:153: recipe for target
'arch/mips/vdso/vgettimeofday-o32.o' failed
make[3]: *** [arch/mips/vdso/vgettimeofday-o32.o] Error 1
scripts/Makefile.build:490: recipe for target 'arch/mips/vdso' failed

Fix the config-n32-o32-env.c inclusion path prepending the $(srctree)
variable.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index de853c6aab28..6b482ac52e61 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -40,8 +40,8 @@ CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
 # config-n32-o32-env.c prepares the environment to build a 32bit vDSO
 # library on a 64bit kernel.
 # Note: Needs to be included before than the generic library.
-CFLAGS_vgettimeofday-o32.o = -include $(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
-CFLAGS_vgettimeofday-n32.o = -include $(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
+CFLAGS_vgettimeofday-o32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
+CFLAGS_vgettimeofday-n32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
 endif
 
 CFLAGS_REMOVE_vgettimeofday.o = -pg
-- 
2.22.0

