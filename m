Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51B234533E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 00:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCVXuh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 19:50:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39760 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCVXud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 19:50:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MNiAwM112129;
        Mon, 22 Mar 2021 23:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=xZLmyTUeB7Hw0t5Pc7rgU3SkM4+am/V+4Bd3TGUo+iQ=;
 b=imrz8AnHh+N06oXXsdO4ch1V6dRRzRCY2pkOw204kWKnhPTVbtA/85kiAf2c3t1kYmFh
 jxpvPORGeqryXaVzDvy/5AoPG05aR7q5IwMvmONztwte6zaXJCC+G/mZeH5y9PkL1Akt
 SNMKe1kLPva0c9pMwW6t+g4TjX8AkVHP+UIc66sr0+qrKm8AW+nQEBxgyj3WuEEDmi91
 Sl14hnHP6C+OZIEBCtfTeAZlc1mZEIj5k+ZD6D95u3XW2KE8OtRxm7t0uueyzLfvlZdi
 46M181PZFWiPGgiH5yTfPpPEjUsGH6yHc88C5cnfbpnFfBoTyQ2CI2G25X7hDYPXIeKE aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbd9j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:50:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MNkJ5M153839;
        Mon, 22 Mar 2021 23:50:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37dtxxja7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:50:00 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12MNnmV2030006;
        Mon, 22 Mar 2021 23:49:52 GMT
Received: from dhcp-10-39-195-110.vpn.oracle.com (/10.39.195.110)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 23:49:48 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [LKP] Re: [locking/qspinlock] 0e8d8f4f12:
 stress-ng.zero.ops_per_sec -9.7% regression
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <DD47C64E-9687-4CBE-9A07-835E1540DC8D@oracle.com>
Date:   Mon, 22 Mar 2021 19:49:46 -0400
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "jglauber@marvell.com" <jglauber@marvell.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Dice <dave.dice@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90FEBB90-F136-4692-8102-9C21367D34B9@oracle.com>
References: <20201223054455.1990884-4-alex.kogan@oracle.com>
 <20201228081601.GA31221@xsang-OptiPlex-9020>
 <SA2PR10MB46525798D53C47B39F88ED5DF1919@SA2PR10MB4652.namprd10.prod.outlook.com>
 <503790ff-7f97-a3d3-8780-6ebb234efde1@linux.intel.com>
 <D32BF197-B160-42C1-8655-88B66EC87A78@oracle.com>
 <cd078fa1-f997-e9f7-892a-78fb38d30fca@linux.intel.com>
 <DD47C64E-9687-4CBE-9A07-835E1540DC8D@oracle.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220177
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220177
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Mar 22, 2021, at 7:15 PM, Alex Kogan <alex.kogan@oracle.com> wrote:
>=20
> Many thanks to Zhengjun Xing for the help in reproducing the issue.
>=20
> On our system, the regression is less than 7% (the numbers are below), =
however,
> at least at the full capacity, the numbers are very stable. This =
allowed me to track down the
> issue and identify unnecessary stores into the queue node structure, =
which may cause=20
> cache misses during lock transfers. Moving those stores into the =
initialization code (cna_init_nodes())
> solves the problem.
>=20
> Below are the numbers of =E2=80=9Cbogo ops/s=E2=80=9D reported by =
stress-ng with various numbers of workers.=20
> Each number represents an average over 25 runs, with the standard =
deviation reported in ().
>=20
> #workers      stock                          CNA / speedup             =
  CNA+patch / speedup
>  18  16327.844 (581.744) 15480.061 (582.654) / 0.948  16422.349 =
(473.729) / 1.006
>  36    8573.557 (285.058)   8003.888 (196.125) / 0.934    8457.436 =
(258.065) / 0.986
>  72    4042.535 (28.766)     3960.407 (28.648) / 0.980      4107.143 =
(23.037) / 1.016
> 108   2735.913 (7.440)       2678.888 (7.102) / 0.979        2774.751 =
(4.375) / 1.014
> 144   2093.477 (3.341)       2042.968 (1.982) / 0.976        2109.879 =
(1.714) / 1.008

Those are "bogo ops/s (usr+sys time)", btw. Just in case, below are =
"bogo ops/s (real time)=E2=80=9D
numbers, which I believe is what is reported by the kernel test robot:

#workers      stock                     CNA / speedup               =
CNA+patch / speedup
 18   262932.282 (12638.248)   249653.081 (11822.940) / 0.949  =
265189.104 (9271.447) / 1.009
 36   277315.640 (11100.324)   260177.335 (7186.451) / 0.938   =
274691.250 (10329.523) / 0.991
 72   263904.000 (2128.206)    259967.180 (1857.393) / 0.985   =
268971.483 (1713.639) / 1.019
108   273811.373 (664.517)     268949.947 (690.329) / 0.982    =
278196.867 (403.978) / 1.016
144   284321.364 (399.281)     278153.208 (210.776) / 0.978    =
287343.806 (280.963) / 1.011

Regards,
=E2=80=94 Alex

> The patch is attached. As always, comments are welcome!
>=20
> Unless there any objections, I will reintegrate the patch into the =
series, and post a new
> revision.
>=20
> Regards,
> =E2=80=94 Alex

