Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B536BE79
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGQOnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 10:43:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQOnT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 10:43:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEdBvo100794;
        Wed, 17 Jul 2019 14:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ksYZhu2fdY7kAOsQzqB4qBn41JsG7CcF18Hev7FIFKE=;
 b=v0AsSmXvq1TQUtPQP6fHperZC/SOkuz28Z5PxhUtLv9iU8G/lDb4YiWwTfy8HXeQbmvy
 cGJllhe0vBjy+42s6uBkqcZHBc0V++AP3IeeiQ3R3eH6/dyHouzot/ov/5AnWFHOU8Xq
 pKDPoiMErZ9zoBDKqj5DGKBzypX9U0i5TpA2huYIacQo0SjOEQBlB8Y9PQpTG+FTtg1R
 hseJmjrqG9JaFzlPeFGVC9xIpz0R9tBVijQxeDY7dkl7mPtCDqsiwGIUrrHtk7zE4WPI
 WhNuJNVIpss8xSIdaUc+efJAH/6MN3xSIwe9sL5hMn/4PuPdQMemW414vNUZ0ZDojib4 xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xr382x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:42:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEbtWW106473;
        Wed, 17 Jul 2019 14:42:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tsmccf337-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:42:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HEgVhQ014169;
        Wed, 17 Jul 2019 14:42:31 GMT
Received: from [192.168.0.21] (/209.6.165.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 14:42:30 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Date:   Wed, 17 Jul 2019 10:42:26 -0400
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <779FC7D4-67CE-4D22-8154-FC108479935F@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
 <20190717074435.GU3419@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=838 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170172
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +---------+         +----+
>>  *               +-> |mcs::next| -> ...  |next| -> NULL     =
[Secondary queue]
>> *                   |cna::tail| -+      +----+
>>  *                   +---------+  |        ^
>> *                                +--------+
>>  *
>>  * N.B. locked =3D 1 if secondary queue is absent.
>>  */


I would change mcs_node to cna_node, next to mcs::next and locked to =
mcs::locked
in the very first node. Other than that, this is great. Thanks, Peter =
and Longman!

I should probably stick this graphic in the comment at the top of the =
file,=20
instead of a comment to find_successor() (or whatever this function ends =
up=20
being called).

=E2=80=94 Alex


