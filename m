Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC635439
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2019 01:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFDXWl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 19:22:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57700 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfFDXWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 19:22:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54NE9sa117761;
        Tue, 4 Jun 2019 23:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YXvYIW/TW5gVwJgPNuplVdUZS0b4Nt48gIxbsBj1q/A=;
 b=RtHIB50u7sCZX9RPoLJf0ZHJkpch7IXBg43GqRPBZNwQNAKIZ1Fe1PhgpNlRK+DGJQo8
 lSVGhzJjuIVibp+vRd2n7xvFHcA0mUp+yl6zRpu/O1SdhEbRN8KVPNzg3MuJ665wOt8D
 OXBjmWQJtRpmguu4bIch0Rtht6EHlilGvOM6jgxv+O/87WyMCwGCZo6Xse+EXPa8teDX
 rjR995hOuZyKMICZD2fQse9ORiTlNsim1r28tHpjiESTwKW8UAdpG+JsMg+tDWtWmsBh
 96TEzBexMUmmKxxluIaxbJWn0djN0qPyA3q+05GNXykuOBeveW8FJpcOUIDfWQCPvZxz Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2suj0qfuae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 23:21:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54NKbcE183651;
        Tue, 4 Jun 2019 23:21:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhbvdnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 23:21:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x54NLFRu018591;
        Tue, 4 Jun 2019 23:21:15 GMT
Received: from [172.16.8.192] (/206.166.194.194)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 16:21:15 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Date:   Tue, 4 Jun 2019 19:21:13 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906040147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906040147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter, Longman,=20

> On Apr 3, 2019, at 12:01 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Apr 03, 2019 at 11:39:09AM -0400, Alex Kogan wrote:
>=20
>>>> The patch that I am looking for is to have a separate
>>>> numa_queued_spinlock_slowpath() that coexists with
>>>> native_queued_spinlock_slowpath() and
>>>> paravirt_queued_spinlock_slowpath(). At boot time, we select the =
most
>>>> appropriate one for the system at hand.
>> Is this how this selection works today for paravirt?
>> I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking =
about a different mechanism here.
>> Can you, please, elaborate or give me a link to a page that explains =
that?
>=20
> Oh man, you ask us to explain how paravirt patching works... that's
> magic :-)
>=20
> Basically, the compiler will emit a bunch of indirect calls to the
> various pv_ops.*.* functions.
>=20
> Then, at alternative_instructions() <- apply_paravirt() it will =
rewrite
> all these indirect calls to direct calls to the function pointers that
> are in the pv_ops structure at that time (+- more magic).
Trying to resume this work, I am looking for concrete steps required to =
integrate CNA with the paravirt patching.

Looking at alternative_instructions(), I wonder if I need to add another =
call, something like apply_numa() similar to apply_paravirt(), and do =
the patch work there.
Or perhaps I should =E2=80=9Cjust" initialize the pv_ops structure with =
the corresponding numa_queued_spinlock_slowpath() in paravirt.c?

Also, the paravirt code is under arch/x86, while CNA is generic (not =
x86-specific).
Do you still want to see CNA-related patching residing under arch/x86?

We still need a config option (something like NUMA_AWARE_SPINLOCKS) to =
enable CNA patching under this config only, correct?

Thanks in advance,
=E2=80=94 Alex

