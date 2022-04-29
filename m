Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483D514B6D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376575AbiD2Nzh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376488AbiD2NzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC535C84E;
        Fri, 29 Apr 2022 06:51:32 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCvwmg019538;
        Fri, 29 Apr 2022 13:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ysIE5/mPGjC1gKbHUVU7cMXFrDybo5iDqb1jAtcA8Iw=;
 b=niroAutCinKER9j8kFIOV4lbtF8xCCH+FpIJfUU+XT3xp/aoGlGgHb0X4QV1fc27HPSZ
 9AputBc9o3qK2I2xE7l04mteaZZHs7QhLgwEqkFGBjJ8CBCD7byhMOZYd5/loVivfYeL
 Kh6DrGqiWwHUHL6fswV7Y3aKA6DG8nbv3o54znTl+ymK891Bk4DAEl0bn3/0H8pFD4TU
 Ridq0xWueF8LzeddRFugENYoG/B4d8R6DZ9wnrIV1YBsBGDj31Y0/PigysELoAMrq3J2
 6NMs/+NjhEF0SC9regEbPDPscjyT9YpsmN0OuC3YSBCyOdT7tpOWtqbioAg3eSMCa9QP ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p50s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:28 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDevmZ037442;
        Fri, 29 Apr 2022 13:51:27 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p50rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRoqd025884;
        Fri, 29 Apr 2022 13:51:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yag3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpNm948759274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 124884C040;
        Fri, 29 Apr 2022 13:51:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C15944C044;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...)
Subject: [PATCH 13/37] Input: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:21 +0200
Message-Id: <20220429135108.2781579-24-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XwHXm6orjuzAOLNyHZ0jSWDS4GVRYE1r
X-Proofpoint-ORIG-GUID: NsEYggQmNgCRnscUXkbBEyIqCTMbSSWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=764 priorityscore=1501
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
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
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
index 43c7d6e5bdc0..a938629d8894 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -674,6 +674,7 @@ config TOUCHSCREEN_INEXIO
 
 config TOUCHSCREEN_MK712
 	tristate "ICS MicroClock MK712 touchscreen"
+	depends on ISA
 	help
 	  Say Y here if you have the ICS MicroClock MK712 touchscreen
 	  controller chip in your system.
-- 
2.32.0

