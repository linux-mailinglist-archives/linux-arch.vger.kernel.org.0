Return-Path: <linux-arch+bounces-7839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2411B994B5D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B7DB23FBB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534411DEFEC;
	Tue,  8 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WiIVuAXi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5191DE4CB;
	Tue,  8 Oct 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391293; cv=none; b=t/DqEu1hQbS6KzRYwQMDNOMm1x2aa2FZwSUw+dhLaA7XHfcUA+8bAPZ+YaN9KEmPNASB4lSKll0PbbtU3s7giRC/rJqO4N0SHOn8Cmz4tMLV0Wdz0JcWA1yLV/BBD+pH5IqHOdTpxKVrbz/9sNRSUj0etcBGESYSAob1jxErshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391293; c=relaxed/simple;
	bh=j7KaGUsyaLEUfGtXkukiFzIvWKJHDMnnZRqJknyuK2M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nesT8sn1N/Qg8t+Em/FpGz2xbulHBymfRRAqmcD/+ZkRMBTglOkKBE09EcrkbVa0giQXGHanKK8r2AswDOaZlGnyhFjcQfBYdnD+6oarhFOSsLD4q45ItB3NpVCOLD2hAHEmI3uzf4w8oCgDYaRpxGCCZ2Xg5rthjJOSZ8dpeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WiIVuAXi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498BsMpS006194;
	Tue, 8 Oct 2024 12:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:content-type:message-id:references:in-reply-to:to
	:cc:content-transfer-encoding:mime-version; s=pp1; bh=gJGd5/wr8D
	cxtqBm0AFwiAsWUR/rh1W6zfn73uIs31M=; b=WiIVuAXi//XTK+GAvS53FesISF
	AEcXXbY57tr/ItEJeGg2zH0XgEu8CDF8jbUsxvbCgl1R8rG5uTyl5008CqprqWb/
	7DH1KymenTA8aQITz/kojV7/oWg9Pmq8hOZD/DrCkMtQRYr+/Hx1Xc7VKvPaCqg4
	2jGBDpD3R6p9ZHjCMxl17A5FRWy5oDZy3EHEHRNRrcvkrpozqs3coDOOo+EcOOW8
	1JNs7sP7RaLe8I2s7/eAbvsatYXmqXx80ZgyLLEQ09626fGhO/1bZKVn7MMiLJiV
	SRqw9hS6BIWYjoTn38AUyMRYndeBdmr8WocshnCYr6ZnuKXi87jfrvgsrx2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42549908pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498Ca5Ne023011;
	Tue, 8 Oct 2024 12:40:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42549908p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498APkGC010715;
	Tue, 8 Oct 2024 12:40:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jc124-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498CetU627001508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 12:40:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD8058054;
	Tue,  8 Oct 2024 12:40:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC4F58066;
	Tue,  8 Oct 2024 12:40:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 12:40:50 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 08 Oct 2024 14:39:46 +0200
Subject: [PATCH v8 5/5] asm-generic/io.h: Remove I/O port accessors for
 HAS_IOPORT=n
Content-Type: text/plain; charset="utf-8"
Message-Id: <20241008-b4-has_ioport-v8-5-793e68aeadda@linux.ibm.com>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
In-Reply-To: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
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
 bh=j7KaGUsyaLEUfGtXkukiFzIvWKJHDMnnZRqJknyuK2M=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZNQzXGM6a7CKhPjMv48StB+W1vKk2+zfa73tq8F3Ch
 Zlh+/t1HaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzkYj3DP/VVKno+F2SXiM5L
 /LnePUmH+2RMuGLmLp17u3OFnDrV1jEyzHW/f+uGsRTDg67md8Vn9boW+/jNmC26ysZjy47kVS8
 cWAE=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5qJmzXVUXu_PPGWzienVGSvZhaeyctpR
X-Proofpoint-ORIG-GUID: RHnEoljeT0f3lG_stDyffoOEyw6MUwE3
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
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080078

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
2.43.0


