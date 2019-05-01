Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7512810D90
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 21:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEAT4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 15:56:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfEAT4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JqHWQ016909
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7es90s8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 20:56:33 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41JuXfo48889916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 19:56:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC7F8A4054;
        Wed,  1 May 2019 19:56:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF155A405C;
        Wed,  1 May 2019 19:56:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.12])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 May 2019 19:56:29 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 01 May 2019 22:56:28 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
Date:   Wed,  1 May 2019 22:56:16 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050119-0008-0000-0000-000002E24BDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050119-0009-0000-0000-0000224EB7A8
Message-Id: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010124
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
arch/s390/Kconfig is an ancient compile error with allnoconfig which was
fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.

Since then a lot have changed and now allnoconfig builds just fine without
ARCH_SELECT_MEMORY_MODEL, so it can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/s390/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d06..69d3956 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -621,9 +621,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y
-
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y if SPARSEMEM
 
-- 
2.7.4

