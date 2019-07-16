Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE36AB06
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbfGPOyD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 10:54:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPOyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 10:54:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEmcI4125879;
        Tue, 16 Jul 2019 14:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=jMrbDq6/gbs2hZj13b/yWOFJhrxf6vLsu7dgoGkQCnQ=;
 b=QqmIswjnPG8I98M0sG7apghVmwVrT0Sj3eu3GI5ZetScM+7aZhnuZosT7cMwyTi/OULk
 Yhkrqy4VxurAGVNzlj87C3i8GPUxt0eAPj7jRqSr5hQLvYtLXk1Wl9liXZRlGHe/JZo6
 GrGhzBl+yveWTjZT2jEyMmKlse867MdDlLq5RylH11PSss9Sy2cgoELBhRt5VUToKErG
 S0JLzC9rBKj3+jrPP/ymx5I2xeOIxBHiJ0UZLPpDbh2FwdzOxHiu3XBcSihdQ71WAqSo
 Hufnto1Fpzzz2FH8pYRS8j9BolLFQnHkjGINwWSbUU+CdVGa+L+G4FyiY7UixacVvExW wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtn4qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:53:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEqkxD129539;
        Tue, 16 Jul 2019 14:53:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tq4dtynsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:53:08 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GEr4JB015648;
        Tue, 16 Jul 2019 14:53:04 GMT
Received: from [10.39.235.122] (/10.39.235.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 14:53:04 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow
 path
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190716102034.GN3419@hirez.programming.kicks-ass.net>
Date:   Tue, 16 Jul 2019 10:53:02 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
 <20190716102034.GN3419@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160182
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 16, 2019, at 6:20 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jul 15, 2019 at 03:25:33PM -0400, Alex Kogan wrote:
>=20
>> +/*
>> + * set_locked_empty_mcs - Try to set the spinlock value to =
_Q_LOCKED_VAL,
>> + * and by doing that unlock the MCS lock when its waiting queue is =
empty
>> + * @lock: Pointer to queued spinlock structure
>> + * @val: Current value of the lock
>> + * @node: Pointer to the MCS node of the lock holder
>> + *
>> + * *,*,* -> 0,0,1
>> + */
>> +static __always_inline bool __set_locked_empty_mcs(struct qspinlock =
*lock,
>> +						   u32 val,
>> +						   struct mcs_spinlock =
*node)
>> +{
>> +	return atomic_try_cmpxchg_relaxed(&lock->val, &val, =
_Q_LOCKED_VAL);
>> +}
>=20
> That name is nonsense. It should be something like:
>=20
> static __always_inline bool __try_clear_tail(=E2=80=A6)

We already have set_locked(), so I was trying to convey the fact that we =
are
doing the same here, but only when the MCS chain is empty.

I can use __try_clear_tail() instead.

>=20
>=20
>> +/*
>> + * pass_mcs_lock - pass the MCS lock to the next waiter
>> + * @node: Pointer to the MCS node of the lock holder
>> + * @next: Pointer to the MCS node of the first waiter in the MCS =
queue
>> + */
>> +static __always_inline void __pass_mcs_lock(struct mcs_spinlock =
*node,
>> +					    struct mcs_spinlock *next)
>> +{
>> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
>> +}
>=20
> I'm not entirely happy with that name either; but it's not horrible =
like
> the other one. Why not mcs_spin_unlock_contended() ?

Sure, I can use mcs_spin_unlock_contended() instead.

Thanks,
=E2=80=94 Alex

