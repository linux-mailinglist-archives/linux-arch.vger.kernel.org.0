Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36EE145C76
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVTav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 14:30:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49500 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTau (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 14:30:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00MJSOLY013172;
        Wed, 22 Jan 2020 19:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=NWUObdwgZDzbSQPfNwPkqO4BXDviIlQVMJjazGC8iZI=;
 b=WblboZNmJ3T7EyFz0bU/La07yBbrviyMBLElM2gxIIjYpzinBGY4Q5e2k98xiUKKN8F2
 wXZSudBpGBeixGrpEZg3opwZ859Bfdw1gj+4Ktfwi8ZzpAvsHIogDHqkJhgww76nBHgS
 QOvtM9/RIUYrOnL59+9aRHWvkkL1jz+5j+6e2dK3IoxdU0Two7osf7KbDDJiOApa3xPm
 E8C8dNR4wiIGiE5eF9XkdhgdQbiH3NXaw63b0S5CKD+k3AeJKZpzmLnK28I7/COs2540
 jwOEg2AZFuj+CEhnALscVh4IRP7PrxEtJ7jowHd4Fz34bnjDMO9+2vXwNpTuHroyG+4k gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnrdshb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 19:29:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00MJSfHr164521;
        Wed, 22 Jan 2020 19:29:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xppq18gyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 19:29:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00MJTenw028887;
        Wed, 22 Jan 2020 19:29:40 GMT
Received: from [10.39.195.152] (/10.39.195.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 11:29:39 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
Date:   Wed, 22 Jan 2020 14:29:36 -0500
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
To:     Lihao Liang <lihaoliang@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001220165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001220165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Lihao.

> On Jan 22, 2020, at 6:45 AM, Lihao Liang <lihaoliang@google.com> =
wrote:
>=20
> Hi Alex,
>=20
> On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> =
wrote:
>>=20
>> Summary
>> -------
>>=20
>> Lock throughput can be increased by handing a lock to a waiter on the
>> same NUMA node as the lock holder, provided care is taken to avoid
>> starvation of waiters on other NUMA nodes. This patch introduces CNA
>> (compact NUMA-aware lock) as the slow path for qspinlock. It is
>> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>>=20
>=20
> Thanks for your patches. The experimental results look promising!
>=20
> I understand that the new CNA qspinlock uses randomization to achieve
> long-term fairness, and provides the numa_spinlock_threshold parameter
> for users to tune.
This has been the case in the first versions of the series, but is not =
true anymore.
That is, the long-term fairness is achieved deterministically (and you =
are correct=20
that it is done through the numa_spinlock_threshold parameter).

> As Linux runs extremely diverse workloads, it is not
> clear how randomization affects its fairness, and how users with
> different requirements are supposed to tune this parameter.
>=20
> To this end, Will and I consider it beneficial to be able to answer =
the
> following question:
>=20
> With different values of numa_spinlock_threshold and
> SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> sockets have to wait to acquire the lock?
The SHUFFLE_REDUCTION_PROB_ARG parameter is intended for performance
optimization only, and *does not* affect the long-term fairness (or, at =
the=20
very least, does not make it any worse). As Longman correctly pointed =
out in=20
his response to this email, the shuffle reduction optimization is =
relevant only
when the secondary queue is empty. In that case, CNA hands-off the lock
exactly as MCS does, i.e., in the FIFO order. Note that when the =
secondary
queue is not empty, we do not call probably().

> This is particularly relevant
> in high contention situations when new threads keep arriving on the =
same
> socket as the lock holder.
In this case, the lock will stay on the same NUMA node/socket for=20
2^numa_spinlock_threshold times, which is the worst case scenario if we=20=

consider the long-term fairness. And if we have multiple nodes, it will =
take=20
up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
lock transitions until any given thread will acquire the lock
(assuming 2^numa_spinlock_threshold > nr_cpus_per_node).

Hopefully, it addresses your concern. Let me know if you have any =
further=20
questions.

Best regards,
=E2=80=94 Alex

