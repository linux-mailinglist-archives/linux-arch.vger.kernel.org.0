Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03861704C01
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjEPLLy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjEPLLc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:11:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975146AE;
        Tue, 16 May 2023 04:10:20 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GB45M9006515;
        Tue, 16 May 2023 11:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=AtGWLXUTN+qs4yeQcx5N9AqF56cJjjk1MlHpZx/g9wo=;
 b=Qh8B4PeJZhDcIH+gAjrr3pVn8eRy99jwMotmiKLbQKJBySUWapuBaLAwbVX8Fk6mqMRW
 rw0iNnSsQVnJ1E1tQnEo+dLdivMtukR8G264HGtxblSzw5NyCH5cmqN1P7UOb1RkwFri
 JrZJUCAfVGpTwx8WVeZN8nu0UaJ2RJRqSUZry5JwlKTKJhLze5O+8NLEq/vdnQGK5Ly/
 LPZUe4BpG6tWdH2T4lkcvE/ATQ2uwiMZY/bzQIv/ilZQI4TYZdcOIy7Vf950CFRQCxzN
 yvpjSZQeomwcJ/1FsCWeZ9aTiaIELMI639hKULTdjsL21FWGgQVM5SdznK7/JPs5+QQr 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8mrrdeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:09:13 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GB4atM008919;
        Tue, 16 May 2023 11:07:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8mrr8a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G8Ybkw031114;
        Tue, 16 May 2023 11:01:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qj1tdsaux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:01:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GB1GiK24117900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:01:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7218C2004D;
        Tue, 16 May 2023 11:01:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 234CC20040;
        Tue, 16 May 2023 11:01:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:01:16 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 41/41] asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
Date:   Tue, 16 May 2023 13:00:37 +0200
Message-Id: <20230516110038.2413224-42-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516110038.2413224-1-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eUHPXjx_Kxq_Tt-dBQSCKCHtt9hyHAWF
X-Proofpoint-GUID: FEbUPhHOuDgGY7Qb0MJ4mDjn31pei3cy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With all subsystems and drivers either declaring their dependence on
HAS_IOPORT or fencing I/O port specific code sections we can finally
make inb()/outb() and friends compile-time dependent on HAS_IOPORT as
suggested by Linus in the linked mail. The main benefit of this is that
on platforms such as s390 which have no meaningful way of implementing
inb()/outb() their use without the proper HAS_IOPORT dependency will
result in easy to catch and fix compile-time errors instead of compiling
code that can never work.

Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 include/asm-generic/io.h | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 587e7e9b9a37..6ab2b6dfb6b1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -539,6 +539,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 
 #if !defined(inb) && !defined(_inb)
 #define _inb _inb
+#ifdef CONFIG_HAS_IOPORT
 static inline u8 _inb(unsigned long addr)
 {
 	u8 val;
@@ -548,10 +549,15 @@ static inline u8 _inb(unsigned long addr)
 	__io_par(val);
 	return val;
 }
+#else
+u8 _inb(unsigned long addr)
+	__compiletime_error("inb()) requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #if !defined(inw) && !defined(_inw)
 #define _inw _inw
+#ifdef CONFIG_HAS_IOPORT
 static inline u16 _inw(unsigned long addr)
 {
 	u16 val;
@@ -561,10 +567,15 @@ static inline u16 _inw(unsigned long addr)
 	__io_par(val);
 	return val;
 }
+#else
+u16 _inw(unsigned long addr)
+	__compiletime_error("inw() requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #if !defined(inl) && !defined(_inl)
 #define _inl _inl
+#ifdef CONFIG_HAS_IOPORT
 static inline u32 _inl(unsigned long addr)
 {
 	u32 val;
@@ -574,36 +585,55 @@ static inline u32 _inl(unsigned long addr)
 	__io_par(val);
 	return val;
 }
+#else
+u32 _inl(unsigned long addr)
+	__compiletime_error("inl() requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #if !defined(outb) && !defined(_outb)
 #define _outb _outb
+#ifdef CONFIG_HAS_IOPORT
 static inline void _outb(u8 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writeb(value, PCI_IOBASE + addr);
 	__io_paw();
 }
+#else
+void _outb(u8 value, unsigned long addr)
+	__compiletime_error("outb() requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #if !defined(outw) && !defined(_outw)
 #define _outw _outw
+#ifdef CONFIG_HAS_IOPORT
 static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
 	__io_paw();
 }
+#else
+void _outw(u16 value, unsigned long addr)
+	__compiletime_error("outw() requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #if !defined(outl) && !defined(_outl)
 #define _outl _outl
+#ifdef CONFIG_HAS_IOPORT
 static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
 	__io_paw();
 }
+#else
+void _outl(u32 value, unsigned long addr)
+	__compiletime_error("outl() requires CONFIG_HAS_IOPORT");
+#endif
 #endif
 
 #include <linux/logic_pio.h>
@@ -687,53 +717,83 @@ static inline void outl_p(u32 value, unsigned long addr)
 
 #ifndef insb
 #define insb insb
+#ifdef CONFIG_HAS_IOPORT
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsb(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void insb(unsigned long addr, void *buffer, unsigned int count)
+	__compiletime_error("insb() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef insw
 #define insw insw
+#ifdef CONFIG_HAS_IOPORT
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsw(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void insw(unsigned long addr, void *buffer, unsigned int count)
+	__compiletime_error("insw() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef insl
 #define insl insl
+#ifdef CONFIG_HAS_IOPORT
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsl(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void insl(unsigned long addr, void *buffer, unsigned int count)
+	__compiletime_error("insl() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef outsb
 #define outsb outsb
+#ifdef CONFIG_HAS_IOPORT
 static inline void outsb(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesb(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void outsb(unsigned long addr, const void *buffer, unsigned int count)
+	__compiletime_error("outsb() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef outsw
 #define outsw outsw
+#ifdef CONFIG_HAS_IOPORT
 static inline void outsw(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesw(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void outsw(unsigned long addr, const void *buffer, unsigned int count)
+	__compiletime_error("outsw() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef outsl
 #define outsl outsl
+#ifdef CONFIG_HAS_IOPORT
 static inline void outsl(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesl(PCI_IOBASE + addr, buffer, count);
 }
+#else
+void outsl(unsigned long addr, const void *buffer, unsigned int count)
+	__compiletime_error("outsl() requires HAS_IOPORT");
+#endif
 #endif
 
 #ifndef insb_p
-- 
2.39.2

