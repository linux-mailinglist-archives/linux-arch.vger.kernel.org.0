Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34DFCFF8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNU7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 15:59:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKNU7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 15:59:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKvWDx008472;
        Thu, 14 Nov 2019 20:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=FG1HaMVnPjLO1zLjrgAgeO5VvEqSIsYObWWwx7TU3oI=;
 b=h+UlB897sReoHEOAX83F20rnF2ROsR9G3B8TA4MY1gv4lCvFFWSlNMOsNvkCCVy3dF7E
 8+Plaji6SW39t3bKqxnWFWBoFzqu3gqv3hulx+zOHmiVU3QqY3R+ERgaUCayqEMYfYBU
 8qmpGDJP+qB8KwUDYop4FtRNDcJOLuHrfzJfStR+67MNHUR7SSWjdcIkfTcmk8E02BXX
 iNZYHdPmQfdEKFxgPeVR1R9WX3FsRpyBllvjxESXrY1iNyVr0YfpkoHJmNnkSVjUs9Au
 zWKQREmJL1j2yBawmT5RJZxOBhSoA2EPv7xbtkMsoR9lmGpEodd08bdtcSPtJctmFkrM JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w5p3r5nyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 20:57:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKsDBL131135;
        Thu, 14 Nov 2019 20:57:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w8v2h9jmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 20:57:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEKvXhx004864;
        Thu, 14 Nov 2019 20:57:34 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 12:57:33 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <201911110540.8p3UoQAR%lkp@intel.com>
Date:   Thu, 14 Nov 2019 15:57:34 -0500
Cc:     kbuild-all@lists.01.org, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <58623E4A-973B-46CC-8FA8-29E68DB5EFF4@oracle.com>
References: <20191107174622.61718-4-alex.kogan@oracle.com>
 <201911110540.8p3UoQAR%lkp@intel.com>
To:     kbuild test robot <lkp@intel.com>, linux-sparse@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140173
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ linux-sparse mailing list

It seems like a bug in the way sparse handles =E2=80=9Cpure=E2=80=9D =
functions that return
a pointer.

One of the pure functions in question is defined as following:
	static inline __pure
	struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, =
int idx)
	{
        	return &((struct qnode *)base + idx)->mcs;
	}

and the corresponding variable definition and the assignment statement =
that
produce a warning (in kernel/locking/qspinlock.c) are:
	struct mcs_spinlock *prev, *next, *node;
	=E2=80=A6
	node =3D grab_mcs_node(node, idx);

The issue can be recreated without my patch with
	# sparse version: v0.6.1
	make ARCH=3Dx86_64 allmodconfig
	make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' =
kernel/locking/qspinlock.o


The warnings can be eliminated by adding an explicit cast, e.g.:

	node =3D (struct mcs_spinlock *)grab_mcs_node(node, idx);

but this seems wrong (unnecessary) to me.

Regards,
=E2=80=94 Alex

> On Nov 10, 2019, at 4:30 PM, kbuild test robot <lkp@intel.com> wrote:
>=20
> Hi Alex,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [cannot apply to v5.4-rc6 next-20191108]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help
> improve the system. BTW, we also suggest to use '--base' option to =
specify the
> base tree in git format-patch, please see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__stackoverflow.com_a=
_37406982&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DH=
vhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DhIJsql5G3kZsA2K8s_1WK7096mE=
KsYe-jEraOUNhbDs&s=3D4bbPcLEtAedk_fBrSIBMWvdEslLtH5W28nZLbmMIgL8&e=3D ]
>=20
> url:    =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_0day-2Dc=
i_linux_commits_Alex-2DKogan_locking-2Dqspinlock-2DRename-2Dmcs-2Dlock-2Du=
nlock-2Dmacros-2Dand-2Dmake-2Dthem-2Dmore-2Dgeneric_20191109-2D180535&d=3D=
DwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE=
1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DhIJsql5G3kZsA2K8s_1WK7096mEKsYe-jEraOUNhb=
Ds&s=3DydR3iBtEF-3XUySBCcPYJ8oqw_oNDB-liJdapTXeFeM&e=3D=20
> base:   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub_=
scm_linux_kernel_git_torvalds_linux.git&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=
=3DhIJsql5G3kZsA2K8s_1WK7096mEKsYe-jEraOUNhbDs&s=3Dc4rCmFY0YTXCPiXW9d_BD0R=
N6WU6QGb64h1iyWNCm9A&e=3D  0058b0a506e40d9a2c62015fe92eb64a44d78cd9
> reproduce:
>        # apt-get install sparse
>        # sparse version: v0.6.1-21-gb31adac-dirty
>        make ARCH=3Dx86_64 allmodconfig
>        make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
>   kernel/locking/qspinlock.c:450:14: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*[assigned] node @@    got ct mcs_spinlock *[assigned] node @@
>   kernel/locking/qspinlock.c:450:14: sparse:    expected struct =
mcs_spinlock *[assigned] node
>   kernel/locking/qspinlock.c:450:14: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock.c:498:22: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*prev @@    got struct struct mcs_spinlock *prev @@
>   kernel/locking/qspinlock.c:498:22: sparse:    expected struct =
mcs_spinlock *prev
>   kernel/locking/qspinlock.c:498:22: sparse:    got struct =
mcs_spinlock [pure] *
>>> kernel/locking/qspinlock_cna.h:141:60: sparse: sparse: incorrect =
type in initializer (different modifiers) @@    expected struct =
mcs_spinlock *tail_2nd @@    got struct struct mcs_spinlock *tail_2nd @@
>>> kernel/locking/qspinlock_cna.h:141:60: sparse:    expected struct =
mcs_spinlock *tail_2nd
>>> kernel/locking/qspinlock_cna.h:141:60: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock.c:450:14: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*[assigned] node @@    got ct mcs_spinlock *[assigned] node @@
>   kernel/locking/qspinlock.c:450:14: sparse:    expected struct =
mcs_spinlock *[assigned] node
>   kernel/locking/qspinlock.c:450:14: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock.c:498:22: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*prev @@    got struct struct mcs_spinlock *prev @@
>   kernel/locking/qspinlock.c:498:22: sparse:    expected struct =
mcs_spinlock *prev
>   kernel/locking/qspinlock.c:498:22: sparse:    got struct =
mcs_spinlock [pure] *
>>> kernel/locking/qspinlock_cna.h:107:18: sparse: sparse: incorrect =
type in assignment (different modifiers) @@    expected struct =
mcs_spinlock *tail_2nd @@    got struct struct mcs_spinlock *tail_2nd @@
>   kernel/locking/qspinlock_cna.h:107:18: sparse:    expected struct =
mcs_spinlock *tail_2nd
>   kernel/locking/qspinlock_cna.h:107:18: sparse:    got struct =
mcs_spinlock [pure] *
>>> kernel/locking/qspinlock_cna.h:240:61: sparse: sparse: incorrect =
type in argument 2 (different modifiers) @@    expected struct =
mcs_spinlock *pred_start @@    got struct struct mcs_spinlock =
*pred_start @@
>>> kernel/locking/qspinlock_cna.h:240:61: sparse:    expected struct =
mcs_spinlock *pred_start
>   kernel/locking/qspinlock_cna.h:240:61: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock_cna.h:252:26: sparse: sparse: incorrect =
type in assignment (different modifiers) @@    expected struct =
mcs_spinlock *tail_2nd @@    got struct struct mcs_spinlock *tail_2nd @@
>   kernel/locking/qspinlock_cna.h:252:26: sparse:    expected struct =
mcs_spinlock *tail_2nd
>   kernel/locking/qspinlock_cna.h:252:26: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock.c:450:14: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*[assigned] node @@    got ct mcs_spinlock *[assigned] node @@
>   kernel/locking/qspinlock.c:450:14: sparse:    expected struct =
mcs_spinlock *[assigned] node
>   kernel/locking/qspinlock.c:450:14: sparse:    got struct =
mcs_spinlock [pure] *
>   kernel/locking/qspinlock.c:498:22: sparse: sparse: incorrect type in =
assignment (different modifiers) @@    expected struct mcs_spinlock =
*prev @@    got struct struct mcs_spinlock *prev @@
>   kernel/locking/qspinlock.c:498:22: sparse:    expected struct =
mcs_spinlock *prev
>   kernel/locking/qspinlock.c:498:22: sparse:    got struct =
mcs_spinlock [pure] *
>=20
> vim +141 kernel/locking/qspinlock_cna.h
>=20
>    90=09
>    91	static inline bool cna_try_change_tail(struct qspinlock *lock, =
u32 val,
>    92					       struct mcs_spinlock =
*node)
>    93	{
>    94		struct mcs_spinlock *head_2nd, *tail_2nd;
>    95		u32 new;
>    96=09
>    97		/* If the secondary queue is empty, do what MCS does. */
>    98		if (node->locked <=3D 1)
>    99			return __try_clear_tail(lock, val, node);
>   100=09
>   101		/*
>   102		 * Try to update the tail value to the last node in the =
secondary queue.
>   103		 * If successful, pass the lock to the first thread in =
the secondary
>   104		 * queue. Doing those two actions effectively moves all =
nodes from the
>   105		 * secondary queue into the main one.
>   106		 */
>> 107		tail_2nd =3D decode_tail(node->locked);
>   108		head_2nd =3D tail_2nd->next;
>   109		new =3D ((struct cna_node *)tail_2nd)->encoded_tail + =
_Q_LOCKED_VAL;
>   110=09
>   111		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
>   112			/*
>   113			 * Try to reset @next in tail_2nd to NULL, but =
no need to check
>   114			 * the result - if failed, a new successor has =
updated it.
>   115			 */
>   116			cmpxchg_relaxed(&tail_2nd->next, head_2nd, =
NULL);
>   117			arch_mcs_pass_lock(&head_2nd->locked, 1);
>   118			return true;
>   119		}
>   120=09
>   121		return false;
>   122	}
>   123=09
>   124	/*
>   125	 * cna_splice_tail -- splice nodes in the main queue between =
[first, last]
>   126	 * onto the secondary queue.
>   127	 */
>   128	static void cna_splice_tail(struct mcs_spinlock *node,
>   129				    struct mcs_spinlock *first,
>   130				    struct mcs_spinlock *last)
>   131	{
>   132		/* remove [first,last] */
>   133		node->next =3D last->next;
>   134=09
>   135		/* stick [first,last] on the secondary queue tail */
>   136		if (node->locked <=3D 1) { /* if secondary queue is =
empty */
>   137			/* create secondary queue */
>   138			last->next =3D first;
>   139		} else {
>   140			/* add to the tail of the secondary queue */
>> 141			struct mcs_spinlock *tail_2nd =3D =
decode_tail(node->locked);
>   142			struct mcs_spinlock *head_2nd =3D =
tail_2nd->next;
>   143=09
>   144			tail_2nd->next =3D first;
>   145			last->next =3D head_2nd;
>   146		}
>   147=09
>   148		node->locked =3D ((struct cna_node =
*)last)->encoded_tail;
>   149	}
>   150=09
>   151	/*
>   152	 * cna_scan_main_queue - scan the main waiting queue looking for =
the first
>   153	 * thread running on the same NUMA node as the lock holder. If =
found (call it
>   154	 * thread T), move all threads in the main queue between the =
lock holder and
>   155	 * T to the end of the secondary queue and return 0; otherwise, =
return the
>   156	 * encoded pointer of the last scanned node in the primary queue =
(so a
>   157	 * subsequent scan can be resumed from that node)
>   158	 *
>   159	 * Schematically, this may look like the following (nn stands =
for numa_node and
>   160	 * et stands for encoded_tail).
>   161	 *
>   162	 *   when cna_scan_main_queue() is called (the secondary queue =
is empty):
>   163	 *
>   164	 *  A+------------+   B+--------+   C+--------+   T+--------+
>   165	 *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> =
NULL
>   166	 *   |mcs:locked=3D1|    |cna:nn=3D0|    |cna:nn=3D2|    =
|cna:nn=3D1|
>   167	 *   |cna:nn=3D1    |    +--------+    +--------+    +--------+
>   168	 *   +----------- +
>   169	 *
>   170	 *   when cna_scan_main_queue() returns (the secondary queue =
contains B and C):
>   171	 *
>   172	 *  A+----------------+    T+--------+
>   173	 *   |mcs:next        | ->  |mcs:next| -> NULL
>   174	 *   |mcs:locked=3DC.et | -+  |cna:nn=3D1|
>   175	 *   |cna:nn=3D1        |  |  +--------+
>   176	 *   +--------------- +  +-----+
>   177	 *                             \/
>   178	 *          B+--------+   C+--------+
>   179	 *           |mcs:next| -> |mcs:next| -+
>   180	 *           |cna:nn=3D0|    |cna:nn=3D2|  |
>   181	 *           +--------+    +--------+  |
>   182	 *               ^                     |
>   183	 *               +---------------------+
>   184	 *
>   185	 * The worst case complexity of the scan is O(n), where n is the =
number
>   186	 * of current waiters. However, the amortized complexity is =
close to O(1),
>   187	 * as the immediate successor is likely to be running on the =
same node once
>   188	 * threads from other nodes are moved to the secondary queue.
>   189	 */
>   190	static u32 cna_scan_main_queue(struct mcs_spinlock *node,
>   191				       struct mcs_spinlock *pred_start)
>   192	{
>   193		struct cna_node *cn =3D (struct cna_node *)node;
>   194		struct cna_node *cni =3D (struct cna_node =
*)READ_ONCE(pred_start->next);
>   195		struct cna_node *last;
>   196		int my_numa_node =3D cn->numa_node;
>   197=09
>   198		/* find any next waiter on 'our' NUMA node */
>   199		for (last =3D cn;
>   200		     cni && cni->numa_node !=3D my_numa_node;
>   201		     last =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
>   202			;
>   203=09
>   204		/* if found, splice any skipped waiters onto the =
secondary queue */
>   205		if (cni) {
>   206			if (last !=3D cn)	/* did we skip any =
waiters? */
>   207				cna_splice_tail(node, node->next,
>   208						(struct mcs_spinlock =
*)last);
>   209			return 0;
>   210		}
>   211=09
>   212		return last->encoded_tail;
>   213	}
>   214=09
>   215	__always_inline u32 cna_pre_scan(struct qspinlock *lock,
>   216					  struct mcs_spinlock *node)
>   217	{
>   218		struct cna_node *cn =3D (struct cna_node *)node;
>   219=09
>   220		cn->pre_scan_result =3D cna_scan_main_queue(node, node);
>   221=09
>   222		return 0;
>   223	}
>   224=09
>   225	static inline void cna_pass_lock(struct mcs_spinlock *node,
>   226					 struct mcs_spinlock *next)
>   227	{
>   228		struct cna_node *cn =3D (struct cna_node *)node;
>   229		struct mcs_spinlock *next_holder =3D next, *tail_2nd;
>   230		u32 val =3D 1;
>   231=09
>   232		u32 scan =3D cn->pre_scan_result;
>   233=09
>   234		/*
>   235		 * check if a successor from the same numa node has not =
been found in
>   236		 * pre-scan, and if so, try to find it in post-scan =
starting from the
>   237		 * node where pre-scan stopped (stored in =
@pre_scan_result)
>   238		 */
>   239		if (scan > 0)
>> 240			scan =3D cna_scan_main_queue(node, =
decode_tail(scan));
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source =
Technology Center
> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_hyperk=
itty_list_kbuild-2Dall-40lists.01.org&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8P=
Zh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3D=
hIJsql5G3kZsA2K8s_1WK7096mEKsYe-jEraOUNhbDs&s=3DVprTTTCiBtYDpGK-n61PqoAYog=
z7_cX60cLNj_O8K2E&e=3D  Intel Corporation

