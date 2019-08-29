Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07A4A1FDC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfH2PvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:51:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbfH2PvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TFlssW044910;
        Thu, 29 Aug 2019 11:51:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upfu0n5nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 11:51:06 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TFp3O1012114;
        Thu, 29 Aug 2019 15:51:05 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 2ujvv6w8kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 15:51:05 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TFp4bA18940378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 15:51:04 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D8E6AE060;
        Thu, 29 Aug 2019 15:51:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91758AE05F;
        Thu, 29 Aug 2019 15:51:01 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.151.248])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 15:51:01 +0000 (GMT)
From:   "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au,
        andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        cclaudio@linux.ibm.com,
        "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 2/2] docs: powerpc: Add ELF note documentation
Date:   Thu, 29 Aug 2019 12:50:21 -0300
Message-Id: <20190829155021.2915-3-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829155021.2915-1-maxiwell@linux.ibm.com>
References: <20190829155021.2915-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=925 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290168
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The ELF note documentation describes the types and descriptors to be
used with the PowerPC namespace.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
---
 Documentation/powerpc/elfnote.rst | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/powerpc/elfnote.rst

diff --git a/Documentation/powerpc/elfnote.rst b/Documentation/powerpc/elfnote.rst
new file mode 100644
index 000000000000..2a5c4beeb809
--- /dev/null
+++ b/Documentation/powerpc/elfnote.rst
@@ -0,0 +1,42 @@
+==========================
+ELF Note PowerPC Namespace
+==========================
+
+The PowerPC namespace in an ELF Note of the kernel binary is used to store
+capabilities and information which can be used by a bootloader or userland.
+
+Types and Descriptors
+---------------------
+
+The types to be used with the "PowerPC" namesapce are defined in the
+include/uapi/asm/elfnote.h
+
+	1) PPC_ELFNOTE_CAPABILITIES
+
+Define the capabilities supported/required by the kernel. This type uses a
+bitmap as "descriptor" field. Each bit is described below:
+
+- Ultravisor-capable bit (PowerNV only).
+
+	#define PPCCAP_ULTRAVISOR_BIT (1 << 0)
+
+	Indicate that the powerpc kernel binary knows how to run in an
+	ultravisor-enabled system.
+
+	In an ultravisor-enabled system, some machine resources are now controlled
+	by the ultravisor. If the kernel is not ultravisor-capable, but it ends up
+	being run on a machine with ultravisor, the kernel will probably crash
+	trying to access ultravisor resources. For instance, it may crash in early
+	boot trying to set the partition table entry 0.
+
+	In an ultravisor-enabled system, a bootloader could warn the user or prevent
+   	the kernel from being run if the PowerPC ultravisor capability doesn't exist
+	or the Ultravisor-capable bit is not set.
+
+References
+----------
+
+arch/powerpc/include/asm/elfnote.h
+arch/powerpc/kernel/note.S
+
+
-- 
2.20.1

