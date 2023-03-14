Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9B6B931A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCNMPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCNMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51DA0F23;
        Tue, 14 Mar 2023 05:13:10 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EC0GcT016896;
        Tue, 14 Mar 2023 12:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ild5HBQy6ZyBXnH/8IOYxskl2r9VDYJMtmuh3COMvf4=;
 b=gVHrHveBQlzm/opojwkN+cQXT3hXkiBOjRMQUkEfJ+FBzI3Oqujo518Hsr5quaX4cbEO
 rPXdMFrGtXXe8o78TvRz6e7enKVdJ676z+8ukmq8AqAq1Pfhhj0h9y2mynfkSZhsHoXM
 QzcA6KWWUivF+IrYMsvr6GZeAvDtUQEVYKOY4HxbIANgVE0yBajqlb/GyniyD4AlQN+o
 agcytVm1QtJ4t6XVa8fhV2yt2LfS9cH1bvIkyJrkr6ljECyMF5377cDwX0ZB2i+dDTlc
 2lhDI3wduuqmRo5l4Ps6U8o6ZZoqq+p8MtnKwMDBGCLWuqEmLg693qQNPzrkzbMhf1E0 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23uc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBM4ME025738;
        Tue, 14 Mar 2023 12:12:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23ub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7uGPY001011;
        Tue, 14 Mar 2023 12:12:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mrw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCaLK000540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8BC2007A;
        Tue, 14 Mar 2023 12:12:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A1212007D;
        Tue, 14 Mar 2023 12:12:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:36 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
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
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH v3 19/38] mpt fusion: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:57 +0100
Message-Id: <20230314121216.413434-20-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QksM_jC-8JxG-rApA-S_A3Bu3alLe2cV
X-Proofpoint-GUID: VvXgicXL0JQoVNjoq33IbC4bol01cN8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=917 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
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
 drivers/message/fusion/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
index a3d0288fd0e2..88a6e506a942 100644
--- a/drivers/message/fusion/Kconfig
+++ b/drivers/message/fusion/Kconfig
@@ -2,7 +2,7 @@
 
 menuconfig FUSION
 	bool "Fusion MPT device support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	Say Y here to get to see options for Fusion Message
 	Passing Technology (MPT) drivers.
-- 
2.37.2

