Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350F2109509
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 22:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYVSF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 16:18:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfKYVSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 16:18:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPL9SgQ165259;
        Mon, 25 Nov 2019 21:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=K7hqDnK/TsK5jvG3JC6XMU0Tierrock1H72ajxKsRBk=;
 b=OxsvRh5qJIREV0Nl58dZLErboXL1oTJYkpCY+bN+jUxOsaZnBggZOaWX42HmTWvi5Sdd
 jU/vbr9jriaO9rf9vnnq/9NcUnL44XByndtFygp0jflr1w+2WgYFOylKbTvjSenpWQcA
 Df94UVHciiRbCXw540IQwQfE4TBrib2TGIvfDDsXqpHHC9V2EZTSLY8eBcYJydFhZqtK
 GLy/SVg92+5KEHok13Wp4sRddWEoRaJc8UrIVtl3DqdcY9HSvYoyaX8SbsHvujXaE6Jd
 0z0ucNwxpPE9soWGJXRUhljiIXmWJn7TqkxYKCg3/cCwCdulaqfxjDfbM79dhPIpDNlp Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdr2917-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 21:17:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPL8VPe156913;
        Mon, 25 Nov 2019 21:15:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wfe80nsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 21:15:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPLFBfc020511;
        Mon, 25 Nov 2019 21:15:11 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 13:15:11 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v7 0/5] Add NUMA-awareness to qspinlock
Date:   Mon, 25 Nov 2019 16:07:04 -0500
Message-Id: <20191125210709.10293-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250171
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Minor change from v6:
---------------------

- fixed a 32-bit build failure by adding dependency on 64BIT in Kconfig.
Reported-by: kbuild test robot <lkp@intel.com>


Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. After acquiring the MCS lock and
before acquiring the spinlock, the lock holder scans the main queue
looking for a thread running on the same node (pre-scan). If found (call
it thread T), all threads in the main queue between the current lock
holder and T are moved to the end of the secondary queue.  If such T
is not found, we make another scan of the main queue after acquiring 
the spinlock when unlocking the MCS lock (post-scan), starting at the
node where pre-scan stopped. If both scans fail to find such T, the
MCS lock is passed to the first thread in the secondary queue. If the
secondary queue is empty, the MCS lock is passed to the next thread in the
main queue. To avoid starvation of threads in the secondary queue, those
threads are moved back to the head of the main queue after a certain
number of intra-node lock hand-offs.

More details are available at https://arxiv.org/abs/1810.05600.

The series applies on top of v5.4.0, commit eae56099de85.
Performance numbers are available in previous revisions
of the series.

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 .../admin-guide/kernel-parameters.txt         |  18 +
 arch/arm/include/asm/mcs_spinlock.h           |   6 +-
 arch/x86/Kconfig                              |  20 ++
 arch/x86/include/asm/qspinlock.h              |   4 +
 arch/x86/kernel/alternative.c                 |  70 ++++
 include/asm-generic/mcs_spinlock.h            |   4 +-
 kernel/locking/mcs_spinlock.h                 |  20 +-
 kernel/locking/qspinlock.c                    |  77 ++++-
 kernel/locking/qspinlock_cna.h                | 319 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 517 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.21.0 (Apple Git-122.2)

