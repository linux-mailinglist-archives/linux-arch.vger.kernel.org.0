Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE934646B9
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfGJNFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 09:05:09 -0400
Received: from foss.arm.com ([217.140.110.172]:32982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJNFJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 09:05:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5893A2B;
        Wed, 10 Jul 2019 06:05:08 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846A43F738;
        Wed, 10 Jul 2019 06:05:05 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        john.stultz@linaro.org
Subject: [PATCH] arm64: vdso: Fix ABI regression in compat vdso
Date:   Wed, 10 Jul 2019 14:04:52 +0100
Message-Id: <20190710130452.44111-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621095252.32307-11-vincenzo.frascino@arm.com>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prior to the introduction of Unified vDSO support and compat layer for
vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
In the current implementation, AT_SYSINFO_EHDR is defined even if the
compat vdso layer is not built and this causes a regression in the
expected behavior of the ABI.

Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
tasks is defined only when CONFIG_GENERIC_COMPAT_VDSO and
CONFIG_COMPAT_VDSO are enabled.

Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 3c7037c6ba9b..b7992bb9d414 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
-#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#if defined(CONFIG_COMPAT_VDSO) && defined(CONFIG_GENERIC_COMPAT_VDSO)
 #define COMPAT_ARCH_DLINFO						\
 do {									\
 	/*								\
-- 
2.22.0

