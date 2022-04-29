Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56192514BE2
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376879AbiD2N56 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376646AbiD2N5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:57:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339605BE45;
        Fri, 29 Apr 2022 06:52:01 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBdelw018542;
        Fri, 29 Apr 2022 13:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O2RMGZNUZqyvyDp2Dtpnryg5WAFpwHOaXeavtEJ+h04=;
 b=AS1JHEnhTjtKQ1+rF+KhwtpCuQhZQgGK6bb+rUZKSrtOIP1cg9Y1RLrUoowAY+OY7xrS
 LYogL04/cPM9uNBB7MXOKI1vbxq422TULE8pJwVlHlmkGeXkJdjLFFhOS6XuRDJi3fHm
 9C/u0F5++IU6hxz2MJ8a2piItioI5bP0PqI524Tjc2r6TRQh4UtpDJWz2Mwik6C8NPfb
 +743EOK5QsFyP8kVadxqUidjvJTdpp+4ImHeZ2Tf8FdegYNQznLfZJpoptFDzo9P8U66
 hpvmDBSUshdlg77wvkA3n8KhSkmGiQjKsO9ligSxYuQQ1CMXGDVvV9ZnGEI+dvufYD6X qQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvaq279p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRL1t021679;
        Fri, 29 Apr 2022 13:51:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDcUBR50594254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 504614C046;
        Fri, 29 Apr 2022 13:51:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF68C4C044;
        Fri, 29 Apr 2022 13:51:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:38 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [RFC v2 29/39] rtc: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:49 +0200
Message-Id: <20220429135108.2781579-52-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2vt6--GgpJTTd9xXT4Uso-VHKKtrbOwX
X-Proofpoint-GUID: 2vt6--GgpJTTd9xXT4Uso-VHKKtrbOwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=509 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/rtc/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 41c65b4d2baf..e1bb11a225b2 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -951,6 +951,7 @@ comment "Platform RTC drivers"
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
 	depends on X86 || ARM || PPC || MIPS || SPARC64
+	depends on HAS_IOPORT
 	default y if X86
 	select RTC_MC146818_LIB
 	help
@@ -971,6 +972,7 @@ config RTC_DRV_CMOS
 config RTC_DRV_ALPHA
 	bool "Alpha PC-style CMOS"
 	depends on ALPHA
+	depends on HAS_IOPORT
 	select RTC_MC146818_LIB
 	default y
 	help
@@ -1188,7 +1190,7 @@ config RTC_DRV_MSM6242
 
 config RTC_DRV_BQ4802
 	tristate "TI BQ4802"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAS_IOPORT
 	help
 	  If you say Y here you will get support for the TI
 	  BQ4802 RTC chip.
-- 
2.32.0

