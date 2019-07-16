Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72DA6AA9D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfGPObS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 10:31:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPObS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 10:31:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GESeuB114127;
        Tue, 16 Jul 2019 14:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=N/b6VOTPb74aJOzgxtMHhEZs0/2R4+eOxM9iauY4Cqo=;
 b=TYIwu/vXzDGP10SKtj166MVC8ei7IqLWvnBGRm8foSd5zDykmbm2AQ5DxeMVe0m3G5tG
 jAPcv/h9wMpyhAlKC+y8VqaSykrEo+SPJDAstUtqUbVU+dDsi54IdMSq+nl/9N6Bc+GD
 6o8yQj2ABHPFYvxrBLJEAMOcsm/BBYjdq/5G5j+EefxsWllZZxLfmu00gJT9MLwjAx8z
 iq6CubmrHZ6mNazgzj+cXgjNjxVsibSPKt1wsgXSqfwpZb6xr6/AWZFGRSdsa/03BmXs
 p5LwhzhwqYaO5nb/1dS8TEzyUiZm5mVzjjxdFkugPoVyj7zAuEJ6jL0wpKmlO+utgS64 XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xqvua1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:30:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GES5wd183813;
        Tue, 16 Jul 2019 14:30:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tq5bcevaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:30:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GEUXUa023587;
        Tue, 16 Jul 2019 14:30:33 GMT
Received: from [10.39.235.122] (/10.39.235.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 07:30:33 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
Date:   Tue, 16 Jul 2019 10:30:28 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDD00A3A-6938-40DE-B464-A56C641B4634@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=930 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160178
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jul 16, 2019, at 7:05 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
>> +/**
>> + * find_successor - Scan the main waiting queue looking for the =
first
>> + * thread running on the same node as the lock holder. If found =
(call it
>> + * thread T), move all threads in the main queue between the lock =
holder
>> + * and T to the end of the secondary queue and return T; otherwise, =
return NULL.
>> + */
>> +static struct cna_node *find_successor(struct mcs_spinlock *me)
>=20
> Either don't use a kernel doc comment, but if you must, you have to
> stick to their format, otherwise we'll get endless stupid patches =
fixing
> up the stupid comment.
Will fix that.

Thanks,
=E2=80=94 Alex

