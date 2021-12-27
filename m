Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC5480207
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhL0Qom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230365AbhL0QoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfpFj012078;
        Mon, 27 Dec 2021 16:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1B/ikMdI9recSsvoWnx6ERZvPWBYY70quL3TrfuTclM=;
 b=Dn4HFKNTxFnBi2Mkawz0QpRXF2hsg6OKigNteERQ7fabzCJKR6o5RpE10jYPUkNloRWa
 UhqUX16ropuMsJbIjcMK7plb882bp++OIv5ENGv9Efacimt0tXwN3TlNj2iUtwcSx5wQ
 9KAe8U1qVHf0pQNfdM1uq0QAjtYcMr2qvTcXSHSRflXccefRWaCs20G+B67tFmAVXMtD
 gbmu9KGWD15DQ7K4xVut0e5Q0RoLnOE+q9oSA6ba2kOGt9rXzkZg7gQ5Xk5hVNmiNCFu
 Pku8WMHnq4OaMQ0ZANVfS4E7JLqJQZv6ST+WnkBP8rBRiyVSrOKLFJaAZ687zH5Y0hi2 Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:54 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGgenW013937;
        Mon, 27 Dec 2021 16:43:54 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug11b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:54 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGhKhr019783;
        Mon, 27 Dec 2021 16:43:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3d5tx92t5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhnh044761368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA880A405F;
        Mon, 27 Dec 2021 16:43:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D663A405B;
        Mon, 27 Dec 2021 16:43:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:49 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: [RFC 27/32] PCI/sysfs: make I/O resource depend on HAS_IOPORT
Date:   Mon, 27 Dec 2021 17:43:12 +0100
Message-Id: <20211227164317.4146918-28-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ujuf9iMmvq98x9JQzuWVzyWWjxlWNq53
X-Proofpoint-ORIG-GUID: MUt-MUcYieEPSQclck_HrIpCkLiBQ8ug
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

Exporting I/O resources only makes sense if legacy I/O spaces are
supported so conditionally add them only if HAS_IOPORT is set.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci-sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index cfe2f85af09e..a59a85593972 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1099,6 +1099,7 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 1);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *attr, char *buf,
 			       loff_t off, size_t count, bool write)
@@ -1157,6 +1158,21 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
+#else
+static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t off, size_t count)
+{
+	return -ENXIO;
+}
+
+static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
+				     struct bin_attribute *attr, char *buf,
+				     loff_t off, size_t count)
+{
+	return -ENXIO;
+}
+#endif
 
 /**
  * pci_remove_resource_files - cleanup resource files
-- 
2.32.0

