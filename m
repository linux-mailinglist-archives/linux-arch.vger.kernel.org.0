Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAF10D8D
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEAT4g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 15:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbfEAT4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JqJ3c129238
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7es7131g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 20:56:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41JuS8U46792752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 19:56:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BC024203F;
        Wed,  1 May 2019 19:56:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16D8B4204C;
        Wed,  1 May 2019 19:56:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.12])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 May 2019 19:56:24 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 01 May 2019 22:56:23 +0300
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
Subject: [PATCH 1/3] arm: remove ARCH_SELECT_MEMORY_MODEL
Date:   Wed,  1 May 2019 22:56:15 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050119-0028-0000-0000-00000369516A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050119-0029-0000-0000-00002428BA50
Message-Id: <1556740577-4140-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010124
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The ARCH_SELECT_MEMORY_MODEL in arch/arm/Kconfig is enabled only when
ARCH_SPARSEMEM_ENABLE=y. But in this case, ARCH_SPARSEMEM_DEFAULT is also
enabled and this in turn enables SPARSEMEM_MANUAL.

Since there is no definition of ARCH_FLATMEM_ENABLE in arch/arm/Kconfig,
SPARSEMEM_MANUAL is the only enabled memory model, hence the final
selection will evaluate to SPARSEMEM=y.

Since ARCH_SPARSEMEM_ENABLE is set to 'y' only by several sub-arch
configurations, the default for must sub-arches would be the falback to
FLATMEM regardless of ARCH_SELECT_MEMORY_MODEL.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aed25a..25a69a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1592,9 +1592,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.7.4

