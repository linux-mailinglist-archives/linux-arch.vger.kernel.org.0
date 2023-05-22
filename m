Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8286870BA9D
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjEVKwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjEVKvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68431A8;
        Mon, 22 May 2023 03:51:26 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MANwQM029722;
        Mon, 22 May 2023 10:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kZbh9TuLodKcSl9IAvECr9fdM5pb/9fofPwHViYFQvE=;
 b=P6/lYUI34s/dxsx1tVMI8/Zjy6jwRb+jOlRHCt07FBzKLY9YmPEUhSNdXM5lAse7WiPk
 CyCGqOlHJzZa2gPaI7ru2FtQZ2/fBLTNwTcQZYLbSZnOeMSB0gN1RKwbqXctpdBpgbG8
 IGeGI+SqfCSUWq+M5zNDjiFaoJJtux7dnExEz5Bf1SXlPyqoU1WZnCzWeVzpGylSTL5C
 GKMmFqbmFsdSXyWpc73aA9SEYnckA5VaxbaINotY8RMztnR/SGPjB/2i6TtvUJtCDusZ
 FbHzPWm7HxOfrso/oHW+d4jEjGMbg+rCz/y6wQapdaYt8juBqW9i3MvaVp5Zz9HejHKK fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqd3tc98b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAb6mk005611;
        Mon, 22 May 2023 10:51:16 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqd3tc97h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5xB5H007770;
        Mon, 22 May 2023 10:51:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcu8wf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MApBrb2228892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:51:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FC62004B;
        Mon, 22 May 2023 10:51:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD3B120043;
        Mon, 22 May 2023 10:51:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:51:10 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v5 23/44] parport: PC style parport depends on HAS_IOPORT
Date:   Mon, 22 May 2023 12:50:28 +0200
Message-Id: <20230522105049.1467313-24-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q5y0hsUNBmLVmH2dlnWCoyXC73LYg7Gi
X-Proofpoint-GUID: XY8n3rTkFbbZfldquVZpKdTfb-e-DUiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=604 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. As PC style parport uses these functions we need to
handle this dependency.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/parport/Kconfig | 3 ++-
 include/linux/parport.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 5561362224e2..631c193fe42c 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -42,7 +42,8 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
+	depends on HAS_IOPORT
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
diff --git a/include/linux/parport.h b/include/linux/parport.h
index a0bc9e0267b7..fff39bc30629 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -514,7 +514,7 @@ extern int parport_device_proc_register(struct pardevice *device);
 extern int parport_device_proc_unregister(struct pardevice *device);
 
 /* If PC hardware is the only type supported, we can optimise a bit.  */
-#if !defined(CONFIG_PARPORT_NOT_PC)
+#if !defined(CONFIG_PARPORT_NOT_PC) && defined(CONFIG_PARPORT_PC)
 
 #include <linux/parport_pc.h>
 #define parport_write_data(p,x)            parport_pc_write_data(p,x)
-- 
2.39.2

