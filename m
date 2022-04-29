Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C02514BE1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbiD2N6Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376681AbiD2N5C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D720CEE1F;
        Fri, 29 Apr 2022 06:52:02 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBjWNd029710;
        Fri, 29 Apr 2022 13:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YxpQ3H20/E/Qr4kvVqxRNsgC1Qp0/t94nuLJRCpv7+M=;
 b=rgKBNLcdGUmvA//ZMq9EOqArO3PbEs1ON2cDHG9cvDfxxoBC7qdlVtP7BlEdjKMqoPjD
 dw17T3jWI9+7fYNNA03WhzGQr0H9N4WtLQ8NsfGNAsfoIjSK9hplXvmW43TbFvV81sKQ
 442MYmievexOgW/TOF0AGLugkh2yqXj8HrDQ5w16wTviyju+sKYpkVCEV/Wf2q04zOcq
 6K1zpFStCmOmeBW9AgDzp6T2d58t4jVPEeprSL2MDUAr5XpV8xrL/hv1zzlPl9X6NAOo
 OGzJfJgGQh6mzikCIntMEU+y5eGmJuZPQ8uOesySSSMOnHzKpB0zcsR4jR0WBrz6YtLQ lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqv5rjkfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TCrWu9019890;
        Fri, 29 Apr 2022 13:51:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqv5rjkej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRoqf025884;
        Fri, 29 Apr 2022 13:51:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yagd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpm6f53805380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE9C4C044;
        Fri, 29 Apr 2022 13:51:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E925E4C040;
        Fri, 29 Apr 2022 13:51:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:47 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER)
Subject: [RFC v2 36/39] video: handle HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:51:04 +0200
Message-Id: <20220429135108.2781579-67-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xTc4x_gryjS354gxUkx1J_bxI4jEUkeI
X-Proofpoint-ORIG-GUID: bNXdUOvT0ayFom4hmx5trLOAVpZonERH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them and guard inline code in headers.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/video/fbdev/Kconfig | 25 +++++++++++++------------
 include/video/vga.h         |  8 ++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 93b8d84c34cf..e7d27c0602d5 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -343,7 +343,7 @@ config FB_IMX
 
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
-	depends on FB && PCI && (BROKEN || !SPARC64)
+	depends on FB && PCI && HAS_IOPORT && (BROKEN || !SPARC64)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -436,6 +436,7 @@ config FB_FM2
 config FB_ARC
 	tristate "Arc Monochrome LCD board support"
 	depends on FB && (X86 || COMPILE_TEST)
+	depends on HAS_IOPORT
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
@@ -1242,7 +1243,7 @@ config FB_RADEON_DEBUG
 
 config FB_ATY128
 	tristate "ATI Rage128 display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1265,7 +1266,7 @@ config FB_ATY128_BACKLIGHT
 
 config FB_ATY
 	tristate "ATI Mach64 display support" if PCI || ATARI
-	depends on FB && !SPARC32
+	depends on FB && HAS_IOPORT && !SPARC32
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1315,7 +1316,7 @@ config FB_ATY_BACKLIGHT
 
 config FB_S3
 	tristate "S3 Trio/Virge support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1374,7 +1375,7 @@ config FB_SAVAGE_ACCEL
 
 config FB_SIS
 	tristate "SiS/XGI display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1404,7 +1405,7 @@ config FB_SIS_315
 
 config FB_VIA
 	tristate "VIA UniChrome (Pro) and Chrome9 display support"
-	depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
+	depends on FB && PCI && GPIOLIB && I2C && HAS_IOPORT && (X86 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1442,7 +1443,7 @@ endif
 
 config FB_NEOMAGIC
 	tristate "NeoMagic display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1470,7 +1471,7 @@ config FB_KYRO
 
 config FB_3DFX
 	tristate "3Dfx Banshee/Voodoo3/Voodoo5 display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1518,7 +1519,7 @@ config FB_VOODOO1
 
 config FB_VT8623
 	tristate "VIA VT8623 support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1532,7 +1533,7 @@ config FB_VT8623
 
 config FB_TRIDENT
 	tristate "Trident/CyberXXX/CyberBlade support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1554,7 +1555,7 @@ config FB_TRIDENT
 
 config FB_ARK
 	tristate "ARK 2000PV support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -2226,7 +2227,7 @@ config FB_SSD1307
 
 config FB_SM712
 	tristate "Silicon Motion SM712 framebuffer support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/include/video/vga.h b/include/video/vga.h
index d334e64c1c19..53cb52c0fddb 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -201,18 +201,26 @@ extern int restore_vga(struct vgastate *state);
  
 static inline unsigned char vga_io_r (unsigned short port)
 {
+#ifdef CONFIG_HAS_IOPORT
 	return inb_p(port);
+#else
+	return 0xff;
+#endif
 }
 
 static inline void vga_io_w (unsigned short port, unsigned char val)
 {
+#ifdef CONFIG_HAS_IOPORT
 	outb_p(val, port);
+#endif
 }
 
 static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
 				  unsigned char val)
 {
+#ifdef CONFIG_HAS_IOPORT
 	outw(VGA_OUT16VAL (val, reg), port);
+#endif
 }
 
 static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
-- 
2.32.0

