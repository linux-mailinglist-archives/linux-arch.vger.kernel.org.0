Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9922135DE1B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDMLzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 07:55:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhDMLzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 07:55:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBYGJK093276;
        Tue, 13 Apr 2021 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=K1D0TefXvbQcZQJhHF0HWva11X2Hy1Uc9SEtL0kx9ZY=;
 b=LqqG02oIz4nVoq2QcRWPVdZ/tsng5DNt0qxqrgIgap+2bz7i+zB6A4NVsXUvp9SDcy1a
 bFYftbfNcwdB3jYVI/M2RZBEr91ZtDV53tE9eSTkcXwWbj0R6Z3Uu2q/Uyy3p0KRXsBM
 uhqjkr2xt3xrrmrlGtDubIPjB4Be0VeQrzOGAuMf7+zdtSKwbfGudx1WvmcT9BQuvzSu
 jEPKeAuCh+AVEblyk4ZPMtUUZVtCoTrumiGUvNbMZaAa6D5+78liNt3NDpr5Q5IFclXX
 8IU/AZqm6xEguwg+jNps+ilklnS6vO5m+coP9f25lxm+UszTD//rGBljCIYYkoEKS6Ax Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkpjqh1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:54:45 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13DBYrMg094933;
        Tue, 13 Apr 2021 07:54:44 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkpjqh1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:54:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DBr8Rg018615;
        Tue, 13 Apr 2021 11:54:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 37u3n89d68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 11:54:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DBsdrL27001124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 11:54:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7520D52052;
        Tue, 13 Apr 2021 11:54:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DD725204E;
        Tue, 13 Apr 2021 11:54:39 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on PCI_IOBASE
Date:   Tue, 13 Apr 2021 13:54:39 +0200
Message-Id: <20210413115439.1011560-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Svov5rAQw-nSijM3JuZ1icP9P81uchPp
X-Proofpoint-ORIG-GUID: Yp3UWpatE9sMn0DVXWk63CSU3xVUGLub
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130081
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When PCI_IOBASE is not defined, it is set to 0 such that it is ignored
in calls to the readX/writeX primitives. While mathematically obvious
this triggers clang's -Wnull-pointer-arithmetic warning.

An additional complication is that PCI_IOBASE is explicitly typed as
"void __iomem *" which causes the type conversion that converts the
"unsigned long" port/addr parameters to the appropriate pointer type.
As non pointer types are used by drivers at the callsite since these are
dealing with I/O port numbers, changing the parameter type would cause
further warnings in drivers. Instead use "uintptr_t" for PCI_IOBASE
0 and explicitly cast to "void __iomem *" when calling readX/writeX.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 include/asm-generic/io.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index c6af40ce03be..8eb00bdef7ad 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -441,7 +441,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #endif /* CONFIG_64BIT */
 
 #ifndef PCI_IOBASE
-#define PCI_IOBASE ((void __iomem *)0)
+#define PCI_IOBASE ((uintptr_t)0)
 #endif
 
 #ifndef IO_SPACE_LIMIT
@@ -461,7 +461,7 @@ static inline u8 _inb(unsigned long addr)
 	u8 val;
 
 	__io_pbr();
-	val = __raw_readb(PCI_IOBASE + addr);
+	val = __raw_readb((void __iomem *)(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -474,7 +474,7 @@ static inline u16 _inw(unsigned long addr)
 	u16 val;
 
 	__io_pbr();
-	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw((void __iomem *)(PCI_IOBASE + addr)));
 	__io_par(val);
 	return val;
 }
@@ -487,7 +487,7 @@ static inline u32 _inl(unsigned long addr)
 	u32 val;
 
 	__io_pbr();
-	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl((void __iomem *)(PCI_IOBASE + addr)));
 	__io_par(val);
 	return val;
 }
@@ -498,7 +498,7 @@ static inline u32 _inl(unsigned long addr)
 static inline void _outb(u8 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writeb(value, PCI_IOBASE + addr);
+	__raw_writeb(value, (void __iomem *)(PCI_IOBASE + addr));
 	__io_paw();
 }
 #endif
@@ -508,7 +508,7 @@ static inline void _outb(u8 value, unsigned long addr)
 static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), (void __iomem *)(PCI_IOBASE + addr));
 	__io_paw();
 }
 #endif
@@ -518,7 +518,7 @@ static inline void _outw(u16 value, unsigned long addr)
 static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
+	__raw_writel((u32 __force)cpu_to_le32(value), (void __iomem *)(PCI_IOBASE + addr));
 	__io_paw();
 }
 #endif
@@ -606,7 +606,7 @@ static inline void outl_p(u32 value, unsigned long addr)
 #define insb insb
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsb(PCI_IOBASE + addr, buffer, count);
+	readsb((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
@@ -614,7 +614,7 @@ static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 #define insw insw
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsw(PCI_IOBASE + addr, buffer, count);
+	readsw((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
@@ -622,7 +622,7 @@ static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 #define insl insl
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsl(PCI_IOBASE + addr, buffer, count);
+	readsl((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
@@ -631,7 +631,7 @@ static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 static inline void outsb(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesb(PCI_IOBASE + addr, buffer, count);
+	writesb((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
@@ -640,7 +640,7 @@ static inline void outsb(unsigned long addr, const void *buffer,
 static inline void outsw(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesw(PCI_IOBASE + addr, buffer, count);
+	writesw((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
@@ -649,7 +649,7 @@ static inline void outsw(unsigned long addr, const void *buffer,
 static inline void outsl(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesl(PCI_IOBASE + addr, buffer, count);
+	writesl((void __iomem *)(PCI_IOBASE + addr), buffer, count);
 }
 #endif
 
-- 
2.25.1

