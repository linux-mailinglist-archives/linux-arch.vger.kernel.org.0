Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4370BAE6
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjEVKzI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjEVKxN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:53:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D410E3;
        Mon, 22 May 2023 03:51:44 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9cOMb010125;
        Mon, 22 May 2023 10:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qmqZ2dzPdtkRlhXTjRuzY7WKokNnKKADgdzmzf+kY2s=;
 b=TVlBtofktuuhAfuStTioKB59TYbFzM5sGU82AzY8n6IJJXn0PQwTzyW0He+Bri5HIrCr
 zv5wj7JkLvkbXgdIEtMV2+bTEQvdi1l6uBMprorAfQ5WQurU2zHtmdD3kyS3TMqF08M9
 F0rrdCLj21kJ6y64A2szlhDqNHDt+S+zGg1GHD3Nwg88Ott63v0st9tgCR+1EOZZPGiF
 Kpfyae5Fg/rL1ijobWL8r/emVY9NZbnMb3IHitEnyfntLjuCU5oKyaCyfPISLPPH2EGz
 35KGkE9UKIZNguOaEqPl1qoXpZpt4Sqs6PysZoITHMDtpK/EQxXjYOTF6pLQ1q6Kjyed Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6tdwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:33 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAb9Ob012230;
        Mon, 22 May 2023 10:51:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6tdw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M7buZh013811;
        Mon, 22 May 2023 10:51:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qppcf0rtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MApRop20447944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:51:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C20F20043;
        Mon, 22 May 2023 10:51:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03D7A20040;
        Mon, 22 May 2023 10:51:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:51:26 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v5 41/44] video: Handle HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:46 +0200
Message-Id: <20230522105049.1467313-42-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YSVnudY5LoiPrehiDDA48ZmhtF42DqFq
X-Proofpoint-ORIG-GUID: 0bPc3KvQ1cvHgEMXH0Z13Qdgd1gM95gI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=760 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to #ifdef functions and their callsites
which unconditionally use these I/O accessors. In the
include/video/vga.h these are conveniently all those functions with the
vga_io_* prefix.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/video/fbdev/Kconfig |  3 ++-
 include/video/vga.h         | 35 +++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4eea398ebbfe..598d06bddf6a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -532,7 +532,8 @@ config FB_IMSTT
 
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
-	depends on FB && HAS_IOPORT
+	depends on FB && (X86 || PPC)
+	depends on HAS_IOPORT
 	select APERTURE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/include/video/vga.h b/include/video/vga.h
index 947c0abd04ef..ed89295941c4 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -201,6 +201,7 @@ extern int restore_vga(struct vgastate *state);
  * generic VGA port read/write
  */
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_r (unsigned short port)
 {
 	return inb_p(port);
@@ -210,12 +211,12 @@ static inline void vga_io_w (unsigned short port, unsigned char val)
 {
 	outb_p(val, port);
 }
-
 static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
 				  unsigned char val)
 {
 	outw(VGA_OUT16VAL (val, reg), port);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
 {
@@ -235,28 +236,34 @@ static inline void vga_mm_w_fast (void __iomem *regbase, unsigned short port,
 
 static inline unsigned char vga_r (void __iomem *regbase, unsigned short port)
 {
-	if (regbase)
-		return vga_mm_r (regbase, port);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		return vga_io_r (port);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		return vga_mm_r (regbase, port);
 }
 
 static inline void vga_w (void __iomem *regbase, unsigned short port, unsigned char val)
 {
-	if (regbase)
-		vga_mm_w (regbase, port, val);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		vga_io_w (port, val);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		vga_mm_w (regbase, port, val);
 }
 
 
 static inline void vga_w_fast (void __iomem *regbase, unsigned short port,
 			       unsigned char reg, unsigned char val)
 {
-	if (regbase)
-		vga_mm_w_fast (regbase, port, reg, val);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		vga_io_w_fast (port, reg, val);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		vga_mm_w_fast (regbase, port, reg, val);
 }
 
 
@@ -280,6 +287,7 @@ static inline void vga_wcrt (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rcrt (unsigned char reg)
 {
         vga_io_w (VGA_CRT_IC, reg);
@@ -295,6 +303,7 @@ static inline void vga_io_wcrt (unsigned char reg, unsigned char val)
         vga_io_w (VGA_CRT_DC, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rcrt (void __iomem *regbase, unsigned char reg)
 {
@@ -333,6 +342,7 @@ static inline void vga_wseq (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rseq (unsigned char reg)
 {
         vga_io_w (VGA_SEQ_I, reg);
@@ -348,6 +358,7 @@ static inline void vga_io_wseq (unsigned char reg, unsigned char val)
         vga_io_w (VGA_SEQ_D, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rseq (void __iomem *regbase, unsigned char reg)
 {
@@ -385,6 +396,7 @@ static inline void vga_wgfx (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rgfx (unsigned char reg)
 {
         vga_io_w (VGA_GFX_I, reg);
@@ -400,6 +412,7 @@ static inline void vga_io_wgfx (unsigned char reg, unsigned char val)
         vga_io_w (VGA_GFX_D, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rgfx (void __iomem *regbase, unsigned char reg)
 {
@@ -434,6 +447,7 @@ static inline void vga_wattr (void __iomem *regbase, unsigned char reg, unsigned
         vga_w (regbase, VGA_ATT_W, val);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rattr (unsigned char reg)
 {
         vga_io_w (VGA_ATT_IW, reg);
@@ -445,6 +459,7 @@ static inline void vga_io_wattr (unsigned char reg, unsigned char val)
         vga_io_w (VGA_ATT_IW, reg);
         vga_io_w (VGA_ATT_W, val);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rattr (void __iomem *regbase, unsigned char reg)
 {
-- 
2.39.2

