Return-Path: <linux-arch+bounces-8527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F659AEEE6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4661C20CA4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65A200111;
	Thu, 24 Oct 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J5KIJnSG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7111FF7B6;
	Thu, 24 Oct 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792604; cv=none; b=JVX84zxroEnUx9klbU0+pibiCUlpdxtrfrYBKuApiicQYXLTflL/qCZHOnHl71PhIqpNPultGk4j1lFbs2oncKYOl2JLFBZDzEQDqOohn0ZqADUZOxwqFRz7ZzVma5Hcw6HDMIDj6PsvmpFeQVDx0jwRuanuPw0NiGU5mvkjgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792604; c=relaxed/simple;
	bh=9pbUyl42Nhcqma6QZmYcdpbw5sT9z3q1sa7WhPr42iw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TxlxQbQOx8oQ1STwn/BFBC2Y4a8f+PkCUcUTwnEwdo0lxey/kFtypMunuECc3qvaO8mWDVLR5fNOaXOY7A1uktNemd4rtQbBNLHj2YqM9pUAFosIhrymx9SkNByleKQIon6VzZYag6je0JgypBsMEZLR9HqyYWwZYfskdTK+KD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J5KIJnSG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHc4Zr026032;
	Thu, 24 Oct 2024 17:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OpUSHB
	MEwdUyF98w9KKfMMv1aen5S0miB4aePTMDh+c=; b=J5KIJnSGSY4CoaL38tnBR0
	eECCOwFoDOO1plP9pj9gTGTuzy1JFvfrkyet7luu11SeTBf/YI6nlD1QnOCpGbhn
	OnYMJgLqhduS1mlHbDPqaQOutqKnKHCOgH/lGRrfOBB8eR0dXoFG60unHRH9fN1Q
	/lzkfc4AGl7ROXF6P8pa+2+3rUOTb1LbNcB0Gaiwcul98DtnjVXFT8Jw0AaR5B4P
	8AKRdsG5nmH48Mi4KkyyPm8LZ9B0e5yJFGhaurjTbnpxFG0VbbcDYpexIJT1EXpe
	cVb6RRQmLPS1oJq2JzEU38jMZpOIoxxdAaC0I8EGRvDCXPlGZ4TwUJ40qnCHrDUg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnu2ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OHtJcg001432;
	Thu, 24 Oct 2024 17:56:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnu2c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHpfIT006862;
	Thu, 24 Oct 2024 17:56:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjd1ney-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OHuIFd47251950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:56:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6680358054;
	Thu, 24 Oct 2024 17:56:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C025805A;
	Thu, 24 Oct 2024 17:56:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 17:56:13 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 24 Oct 2024 19:54:44 +0200
Subject: [PATCH v9 5/5] asm-generic/io.h: Remove I/O port accessors for
 HAS_IOPORT=n
Content-Type: text/plain; charset="utf-8"
Message-Id: <20241024-b4-has_ioport-v9-5-6a6668593f71@linux.ibm.com>
References: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
In-Reply-To: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
        linux-arch@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=9pbUyl42Nhcqma6QZmYcdpbw5sT9z3q1sa7WhPr42iw=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKluqRD5oe6lHZ/Cup7FcEvVHjh5cp1ghWfN6j/UM47f
 +7EqwUxHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzkSQ3DP9v/i07uPvviZagZ
 j72b49JrIo8OWVXU3L475+z3dok6tURGhu6y5Nl2wUVHXfotbtUUvd92XS958c81/lOv1TqVWq9
 IYQcA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BKscxSdustK8FLrIBOPouReXKLg57F74
X-Proofpoint-GUID: luNKqXQhiDnO6MaN0akZJiYpxhRMSLIC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240145

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
 include/asm-generic/io.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af4b7b77f582c0469c43e978f67a43..1027be6a62bcbcd5f6797e0fa42035208d0ca79f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -540,6 +540,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 
 #if !defined(inb) && !defined(_inb)
 #define _inb _inb
+#ifdef CONFIG_HAS_IOPORT
 static inline u8 _inb(unsigned long addr)
 {
 	u8 val;
@@ -549,10 +550,15 @@ static inline u8 _inb(unsigned long addr)
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
@@ -562,10 +568,15 @@ static inline u16 _inw(unsigned long addr)
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
@@ -575,36 +586,55 @@ static inline u32 _inl(unsigned long addr)
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
@@ -688,53 +718,83 @@ static inline void outl_p(u32 value, unsigned long addr)
 
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
2.45.2


