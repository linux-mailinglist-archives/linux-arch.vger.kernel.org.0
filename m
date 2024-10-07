Return-Path: <linux-arch+bounces-7758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CE992A7C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C942A284527
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234C1D2234;
	Mon,  7 Oct 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kbKGuVKE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71A1D222A;
	Mon,  7 Oct 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301334; cv=none; b=e4kCw9oAJRc8dtX1tEAjeCL9Mw09TbI0Iurs0FJN4JErFQIRztS9mY5NXTeZWfXox4Wze28+iO8yw0cT/YofvBlFLInDQq1ghZEVJjMIMYA+68Cq1s5Avb1/xKeg29HTHeLRnQ0cf5L/Tn2SevIsphfRtXbk3eJnSiWcZKZants=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301334; c=relaxed/simple;
	bh=452wRDdZVge/AMLetS6xwz17eNsBGeFm8OBE1Z7u7ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3gdzvR5kmFmqNpfSAHOMonvdjEU6/f3OsGrTbH4STzkVwoZcUw1aL91RoV3O5akTzLTPesCR7ZHYs7V5HMV61X8OG81FgSe6DbL5OXQ/uG3LiGdd0LHI7AI+qTXik5APDVjsY0tBTUh/qYO+hk0rkURjdNDLlcR+0KWuyM7nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kbKGuVKE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4979oJlB005069;
	Mon, 7 Oct 2024 11:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=72pwqshR3qxkaW+7U1NLp3jIjLyYZkCRJJ2wyTWK6V0=; b=k
	bKGuVKEABf7oTYTnvuFXai9R5nt5LcdC32PCyVC/U/kEcrgG5i9yFlr7Bm/k9avn
	k517sBG4Mtvya7yrHcEjc3QMvN3B6U/N/SCIgWjN9Z6RmjG+C1EpYYbPu6+d3efw
	yTTAT1oqqI3jWbb1OFGwSWFzocmOSgroFsbHGNpuNXESP+B3dG2QMbTzSijtrZyL
	CjhArVktIeWdeOz6zmYTgBisQZdmBNgspjgTtWqOZkeBq9KQvhnIJ6YfA0P56FjB
	NUtNjBcp/L7nObJR+fgfq63kkhcwnQfzUoQEQxwPeCdo5zrGdPuh1ltWDvlSXypf
	kpz4OWKS/p6RUEWtexB3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424dbv8kua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497Bfq3U027912;
	Mon, 7 Oct 2024 11:41:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424dbv8ku4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497BP0ss022847;
	Mon, 7 Oct 2024 11:41:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jp7jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497BfoF428377820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 11:41:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1022858045;
	Mon,  7 Oct 2024 11:41:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E723C58052;
	Mon,  7 Oct 2024 11:41:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 11:41:44 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 07 Oct 2024 13:40:21 +0200
Subject: [PATCH v6 3/5] drm: handle HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-has_ioport-v6-3-03f7240da6e5@linux.ibm.com>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
In-Reply-To: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4808;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=452wRDdZVge/AMLetS6xwz17eNsBGeFm8OBE1Z7u7ZM=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKZT1yfYmFntfZl0KN6zcvVZW9mrYzurW39MW8Xo7xSt
 Mv/VR93dJSyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCRRmaGfxq+cu9mRDmHePnm
 fZ6v6bvchsHXJjL5zIq0x3r79wq+CmD4Z3Bjm+yGTUs+3v6zw9qkW0HhikrUIk/JqMtWzX6u/ik
 ajAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wg1rloEW3hsU4LVfVOx_G7WPzb-HhEIt
X-Proofpoint-GUID: l7N0xQgrEdCkHZcxUUQWs9Olel4My4t0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_02,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=997 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070081

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them. In the bochs driver there is optional MMIO support
detected at runtime, warn if this isn't taken when HAS_IOPORT is not
defined.

There is also a direct and hard coded use in cirrus.c which according to
the comment is only necessary during resume.  Let's just skip this as
for example s390 which doesn't have I/O port support also doesen't
support suspend/resume.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/gpu/drm/gma500/Kconfig |  2 +-
 drivers/gpu/drm/qxl/Kconfig    |  1 +
 drivers/gpu/drm/tiny/bochs.c   | 17 +++++++++++++++++
 drivers/gpu/drm/tiny/cirrus.c  |  2 ++
 drivers/gpu/drm/xe/Kconfig     |  2 +-
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index efb4a2dd2f80885cb59c925d09401002278d7d61..23b7c14de5e29238ece939d5822d8a9ffc4675cc 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_GMA500
 	tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
-	depends on DRM && PCI && X86 && MMU
+	depends on DRM && PCI && X86 && MMU && HAS_IOPORT
 	select DRM_KMS_HELPER
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select I2C
diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
index ca3f51c2a8fe1a383f8a2479f04b5c0b3fb14e44..d0e0d440c8d96564cb7b8ffd2385c44fc43f873d 100644
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
index 31fc5d839e106ea4d5c8fe42d1bfc3c70291e3fb..0ed78d3d5774778f91de972ac27056938036e722 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/bug.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -105,7 +106,9 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
 
 		writeb(val, bochs->mmio + offset);
 	} else {
+#ifdef CONFIG_HAS_IOPORT
 		outb(val, ioport);
+#endif
 	}
 }
 
@@ -119,7 +122,11 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
 
 		return readb(bochs->mmio + offset);
 	} else {
+#ifdef CONFIG_HAS_IOPORT
 		return inb(ioport);
+#else
+		return 0xff;
+#endif
 	}
 }
 
@@ -132,8 +139,12 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 
 		ret = readw(bochs->mmio + offset);
 	} else {
+#ifdef CONFIG_HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		ret = inw(VBE_DISPI_IOPORT_DATA);
+#else
+		ret = 0xffff;
+#endif
 	}
 	return ret;
 }
@@ -145,8 +156,10 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 
 		writew(val, bochs->mmio + offset);
 	} else {
+#ifdef CONFIG_HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		outw(val, VBE_DISPI_IOPORT_DATA);
+#endif
 	}
 }
 
@@ -229,6 +242,10 @@ static int bochs_hw_init(struct drm_device *dev)
 			return -ENOMEM;
 		}
 	} else {
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+			DRM_ERROR("I/O ports are not supported\n");
+			return -EIO;
+		}
 		ioaddr = VBE_DISPI_IOPORT_INDEX;
 		iosize = 2;
 		if (!request_region(ioaddr, iosize, "bochs-drm")) {
diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 751326e3d9c374baf72115492aeefff2b73869f0..e31e1df029ab0272c4a1ff0ab3eb026ca679b560 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -509,8 +509,10 @@ static void cirrus_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 
 	cirrus_mode_set(cirrus, &crtc_state->mode);
 
+#ifdef CONFIG_HAS_IOPORT
 	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
 	outb(VGA_AR_ENABLE_DISPLAY, VGA_ATT_W);
+#endif
 
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 7bbe46a98ff1f449bc2af30686585a00e9e8af93..116f58774135fc3a9f37d6d72d41340f5c812297 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -49,7 +49,7 @@ config DRM_XE
 
 config DRM_XE_DISPLAY
 	bool "Enable display support"
-	depends on DRM_XE && DRM_XE=m
+	depends on DRM_XE && DRM_XE=m && HAS_IOPORT
 	select FB_IOMEM_HELPERS
 	select I2C
 	select I2C_ALGOBIT

-- 
2.43.0


