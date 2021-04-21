Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603573669CF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 13:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhDULSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 07:18:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237414AbhDULSw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 07:18:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LBEZRO050148;
        Wed, 21 Apr 2021 07:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jAiMiw2e6+1XZZGZXBMG035KEyr8tjtVKWXIdCM0biQ=;
 b=YUKvfRbx7B0r3vJ1PH4TaPyxW+vonDkI3EH/cT+Kl96BFtDb0qi5CCzhG2EzoN9q13b4
 RZQ5EFbbvlKiTLtup2ArpoKVH+HNnFlX2+Y/MNQnm5sU4po2M4cE5z33TC65gfCtI1/I
 NZgha6NdX5OU9ta49/njYdMqjYM4nXcp5hIIkSneElvN3PTWHRlBhXyzcPlXpyeTOKxQ
 SF+RwcRnWW+ZXqiOtZLz8uK69ymgWTyhw5RArZo5nyv2A3+B+i8mo5iFt7DvPGcLoTVK
 m8/Xae0conpE77bb00py3JCuuICLQt7hO4JHJl1gPSsbAGkvHda7sjp9WYJgGGwbYB8i jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382jds14pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:18:05 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LBG88B056012;
        Wed, 21 Apr 2021 07:18:04 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382jds14p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:18:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LBH3ZK018782;
        Wed, 21 Apr 2021 11:18:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37yqa8j91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 11:18:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LBI0tE24445332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 11:18:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67DC94203F;
        Wed, 21 Apr 2021 11:18:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0988142045;
        Wed, 21 Apr 2021 11:18:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 11:17:59 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 0/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on PCI_IOBASE
Date:   Wed, 21 Apr 2021 13:17:56 +0200
Message-Id: <20210421111759.2059976-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EAQBMOlkNhLPmhmROBdDkmWEOEqTImRJ
X-Proofpoint-ORIG-GUID: M-rChegDgNZIrGrKaOcdNqLCeP0dzNQa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_04:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=647
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210085
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is version 3 of my attempt to get rid of a clang -Wnull-pointer-arithmetic
warning for the use of PCI_IOBASE in asm-generic/io.h. This was originally
found on s390 but should apply to all platforms leaving PCI_IOBASE undefined
while making use of the inb() and friends helpers from asm-generic/io.h.

This applies cleanly and was compile tested on top of v5.12-rc8 for the
previously broken ARC and nds32 architectures.

I did boot test this only on x86_64 and s390x the former implements inb()
itself while the latter would emit a WARN_ONCE() but no drivers using inb().

Thanks,
Niklas

Changes since v2:
- Improved comment for SPARC PCI_IOBASE definition as suggested by David Laight
- Added a patch for ARC which is missing the asm/bug.h include for WARN_ONCE()
  (kernel test robot)
- Added ifdefs to ioport_map() and __pci_ioport_map() since apparently at least
  test configs enable CONFIG_HAS_IOPORT_MAP even on architectures which leave
  PCI_IOBASE unset (kernel test robot for nds32 and ARC).

Changes since v1:
- Added patch to explicitly set PCI_IOBASE to 0 on sparc as suggested by Arnd
  Bergmann
- Instead of working around the warning with a uintptr_t PCI_IOBASE make inb()
  and friends explicitly WARN_ONCE() and return 0xff... (Arnd Bergmann)

Niklas Schnelle (3):
  sparc: explicitly set PCI_IOBASE to 0
  ARC: io.h: Include asm/bug.h
  asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on
    PCI_IOBASE

 arch/arc/include/asm/io.h   |  1 +
 arch/sparc/include/asm/io.h |  8 +++++
 include/asm-generic/io.h    | 64 ++++++++++++++++++++++++++++++++++---
 3 files changed, 69 insertions(+), 4 deletions(-)

-- 
2.25.1

