Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11172AE79
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2019 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfE0GRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 May 2019 02:17:54 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:64274 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726219AbfE0GRx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 02:17:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x4R6CIId059725;
        Mon, 27 May 2019 14:12:18 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 27 May 2019
 14:17:35 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, <greentime@andestech.com>,
        <green.hu@gmail.com>, <deanbo422@gmail.com>
CC:     <vincentc@andestech.com>
Subject: [PATCH v2 2/3] nds32: add new emulations for floating point instruction
Date:   Mon, 27 May 2019 14:17:20 +0800
Message-ID: <1558937841-4222-3-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558937841-4222-1-git-send-email-vincentc@andestech.com>
References: <1558937841-4222-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x4R6CIId059725
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The existing floating point emulations is only available for floating
instruction that possibly issue denormalized input and underflow
exceptions. These existing FPU emulations are not sufficient when IEx
Trap is enabled because some floating point instructions only issue inexact
exception. This patch adds the emulations of such floating point
instructions.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 Changes in v2
 - No changes

 arch/nds32/include/asm/fpuemu.h |   12 ++++++++
 arch/nds32/math-emu/Makefile    |    5 +++-
 arch/nds32/math-emu/fd2si.c     |   30 ++++++++++++++++++++
 arch/nds32/math-emu/fd2siz.c    |   30 ++++++++++++++++++++
 arch/nds32/math-emu/fd2ui.c     |   30 ++++++++++++++++++++
 arch/nds32/math-emu/fd2uiz.c    |   30 ++++++++++++++++++++
 arch/nds32/math-emu/fpuemu.c    |   57 ++++++++++++++++++++++++++++++++++++---
 arch/nds32/math-emu/fs2si.c     |   29 ++++++++++++++++++++
 arch/nds32/math-emu/fs2siz.c    |   29 ++++++++++++++++++++
 arch/nds32/math-emu/fs2ui.c     |   29 ++++++++++++++++++++
 arch/nds32/math-emu/fs2uiz.c    |   30 ++++++++++++++++++++
 arch/nds32/math-emu/fsi2d.c     |   22 +++++++++++++++
 arch/nds32/math-emu/fsi2s.c     |   22 +++++++++++++++
 arch/nds32/math-emu/fui2d.c     |   22 +++++++++++++++
 arch/nds32/math-emu/fui2s.c     |   22 +++++++++++++++
 15 files changed, 394 insertions(+), 5 deletions(-)
 create mode 100644 arch/nds32/math-emu/fd2si.c
 create mode 100644 arch/nds32/math-emu/fd2siz.c
 create mode 100644 arch/nds32/math-emu/fd2ui.c
 create mode 100644 arch/nds32/math-emu/fd2uiz.c
 create mode 100644 arch/nds32/math-emu/fs2si.c
 create mode 100644 arch/nds32/math-emu/fs2siz.c
 create mode 100644 arch/nds32/math-emu/fs2ui.c
 create mode 100644 arch/nds32/math-emu/fs2uiz.c
 create mode 100644 arch/nds32/math-emu/fsi2d.c
 create mode 100644 arch/nds32/math-emu/fsi2s.c
 create mode 100644 arch/nds32/math-emu/fui2d.c
 create mode 100644 arch/nds32/math-emu/fui2s.c

diff --git a/arch/nds32/include/asm/fpuemu.h b/arch/nds32/include/asm/fpuemu.h
index c4bd0c7..63e7ef5 100644
--- a/arch/nds32/include/asm/fpuemu.h
+++ b/arch/nds32/include/asm/fpuemu.h
@@ -13,6 +13,12 @@
 void fmuls(void *ft, void *fa, void *fb);
 void fdivs(void *ft, void *fa, void *fb);
 void fs2d(void *ft, void *fa);
+void fs2si(void *ft, void *fa);
+void fs2si_z(void *ft, void *fa);
+void fs2ui(void *ft, void *fa);
+void fs2ui_z(void *ft, void *fa);
+void fsi2s(void *ft, void *fa);
+void fui2s(void *ft, void *fa);
 void fsqrts(void *ft, void *fa);
 void fnegs(void *ft, void *fa);
 int fcmps(void *ft, void *fa, void *fb, int cop);
@@ -26,6 +32,12 @@
 void fdivd(void *ft, void *fa, void *fb);
 void fsqrtd(void *ft, void *fa);
 void fd2s(void *ft, void *fa);
+void fd2si(void *ft, void *fa);
+void fd2si_z(void *ft, void *fa);
+void fd2ui(void *ft, void *fa);
+void fd2ui_z(void *ft, void *fa);
+void fsi2d(void *ft, void *fa);
+void fui2d(void *ft, void *fa);
 void fnegd(void *ft, void *fa);
 int fcmpd(void *ft, void *fa, void *fb, int cop);
 
diff --git a/arch/nds32/math-emu/Makefile b/arch/nds32/math-emu/Makefile
index 947fe0c..e7a746d 100644
--- a/arch/nds32/math-emu/Makefile
+++ b/arch/nds32/math-emu/Makefile
@@ -4,4 +4,7 @@
 
 obj-y	:= fpuemu.o \
 	   fdivd.o fmuld.o fsubd.o faddd.o fs2d.o fsqrtd.o fcmpd.o fnegs.o \
-	   fdivs.o fmuls.o fsubs.o fadds.o fd2s.o fsqrts.o fcmps.o fnegd.o
+	   fd2si.o fd2ui.o fd2siz.o fd2uiz.o fsi2d.o fui2d.o \
+	   fdivs.o fmuls.o fsubs.o fadds.o fd2s.o fsqrts.o fcmps.o fnegd.o \
+	   fs2si.o fs2ui.o fs2siz.o fs2uiz.o fsi2s.o fui2s.o
+
diff --git a/arch/nds32/math-emu/fd2si.c b/arch/nds32/math-emu/fd2si.c
new file mode 100644
index 0000000..fae3e16
--- /dev/null
+++ b/arch/nds32/math-emu/fd2si.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fd2si(void *ft, void *fa)
+{
+	int r;
+
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(int *)ft = r;
+	}
+
+}
diff --git a/arch/nds32/math-emu/fd2siz.c b/arch/nds32/math-emu/fd2siz.c
new file mode 100644
index 0000000..92fe677
--- /dev/null
+++ b/arch/nds32/math-emu/fd2siz.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fd2si_z(void *ft, void *fa)
+{
+	int r;
+
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_D(r, A, 32, 1);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(int *)ft = r;
+	}
+
+}
diff --git a/arch/nds32/math-emu/fd2ui.c b/arch/nds32/math-emu/fd2ui.c
new file mode 100644
index 0000000..a0423b6
--- /dev/null
+++ b/arch/nds32/math-emu/fd2ui.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fd2ui(void *ft, void *fa)
+{
+	unsigned int r;
+
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(unsigned int *)ft = r;
+	}
+
+}
diff --git a/arch/nds32/math-emu/fd2uiz.c b/arch/nds32/math-emu/fd2uiz.c
new file mode 100644
index 0000000..8ae17cf
--- /dev/null
+++ b/arch/nds32/math-emu/fd2uiz.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fd2ui_z(void *ft, void *fa)
+{
+	unsigned int r;
+
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_D(r, A, 32, 0);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(unsigned int *)ft = r;
+	}
+
+}
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
index 75cf164..46558a1 100644
--- a/arch/nds32/math-emu/fpuemu.c
+++ b/arch/nds32/math-emu/fpuemu.c
@@ -113,6 +113,30 @@ static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
 					func.b = fs2d;
 					ftype = S1D;
 					break;
+				case fs2si_op:
+					func.b = fs2si;
+					ftype = S1S;
+					break;
+				case fs2si_z_op:
+					func.b = fs2si_z;
+					ftype = S1S;
+					break;
+				case fs2ui_op:
+					func.b = fs2ui;
+					ftype = S1S;
+					break;
+				case fs2ui_z_op:
+					func.b = fs2ui_z;
+					ftype = S1S;
+					break;
+				case fsi2s_op:
+					func.b = fsi2s;
+					ftype = S1S;
+					break;
+				case fui2s_op:
+					func.b = fui2s;
+					ftype = S1S;
+					break;
 				case fsqrts_op:
 					func.b = fsqrts;
 					ftype = S1S;
@@ -182,6 +206,30 @@ static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
 					func.b = fd2s;
 					ftype = D1S;
 					break;
+				case fd2si_op:
+					func.b = fd2si;
+					ftype = D1S;
+					break;
+				case fd2si_z_op:
+					func.b = fd2si_z;
+					ftype = D1S;
+					break;
+				case fd2ui_op:
+					func.b = fd2ui;
+					ftype = D1S;
+					break;
+				case fd2ui_z_op:
+					func.b = fd2ui_z;
+					ftype = D1S;
+					break;
+				case fsi2d_op:
+					func.b = fsi2d;
+					ftype = D1S;
+					break;
+				case fui2d_op:
+					func.b = fui2d;
+					ftype = D1S;
+					break;
 				case fsqrtd_op:
 					func.b = fsqrtd;
 					ftype = D1D;
@@ -305,16 +353,16 @@ static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
 	 * If an exception is required, generate a tidy SIGFPE exception.
 	 */
 #if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-	if (((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE_NO_UDFE) ||
-	    ((fpu_reg->fpcsr & FPCSR_mskUDF) && (fpu_reg->UDF_trap)))
+	if (((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE_NO_UDF_IEXE)
+	    || ((fpu_reg->fpcsr << 5) & (fpu_reg->UDF_IEX_trap))) {
 #else
-	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE)
+	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE) {
 #endif
 		return SIGFPE;
+	}
 	return 0;
 }
 
-
 int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
 {
 	unsigned long insn = 0, addr = regs->ipc;
@@ -336,6 +384,7 @@ int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
 
 	if (NDS32Insn_OPCODE(insn) != cop0_op)
 		return SIGILL;
+
 	switch (NDS32Insn_OPCODE_COP0(insn)) {
 	case fs1_op:
 	case fs2_op:
diff --git a/arch/nds32/math-emu/fs2si.c b/arch/nds32/math-emu/fs2si.c
new file mode 100644
index 0000000..b4931d6
--- /dev/null
+++ b/arch/nds32/math-emu/fs2si.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fs2si(void *ft, void *fa)
+{
+	int r;
+
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(int *)ft = r;
+	}
+}
diff --git a/arch/nds32/math-emu/fs2siz.c b/arch/nds32/math-emu/fs2siz.c
new file mode 100644
index 0000000..1c2b99c
--- /dev/null
+++ b/arch/nds32/math-emu/fs2siz.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fs2si_z(void *ft, void *fa)
+{
+	int r;
+
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_S(r, A, 32, 1);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(int *)ft = r;
+	}
+}
diff --git a/arch/nds32/math-emu/fs2ui.c b/arch/nds32/math-emu/fs2ui.c
new file mode 100644
index 0000000..c337f03
--- /dev/null
+++ b/arch/nds32/math-emu/fs2ui.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fs2ui(void *ft, void *fa)
+{
+	unsigned int r;
+
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(unsigned int *)ft = r;
+	}
+}
diff --git a/arch/nds32/math-emu/fs2uiz.c b/arch/nds32/math-emu/fs2uiz.c
new file mode 100644
index 0000000..22c5e47
--- /dev/null
+++ b/arch/nds32/math-emu/fs2uiz.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fs2ui_z(void *ft, void *fa)
+{
+	unsigned int r;
+
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)ft = 0xffffffff;
+		__FPU_FPCSR |= FP_EX_INVALID;
+	} else {
+		FP_TO_INT_S(r, A, 32, 0);
+		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+		*(unsigned int *)ft = r;
+	}
+
+}
diff --git a/arch/nds32/math-emu/fsi2d.c b/arch/nds32/math-emu/fsi2d.c
new file mode 100644
index 0000000..6b04cec
--- /dev/null
+++ b/arch/nds32/math-emu/fsi2d.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fsi2d(void *ft, void *fa)
+{
+	int a = *(int *)fa;
+
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, a, 32, int);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
diff --git a/arch/nds32/math-emu/fsi2s.c b/arch/nds32/math-emu/fsi2s.c
new file mode 100644
index 0000000..689864a
--- /dev/null
+++ b/arch/nds32/math-emu/fsi2s.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fsi2s(void *ft, void *fa)
+{
+	int a = *(int *)fa;
+
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, a, 32, int);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
diff --git a/arch/nds32/math-emu/fui2d.c b/arch/nds32/math-emu/fui2d.c
new file mode 100644
index 0000000..9689d33
--- /dev/null
+++ b/arch/nds32/math-emu/fui2d.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fui2d(void *ft, void *fa)
+{
+	unsigned int a = *(unsigned int *)fa;
+
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, a, 32, int);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
diff --git a/arch/nds32/math-emu/fui2s.c b/arch/nds32/math-emu/fui2s.c
new file mode 100644
index 0000000..f70f076
--- /dev/null
+++ b/arch/nds32/math-emu/fui2s.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2019 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+
+void fui2s(void *ft, void *fa)
+{
+	unsigned int a = *(unsigned int *)fa;
+
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, a, 32, int);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
-- 
1.7.1

