Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3414A7B8
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 17:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgA0QCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 11:02:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgA0QCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 11:02:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RFw33d009465;
        Mon, 27 Jan 2020 16:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=fQJQyN44UUauHocBYRd01tMSTWgiqH1MXpHVaQEGRs8=;
 b=SsBwwRut8ax5nfhXXsjcZEjzQI+wmh46icmI68AODoRKGwFUDgf8e4AIyQZCsWVEdBig
 ahMJYWxG+j3KqSMGLNYA3NgFFLVeNzW0P903/7UqpHJVeqZIA8jgUNTUMxi8oTkCQBZE
 Dm4cDtkZxetID+K2eq2FhwMYTfAcVj3CIMaDYh/4VLx4ORLPDaX7ZMHDAcgYUyKOGtXe
 Wt3L66cbq7XMNoVIJ2DwsRQ1FTZi/bu/GMPDjYtFCopdLw0S/AOJTBu/6VMFvZLZLOMS
 ScU9BFdkSsRk+5RiaD40ItDKgYaXTU3q7PCMbYxo3s4A8GpDVBY36ltcPg35uVeXhAex 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmq899q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 16:01:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RG133i175223;
        Mon, 27 Jan 2020 16:01:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xry4un3pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 16:01:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00RG1VeP030884;
        Mon, 27 Jan 2020 16:01:31 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 08:01:30 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
Date:   Mon, 27 Jan 2020 11:01:33 -0500
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25401561-CD1F-4FDC-AED5-256EBE56B9F6@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
 <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
 <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
To:     Lihao Liang <lihaoliang@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270135
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Lihao.

>>>=20
>>>> This is particularly relevant
>>>> in high contention situations when new threads keep arriving on the =
same
>>>> socket as the lock holder.
>>> In this case, the lock will stay on the same NUMA node/socket for
>>> 2^numa_spinlock_threshold times, which is the worst case scenario if =
we
>>> consider the long-term fairness. And if we have multiple nodes, it =
will take
>>> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
>>> lock transitions until any given thread will acquire the lock
>>> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
>>>=20
>>=20
>> You're right that the latest version of the patch handles long-term =
fairness
>> deterministically.
>>=20
>> As I understand it, the n-th thread in the main queue is guaranteed =
to
>> acquire the lock after N lock handovers, where N is bounded by
>>=20
>> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>>=20
>> I'm not sure what role the variable nr_cpus_per_node plays in your =
analysis.
>>=20
>> Do I miss anything?
>>=20
>=20
> If I understand correctly, there are two phases in the algorithm:
>=20
> MCS phase: when the secondary queue is empty, as explained in your =
emails,
> the algorithm hands the lock to threads in the main queue in an FIFO =
order.
> When probably(SHUFFLE_REDUCTION_PROB_ARG) returns false (with default
> probability 1%), if the algorithm finds the first thread running on =
the same
> socket as the lock holder in cna_scan_main_queue(), it enters the =
following
> CNA phase
Yep. When probably() returns false, we scan the main queue. If as the =
result of
this scan the secondary queue becomes not empty, we enter what you call
the CNA phase.

> .
>=20
> CNA phase: when the secondary queue is not empty, the algorithm keeps
> handing the lock to threads in the main queue that run on the same =
socket as
> the lock holder. When 2^numa_spinlock_threshold is reached, it splices
> the secondary queue to the front of the main queue. And we are back to =
the
> MCS phase above.
Correct.

> For the n-th thread T in the main queue, the MCS phase handles threads =
that
> arrived in the main queue before T. In high contention situations, the =
CNA
> phase handles two kinds of threads:
>=20
> 1. Threads ahead of T that run on the same socket as the lock holder =
when
> a transition from the MCS to CNA phase was made. Assume there are m =
such
> threads.
>=20
> 2. Threads that keep arriving on the same socket as the lock holder. =
There
> are at most 2^numa_spinlock_threshold of them.
>=20
> Then the number of lock handovers in the CNA phase is max(m,
> 2^numa_spinlock_threshold). So the total number of lock handovers =
before T
> acquires the lock is at most
>=20
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>=20
> Please let me know if I misunderstand anything.
I think you got it right (modulo nr_cpus_per_node instead of n, as =
mentioned in=20
my other response).

Regards,
=E2=80=94 Alex=
