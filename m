Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84A740E70
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjF1KNn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10840 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbjF1KGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:44 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SA3jP7026047;
        Wed, 28 Jun 2023 10:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z3BXx87NONENKyRCVCG4NKF1gcn0Sn0umYhm4oYj4BE=;
 b=NQNl5MAjG8hgzXhNR8F2xWnyWXKD7e1cElKoWaar3u6iSNw2DT5q8tS/OeeOuUlpFmIk
 DgP8KTOClusIHrM+ruW78dyWE5I2elZYRCb9hTOnsLS7rwKOM3VdSiIQbHR9O60oJDig
 oqJ7nQgAo/TSF9mvxSPYAqB3scnc15d9F1kyF0Hc5zmRSiazyTTVnSP6Gxmau5wEwaNA
 PaRHKqvYSO2qENBEEHA/Ez8YKRFF/pFNV1oUZwsd5vPKP6A0G4YbgYZjeqR3TH4BXzYq
 VzUGAVjfYEdlC6eMWk+4coVppnB996DIuVQe15ylSp5Ak/SJyCf95vvPLgrzKUC5Q0oj Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjs783xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SA3e9a025757;
        Wed, 28 Jun 2023 10:06:11 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjs783t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:11 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9fpja031089;
        Wed, 28 Jun 2023 10:06:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr451w61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA62pD61931984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8822004F;
        Wed, 28 Jun 2023 10:06:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 353FB20043;
        Wed, 28 Jun 2023 10:06:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:01 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 2/9] cpu/SMT: Move smt/control simple exit cases earlier
Date:   Wed, 28 Jun 2023 12:05:51 +0200
Message-ID: <20230628100558.43482-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _w-Ak6pZWzSTbHGDTOjPLaJ5HY9Lyv-C
X-Proofpoint-GUID: lCKXhyr9JqS8nNIGJlwKk66FW8lOmkhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Move the simple exit cases, ie. which don't depend on the value written,
earlier in the function. That makes it clearer that regardless of the
input those states can not be transitioned out of.

That does have a user-visible effect, in that the error returned will
now always be EPERM/ENODEV for those states, regardless of the value
written. Previously writing an invalid value would return EINVAL even
when in those states.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 237394e0574a..c67049bb3fc8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2482,6 +2482,12 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 {
 	int ctrlval, ret;
 
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
+		return -EPERM;
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
 	if (sysfs_streq(buf, "on"))
 		ctrlval = CPU_SMT_ENABLED;
 	else if (sysfs_streq(buf, "off"))
@@ -2491,12 +2497,6 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	else
 		return -EINVAL;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
-		return -EPERM;
-
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
-- 
2.41.0

