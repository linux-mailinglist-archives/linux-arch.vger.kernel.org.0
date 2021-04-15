Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931F9360990
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDOMhc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 08:37:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35610 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhDOMhc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 08:37:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FCXbPR178254;
        Thu, 15 Apr 2021 08:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=35aH+7ZEjyiIRl+fbi2ev6X/dKK7r0bhA8aw3QX7gpM=;
 b=Zm9k8iMTXkr1igRO1EXyST+se8q5FuzsRCRM/aVK/cd/G72fFe/p5oyXFxJ73MBN39Ej
 EK5LFQgWUtmuzgTQw/svEemXS8b9r9ACoSBWtPNWRSEEdw4paONwHY17W+/AGr0BnY/K
 O8Djl2xivbZqR5E0Pzi+wks0YegJqe0dCT9S65LzyiRwb1YOJw1Xr6frNeTzKxrBl587
 5jdUzCQ3kC1mP8p7fPfwemyUnOy1Kw4T6jfliiX/ZHDpfYTIPHAZM1rW+W+tVNJhjQpS
 EWhpN7MeCVdBLKnCAaeM7NM2VwMCDoaiSt5wBqvGBMrQzJM6m/qFg8rmZru4ahQLIekn 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xbq3xute-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13FCaGY7188244;
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xbq3xurp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FCYcEj028994;
        Thu, 15 Apr 2021 12:37:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8bvhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:37:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FCacaY32768304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 12:36:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A536CA405F;
        Thu, 15 Apr 2021 12:37:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54CB0A4054;
        Thu, 15 Apr 2021 12:37:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 12:37:00 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on PCI_IOBASE
Date:   Thu, 15 Apr 2021 14:36:58 +0200
Message-Id: <20210415123700.3030728-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wKHVCLoTjndQ_uHcBBZKapqs8xZtEkJ4
X-Proofpoint-GUID: LB4OIAlqeZZhhjLeW-V2s3eD50fS1_aD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=795 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150084
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is version 2 of my attempt to get rid of a clang -Wnull-pointer-arithmetic
warning for the use of PCI_IOBASE in asm-generic/io.h. This was originally
found on s390 but should apply to all platforms leaving PCI_IOBASE undefined
while making use of the inb() and friends helpers from asm-generic/io.h.

Thanks,
Niklas

Changes since v1:
- Added patch to explicitly set PCI_IOBASE to 0 on sparc as suggested by Arnd
  Bergmann
- Instead of working around the warning with a uintptr_t PCI_IOBASE make inb()
  and friends explicitly WARN_ONCE() and return 0xff... (Arnd)

Niklas Schnelle (2):
  sparc: explicitly set PCI_IOBASE to 0
  asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on
    PCI_IOBASE

 arch/sparc/include/asm/io.h |  4 +++
 include/asm-generic/io.h    | 55 ++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.25.1

