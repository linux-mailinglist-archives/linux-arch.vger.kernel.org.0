Return-Path: <linux-arch+bounces-12821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66225B07B9C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600684E2174
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B02F5C2A;
	Wed, 16 Jul 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iVMrVZ7w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F62F5C20;
	Wed, 16 Jul 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685168; cv=none; b=fWJl3U9y09ohrEXI/xic8bp4wtB2MNgmB5Gg7UJP0U4SdvV9N6lEa2VK2UJZ6/AaABQ6kun6fRVc2/zegeJEQtCGRQG7Xf/RZhr5Fhw2Df03to1H0GL1+cfaEbxatYYZEvjJjxFAgiMvJy4EdBYMyGXNKiwR/1xj44jI2PxZau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685168; c=relaxed/simple;
	bh=8tKAW3ILK63tvFgopBEPcTxEPxSi4i6zqnD0dg4NOrE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ijk/c2YyIyGmvaY1Ve1sCRJOulquwote2e+WXDQ6cs+5o2ure/hCGnvUiwNtYi4VvwAlRA1ZMHYx5ZiXF1Z+l0JSrRwlcaajSm9htqagw8P29jPRs70i1iapo/cW5DVWA0WeaWyY8gnfCPsNSnqIOWARdIVGOnTnBxb6xKDOJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iVMrVZ7w reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:6dc:b955:47cb:dcbb])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56GGlgcB1606025
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 16 Jul 2025 09:47:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56GGlgcB1606025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752684483;
	bh=Pi512eHi9UqcH1NIe21hPNH34+JTvpPZpIBQ9bkTpeo=;
	h=From:To:Subject:Date:From;
	b=iVMrVZ7wCY+XR+v+/5lGaQK0wtkobCborN8fAcNbqMDyZci7UAzAbz6/wkfvH8sml
	 yQuQrqcZYdI4rVp7Cb4tmJF3SAB/7/Bnn45T+6/vLbmdVlw/iKcjNzcjDQZsRNADMU
	 2uGk2Q4+1McKUub7sk1zw8j0WQNs9JUdbWdZHTymZ9oCzx42BRH9Opvt0sRdKFTnjE
	 r5Pxq+Te1DUEUkR3blNMxL6s9Ty/LyXU/8mCYaLcEMp4eCRa6T8/O9vlNQQJ7xkwq3
	 bWubqVadZ0JXsRMKm4thdvRgAW4s9CUjgaqkkPit8nThtZY7X+pDf6dfxDrcHy407k
	 pQSnTF2Ke3B0A==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: [PATCH 1/1] uapi/termios: remove struct ktermios from uapi headers
Date: Wed, 16 Jul 2025 09:47:32 -0700
Message-ID: <20250716164735.170713-1-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ktermios is not, nor has it ever been, a UAPI.  Remove it from
the UAPI headers.

Normally we have shadowed kernel-only headers that include the uapi
ones; in this case this would be <asm/termbits.h>, however, I was
unable to find a way by which *some* paths would still somehow pick up
the UAPI header only (presumably due to the mix of arch-specific and
asm-generic headers), so I separated out the kernel-specific parts
into a new header <asm/ktermios.h>.

<linux/termios.h> now has a kernel version, which only differs by
including <asm/ktermios.h>.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/alpha/include/asm/ktermios.h        |  2 ++
 arch/alpha/include/uapi/asm/termbits.h   | 17 ++--------------
 arch/arc/include/asm/ktermios.h          |  1 +
 arch/arm/include/asm/ktermios.h          |  1 +
 arch/arm64/include/asm/ktermios.h        |  1 +
 arch/csky/include/asm/ktermios.h         |  1 +
 arch/hexagon/include/asm/ktermios.h      |  1 +
 arch/loongarch/include/asm/ktermios.h    |  1 +
 arch/m68k/include/asm/ktermios.h         |  1 +
 arch/microblaze/include/asm/ktermios.h   |  1 +
 arch/mips/include/asm/ktermios.h         |  1 +
 arch/mips/include/uapi/asm/termbits.h    | 15 ++------------
 arch/nios2/include/asm/ktermios.h        |  1 +
 arch/openrisc/include/asm/ktermios.h     |  1 +
 arch/parisc/include/asm/ktermios.h       |  1 +
 arch/parisc/include/uapi/asm/termbits.h  | 15 ++------------
 arch/powerpc/include/asm/ktermios.h      |  2 ++
 arch/powerpc/include/uapi/asm/termbits.h | 13 ------------
 arch/riscv/include/asm/ktermios.h        |  1 +
 arch/s390/include/asm/ktermios.h         |  1 +
 arch/sh/include/asm/ktermios.h           |  1 +
 arch/sparc/include/asm/ktermios.h        | 11 ++++++++++
 arch/sparc/include/asm/termbits.h        |  9 --------
 arch/um/include/asm/ktermios.h           |  1 +
 arch/x86/include/asm/ktermios.h          |  1 +
 arch/xtensa/include/asm/ktermios.h       |  1 +
 include/asm-generic/ktermios.h           | 26 ++++++++++++++++++++++++
 include/linux/termios.h                  |  7 +++++++
 include/uapi/asm-generic/termbits.h      | 15 ++------------
 include/uapi/linux/termios.h             |  4 ++--
 30 files changed, 76 insertions(+), 78 deletions(-)
 create mode 100644 arch/alpha/include/asm/ktermios.h
 create mode 100644 arch/arc/include/asm/ktermios.h
 create mode 100644 arch/arm/include/asm/ktermios.h
 create mode 100644 arch/arm64/include/asm/ktermios.h
 create mode 100644 arch/csky/include/asm/ktermios.h
 create mode 100644 arch/hexagon/include/asm/ktermios.h
 create mode 100644 arch/loongarch/include/asm/ktermios.h
 create mode 100644 arch/m68k/include/asm/ktermios.h
 create mode 100644 arch/microblaze/include/asm/ktermios.h
 create mode 100644 arch/mips/include/asm/ktermios.h
 create mode 100644 arch/nios2/include/asm/ktermios.h
 create mode 100644 arch/openrisc/include/asm/ktermios.h
 create mode 100644 arch/parisc/include/asm/ktermios.h
 create mode 100644 arch/powerpc/include/asm/ktermios.h
 create mode 100644 arch/riscv/include/asm/ktermios.h
 create mode 100644 arch/s390/include/asm/ktermios.h
 create mode 100644 arch/sh/include/asm/ktermios.h
 create mode 100644 arch/sparc/include/asm/ktermios.h
 delete mode 100644 arch/sparc/include/asm/termbits.h
 create mode 100644 arch/um/include/asm/ktermios.h
 create mode 100644 arch/x86/include/asm/ktermios.h
 create mode 100644 arch/xtensa/include/asm/ktermios.h
 create mode 100644 include/asm-generic/ktermios.h
 create mode 100644 include/linux/termios.h

diff --git a/arch/alpha/include/asm/ktermios.h b/arch/alpha/include/asm/ktermios.h
new file mode 100644
index 000000000000..f1e3d24b8e61
--- /dev/null
+++ b/arch/alpha/include/asm/ktermios.h
@@ -0,0 +1,2 @@
+#define KTERMIOS_C_CC_BEFORE_C_LINE 1
+#include <asm-generic/ktermios.h>
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index f1290b22072b..50a1b468b81c 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_TERMBITS_H
-#define _ALPHA_TERMBITS_H
+#ifndef _UAPI_ALPHA_TERMBITS_H
+#define _UAPI_ALPHA_TERMBITS_H
 
 #include <asm-generic/termbits-common.h>
 
@@ -37,19 +37,6 @@ struct termios2 {
 	speed_t c_ospeed;		/* output speed */
 };
 
-/* Alpha has matching termios and ktermios */
-
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t c_line;			/* line discipline (== c_cc[19]) */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
 /* c_cc characters */
 #define VEOF		 0
 #define VEOL		 1
diff --git a/arch/arc/include/asm/ktermios.h b/arch/arc/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/arc/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/arm/include/asm/ktermios.h b/arch/arm/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/arm/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/arm64/include/asm/ktermios.h b/arch/arm64/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/arm64/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/csky/include/asm/ktermios.h b/arch/csky/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/csky/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/hexagon/include/asm/ktermios.h b/arch/hexagon/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/hexagon/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/loongarch/include/asm/ktermios.h b/arch/loongarch/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/loongarch/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/m68k/include/asm/ktermios.h b/arch/m68k/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/m68k/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/microblaze/include/asm/ktermios.h b/arch/microblaze/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/microblaze/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/mips/include/asm/ktermios.h b/arch/mips/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/mips/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index 1eb60903d6f0..dacefee984d6 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -8,8 +8,8 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Copyright (C) 2001 MIPS Technologies, Inc.
  */
-#ifndef _ASM_TERMBITS_H
-#define _ASM_TERMBITS_H
+#ifndef _UAPI_ASM_TERMBITS_H
+#define _UAPI_ASM_TERMBITS_H
 
 #include <asm-generic/termbits-common.h>
 
@@ -40,17 +40,6 @@ struct termios2 {
 	speed_t c_ospeed;		/* output speed */
 };
 
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
 /* c_cc characters */
 #define VINTR		 0		/* Interrupt character [ISIG] */
 #define VQUIT		 1		/* Quit character [ISIG] */
diff --git a/arch/nios2/include/asm/ktermios.h b/arch/nios2/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/nios2/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/openrisc/include/asm/ktermios.h b/arch/openrisc/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/openrisc/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/parisc/include/asm/ktermios.h b/arch/parisc/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/parisc/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 3a8938d26fb4..d8818b887680 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ARCH_PARISC_TERMBITS_H__
-#define __ARCH_PARISC_TERMBITS_H__
+#ifndef _UAPI_PARISC_TERMBITS_H
+#define _UAPI_PARISC_TERMBITS_H
 
 #include <asm-generic/termbits-common.h>
 
@@ -27,17 +27,6 @@ struct termios2 {
 	speed_t c_ospeed;		/* output speed */
 };
 
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
 /* c_cc characters */
 #define VINTR		 0
 #define VQUIT		 1
diff --git a/arch/powerpc/include/asm/ktermios.h b/arch/powerpc/include/asm/ktermios.h
new file mode 100644
index 000000000000..f1e3d24b8e61
--- /dev/null
+++ b/arch/powerpc/include/asm/ktermios.h
@@ -0,0 +1,2 @@
+#define KTERMIOS_C_CC_BEFORE_C_LINE 1
+#include <asm-generic/ktermios.h>
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index 21dc86dcb2f1..f4e4d8270c8e 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -31,19 +31,6 @@ struct termios {
 	speed_t c_ospeed;		/* output speed */
 };
 
-/* For PowerPC the termios and ktermios are the same */
-
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t c_line;			/* line discipline (== c_cc[19]) */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
 /* c_cc characters */
 #define VINTR 	         0
 #define VQUIT 	         1
diff --git a/arch/riscv/include/asm/ktermios.h b/arch/riscv/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/riscv/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/s390/include/asm/ktermios.h b/arch/s390/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/s390/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/sh/include/asm/ktermios.h b/arch/sh/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/sh/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/sparc/include/asm/ktermios.h b/arch/sparc/include/asm/ktermios.h
new file mode 100644
index 000000000000..bdd3682eecef
--- /dev/null
+++ b/arch/sparc/include/asm/ktermios.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SPARC_KTERMIOS_H
+#define _SPARC_KTERMIOS_H
+
+#define VMIN     16
+#define VTIME    17
+#define KNCCS	 (NCCS+2)
+
+#include <asm-generic/ktermios.h>
+
+#endif /* !(_SPARC_KTERMIOS_H) */
diff --git a/arch/sparc/include/asm/termbits.h b/arch/sparc/include/asm/termbits.h
deleted file mode 100644
index fa9de4a46d36..000000000000
--- a/arch/sparc/include/asm/termbits.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SPARC_TERMBITS_H
-#define _SPARC_TERMBITS_H
-
-#include <uapi/asm/termbits.h>
-
-#define VMIN     16
-#define VTIME    17
-#endif /* !(_SPARC_TERMBITS_H) */
diff --git a/arch/um/include/asm/ktermios.h b/arch/um/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/um/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/x86/include/asm/ktermios.h b/arch/x86/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/x86/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/arch/xtensa/include/asm/ktermios.h b/arch/xtensa/include/asm/ktermios.h
new file mode 100644
index 000000000000..4320921a82a9
--- /dev/null
+++ b/arch/xtensa/include/asm/ktermios.h
@@ -0,0 +1 @@
+#include <asm-generic/ktermios.h>
diff --git a/include/asm-generic/ktermios.h b/include/asm-generic/ktermios.h
new file mode 100644
index 000000000000..bf22e22d8130
--- /dev/null
+++ b/include/asm-generic/ktermios.h
@@ -0,0 +1,26 @@
+#ifndef _ASM_GENERIC_KTERMIOS_H
+#define _ASM_GENERIC_KTERMIOS_H
+
+#ifndef KNCCS
+# define KNCCS NCCS
+#endif
+
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+#ifndef KTERMIOS_C_CC_BEFORE_C_LINE
+	/* Most architectures */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[KNCCS];		/* control characters */
+#else
+	/* Alpha and PowerPC */
+	cc_t c_cc[KNCCS];		/* control characters */
+	cc_t c_line;			/* line discipline */
+#endif
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
+#endif /* _ASM_GENERIC_KTERMIOS_H */
diff --git a/include/linux/termios.h b/include/linux/termios.h
new file mode 100644
index 000000000000..9d37d24cae02
--- /dev/null
+++ b/include/linux/termios.h
@@ -0,0 +1,7 @@
+#ifndef _LINUX_TERMIOS_H
+#define _LINUX_TERMIOS_H
+
+#include <uapi/linux/termios.h>
+#include <asm/ktermios.h>
+
+#endif
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 890ef29053e2..df60b006657f 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_GENERIC_TERMBITS_H
-#define __ASM_GENERIC_TERMBITS_H
+#ifndef _UAPI_ASM_GENERIC_TERMBITS_H
+#define _UAPI_ASM_GENERIC_TERMBITS_H
 
 #include <asm-generic/termbits-common.h>
 
@@ -27,17 +27,6 @@ struct termios2 {
 	speed_t c_ospeed;		/* output speed */
 };
 
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
 /* c_cc characters */
 #define VINTR		 0
 #define VQUIT		 1
diff --git a/include/uapi/linux/termios.h b/include/uapi/linux/termios.h
index e6da9d4433d1..32ff18b0dfbc 100644
--- a/include/uapi/linux/termios.h
+++ b/include/uapi/linux/termios.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_TERMIOS_H
-#define _LINUX_TERMIOS_H
+#ifndef _UAPI_LINUX_TERMIOS_H
+#define _UAPI_LINUX_TERMIOS_H
 
 #include <linux/types.h>
 #include <asm/termios.h>
-- 
2.50.1


