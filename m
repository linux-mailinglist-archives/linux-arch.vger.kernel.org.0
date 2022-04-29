Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28834514B44
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376532AbiD2NzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376464AbiD2Ny5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B035A14F;
        Fri, 29 Apr 2022 06:51:31 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBZSqW029789;
        Fri, 29 Apr 2022 13:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JsP9DZ13GY9p4Te/4OhuyLur42PMbft/qLBbv9gdVfA=;
 b=NdBt+3oWgMAh6kkB5ONjj6VT9226CnPF3qib/HpQq0itE/3j34BjXwWM5FT6Ri6Ob4Eg
 pn9x+wVa57SeWNcXePpggb2jaoFu2r463WXTlBY/ycXqyQdgWD6DAweWjdfGwvHHLcZ4
 0BELjPDh2ikuzvNHGlgfWPu6yMBFNX073G7yzY25Bcn7gcZPR+GB66j2hfmXoZUMtn6D
 03zaAaVsCxCRP24JO38Ldtq0xJFFZa7JoHLu59iMa8vi+lR0tsQqecuKMCprks0W0qi4
 3Llkk2yFvVhDIASkWVZs+XT9/c41zqI9nHmIeO//3VK8NM1MYLngreFg61Ftcqjk7q9H NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqv5rjk2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDVxnB015749;
        Fri, 29 Apr 2022 13:51:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqv5rjk1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQlvl014243;
        Fri, 29 Apr 2022 13:51:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpJ9F38273394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17FDA4C040;
        Fri, 29 Apr 2022 13:51:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D314C044;
        Fri, 29 Apr 2022 13:51:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:18 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [RFC v2 08/39] drm: handle HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:13 +0200
Message-Id: <20220429135108.2781579-16-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z2_b3Ep6jzQYlZLubaqzG5wd29WjJfWI
X-Proofpoint-ORIG-GUID: 2dZ9-j-Mnz9uF8ZFVdGA_r1MSqumR5yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=708 classifier=spam adjust=0 reason=mlx scancount=1
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
index ed971c8bb446..9acc726d99ec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <asm/bug.h>
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
@@ -102,7 +103,11 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
 
 		writeb(val, bochs->mmio + offset);
 	} else {
+#ifdef HAS_IOPORT
 		outb(val, ioport);
+#else
+		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
+#endif
 	}
 }
 
@@ -116,7 +121,12 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
 
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
 
@@ -129,8 +139,13 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 
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
@@ -142,8 +157,12 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 
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
index c8e791840862..0dc4788c5399 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -306,8 +306,10 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 
 	cirrus_set_start_address(cirrus, 0);
 
+#ifdef CONFIG_HAS_IOPORT
 	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
 	outb(0x20, 0x3c0);
+#endif
 
 	drm_dev_exit(idx);
 	return 0;
-- 
2.32.0

