Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB814E551
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgA3WGf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 17:06:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 17:06:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UM3PG3086147;
        Thu, 30 Jan 2020 22:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=YcC/ENL9iqZSK4D+kLTsVIomtiqLWyzWEd1epN64/qk=;
 b=ioKZPM/slJXaLf4ZqEMqjvk+50DLqvuHkdOHw+Cgz8ayZR5+WNQDpbi+xWzC6CTS4RLn
 i3wVxKs03PWdcARBZlEUP/KsqLSz610530AVUDlI8I5/aW+Hd6HWJFiiaHRZIzJdV3Fg
 p8OihU85jmRVEcM6UZKji5cXyfayxFbypX7itJApNsW84VvXKL+RF1e22fwewf3h0K/H
 2DvwJG2xHcGPXJSWW7z1EGzHVNlPlGf+5aD9b35PzKGqjV2zmjZXtiTXusU1TuwNrxeQ
 YG9dvPPKsKK6hiJgPFc61QUVg8U/hpQYi6es26RzP4RG1R5PlKRyoyrMAsC3dWiH2fpQ Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmqy3u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 22:05:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UM3hR2033459;
        Thu, 30 Jan 2020 22:05:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xuemxby59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 22:05:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00UM5VAY018630;
        Thu, 30 Jan 2020 22:05:31 GMT
Received: from [10.39.234.252] (/10.39.234.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 14:05:30 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20200125111931.GW11457@worktop.programming.kicks-ass.net>
Date:   Thu, 30 Jan 2020 17:05:28 -0500
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
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
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
References: <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jan 25, 2020, at 6:19 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Jan 24, 2020 at 01:19:05PM -0500, Alex Kogan wrote:
>=20
>> Is there a lightweight way to identify such a =E2=80=9Cprioritized=E2=80=
=9D thread?
>=20
> No; people might for instance care about tail latencies between their
> identically spec'ed worker tasks.

I would argue that those users need to tune/reduce the intra-node =
handoff
threshold for their needs. Or disable CNA altogether.

In general, Peter, seems like you are not on board with the way Longman
suggested to handle prioritized threads. Am I right?

Thanks,
=E2=80=94 Alex

