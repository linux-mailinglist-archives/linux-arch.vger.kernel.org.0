Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3554801F0
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhL0QoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230010AbhL0QoI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfhB7011929;
        Mon, 27 Dec 2021 16:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x3b7R7iz1b5Mb77oSbKN/Adqs1My+EXW6D4I0TucQs0=;
 b=l0UrEyW+3huQWhzz1pmuhuuF9nc+danenakOcphzgkddofey3TPx+ILAqjKNajwFzGPG
 w/DxqDImk8AHKnpuuX/cBBLGNCWVmdmsVUudE4LUMQsBMPkdNGt75hL6M+gGhZFD4Oyn
 Z5b8avw5ARzZqMr14kOg912w4cNKjUg5KgPv9mzfL5xVsXaV05afJZaqiAcaEMpU+cCT
 RWWWIAJ3xIk3GwC3aKdmuDxKQZEwyy5DCH9QNnzm6WM8b3bXuO+4OiFLFhQaxjIHZE//
 zE7KNVvnlIP3kIxkastM042S3nFuI8v/izfcYkJ5rAyMmNhCj/kVJceXt0QXYv7f5iSe hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:45 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGfuuw012209;
        Mon, 27 Dec 2021 16:43:44 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGhbHG009478;
        Mon, 27 Dec 2021 16:43:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3d5tx9tsnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGheZ243974956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14481A405C;
        Mon, 27 Dec 2021 16:43:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 915B0A4054;
        Mon, 27 Dec 2021 16:43:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:39 +0000 (GMT)
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
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: [RFC 16/32] misc: handle HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:43:01 +0100
Message-Id: <20211227164317.4146918-17-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BfgWnkUB20COgD5By6Ap0OIB6yjWnbn-
X-Proofpoint-ORIG-GUID: PyNZNNkoUH8p5Tmd8bGx8foxUSXW6lmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270080
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
 drivers/misc/altera-stapl/Makefile | 3 ++-
 drivers/misc/altera-stapl/altera.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/altera-stapl/Makefile b/drivers/misc/altera-stapl/Makefile
index dd0f8189666b..90f18e7bf9b0 100644
--- a/drivers/misc/altera-stapl/Makefile
+++ b/drivers/misc/altera-stapl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-altera-stapl-objs = altera-lpt.o altera-jtag.o altera-comp.o altera.o
+altera-stapl-y = altera-jtag.o altera-comp.o altera.o
+altera-stapl-$(CONFIG_HAS_IOPORT) += altera-lpt.o
 
 obj-$(CONFIG_ALTERA_STAPL) += altera-stapl.o
diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 92c0611034b0..c7ae64de8bb4 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2431,6 +2431,10 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 
 	astate->config = config;
 	if (!astate->config->jtag_io) {
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+			retval = -ENODEV;
+			goto free_state;
+		}
 		dprintk("%s: using byteblaster!\n", __func__);
 		astate->config->jtag_io = netup_jtag_io_lpt;
 	}
@@ -2505,7 +2509,7 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 
 	} else if (exec_result)
 		printk(KERN_ERR "%s: error %d\n", __func__, exec_result);
-
+free_state:
 	kfree(astate);
 free_value:
 	kfree(value);
-- 
2.32.0

