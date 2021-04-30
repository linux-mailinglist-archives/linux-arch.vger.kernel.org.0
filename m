Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5F36F90C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhD3LRp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 07:17:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbhD3LRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 07:17:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UB3H4M016527;
        Fri, 30 Apr 2021 07:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=X7H6Thm5vVvEdOzIMF99WmtzE3yIxl5XgPZmIRQQpSM=;
 b=BNfwknSmGRvxLT33wsoOPyxeWMipoQHfo4/O8XDyHNyLU3gvh8qbW034jnOI7FEaMKx8
 w/E94NrQRqe3rrMpZldpxGgH/oq3dFrBlmhhvWULuXv5BAEUnkJumCPxyzLdeY5ed9Qy
 dkxAY+ckatHVlhtbFO+Bzr9l7DjrmzSRgWP3TeHcum2SAMJ9K/Acv1oFwc+KT0OPTfZ3
 TeDUYe7FcNbOzkZHs4jW7WR/LcqXLfIcKCUD90/+sep4DpRYIZ3nmZ6TxW6E6txtyaAy
 zrXh7kCoawUz7cjYZss189Gkqxa4tx5iDpAgngnWmpito7it3tKJRzPC0BeTaKeNUFBA 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388drswy1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 07:16:47 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13UBDd8B052160;
        Fri, 30 Apr 2021 07:16:46 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388drswy0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 07:16:46 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UBCsJJ010967;
        Fri, 30 Apr 2021 11:16:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 384ay81q8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 11:16:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UBGf4C45809994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:16:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2843A4057;
        Fri, 30 Apr 2021 11:16:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DF82A4040;
        Fri, 30 Apr 2021 11:16:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Apr 2021 11:16:41 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org
Subject: [PATCH v4 0/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic warning on PCI_IOBASE
Date:   Fri, 30 Apr 2021 13:16:38 +0200
Message-Id: <20210430111641.1911207-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xRR3TU8l-97YDHOxFoi3RsZeyFN6kn-G
X-Proofpoint-GUID: RZlDyf6cM3uzqma3gwaEolsaHKGd2vpX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_06:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=729 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104300080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Niklas Schnelle <niklas@komani.de>

Hi,

This is version 4 of my attempt to get rid of a clang
-Wnull-pointer-arithmetic warning for the use of PCI_IOBASE in
asm-generic/io.h. This was originally found on s390 but should apply to
all platforms leaving PCI_IOBASE undefined while making use of the inb()
and friends helpers from asm-generic/io.h.

This applies cleanly and was compile tested on top of v5.12 for the
previously broken ARC, nds32, h8300 and risc-v architecture

I did boot test this only on x86_64 and s390x the former implements
inb() itself while the latter would emit a WARN_ONCE() but no drivers
use inb().

Thanks,
Niklas

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
 include/asm-generic/io.h    | 65 ++++++++++++++++++++++++++++++++++---
 3 files changed, 72 insertions(+), 6 deletions(-)

-- 
2.31.1

