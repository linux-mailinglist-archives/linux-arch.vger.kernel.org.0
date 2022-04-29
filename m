Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54577514BF4
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbiD2N5k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376765AbiD2N4q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:56:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884DDCE679;
        Fri, 29 Apr 2022 06:51:56 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCPJna018469;
        Fri, 29 Apr 2022 13:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RcNkQX5z7RIrwJgtlTJ9IWhaRouQF0bHtS4kZ+78lL0=;
 b=HMdoIP9EFNxuFZ0X/Qmzj7uO4amOVr764v05Zw6M6GcoUsjCAInRfauKkN/Oa2gf9t/P
 aeFn/wWcHb8w0kIsUvXkMo1ONl8+x5Jqoc3sXlcJvTwb5u2NzezKHk7vECZ78CDxoUbQ
 HgABBVsOpPKyXi29tDBZNMhnw1VD85SiJzPVrC/SkP6euIzQqsTBIAwjuHIz2bKimYWf
 BBkYJlvwm9oOjeXUqxbflaUBRXFlBcMPMrRimtDrTQaPeNzM2CgLzO9XErdeJvwfkcDd
 cqmP1P/nMCLpb76AFKJmYxjpWfnZ55kepfDg1+uq4ooab+qSPLyknZ3X+CarORDdQB8H yw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvaq27ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRreh011863;
        Fri, 29 Apr 2022 13:51:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhqaw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDcbbU48038340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 182BB4C046;
        Fri, 29 Apr 2022 13:51:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2F4D4C040;
        Fri, 29 Apr 2022 13:51:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:45 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 35/37] /dev/port: don't compile file operations without CONFIG_DEVPORT
Date:   Fri, 29 Apr 2022 15:51:01 +0200
Message-Id: <20220429135108.2781579-64-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8kqWhcxp0kwNlDdahw3pTFRK_m6w0aDr
X-Proofpoint-GUID: 8kqWhcxp0kwNlDdahw3pTFRK_m6w0aDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=978 clxscore=1015
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

In the future inb() and friends will not be available when compiling
with CONFIG_HAS_IOPORT=n so we must only try to access them here if
CONFIG_DEVPORT is set which depends on HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/char/mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..c1373617153f 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -402,6 +402,7 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+#ifdef CONFIG_DEVPORT
 static ssize_t read_port(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -443,6 +444,7 @@ static ssize_t write_port(struct file *file, const char __user *buf,
 	*ppos = i;
 	return tmp-buf;
 }
+#endif
 
 static ssize_t read_null(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
@@ -665,12 +667,14 @@ static const struct file_operations null_fops = {
 	.splice_write	= splice_write_null,
 };
 
-static const struct file_operations __maybe_unused port_fops = {
+#ifdef CONFIG_DEVPORT
+static const struct file_operations port_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_port,
 	.write		= write_port,
 	.open		= open_port,
 };
+#endif
 
 static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
-- 
2.32.0

