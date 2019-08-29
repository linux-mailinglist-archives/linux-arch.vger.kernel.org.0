Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2330AA1FD6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfH2PvK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:51:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728602AbfH2PvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TFlqNQ102748;
        Thu, 29 Aug 2019 11:51:01 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upfxxmjxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 11:51:00 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TFo79O010564;
        Thu, 29 Aug 2019 15:50:59 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 2umpctt486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 15:50:59 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TFoxQK42336710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 15:50:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA53AE05F;
        Thu, 29 Aug 2019 15:50:58 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24D32AE05C;
        Thu, 29 Aug 2019 15:50:56 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.151.248])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 15:50:55 +0000 (GMT)
From:   "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au,
        andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        cclaudio@linux.ibm.com,
        "Maxiwell S . Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc: Add PowerPC Capabilities ELF note
Date:   Thu, 29 Aug 2019 12:50:20 -0300
Message-Id: <20190829155021.2915-2-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829155021.2915-1-maxiwell@linux.ibm.com>
References: <20190829155021.2915-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290168
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Claudio Carvalho <cclaudio@linux.ibm.com>

Add the PowerPC name and the PPC_ELFNOTE_CAPABILITIES type in the
kernel binary ELF note. This type is a bitmap that can be used to
advertise kernel capabilities to userland.

This patch also defines PPCCAP_ULTRAVISOR_BIT as being the bit zero.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
[ maxiwell: Define the 'PowerPC' type in the elfnote.h ]
Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 arch/powerpc/include/asm/elfnote.h | 24 ++++++++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/note.S         | 40 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/elfnote.h
 create mode 100644 arch/powerpc/kernel/note.S

diff --git a/arch/powerpc/include/asm/elfnote.h b/arch/powerpc/include/asm/elfnote.h
new file mode 100644
index 000000000000..a201b6e9ae44
--- /dev/null
+++ b/arch/powerpc/include/asm/elfnote.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC ELF notes.
+ *
+ * Copyright 2019, IBM Corporation
+ */
+
+#ifndef __ASM_POWERPC_ELFNOTE_H__
+#define __ASM_POWERPC_ELFNOTE_H__
+
+/*
+ * These note types should live in a SHT_NOTE segment and have
+ * "PowerPC" in the name field.
+ */
+
+/*
+ * The capabilities supported/required by this kernel (bitmap).
+ *
+ * This type uses a bitmap as "desc" field. Each bit is described
+ * in arch/powerpc/kernel/note.S
+ */
+#define PPC_ELFNOTE_CAPABILITIES 1
+
+#endif /* __ASM_POWERPC_ELFNOTE_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2..0fcd3045284f 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -52,7 +52,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
-				   paca.o nvram_64.o firmware.o
+				   paca.o nvram_64.o firmware.o note.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/powerpc/kernel/note.S b/arch/powerpc/kernel/note.S
new file mode 100644
index 000000000000..bcdad15395dd
--- /dev/null
+++ b/arch/powerpc/kernel/note.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC ELF notes.
+ *
+ * Copyright 2019, IBM Corporation
+ */
+
+#include <linux/elfnote.h>
+#include <asm/elfnote.h>
+
+/*
+ * Ultravisor-capable bit (PowerNV only).
+ *
+ * Bit 0 indicates that the powerpc kernel binary knows how to run in an
+ * ultravisor-enabled system.
+ *
+ * In an ultravisor-enabled system, some machine resources are now controlled
+ * by the ultravisor. If the kernel is not ultravisor-capable, but it ends up
+ * being run on a machine with ultravisor, the kernel will probably crash
+ * trying to access ultravisor resources. For instance, it may crash in early
+ * boot trying to set the partition table entry 0.
+ *
+ * In an ultravisor-enabled system, a bootloader could warn the user or prevent
+ * the kernel from being run if the PowerPC ultravisor capability doesn't exist
+ * or the Ultravisor-capable bit is not set.
+ */
+#ifdef CONFIG_PPC_POWERNV
+#define PPCCAP_ULTRAVISOR_BIT		(1 << 0)
+#else
+#define PPCCAP_ULTRAVISOR_BIT		0
+#endif
+
+/*
+ * Add the PowerPC Capabilities in the binary ELF note. It is a bitmap that
+ * can be used to advertise kernel capabilities to userland.
+ */
+#define PPC_CAPABILITIES_BITMAP (PPCCAP_ULTRAVISOR_BIT)
+
+ELFNOTE(PowerPC, PPC_ELFNOTE_CAPABILITIES,
+	.long PPC_CAPABILITIES_BITMAP)
-- 
2.20.1

