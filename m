Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EBF4801D2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhL0QoN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57610 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhL0QoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:04 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfnCa017488;
        Mon, 27 Dec 2021 16:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zFVamE5yMrJop6aOfxuo/svDSoyuUM8QC9jHNU4Bwh8=;
 b=SC8GPIWPvRrakW2Kwz1vS20hmcEQm6Y2OsqQ7kN9gHY3DcETPUcx/QGQo8HXUX+vezBB
 A4tbrNQfAMgr29a5JrvgLKSKaqkgsEKDRV+8vHx/xAXnxa2ckrP75WXygEoar9M/ykWz
 kVT9m6Bku9LD37F4OkvUD4QBgPUVc4fbW1s+ItDMDW0PPlFrBbnFR2qUhEeOI07mslr6
 yoGsAfVzej4yKCeZC+2joKouAAq1BKpZGhwgM9ya7iyJbBTOQ4aI8rck33K7MifNDMJz
 k5UDJR0gdPHPx0XJKpH3azdlkgf2Pp5ZjLZa/SqHuUiOSeuLt2Wb4yxUg/MNlyKcp3N7 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7h7u80v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGhe3e023887;
        Mon, 27 Dec 2021 16:43:40 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7h7u80u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGh4g8007888;
        Mon, 27 Dec 2021 16:43:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3d5tx9asm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhZRH40632760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFA59A405C;
        Mon, 27 Dec 2021 16:43:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48993A4054;
        Mon, 27 Dec 2021 16:43:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:35 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-input@vger.kernel.org
Subject: [RFC 11/32] Input: Kconfig: add HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:42:56 +0100
Message-Id: <20211227164317.4146918-12-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A1DUS9DrDIJkHlzeXlDXpoEFLDhFrKX0
X-Proofpoint-ORIG-GUID: ECthtyuMMzAFK14KJqQYBG2ERGxapcuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=943
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/input/serio/Kconfig       | 2 ++
 drivers/input/touchscreen/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index f39b7b3f7942..5d125627c595 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -75,6 +75,7 @@ config SERIO_Q40KBD
 config SERIO_PARKBD
 	tristate "Parallel port keyboard adapter"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you built a simple parallel port adapter to attach
 	  an additional AT keyboard, XT keyboard or PS/2 mouse.
@@ -148,6 +149,7 @@ config HIL_MLC
 config SERIO_PCIPS2
 	tristate "PCI PS/2 keyboard and PS/2 mouse controller"
 	depends on PCI
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you have a Mobility Docking station with PS/2
 	  keyboard and mice ports.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2f6adfb7b938..a77663b79aec 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -664,6 +664,7 @@ config TOUCHSCREEN_INEXIO
 
 config TOUCHSCREEN_MK712
 	tristate "ICS MicroClock MK712 touchscreen"
+	depends on ISA
 	help
 	  Say Y here if you have the ICS MicroClock MK712 touchscreen
 	  controller chip in your system.
-- 
2.32.0

