Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11D35E7F5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 23:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhDMVDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 17:03:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhDMVDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 17:03:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DKsTeS161373;
        Tue, 13 Apr 2021 21:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=4dfm4RYUr78E9iOXwzBJjD+SfiaJJoNxrQuIO7bUaho=;
 b=vYGxKbGql9P0qHyyxthSn5g3d5s78/gURsoGiPTnXKEyWtn3TXnBuxyBfx4b48ixgXSL
 Hc7Gbn9fDu/YatFxrPmh3FLy8OcC+1Wt8CYhwKUt98HfiKax4A1AeKxt19Jfo2llOVZu
 AnV96eudiy7sF+DB+u8yoL1QkyNRADsfkCv2AOQ+q9v79ODo/+FhxIAEKtZB9BKa3VbB
 0XFTRpsVob4Ozw2PXkIEfs+NPcBydzHiT1pBh3MzJNAASN8iUfDk8/eNW6N3lgpoesfu
 qv8aitwVLpYZ8hEoi3GMFgyf33UKL3o3MGfTXpqhfgzfBinj/ZSVLmd++dzLSoULB2nY vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37u3ymge2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:01:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DKpgdd195472;
        Tue, 13 Apr 2021 21:01:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37unx0ach3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:01:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13DL1d15001510;
        Tue, 13 Apr 2021 21:01:39 GMT
Received: from [10.39.235.234] (/10.39.235.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 14:01:39 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <87mtu2vhzz.fsf@linux.intel.com>
Date:   Tue, 13 Apr 2021 17:01:37 -0400
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130140
X-Proofpoint-GUID: dMb8NI2VGUfRTEMwrIaQQqvhIrl_kPln
X-Proofpoint-ORIG-GUID: dMb8NI2VGUfRTEMwrIaQQqvhIrl_kPln
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130140
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Andi.

Thanks for your comments!

> On Apr 13, 2021, at 2:03 AM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> Alex Kogan <alex.kogan@oracle.com> writes:
>>=20
>> +	numa_spinlock_threshold=3D	[NUMA, PV_OPS]
>> +			Set the time threshold in milliseconds for the
>> +			number of intra-node lock hand-offs before the
>> +			NUMA-aware spinlock is forced to be passed to
>> +			a thread on another NUMA node.	Valid values
>> +			are in the [1..100] range. Smaller values result
>> +			in a more fair, but less performant spinlock,
>> +			and vice versa. The default value is 10.
>=20
> ms granularity seems very coarse grained for this. Surely
> at some point of spinning you can afford a ktime_get? But ok.
We are reading time when we are at the head of the (main) queue, but
don=E2=80=99t have the lock yet. Not sure about the latency of =
ktime_get(), but
anything reasonably fast but not necessarily precise should work.

> Could you turn that into a moduleparm which can be changed at runtime?
> Would be strange to have to reboot just to play with this parameter
Yes, good suggestion, thanks.

> This would also make the code a lot shorter I guess.
So you don=E2=80=99t think we need the command-line parameter, just the =
module_param?

Regards,
=E2=80=94 Alex

