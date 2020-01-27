Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC89149EF3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 07:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgA0GRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 01:17:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 01:17:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R6DIcW119854;
        Mon, 27 Jan 2020 06:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=gJ/jpXTHwRBSq22rXvdlhHavOGJ9Q+e1no1Mq6F4Bvw=;
 b=Y/YSmaBFS9lARC5G6233J/9lchWbfrA75ugGtpPugGClHYpgmtGMotz2gMoQF8X/ATIJ
 ygHRsmQtsrk6wFVvWBC0NS2fLFkbJv8RkTGJBmuHc3+C4TDgVf+CJAwmIsG7qKEm7osv
 3/R+M0BOGKKElRC4TBXo9DP5tu0yp92Kf9zNe3FPZbTkekOzi8hDht1OnMngD0E09fhL
 aRdznbzsQkbytkP5N8hEx/Wac5dc82MyS4xVbntjXZrKdO3L1qOmdOh6Jaqq/SvF98i+
 an5wMSQtn2I3E1NGzNmEh9Dk0g8euyQ3jy12mvLH1cY1JMn1piQQ8PMWX9XKLEabYKfB MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmq5adk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:16:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R6ECZ9111490;
        Mon, 27 Jan 2020 06:16:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xry6qr03t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:16:36 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00R6GYZC001241;
        Mon, 27 Jan 2020 06:16:34 GMT
Received: from [10.39.241.133] (/10.39.241.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jan 2020 22:16:34 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
Date:   Mon, 27 Jan 2020 01:16:36 -0500
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CBCD208-0859-458E-8A89-96E8E9A98664@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
 <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
To:     Lihao Liang <lihaoliang@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270054
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>> This is particularly relevant
>>> in high contention situations when new threads keep arriving on the =
same
>>> socket as the lock holder.
>> In this case, the lock will stay on the same NUMA node/socket for
>> 2^numa_spinlock_threshold times, which is the worst case scenario if =
we
>> consider the long-term fairness. And if we have multiple nodes, it =
will take
>> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
>> lock transitions until any given thread will acquire the lock
>> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
>>=20
>=20
> You're right that the latest version of the patch handles long-term =
fairness
> deterministically.
>=20
> As I understand it, the n-th thread in the main queue is guaranteed to
> acquire the lock after N lock handovers, where N is bounded by
>=20
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>=20
> I'm not sure what role the variable nr_cpus_per_node plays in your =
analysis.

Yeah, that=E2=80=99s a minor point, but let me try to clarify.

The "n-th thread in the main queue=E2=80=9D is (at most) the =
nr_cpus_per_node-th thread=20
for some node k. So when the node k gets the preference, that thread =
will
get the lock after at most nr_cpus_per_node-1 lock transitions. As we =
consider
the upper bound, your analysis is also correct; mine is just a bit =
tighter.

Makes sense?

Regards,
=E2=80=94 Alex

