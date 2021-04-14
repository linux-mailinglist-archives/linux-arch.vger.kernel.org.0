Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0D35EAE3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 04:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhDNCcd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 22:32:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhDNCcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 22:32:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E2QMj9063285;
        Wed, 14 Apr 2021 02:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=w6C5CtiBnXdjgKEXIjAFsIoL+gLxujYJkEUCd/DEkqE=;
 b=AnHgQGespbOtXpgfo4hpU1xuzKDoFd+9fu6cGkCEAcERDAYam8dJTA5Jaw+fmOVDGgqI
 72neJ3vY0c1ICt2Z70wptFghoiKi7GNpMLS6jZewClNINB/Lcs5xXw/DN8UQredSSK/K
 +e+pZvuFdlaugfhIQmEi5J+b0YGUb8FE81eKN+LHzKE3EO3bs4Bkxxhkhx6bO58UTOpv
 KYCi2aNvLYWYjVOgmfG0SikXgg8IiJVp4aNEAnlC3J13c+1x3Owq+2F4wQ+YgcwMiA3F
 wehjiErqikczxC3t66xaK+Ri34EoucTZrlygfFCFIaJgeXn2hKoZHsfdShTHu4mwToJ6 bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbh0m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 02:30:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E2PVFF055389;
        Wed, 14 Apr 2021 02:30:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37unst8pth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 02:30:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E2Uh9g028709;
        Wed, 14 Apr 2021 02:30:43 GMT
Received: from [10.39.235.234] (/10.39.235.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 02:30:43 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20210413212203.GT3762101@tassilo.jf.intel.com>
Date:   Tue, 13 Apr 2021 22:30:41 -0400
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7902C919-9624-48C9-89C3-D390A9FF78AB@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
 <20210413212203.GT3762101@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140016
X-Proofpoint-GUID: 0wVLpAsklsLLbRASaJbeaA4Y4iHpN-OR
X-Proofpoint-ORIG-GUID: 0wVLpAsklsLLbRASaJbeaA4Y4iHpN-OR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140016
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Apr 13, 2021, at 5:22 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
>>> ms granularity seems very coarse grained for this. Surely
>>> at some point of spinning you can afford a ktime_get? But ok.
>> We are reading time when we are at the head of the (main) queue, but
>> don=E2=80=99t have the lock yet. Not sure about the latency of =
ktime_get(), but
>> anything reasonably fast but not necessarily precise should work.
>=20
> Actually cpu_clock / sched_clock (see my other email). These should
> be fast without corner cases and also monotonic.
I see, thanks.

>=20
>>=20
>>> Could you turn that into a moduleparm which can be changed at =
runtime?
>>> Would be strange to have to reboot just to play with this parameter
>> Yes, good suggestion, thanks.
>>=20
>>> This would also make the code a lot shorter I guess.
>> So you don=E2=80=99t think we need the command-line parameter, just =
the module_param?
>=20
> module_params can be changed at the command line too, so yes.
Got it, thanks again.

=E2=80=94 Alex

