Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA41474E5
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgAWXke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 18:40:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56632 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAWXkd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 18:40:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NNddRX162728;
        Thu, 23 Jan 2020 23:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=LuHOXPa0REgKt+N/61X5+EaaF8izuIJBTiFn/CQUE9c=;
 b=M+TsQr/5QRHVJ7C+CcV4RTCnd9fI3rn/M4Rn+X33uDdvU/+TH4nAQ68ZUyd60AuNR6tV
 TyRBcBeU1tUfGq3gV/rlo9yiD9rrQrrkjtQmtCvjXuCZp9ZWNtJJtMvkUQxviUHkGuwn
 zGKoU03JOpi5+lzzMcNUZ8ZMb5Lr+zVscinhp3ok55ZqzNv9VZxbM0XesseTdOS9MiCI
 Em2kmnE1vWi9XcZuwdbn2WgnJq4AyDxfp4GtHRP176kWTLgmwD9Dr1pl6t+RjwshAec9
 LaGJYOONigJTR1icMYW3CXPwIdFNiwam7RgqvXwAQDbZt3ROVn/gbBJwwXqd4yK0kLmR /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xksyqnn1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 23:39:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NNdAmb148603;
        Thu, 23 Jan 2020 23:39:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xqmuxhjy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 23:39:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NNdbmU011661;
        Thu, 23 Jan 2020 23:39:38 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 15:39:36 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
Date:   Thu, 23 Jan 2020 18:39:36 -0500
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B2B46E9-651E-4BA5-988A-924AE3E72C00@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-5-alex.kogan@oracle.com>
 <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
 <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230176
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Jan 23, 2020, at 3:39 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 1/23/20 2:55 PM, Waiman Long wrote:
>> Playing with lock event counts, I would like you to change the =
meaning
>> intra_count parameter that you are tracking. Instead of tracking the
>> number of times a lock is passed to a waiter of the same node
>> consecutively, I would like you to track the number of times the head
>> waiter in the secondary queue has given up its chance to acquire the
>> lock because a later waiter has jumped the queue and acquire the lock
>> before it.
Isn=E2=80=99t that the same thing? Note that we keep track of the number =
of=20
intra-node lock transfers only when the secondary queue is not empty.

>> This value determines the worst case latency that a secondary
>> queue waiter can experience. So
>=20
> Well, that is not strictly true as a a waiter in the middle of the
> secondary queue can go back and fro between the queues for a number of
> times. Of course, if we can ensure that when a FLUSH_SECONDARY_QUEUE =
is
> issued, those waiters that were in the secondary queue won't be put =
back
> into the secondary queue again.
This will not work as intended when we have more than 2 nodes. That is, =
if we
have threads from node A & B in the secondary queue, and then the queue
is flushed and its head (say, from node A) gets the lock, we want to =
push=20
threads from node B back into the secondary queue, to keep the lock on =
node A.

And if we have only 2 nodes, a waiter in the middle of the secondary =
queue will=20
never go back into the secondary queue, even if the threshold is small.=20=

This is because we flush the secondary queue by putting all its waiters =
in
the front of the main queue, and the secondary queue will remain empty =
at least
until we reach a thread from another node.

Regards,
=E2=80=94 Alex=
