Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570886B92D4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCNMNS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCNMNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5345C74DEE;
        Tue, 14 Mar 2023 05:12:45 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EBv91v021398;
        Tue, 14 Mar 2023 12:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NdgmMlIoea7vJyu4oX4UGluHVaQmygSR6zFwM3C2qWw=;
 b=rugV2xCrbZC2AC3daXfZeZZ4C8YQFuyY1jm9vVzG+pqQxYX5GVR1AZxrtpmXGLKb64sq
 2NNWolcnl4Pze2jdOQQrp1cvDaI4e0uuJmQpKb1UXZXxN/npZ9JLmsSJxdwNxe4ecnp4
 LJq4Bavr/tBBVFb0Ic5LaO6zrBF6ZW5MSrtJq2/frTUcsR6dOaXxkxvnpIXZrYz8O4VO
 NNU9/lnd6NfmIdEvF7Hn1O0avCSPxnX0dMjBQ5+GoKYlgMPjzeQ5yU2kBMZcEJa33mSY
 74GRRQ9iBJ09OettwUNJFqjuDGcpI/p/CbVsa2P3FNW9FsXiMGLMQl5DvtimlxVw55vB rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papenbxj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E9bfU1027062;
        Tue, 14 Mar 2023 12:12:31 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papenbxh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8XmM3029496;
        Tue, 14 Mar 2023 12:12:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p8gwfks4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCQIC17236240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FA742007D;
        Tue, 14 Mar 2023 12:12:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1977F2007C;
        Tue, 14 Mar 2023 12:12:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:26 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
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
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 07/38] drm: handle HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:45 +0100
Message-Id: <20230314121216.413434-8-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PlSVZJS_jwBDQj_1Psq3uoo-swEz2CGf
X-Proofpoint-GUID: 75W8jY6oJVtl2VT6uX7aBB4ogE891Uc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=654 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
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
those drivers using them. In the bochs driver there is optional MMIO
support detected at runtime, warn if this isn't taken when
HAS_IOPORT is not defined.

There is also a direct and hard coded use in cirrus.c which according to
the comment is only necessary during resume.  Let's just skip this as
for example s390 which doesn't have I/O port support also doesen't
support suspend/resume.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/gpu/drm/qxl/Kconfig   |  1 +
 drivers/gpu/drm/tiny/bochs.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/tiny/cirrus.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
index ca3f51c2a8fe..d0e0d440c8d9 100644
--- a/drivers/gpu/drm/qxl/Kconfig
+++ b/drivers/gpu/drm/qxl/Kconfig
@@ -2,6 +2,7 @@
 config DRM_QXL
 	tristate "QXL virtual GPU"
 	depends on DRM && PCI && MMU
+	depends on HAS_IOPORT
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_TTM_HELPER
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 024346054c70..da4a5d53b003 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <asm/bug.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -105,7 +106,11 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
 
 		writeb(val, bochs->mmio + offset);
 	} else {
+#ifdef HAS_IOPORT
 		outb(val, ioport);
+#else
+		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
+#endif
 	}
 }
 
@@ -119,7 +124,12 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
 
 		return readb(bochs->mmio + offset);
 	} else {
+#ifdef HAS_IOPORT
 		return inb(ioport);
+#else
+		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
+		return 0xff;
+#endif
 	}
 }
 
@@ -132,8 +142,13 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 
 		ret = readw(bochs->mmio + offset);
 	} else {
+#ifdef HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		ret = inw(VBE_DISPI_IOPORT_DATA);
+#else
+		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
+		ret = 0xffff;
+#endif
 	}
 	return ret;
 }
@@ -145,8 +160,12 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 
 		writew(val, bochs->mmio + offset);
 	} else {
+#ifdef HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		outw(val, VBE_DISPI_IOPORT_DATA);
+#else
+		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
+#endif
 	}
 }
 
diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index accfa52e78c5..9da89732c5ac 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -308,8 +308,10 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 
 	cirrus_set_start_address(cirrus, 0);
 
+#ifdef CONFIG_HAS_IOPORT
 	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
 	outb(0x20, 0x3c0);
+#endif
 
 	drm_dev_exit(idx);
 	return 0;
-- 
2.37.2

