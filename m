Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D85149EEA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0GGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 01:06:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0GGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 01:06:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R6365q111317;
        Mon, 27 Jan 2020 06:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=JHl3pxKyojAGqGYtfwPFlNCopLmnuaTKzY6k8aSGSUo=;
 b=kOc4+jOX6atn7j9uyuG/XIuhfbNoYv9V/Dg/jICNfYgMbvDP/yAaoCHG++BO5OUH3zYq
 mo5r6N01ZydHh6+tMXhEHlxTQFqjRHYSpbcZ4tIE9/S4VTpDzvbvU3mhqMADQbRRgABw
 +YIYu3w3uPDpYILjOHtqshx0KrdyZUgfNUSmtHTIQzhcZGrcfsVxRNFoIW9nB2nf4Wa+
 6qhUqTsj+MVBVhKz3l9eVAWOlHbZJNx5k9pXedlkaqEfKcSNWIdTODvy6kAGztxCD5JQ
 hcdUuyxHJ2rHmC2OLmqVDWR/vD5NJaAS5mTlPyrFn97iTc628nlMbA/OBc/yIkSOR1yS rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmq58bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:05:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R643Vq184794;
        Mon, 27 Jan 2020 06:05:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xry4tm010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:05:00 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R64i3x020066;
        Mon, 27 Jan 2020 06:04:47 GMT
Received: from [10.39.241.133] (/10.39.241.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jan 2020 22:04:43 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20200126224245.GA22901@paulmck-ThinkPad-P72>
Date:   Mon, 27 Jan 2020 01:04:45 -0500
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB96E148-C72B-4D00-95F0-C4B69A3EE454@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
 <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
 <20200126153535.GL2935@paulmck-ThinkPad-P72>
 <20200126224245.GA22901@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270052
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 26, 2020, at 5:42 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Sun, Jan 26, 2020 at 07:35:35AM -0800, Paul E. McKenney wrote:
>> On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
>>> On 1/24/20 11:58 PM, Paul E. McKenney wrote:
>>>> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
>>>>> On 1/24/20 8:59 PM, Waiman Long wrote:
>>>>>>> You called it!  I will play with QEMU's -numa argument to see if =
I can get
>>>>>>> CNA to run for me.  Please accept my apologies for the false =
alarm.
>>>>>>>=20
>>>>>>> 							Thanx, =
Paul
>>>>>>>=20
>>>>>> CNA is not currently supported in a VM guest simply because the =
numa
>>>>>> information is not reliable. You will have to run it on baremetal =
to
>>>>>> test it. Sorry for that.
>>>>> Correction. There is a command line option to force CNA lock to be =
used
>>>>> in a VM. Use the "numa_spinlock=3Don" boot command line parameter.
>>>> As I understand it, I need to use a series of -numa arguments to =
qemu
>>>> combined with the numa_spinlock=3Don (or =3D1) on the kernel =
command line.
>>>> If the kernel thinks that there is only one NUMA node, it appears =
to
>>>> avoid doing CNA.
>>>>=20
>>>> Correct?
>>>>=20
>>>> 							Thanx, Paul
>>>>=20
>>> In auto-detection mode (the default), CNA will only be turned on =
when
>>> paravirt qspinlock is not enabled first and there are at least 2 =
numa
>>> nodes. The "numa_spinlock=3Don" option will force it on even when =
both of
>>> the above conditions are false.
>>=20
>> Hmmm...
>>=20
>> Here is my kernel command line taken from the console log:
>>=20
>> console=3DttyS0 locktorture.onoff_interval=3D0 numa_spinlock=3Don =
locktorture.stat_interval=3D15 locktorture.shutdown_secs=3D1800 =
locktorture.verbose=3D1
>>=20
>> Yet the string "Enabling CNA spinlock" does not appear.
>>=20
>> Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his =
build.
>> Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=3Dy"...
>=20
> And after fixing that, plus adding the other three Kconfig options =
required
> to enable this, I really do see "Enabling CNA spinlock" in the console =
log.
> Yay!
Great! Your persistence paid off :)

Yet, CNA does not do much interesting here, as it sees only one numa =
node.

>=20
> At the end of the 30-minute locktorture exclusive-lock run, I see =
this:
>=20
> Writes:  Total: 572176565  Max/Min: 54167704/10878216 ???  Fail: 0
>=20
> This is about a five-to-one ratio.  Is this expected behavior, given a
> single NUMA node on a single-socket system with 12 hardware threads?
I=E2=80=99m not sure what is expected here.
I=E2=80=99m guessing that if you boot your guest with the default=20
(non-CNA/non-paravirt) qspinlock, you will get a similar result.

>=20
> I will try reader-writer lock next.
>=20
> Again, should I be using qemu's -numa command-line option to create =
nodes?
> If so, what would be a sane configuration given 12 CPUs and 512MB of
> memory for the VM?  If not, what is a good way to exercise CNA's NUMA
> capabilities within a guest OS?
That=E2=80=99s a good question. Perhaps Longman knows the answer?

Regards,
=E2=80=94 Alex=
