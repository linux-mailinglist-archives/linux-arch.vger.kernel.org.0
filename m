Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40DE6B9330
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCNMPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjCNMOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:14:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000060400;
        Tue, 14 Mar 2023 05:13:21 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EAl89D030644;
        Tue, 14 Mar 2023 12:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PRQD49KFjaxwXN+kSEDaYzrjl2czSCBAq7mMgzRtK8k=;
 b=C08AkDcxa/EZPgXr+fC21tC+gjBSrf/Z+VQ1bQ51U8Uikcuv7c2TA175cJIrzQGRsyck
 bph0ui6XDvs6ZcsvG9ypvQwqcwHY9ipEOPdGeiBtPBOWZosgUdVHZ8vCZHBDUDUdOKfT
 uMfF47jORQR4kttRErt7yO80tnrKBINSJnXvsifrsk+KDVtiKpDwY38m48dhB7QUg5tD
 xWnbEtR5mVQVMIZHyH57SLAk6GE5NCr9llVpNE4oBoInO2YrvCaszknE7XLeZkULCDrp
 rNUYujsqGSIPeaXtVOW5Cu/23C+asEl5dF29ONpUHjsF/JAXrPpBJuF0DQuA/2KnsZ+H FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqftj551-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:36 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBHInM026076;
        Tue, 14 Mar 2023 12:12:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqftj53s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8wsv9016335;
        Tue, 14 Mar 2023 12:12:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3p8h96kscj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCUVe26608138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D33C2007F;
        Tue, 14 Mar 2023 12:12:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DD702007C;
        Tue, 14 Mar 2023 12:12:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:30 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 12/38] iio: ad7606: Kconfig: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:50 +0100
Message-Id: <20230314121216.413434-13-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w0b3qAZ9PUIcLL8mFiAdc-KlG46IEsFw
X-Proofpoint-GUID: Xa9Y3bErBlM_6c6JeWYaqpXkHLGLuR5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=792 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140103
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45af2302be53..df4c7d80d765 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -145,7 +145,7 @@ config AD7606
 
 config AD7606_IFACE_PARALLEL
 	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
-	depends on HAS_IOMEM
+	depends on HAS_IOPORT
 	select AD7606
 	help
 	  Say yes here to build parallel interface support for Analog Devices:
-- 
2.37.2

