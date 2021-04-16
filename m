Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66793617D5
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 04:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhDPCyX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 22:54:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhDPCyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 22:54:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G2nv5Z164657;
        Fri, 16 Apr 2021 02:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=S2OHefHIz3NUy5DqZtPKK3zT/BOMh9tZ1keD7cmmDbw=;
 b=c/qMduAqXD+aUWiid1zbhKXqS9CfswDidabb5iR7HkeNnae5jjQlsvNk2+lqFiwmUcas
 33f2RWR+vBERxcfxB3DC9+FeJVJAgUgeTsWUccKSv6WOKAg6APEuimTPH0PbkeA4O/5F
 1VQmQtwgE2lbW7U/ZGsq+wDBlzxpujjYjObMYiu6mQ5HukaA4zaWnki2rcASmiPULals
 4TF6pdqhs5XHpjrtLQWLx9O9xW6+Ib16giQdgC1entIXU79ZGmZufhaIECGAH6bE5IUw
 aOpu0aIGC5io54mHaUvS2zvhVDxJ8GdOTa4EoYi1yYGqyKk0nP/Skev4uOPSvm5F8Jy7 IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erqr3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 02:53:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G2noYZ173394;
        Fri, 16 Apr 2021 02:53:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37unx3txsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 02:53:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13G2r0Nx007815;
        Fri, 16 Apr 2021 02:53:00 GMT
Received: from dhcp-10-39-213-90.vpn.oracle.com (/10.39.213.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Apr 2021 02:52:59 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <YHWIezK9pbmbWxsu@hirez.programming.kicks-ass.net>
Date:   Thu, 15 Apr 2021 22:52:57 -0400
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <02D4688A-FB4C-4100-8B85-C915F130BB99@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <YHWIezK9pbmbWxsu@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160022
X-Proofpoint-ORIG-GUID: BgWxyQ0j-dxXObdTaf03sQhp2g50bIYy
X-Proofpoint-GUID: BgWxyQ0j-dxXObdTaf03sQhp2g50bIYy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160022
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Apr 13, 2021, at 8:03 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Apr 01, 2021 at 11:31:54AM -0400, Alex Kogan wrote:
>=20
>> @@ -49,13 +55,33 @@ struct cna_node {
>> 	u16			real_numa_node;
>> 	u32			encoded_tail;	/* self */
>> 	u32			partial_order;	/* enum val */
>> +	s32			start_time;
>> };
>=20
>> +/*
>> + * Controls the threshold time in ms (default =3D 10) for intra-node =
lock
>> + * hand-offs before the NUMA-aware variant of spinlock is forced to =
be
>> + * passed to a thread on another NUMA node. The default setting can =
be
>> + * changed with the "numa_spinlock_threshold" boot option.
>> + */
>> +#define MSECS_TO_JIFFIES(m)	\
>> +	(((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ))
>> +static int intra_node_handoff_threshold __ro_after_init =3D =
MSECS_TO_JIFFIES(10);
>> +
>> +static inline bool intra_node_threshold_reached(struct cna_node *cn)
>> +{
>> +	s32 current_time =3D (s32)jiffies;
>> +	s32 threshold =3D cn->start_time + intra_node_handoff_threshold;
>> +
>> +	return current_time - threshold > 0;
>> +}
>=20
> None of this makes any sense:
>=20
> - why do you track time elapsed as a signed entity?
> - why are you using jiffies; that's terrible granularity.
Good points. I will address that (see below). I will just mention that=20=

those suggestions came from senior folks on this mailing list,
and it seemed prudent to take their counsel.=20

>=20
> As Andi already said, 10ms is silly large. You've just inflated the
> lock-acquire time for every contended lock to stupid land just because
> NUMA.
I just ran a few quick tests =E2=80=94 local_clock() (a wrapper around =
sched_clock())=20
works well, so I will switch to using that.

I also took a few numbers with different thresholds. Looks like we can =
drop=20
the threshold to 1ms with a minor penalty to performance. However,=20
pushing the threshold to 100us has a more significant cost. Here are
the numbers for reference:

will-it-scale/lock2_threads:
threshold:                     10ms     1ms      100us
speedup at 142 threads:       2.184    1.974     1.1418=20

will-it-scale/open1_threads:
threshold:                     10ms     1ms      100us
speedup at 142 threads:       2.146    1.974     1.291

Would you be more comfortable with setting the default at 1ms?

> And this also brings me to the whole premise of this series; *why* are
> we optimizing this? What locks are so contended that this actually =
helps
> and shouldn't you be spending your time breaking those locks? That =
would
> improve throughput more than this ever can.

I think for the same reason the kernel switched from ticket locks to =
queue locks
several years back. There always will be applications with contended =
locks.=20
Sometimes the workarounds are easy, but many times they are not, like =
with=20
legacy applications or when the workload is skewed (e.g., every client =
tries to
update the metadata of the same file protected by the same lock). The =
results
show that for those cases we leave > 2x performance on the table. Those =
are not
only our numbers =E2=80=94 LKP reports show similar or even better =
results,=20
on a wide range of benchmarks, e.g.:
=
https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/HGVOCYDEE5KTL=
YPTAFBD2RXDQOCDPFUJ/
=
https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/OUPS7MZ3GJA2X=
YWM52GMU7H7EI25IT37/
=
https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/DNMEQPXJRQY2I=
KHZ3ERGRY6TUPWDTFUN/

Regards,
=E2=80=94 Alex

