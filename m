Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7410775C
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2019 19:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVSa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Nov 2019 13:30:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55352 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKVSa3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Nov 2019 13:30:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMIONjJ118773;
        Fri, 22 Nov 2019 18:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=NQkUG/QqIaYEKdkqScvUyHBIBLEDQ0mhob5S2Y4ohUs=;
 b=E52+dKeqaDVgHp94Xqj3jHLM1YYCYmkprL5gAi578Gtmpf3gxI2rIwdhX15tENum/b7y
 QyUWHpbp7GZKc6EGvcRfjyWE28WHIehtMcCFtjf1LeptGUjkvIuyaFAYRUh50C/FESMA
 l3r7A107MhuGCihEsCCeMpXGeMBK3z01PSmiaw0qyVBqMK+B4pkFiq40g1pObipkF3am
 vBJLxqjfrDssLbo28BvNTRnU9xYq2vqgPk/4YGQ8kz8KJE/HQB3mwSc8BJkLZKOC8mXa
 Vb7FcATdRhp6eJLhhjpsPxkIHK1JaAr/4+Lsp8uWpH/Bllo8K0adXV0C46H9CiMV/Mgq Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92qc8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 18:29:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMITCF4189474;
        Fri, 22 Nov 2019 18:29:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wegqs4gna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 18:29:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAMIS5d5000570;
        Fri, 22 Nov 2019 18:28:05 GMT
Received: from [10.39.199.17] (/10.39.199.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Nov 2019 10:28:05 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <201911202212.CdyX1gua%lkp@intel.com>
Date:   Fri, 22 Nov 2019 13:28:02 -0500
Cc:     kbuild-all@lists.01.org, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1A1B09F-C44E-45F7-80EB-09E30AEFD358@oracle.com>
References: <20191107174622.61718-4-alex.kogan@oracle.com>
 <201911202212.CdyX1gua%lkp@intel.com>
To:     kbuild test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9449 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9449 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220153
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Nov 20, 2019, at 10:16 AM, kbuild test robot <lkp@intel.com> wrote:
>=20
> Hi Alex,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.4-rc8 next-20191120]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help
> improve the system. BTW, we also suggest to use '--base' option to =
specify the
> base tree in git format-patch, please see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__stackoverflow.com_a=
_37406982&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DH=
vhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DBxEt1232ccGlMGDinAB0QAUaTFy=
l-m5sp4C-crHjpoU&s=3DOzzQqg4fTDV55X-y4vbnGeXoJaPHSvO_EfrUQnMVRHc&e=3D ]
>=20
> url:    =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_0day-2Dc=
i_linux_commits_Alex-2DKogan_locking-2Dqspinlock-2DRename-2Dmcs-2Dlock-2Du=
nlock-2Dmacros-2Dand-2Dmake-2Dthem-2Dmore-2Dgeneric_20191109-2D180535&d=3D=
DwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE=
1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DBxEt1232ccGlMGDinAB0QAUaTFyl-m5sp4C-crHjp=
oU&s=3DuE7ZeYXOFiu09PUVjnCntEe2rR5x_QxS6dEW9twpfok&e=3D=20
> base:   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub_=
scm_linux_kernel_git_torvalds_linux.git&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=
=3DBxEt1232ccGlMGDinAB0QAUaTFyl-m5sp4C-crHjpoU&s=3DaAKxuXc_c7OF0ffioQfVsIB=
6H-4Sd9PYxSM7kurm2ig&e=3D  0058b0a506e40d9a2c62015fe92eb64a44d78cd9
> config: i386-randconfig-f003-20191120 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>   In file included from include/linux/export.h:42:0,
>                    from include/linux/linkage.h:7,
>                    from include/linux/kernel.h:8,
>                    from include/linux/list.h:9,
>                    from include/linux/smp.h:12,
>                    from kernel/locking/qspinlock.c:16:
>   kernel/locking/qspinlock_cna.h: In function 'cna_init_nodes':
>>> include/linux/compiler.h:350:38: error: call to =
'__compiletime_assert_80' declared with attribute error: BUILD_BUG_ON =
failed: sizeof(struct cna_node) > sizeof(struct qnode)
>     _compiletime_assert(condition, msg, __compiletime_assert_, =
__LINE__)
>                                         ^
>   include/linux/compiler.h:331:4: note: in definition of macro =
'__compiletime_assert'
>       prefix ## suffix();    \
>       ^~~~~~
>   include/linux/compiler.h:350:2: note: in expansion of macro =
'_compiletime_assert'
>     _compiletime_assert(condition, msg, __compiletime_assert_, =
__LINE__)
>     ^~~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:39:37: note: in expansion of macro =
'compiletime_assert'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)
>                                        ^~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:50:2: note: in expansion of macro =
'BUILD_BUG_ON_MSG'
>     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>     ^~~~~~~~~~~~~~~~
>>> kernel/locking/qspinlock_cna.h:80:2: note: in expansion of macro =
'BUILD_BUG_ON'
>     BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
>     ^~~~~~~~~~~~

Consider the following definition of qnode:

struct qnode {
	struct mcs_spinlock mcs;
#if defined(CONFIG_PARAVIRT_SPINLOCKS) || =
defined(CONFIG_NUMA_AWARE_SPINLOCKS)
	long reserved[2];
#endif
};

and this is how cna_node is defined:

struct cna_node {
	struct mcs_spinlock	mcs;
	int			numa_node;
	u32			encoded_tail;
	u32			pre_scan_result; /* 0, 1, 2 or encoded =
tail */
	u32			intra_count;
};

Since long is 32 bit on i386, we get the compilation error above.

We can try and squeeze CNA-specific fields into 64 bit on i386 (or any =
32bit=20
architecture for that matter). Note that an encoded tail pointer =
requires up=20
to 24 bits, and we have two of those. We would want different field =
encodings=20
for 32 vs 64bit architectures, and this all will be quite ugly.

So instead we should probably either change the definition of @reserved =
in qnode=20
to long long, or perhaps disable CNA on 32bit architectures altogether?
I would certainly prefer the former, especially as it requires the least =
amount=20
of code/config changes.

Any objections / thoughts?

Thanks,
=E2=80=94 Alex

