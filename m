Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2199E379184
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhEJOz1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 10:55:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240276AbhEJOx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 10:53:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AEXqH2030941;
        Mon, 10 May 2021 10:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dY5rHenPOQ56zgTRtVvd0ws/b24uJv2FPl1M84JdB3I=;
 b=NjMws1Y9wayuZd9DTfgR2rh/8pCf9KMeN77b+aqen0ZuvTeC5aNiabqf2BWg6XcoqItd
 6257X77B3ONwv/Lf6l8iI/2wb9NX539x8B85OtqkBxXG3dl8nVt/rw5bU6tNTFrGEXCx
 UfU+pJqv1sw9Ky0iphO1JxfFH3InHAkln6dK38uKNxfWr8Y20T9mIOMkTsyWwIMp3efZ
 PZwM2GCDSSQRRrPuqiLcJFTAISucKikWYAUIyCkbIXIzcQ4yhdie934d3zy4Fg1Mut4N
 6Iyxp3c4jQhlyc/MGHdLnkF6lCoZHSCM4Nl2nhqDLRrSvdVPoletl2/m7tWD06QOr8cn Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f5ytjbph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:52:40 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14AEXpIJ030871;
        Mon, 10 May 2021 10:52:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f5ytjbnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:52:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14AElnun002962;
        Mon, 10 May 2021 14:52:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj9891r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 14:52:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AEqYeK65274364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 14:52:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A88B85204F;
        Mon, 10 May 2021 14:52:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E88652050;
        Mon, 10 May 2021 14:52:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org
Subject: [PATCH v6 0/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on PCI_IOBASE
Date:   Mon, 10 May 2021 16:52:31 +0200
Message-Id: <20210510145234.594814-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mjhb6J1DiHtD0UWPGo4ogLSab9rjyQv4
X-Proofpoint-GUID: 2Nm1GNL2tf4tx1Rr4qUiX2WRhPVnoUcl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_09:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=748
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105100105
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is version 6 of my attempt to get rid of a clang
-Wnull-pointer-arithmetic warning for the use of PCI_IOBASE in
asm-generic/io.h and fix the NULL pointer access it points out.

This was originally found on s390 but should apply to all platforms
leaving PCI_IOBASE undefined while making use of the inb() and friends
helpers from asm-generic/io.h.

This applies cleanly and was compile tested on top of v5.12 for the
previously broken ARC, nds32, h8300 and risc-v architecture. It also
applies cleanly on v5.13-rc1 for which I boot tested it on s390.

I did boot test this only on x86_64 and s390x the former implements
inb() et al itself while the latter would emit a WARN_ONCE() but no
drivers use inb().

Thanks,
Niklas

Changes sinve v5:
- memset() the buffer in insb()/insw()/insl() in the WARN_ONCE() case
  to prevent use of uninitialized data (Arnd)

Changes since v4:
- Added Link to patch 4 (Arnd)
- Improved comment on RISC-V patch mentioning current brokeness (Arnd)

Changes since v3:
- Changed the subject of the last patch to better reflect the actual
  change i.e. the addition of WARN_ONCE() to the helpers not the
  silencing of the clang warning
- Added asm/bug.h to asm-generic/io.h so it doesn't have to be included
  previously by all arches to be available for the WARN_ONCE()
- Added patch for risc-v which defines PCI_IOBASE except when compiled
  for nommu

Changes since v2:
- Improved comment for SPARC PCI_IOBASE definition as suggested
  by David Laight
- Added a patch for ARC which is missing the asm/bug.h include for
  WARN_ONCE() (kernel test robot)
- Added ifdefs to ioport_map() and __pci_ioport_map() since apparently
  at least test configs enable CONFIG_HAS_IOPORT_MAP even on
  architectures which leave PCI_IOBASE unset (kernel test robot for
  nds32 and ARC).

Changes since v1:
- Added patch to explicitly set PCI_IOBASE to 0 on sparc as suggested by
  Arnd Bergmann
- Instead of working around the warning with a uintptr_t PCI_IOBASE make
  inb() and friends explicitly WARN_ONCE() and return 0xff... (Arnd
  Bergmann)

Niklas Schnelle (3):
  sparc: explicitly set PCI_IOBASE to 0
  risc-v: Use generic io.h helpers for nommu
  asm-generic/io.h: warn in inb() and friends with undefined PCI_IOBASE

 arch/riscv/include/asm/io.h |  5 +--
 arch/sparc/include/asm/io.h |  8 +++++
 include/asm-generic/io.h    | 68 ++++++++++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 6 deletions(-)

-- 
2.25.1

