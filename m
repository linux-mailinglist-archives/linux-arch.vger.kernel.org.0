Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A913B26AE56
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgIOUBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 16:01:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56142 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgIOT6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 15:58:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJsnUt102248;
        Tue, 15 Sep 2020 19:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=v0NKh7M5wU1FAUkHEpWeQ8Ylp8QhhcGBMw8R9tj3QoA=;
 b=kZaeigrORs4TQ6y0QKiuUNom/gnVff8yEJmJ6p/nVzbEBDK7pAYql+qrEoTBNOGkMjTJ
 ffZTFoS/LqDp7FMhioJG1ata4NzDqLtGm9FHmVvZc+cgZk3glnB32eSBHP1AICFkLptr
 L7s7EN10dL/n4SQcfrEXcVBdxw/SfTM+k/I9MybXsU+0bl/SSHHOT8RssfRQYtv9P7Ge
 lu9JZ6xrC+JsfcRiYIvYcFYQRco1cu4GjI3hCc6nYc2kt7KwblYqL1C9BQd/MzDOkL03
 r0uRE8gXv4S7SqvuQOHXeLRIOmmGDW1xfZy13KdIYGqUAAcXEoVT4Qb7Bms1Nvy6kgD0 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9m7a0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:58:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJsgpV103786;
        Tue, 15 Sep 2020 19:58:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33h88yxey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 19:58:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FJvx3s027051;
        Tue, 15 Sep 2020 19:58:00 GMT
Received: from dhcp-10-39-206-109.vpn.oracle.com (/10.39.206.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 19:57:59 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v11 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <8019917d-5e8e-e03d-583c-6809dee7a5c2@infradead.org>
Date:   Tue, 15 Sep 2020 15:57:55 -0400
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FC23678-02D3-444B-B5AF-74E210026185@oracle.com>
References: <20200915180535.2975060-1-alex.kogan@oracle.com>
 <20200915180535.2975060-5-alex.kogan@oracle.com>
 <8019917d-5e8e-e03d-583c-6809dee7a5c2@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=3 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150154
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 15, 2020, at 3:24 PM, Randy Dunlap <rdunlap@infradead.org> =
wrote:
>=20
> Hi,
>=20
> Entries in the kernel-parameters.txt file should be kept in =
alphabetical order
> mostly (there are a few exceptions where related options are kept =
together).
>=20
>=20
>=20
> On 9/15/20 11:05 AM, Alex Kogan wrote:
>> Keep track of the time the thread at the head of the secondary queue
>> has been waiting, and force inter-node handoff once this time passes
>> a preset threshold. The default value for the threshold (10ms) can be
>> overridden with the new kernel boot command-line option
>> "numa_spinlock_threshold". The ms value is translated internally to =
the
>> nearest rounded-up jiffies.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> ---
>> .../admin-guide/kernel-parameters.txt         |  9 ++
>> kernel/locking/qspinlock_cna.h                | 95 =
++++++++++++++++---
>> 2 files changed, 92 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt =
b/Documentation/admin-guide/kernel-parameters.txt
>> index 51ce050f8701..73ab23a47b97 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3363,6 +3363,15 @@
>> 			Not specifying this option is equivalent to
>> 			numa_spinlock=3Dauto.
>>=20
>> +	numa_spinlock_threshold=3D	[NUMA, PV_OPS]
>> +			Set the time threshold in milliseconds for the
>> +			number of intra-node lock hand-offs before the
>> +			NUMA-aware spinlock is forced to be passed to
>> +			a thread on another NUMA node.	Valid values
>> +			are in the [1..100] range. Smaller values result
>> +			in a more fair, but less performant spinlock,
>> +			and vice versa. The default value is 10.
>> +
>> 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>> 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>> 			Some features depend on CPU0. Known dependencies =
are:
>=20
>=20
> This new entry and numa_spinlock from patch 3/5 should go between =
these other 2 NUMA entries:
>=20
> 	numa_balancing=3D	[KNL,X86] Enable or disable automatic =
NUMA balancing.
> 			Allowed values are enable and disable
>=20
> 	numa_zonelist_order=3D [KNL, BOOT] Select zonelist order for =
NUMA.
> 			'node', 'default' can be specified
> 			This can be set from sysctl after boot.
> 			See Documentation/admin-guide/sysctl/vm.rst for =
details.
Will fix that, thanks.

>=20
>=20
> Oooh, that cpu0_hotplug entry is way out of place.  I'll send a patch =
for that.
Sounds good.

=E2=80=94 Alex=
