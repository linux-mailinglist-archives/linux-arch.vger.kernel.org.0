Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9965E140A27
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 13:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgAQMvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 07:51:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40846 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgAQMvM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:12 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HCl7RU137357
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:51:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qgb4bh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:51:11 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:51:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 12:51:06 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00HCp4K854001664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 12:51:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980D152063;
        Fri, 17 Jan 2020 12:51:04 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3289452065;
        Fri, 17 Jan 2020 12:51:02 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 22/23] selftests/vm/pkeys: Override access right definitions on powerpc
Date:   Fri, 17 Jan 2020 18:20:01 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20011712-0028-0000-0000-000003D1FFB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011712-0029-0000-0000-000024962B07
Message-Id: <a1901895804d25cccb478b077a1a6509af93407a.1579265066.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_03:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=810 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170102
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

Some platforms hardcode the x86 values for PKEY_DISABLE_ACCESS
and PKEY_DISABLE_WRITE such as those in:
 /usr/include/bits/mman-shared.h.

This overrides the definitions with correct values for powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-powerpc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 7a4d73400338..1753b01882a7 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -16,11 +16,13 @@
 #define fpregs			fp_regs
 #define si_pkey_offset		0x20
 
-#ifndef PKEY_DISABLE_ACCESS
+#ifdef PKEY_DISABLE_ACCESS
+#undef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS	0x3  /* disable read and write */
 #endif
 
-#ifndef PKEY_DISABLE_WRITE
+#ifdef PKEY_DISABLE_WRITE
+#undef PKEY_DISABLE_WRITE
 # define PKEY_DISABLE_WRITE	0x2
 #endif
 
-- 
2.17.1

