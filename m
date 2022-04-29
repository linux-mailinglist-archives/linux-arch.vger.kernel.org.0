Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3F514BC0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376749AbiD2N5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376528AbiD2N4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:56:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D102CE4B8;
        Fri, 29 Apr 2022 06:51:54 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDYhSl008429;
        Fri, 29 Apr 2022 13:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tOl03ECMEn4YtYdNKQOLjABy+3U2mCnQjDfJteHnEJE=;
 b=j7Pmz35WyQRuo8W4Jv8jTL/s6ga4cYNzB191f21SnmzbeCDozXjZWok1S2wqsoArywKV
 YX/fA7WlUfzwX2ikQP9vN62z51+E1eHLITaLhqnujDsZrrDdErwClKjbn/6J5iUQKrRo
 zCjKr4iXoqWD5ildcqxcmGm3/NZ81oynpOfgfZyNHuLOHAIWlsvtwkhntdb4C6JBvb73
 VFp8RdMhz4ukezenQtZRfqLaqzkgTplb4546RcfAJRXFpdMjmeXaCUI7+56p+giND56Y
 Zgj0nHmSEQZ4Dy/OTd5fAuF8k0g8c6PmNDUkwT5EsI7EHbYMGDw/QLnZCs3KGKPqVRMI sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p511r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDEqGJ010914;
        Fri, 29 Apr 2022 13:51:46 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p5111-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRowh013390;
        Fri, 29 Apr 2022 13:51:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3fm938yatn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpg4726345980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB8964C040;
        Fri, 29 Apr 2022 13:51:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88B5F4C044;
        Fri, 29 Apr 2022 13:51:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:41 +0000 (GMT)
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
Subject: [PATCH 31/37] drm: handle HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:53 +0200
Message-Id: <20220429135108.2781579-56-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T5f3POypuR3DXhIqnVvnwVD5pm7bTljv
X-Proofpoint-ORIG-GUID: 88UZj_djQHbMNnuH__xJuymd1-WRkzX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=567 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them. There is also a direct and hard coded use in
cirrus.c which according to the comment is only necessary during resume.
Let's just skip this as for example s390 which doesn't have I/O port
support also doesen't support suspend/resume.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/gpu/drm/qxl/Kconfig   | 1 +
 drivers/gpu/drm/tiny/Kconfig  | 1 +
 drivers/gpu/drm/tiny/cirrus.c | 2 ++
 3 files changed, 4 insertions(+)

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
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 627d637a1e7e..7102783809c3 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -13,6 +13,7 @@ config DRM_ARCPGU
 config DRM_BOCHS
 	tristate "DRM Support for bochs dispi vga interface (qemu stdvga)"
 	depends on DRM && PCI && MMU
+	depends on HAS_IOPORT
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
 	select DRM_TTM
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

