Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD5377C4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 17:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfFFPXe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 11:23:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPXe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 11:23:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56F8dwU141560;
        Thu, 6 Jun 2019 15:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ketKTVwbtklQIJXqAbX+H6nxp1mYN2KsNnWPbZLX+qw=;
 b=YU740Z7r5N9HPgb5jCMJGJJWLnq7dSsMg5QxEXG0zQCxJcR7gw8s1v6LJfzQbwYEbjXC
 2QL7hJTBixRhxTYbEXatWnvAlC5kz5Y6xlDf8NbEDayqlICWqzF8zPWRoXu2ZAEbdCN1
 oKRHmUUruLaY3qONu64FgBq98cOi7l/RcCgBW0jmNfjOkGeUrHAji/AWDVhYNg9nM/I/
 wvohiWVeAYfvCdQql/iinBNGVsDJmjZY3dxYQEL3g9esS/9Sj2PwkGi7oGO8UTV+Oihc
 bWnqx4nhAdQDqTZpXXr4xCMzKR5zG/0q4a1bplhhUK4C2EtuKZ9lvX66MWobqI40ytRl 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2suj0qs2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 15:22:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56FKgBb070053;
        Thu, 6 Jun 2019 15:22:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhcrbhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 15:22:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56FLnw4008838;
        Thu, 6 Jun 2019 15:21:49 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 08:21:48 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190605204003.GC3402@hirez.programming.kicks-ass.net>
Date:   Thu, 6 Jun 2019 11:21:48 -0400
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6426D627-77EE-471C-B02A-A85271B666E9@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
 <20190605204003.GC3402@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060104
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> Also, the paravirt code is under arch/x86, while CNA is generic (not
>> x86-specific).  Do you still want to see CNA-related patching =
residing
>> under arch/x86?
>>=20
>> We still need a config option (something like NUMA_AWARE_SPINLOCKS) =
to
>> enable CNA patching under this config only, correct?
>=20
> There is the static_call() stuff that could be generic; I posted a new
> version of that today (x86 only for now, but IIRC there's arm64 =
patches
> for that around somewhere too).

The static_call technique appears as the more desirable long-term =
approach, but I think it would be prudent to keep the patches decoupled =
for now so we can move forward with less entanglements.
So unless anyone objects, we will work on plugging into the existing =
patching for pv.
And we will keep that code under arch/x86, but will be open for any =
suggestion to move it elsewhere.

Thanks!
=E2=80=94 Alex

