Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01BB7EA1
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbfISP4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:56:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391497AbfISP4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:56:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFsSrQ133684;
        Thu, 19 Sep 2019 15:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=sriX7NN5BqHD0GlF4Xbuu366jfCsxHPqzJ2QnT7Ovus=;
 b=S6pbH9hTSxhfomU3TV/MckQLOUPdlCJwvNRI6Fu6RgTl7g09tUKygAhAaFdzzISp/bHd
 Z7+lAivQO8/FFGqtqpSYiJA6Pf740MYUvPY/EesxutP/gf0zWlbfjjbsjhYTTxckMKLA
 ZW+G6ZXPnLI9RBKlBF0Jvl4keSGN9RyFX1VjQsBR3q8p2oshbIfooj58706ydhuuEVkm
 QEQnDzimw+QAHbno70KOmXkMbTTGJPBTnZA4Zyjvv1p9qhwGSNGw2NQvEaDumfCUSAXj
 7VHRdev+w9in4qmvzblANfgNF8tOJs8uAde4zc8O3o+6L+o9liPcNOoqGfbJHg8H2vyI VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v3vb4n06e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:55:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFsCYG126243;
        Thu, 19 Sep 2019 15:55:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v3vbaqfqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:55:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JFtL16021238;
        Thu, 19 Sep 2019 15:55:21 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 08:55:20 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v4 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <3ae2b6a2-ffe6-2ca1-e5bf-2292db50e26f@redhat.com>
Date:   Thu, 19 Sep 2019 11:55:21 -0400
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <87B87982-670F-4F12-9EE0-DC89A059FAEC@oracle.com>
References: <20190906142541.34061-1-alex.kogan@oracle.com>
 <20190906142541.34061-4-alex.kogan@oracle.com>
 <3ae2b6a2-ffe6-2ca1-e5bf-2292db50e26f@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190145
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> +/*
>> + * cna_try_find_next - scan the main waiting queue looking for the =
first
>> + * thread running on the same NUMA node as the lock holder. If found =
(call it
>> + * thread T), move all threads in the main queue between the lock =
holder and
>> + * T to the end of the secondary queue and return T; otherwise, =
return NULL.
>> + *
>> + * Schematically, this may look like the following (nn stands for =
numa_node and
>> + * et stands for encoded_tail).
>> + *
>> + *     when cna_try_find_next() is called (the secondary queue is =
empty):
>> + *
>> + *  A+------------+   B+--------+   C+--------+   T+--------+
>> + *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> =
NULL
>> + *   |mcs:locked=3D1|    |cna:nn=3D0|    |cna:nn=3D2|    |cna:nn=3D1|
>> + *   |cna:nn=3D1    |    +--------+    +--------+    +--------+
>> + *   +----------- +
>> + *
>> + *     when cna_try_find_next() returns (the secondary queue =
contains B and C):
>> + *
>> + *  A+----------------+    T+--------+
>> + *   |mcs:next        | ->  |mcs:next| -> NULL
>> + *   |mcs:locked=3DB.et | -+  |cna:nn=3D1|
>> + *   |cna:nn=3D1        |  |  +--------+
>> + *   +--------------- +  |
>> + *                       |
>> + *                       +->  B+--------+   C+--------+
>> + *                             |mcs:next| -> |mcs:next|
>> + *                             |cna:nn=3D0|    |cna:nn=3D2|
>> + *                             |cna:tail| -> +--------+
>> + *                             +--------+
>> + *
>> + * The worst case complexity of the scan is O(n), where n is the =
number
>> + * of current waiters. However, the fast path, which is expected to =
be the
>> + * common case, is O(1).
>> + */
>> +static struct mcs_spinlock *cna_try_find_next(struct mcs_spinlock =
*node,
>> +					      struct mcs_spinlock *next)
>> +{
>> +	struct cna_node *cn =3D (struct cna_node *)node;
>> +	struct cna_node *cni =3D (struct cna_node *)next;
>> +	struct cna_node *first, *last =3D NULL;
>> +	int my_numa_node =3D cn->numa_node;
>> +
>> +	/* fast path: immediate successor is on the same NUMA node */
>> +	if (cni->numa_node =3D=3D my_numa_node)
>> +		return next;
>> +
>> +	/* find any next waiter on 'our' NUMA node */
>> +	for (first =3D cni;
>> +	     cni && cni->numa_node !=3D my_numa_node;
>> +	     last =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
>> +		;
>> +
>> +	/* if found, splice any skipped waiters onto the secondary queue =
*/
>> +	if (cni && last)
>> +		cna_splice_tail(cn, first, last);
>> +
>> +	return (struct mcs_spinlock *)cni;
>> +}
>=20
> At the Linux Plumbers Conference last week, Will has raised the =
concern
> about the latency of the O(1) cna_try_find_next() operation that will
> add to the lock hold time.
While the worst case complexity of the scan is O(n), I _think it can be =
proven
that the amortized complexity is O(1). For intuition, consider a =
two-node=20
system with N threads total. In the worst case scenario, the scan will =
go=20
over N/2 threads running on a different node. If the scan ultimately =
=E2=80=9Cfails=E2=80=9D
(no thread from the lock holder=E2=80=99s node is found), the lock will =
be passed
to the first thread from a different node and then between all those N/2 =
threads,
with a scan of just one node for the next N/2 - 1 passes. Otherwise, =
those=20
N/2 threads will be moved to the secondary queue. On the next lock =
handover,=20
we pass the lock either to the next thread in the main queue (as it has =
to be=20
from our node) or to the first node in the secondary queue. In both =
cases, we=20
scan just one node, and in the latter case, we have again N/2 - 1 passes =
with=20
a scan of just one node each.

> One way to hide some of the latency is to do
> a pre-scan before acquiring the lock. The CNA code could override the
> pv_wait_head_or_lock() function to call cna_try_find_next() as a
> pre-scan and return 0. What do you think?
This is certainly possible, but I do not think it would completely =
eliminate=20
the worst case scenario. It will probably make it even less likely, but =
at=20
the same time, we will reduce the chance of actually finding a thread =
from the
same node (that may enter the main queue while we wait for the owner & =
pending=20
to go away).

Regards,
=E2=80=94 Alex=
