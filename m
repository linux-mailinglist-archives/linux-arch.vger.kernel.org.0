Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF9514B48
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbiD2Nzd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376484AbiD2NzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EF55C66E;
        Fri, 29 Apr 2022 06:51:31 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TC3ICn024330;
        Fri, 29 Apr 2022 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hl58tR8SCGsjWubBXCsSzcoY2kZXTwOMnwT12Ua8eWM=;
 b=nBOH7G9AfEaS+sqS2VcvBc5eTQcDlU5RbqLJW1Q2P35lOrj1XnBWYbo9ollhkVZgqaN/
 ne2eAXHPgl2ubNQOpNrul8bwG5QXlK9RQ1d+JnGg5n+rWLxLGNEpzXWSUJOa7pgqGJ5s
 RayMSqQWC4cytbuY7c3r4+Ur4TiPkNhvubJJ3xT+EsaiqZVIRgId1pKXRTvqJHP8SEhu
 Qsuy4HUeBqS3FnMIZpmmRMDXIm4t63PQFrrlr65pArqi8nvxQHXkNe7d4j62+3k5y7CP
 HpZo0q1Hfefh9TNSsUeRFYlEaNJmbYPUT7AAB6Vms9rF0LYwpBSbcPr9LHN4z19fFN6j Ng== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke41q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRqtH027673;
        Fri, 29 Apr 2022 13:51:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938yan2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpMkF48169246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D4F14C044;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DEFF4C046;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [RFC v2 13/39] iio: adc: Kconfig: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:20 +0200
Message-Id: <20220429135108.2781579-23-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tTSVUjRz5FRignMfD5W_juWzGbTfg2js
X-Proofpoint-GUID: tTSVUjRz5FRignMfD5W_juWzGbTfg2js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290078
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
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 71ab0a06aa82..c99843307e4f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -130,7 +130,7 @@ config AD7606
 
 config AD7606_IFACE_PARALLEL
 	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
-	depends on HAS_IOMEM
+	depends on HAS_IOPORT
 	select AD7606
 	help
 	  Say yes here to build parallel interface support for Analog Devices:
-- 
2.32.0

