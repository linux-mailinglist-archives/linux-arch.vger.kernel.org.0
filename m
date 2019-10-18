Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94197DD143
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506153AbfJRVjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 17:39:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55824 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJRVjN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 17:39:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ILZ6ag074664;
        Fri, 18 Oct 2019 21:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=sZQ9OqPwUxjOm8RziMERTbkSNvmy/hpOfAE/PjKrlhU=;
 b=bvSaYRK/Nd79dT6XNWKy4Br5pqJVwrFamZSAcfwGQzCWkvUXhWpewaXpq2r12treyYxk
 snU2APjmW902mRRgz4b7mDs0Q2A48I7LJoCgywboH39fbGNRpFWn2wOAODf5hqe+Fbg7
 RV0GqBjvtyKkYqVKrudbU8VOP2P507CRgHMxcDFxedw+hWtC1v6hWA/wJZ/pqu2HGuWI
 uoCQgDEnPG1m750e4IDG3aLTBG6Mwa2bmhMG+I2FXZaWd/HM1mITDc8mE545VtIR4Akl
 gy7a4LvzxJNblw4Pm6vKc5YQuBtaa2L9C9yJfBoP61SPN0i0R3u2YhX+I5Vbdw6Wh32e 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vq0q4685k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 21:38:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ILc2Y1042326;
        Fri, 18 Oct 2019 21:38:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vq0dyjm5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 21:38:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9ILbisJ002499;
        Fri, 18 Oct 2019 21:37:44 GMT
Received: from [172.31.33.200] (/155.48.255.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 21:37:43 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v5 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <6ce50aeb-6b87-5d1c-9011-4329e8dadfec@redhat.com>
Date:   Fri, 18 Oct 2019 17:37:51 -0400
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B59E517-D418-46DF-BC58-174BAFC5EC23@oracle.com>
References: <20191016042903.61081-1-alex.kogan@oracle.com>
 <20191016042903.61081-4-alex.kogan@oracle.com>
 <6ce50aeb-6b87-5d1c-9011-4329e8dadfec@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=970
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180189
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Oct 18, 2019, at 12:03 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 10/16/19 12:29 AM, Alex Kogan wrote:
>> +static inline void cna_pass_lock(struct mcs_spinlock *node,
>> +				 struct mcs_spinlock *next)
>> +{
>> +	struct cna_node *cn =3D (struct cna_node *)node;
>> +	struct mcs_spinlock *next_holder =3D next, *tail_2nd;
>> +	u32 val =3D 1;
>> +
>> +	u32 scan =3D cn->pre_scan_result;
>> +
>> +	/*
>> +	 * check if a successor from the same numa node has not been =
found in
>> +	 * pre-scan, and if so, try to find it in post-scan starting =
from the
>> +	 * node where pre-scan stopped (stored in @pre_scan_result)
>> +	 */
>> +	if (scan > 0)
>> +		scan =3D cna_scan_main_queue(node, decode_tail(scan));
>> +
>> +	if (!scan) { /* if found a successor from the same numa node */
>> +		next_holder =3D node->next;
>> +		/*
>> +		 * make sure @val gets 1 if current holder's @locked is =
0 as
>> +		 * we have to store a non-zero value in successor's =
@locked
>> +		 * to pass the lock
>> +		 */
>> +		val =3D node->locked + (node->locked =3D=3D 0);
>=20
> node->locked can be 0 when the cpu enters into an empty MCS queue. We
> could unconditionally set node->locked to 1 for this case in =
qspinlock.c
> or with your above code.

Right, I was doing that in the first two versions of the series. It adds=20=

unnecessary store into @locked for non-CNA variants, and even if it does =
not
have any real performance implications, I think Peter did not like that =
(or,=20
at least, the comment I had to explain why we needed that store).

> Perhaps, a comment about when node->locked will
> be 0.
Yeah, I was tinkering with this comment. Here is how it read in v3:
/*
 * We unlock a successor by passing a non-zero value,
 * so set @val to 1 iff @locked is 0, which will happen
 * if we acquired the MCS lock when its queue was empty
 */

I can change back to something like that if it is better.

>=20
> It may be easier to understand if you just do
>=20
>     val =3D node->locked ? node->locked : 1;
You=E2=80=99re right, that=E2=80=99s another possibility.
However, it adds yet another if-statement on the critical path, which I =
was
trying to avoid that.

Best regards,
=E2=80=94 Alex

