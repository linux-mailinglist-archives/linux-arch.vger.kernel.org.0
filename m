Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783B62583AF
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 23:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgHaVka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 17:40:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbgHaVka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 17:40:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VLdfC7005212;
        Mon, 31 Aug 2020 21:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=EqeCA8+pMsyyrsH82bxHVe0F9RBa83hjma79v3UMAXE=;
 b=Od8fJqMeLYRFpyG3O29wL/1a1FuLtAYHnyHjzUXNwM4kdwt2uWwJ6GyOyz58B/pWsCaT
 7Sm67bzAGwM4vRUrI3qEZTw5wFANwBfSF4cGqlICwirUaC54K6GgKVnFlbpQLVXA/DyY
 F153ZYMdXbp6pOHlWnzmxts4c+iHaB9nkxVJ6N49114B3ofYzjw+rtzkNTd3I9YdC9+y
 jt3JBk1a4Au0p8KIbGPWkGIhN2hH2LpiCEgmusQLiy2R10/IVCfNn8KyQNt2DnMFCTC2
 h6qXM4AMbwh17uIf40GcwgAsAvz4lW54bczYhU2ez3oHlRfgAn62QBA+LI/w+0CdKZ65 Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 337qrhfsh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 21:39:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VLUvBd011272;
        Mon, 31 Aug 2020 21:39:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sqn2ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 21:39:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VLdQSf011060;
        Mon, 31 Aug 2020 21:39:26 GMT
Received: from [10.39.238.217] (/10.39.238.217)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 14:39:26 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
Message-Id: <08E77224-563F-49C7-9E7F-BD98E4FD121D@oracle.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_DBB9AD1D-9F49-43E3-9D5A-72FD3E01F661"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v10 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date:   Mon, 31 Aug 2020 17:39:22 -0400
In-Reply-To: <a4bf9541-1996-3ba2-dfe5-e734c652ac86@redhat.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
To:     Waiman Long <longman@redhat.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
 <20200403205930.1707-4-alex.kogan@oracle.com>
 <a4bf9541-1996-3ba2-dfe5-e734c652ac86@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310127
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Apple-Mail=_DBB9AD1D-9F49-43E3-9D5A-72FD3E01F661
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jul 28, 2020, at 4:00 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 4/3/20 4:59 PM, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a primary queue =
for
>> threads running on the same node as the current lock holder, and a
>> secondary queue for threads running on other nodes. After acquiring =
the
>> MCS lock and before acquiring the spinlock, the lock holder scans the
>> primary queue looking for a thread running on the same node =
(pre-scan). If
>> found (call it thread T), all threads in the primary queue between =
the
>> current lock holder and T are moved to the end of the secondary =
queue.
>> If such T is not found, we make another scan of the primary queue =
when
>> unlocking the MCS lock (post-scan), starting at the position where
>> pre-scan stopped. If both scans fail to find such T, the MCS lock is
>> passed to the first thread in the secondary queue. If the secondary =
queue
>> is empty, the lock is passed to the next thread in the primary queue.
>> For more details, see =
https://urldefense.com/v3/__https://arxiv.org/abs/1810.05600__;!!GqivPVa7B=
rio!OaieLQ3MMZThgxr-Of8i9dbN5CwG8mXSIBJ_sUofhAXcs43IWL2x-stO-XKLEebn$ .
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same node. This issue
>> will be addressed later in the series.
>>=20
>> Enabling CNA is controlled via a new configuration option
>> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at =
the
>> boot time only if we run on a multi-node machine in native =
environment and
>> the new config is enabled. (For the time being, the patching requires
>> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should =
be
>> resolved once static_call() is available.) This default behavior can =
be
>> overridden with the new kernel boot command-line option
>> "numa_spinlock=3Don/off" (default is "auto").
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> ---
>=20
> There is also a concern that the worst case latency for a lock =
transfer can be close to O(n) which can be quite large for large SMP =
systems. I have a patch on top that modifies the current behavior to =
limit the number of node scans after the lock is freed.

I understand the concern. While your patch addresses it, I am afraid it =
makes
the code somewhat more complex, and duplicates some of the slow path
functionality (e.g., the spin loop until the lock value changes to a =
certain
value).

Let me suggest a different idea for gradually restructuring the main =
queue
that has some similarity to the way you suggested to handle prioritized =
waiters.
Basically, instead of scanning the entire chain of main queue waiters,=20=

we can check only the next waiter and, if present and it runs on a =
different
node, move it to the secondary queue. In addition, to maintain the =
preference
for a certain numa node ID, we set the numa node of the next-next =
waiter,=20
if present, to that of the current lock holder. This is the part similar =
to the
way you suggested to handle prioritized waiters.

This way, the worst case complexity of cna_order_queue() decreases from =
O(n)
down to O(1), as we always =E2=80=9Cscan" only one waiter. And as =
before, we change
the preference (and flush the secondary queue) after X handovers (or =
after
Y ms, as in your in other patch).

I attach the patch that applies on top of your patch for prioritized =
nodes
(0006), but does not include your patch 0007 (time based threshold),=20
which I will integrate into the series in the next revision.

Please, let me know what you think.

Thanks,
=E2=80=94 Alex


--Apple-Mail=_DBB9AD1D-9F49-43E3-9D5A-72FD3E01F661
Content-Disposition: attachment;
	filename=0007-locking-qspinlock-Implement-incremental-culling-in-C.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0007-locking-qspinlock-Implement-incremental-culling-in-C.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2028af255824b92a79fc055e15f5dd2251bc055c10=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Alex=20Kogan=20<alex.kogan@oracle.com>=0ADate:=20=
Thu,=2027=20Aug=202020=2019:06:48=20-0400=0ASubject:=20[PATCH=20v10=20=
7/7]=20locking/qspinlock:=20Implement=20incremental=20culling=20in=0A=20=
CNA=0A=0AReplace=20the=20scan=20of=20the=20main=20queue=20in=20=
cna_order_queue()=0Awith=20incremental=20culling.=20This=20decreases=20=
the=20worst=20case=0Acomplexity=20of=20cna_order_queue()=20from=20O(n)=20=
down=20to=20O(1).=0AThe=20idea=20is=20to=20move=20waiters=20running=20on=20=
other=20nodes=0Agradually,=20one-by-one,=20into=20the=20secondary=20=
queue.=20This=20is=0Aachieved=20by=20probing=20the=20numa=20node=20of=20=
the=20next=20waiter=20only,=0Ahence=20O(1)=20complexity.=20To=20keep=20=
the=20lock=20priority=20on=20the=0Asame=20node=20even=20if=20there=20is=20=
a=20chain=20of=20waiters=20from=20different=0Anodes,=20we=20overwrite=20=
numa=20nodes=20of=20those=20waiters.=20Those=0A'fake'=20numa=20nodes=20=
will=20be=20reset=20in=20subsequent=20lock=20acquisitions.=0A=0A=
Signed-off-by:=20Alex=20Kogan=20<alex.kogan@oracle.com>=0A---=0A=20=
kernel/locking/qspinlock_cna.h=20|=20135=20=
+++++++++++++++------------------=0A=201=20file=20changed,=2063=20=
insertions(+),=2072=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/locking/qspinlock_cna.h=20b/kernel/locking/qspinlock_cna.h=0A=
index=20911c96279494..e5faf16ebe29=20100644=0A---=20=
a/kernel/locking/qspinlock_cna.h=0A+++=20=
b/kernel/locking/qspinlock_cna.h=0A@@=20-59,14=20+59,14=20@@=20struct=20=
cna_node=20{=0A=20=09u16=09=09=09numa_node;=0A=20=09u16=09=09=09=
real_numa_node;=0A=20=09u32=09=09=09encoded_tail;=09/*=20self=20*/=0A-=09=
u32=09=09=09partial_order;=09/*=20encoded=20tail=20or=20enum=20val=20*/=0A=
+=09u32=09=09=09partial_order;=09/*=20enum=20val=20*/=0A=20=09u32=09=09=09=
intra_count;=0A=20};=0A=20=0A=20enum=20{=0A-=09LOCAL_WAITER_FOUND=20=3D=20=
2,=09/*=200=20and=201=20are=20reserved=20for=20@locked=20*/=0A-=09=
FLUSH_SECONDARY_QUEUE=20=3D=203,=0A-=09MIN_ENCODED_TAIL=0A+=09=
LOCAL_WAITER_FOUND,=0A+=09LOCAL_WAITER_NOT_FOUND,=0A+=09=
FLUSH_SECONDARY_QUEUE,=0A=20};=0A=20=0A=20/*=0A@@=20-90,10=20+90,9=20@@=20=
static=20void=20__init=20cna_init_nodes_per_cpu(unsigned=20int=20cpu)=0A=20=
=09=09cn->encoded_tail=20=3D=20encode_tail(cpu,=20i);=0A=20=09=09/*=0A=20=
=09=09=20*=20make=20sure=20@encoded_tail=20is=20not=20confused=20with=20=
other=20valid=0A-=09=09=20*=20values=20for=20@locked=20(0=20or=201)=20or=20=
with=20designated=20values=20for=0A-=09=09=20*=20@pre_scan_result=0A+=09=09=
=20*=20values=20for=20@locked=20(0=20or=201)=0A=20=09=09=20*/=0A-=09=09=
WARN_ON(cn->encoded_tail=20<=20MIN_ENCODED_TAIL);=0A+=09=09=
WARN_ON(cn->encoded_tail=20<=3D=201);=0A=20=09}=0A=20}=0A=20=0A@@=20=
-117,10=20+116,6=20@@=20static=20int=20__init=20cna_init_nodes(void)=0A=20=
=0A=20static=20__always_inline=20void=20cna_init_node(struct=20=
mcs_spinlock=20*node)=0A=20{=0A-=09/*=0A-=09=20*=20Set=20the=20priority=20=
bit=20in=20@numa_node=20for=20threads=20that=20should=20not=0A-=09=20*=20=
be=20moved=20to=20the=20secondary=20queue.=0A-=09=20*/=0A=20=09bool=20=
priority=20=3D=20!in_task()=20||=20irqs_disabled()=20||=20=
rt_task(current);=0A=20=09struct=20cna_node=20*cn=20=3D=20(struct=20=
cna_node=20*)node;=0A=20=0A@@=20-213,79=20+208,64=20@@=20static=20inline=20=
bool=20cna_try_clear_tail(struct=20qspinlock=20*lock,=20u32=20val,=0A=20=
}=0A=20=0A=20/*=0A-=20*=20cna_splice_tail=20--=20splice=20nodes=20in=20=
the=20primary=20queue=20between=20[first,=20last]=0A+=20*=20=
cna_splice_tail=20--=20splice=20the=20next=20node=20from=20the=20primary=20=
queue=0A=20=20*=20onto=20the=20secondary=20queue.=0A=20=20*/=0A-static=20=
void=20cna_splice_tail(struct=20mcs_spinlock=20*node,=0A-=09=09=09=20=20=20=
=20struct=20mcs_spinlock=20*first,=0A-=09=09=09=20=20=20=20struct=20=
mcs_spinlock=20*last)=0A+static=20void=20cna_splice_next(struct=20=
mcs_spinlock=20*node,=0A+=09=09=09=20=20=20=20struct=20mcs_spinlock=20=
*next,=0A+=09=09=09=20=20=20=20struct=20mcs_spinlock=20*nnext)=0A=20{=0A=
-=09/*=20remove=20[first,last]=20*/=0A-=09node->next=20=3D=20last->next;=0A=
+=09/*=20remove=20'next'=20from=20the=20main=20queue=20*/=0A+=09=
node->next=20=3D=20nnext;=0A=20=0A-=09/*=20stick=20[first,last]=20on=20=
the=20secondary=20queue=20tail=20*/=0A+=09/*=20stick=20`next`=20on=20the=20=
secondary=20queue=20tail=20*/=0A=20=09if=20(node->locked=20<=3D=201)=20{=20=
/*=20if=20secondary=20queue=20is=20empty=20*/=0A=20=09=09/*=20create=20=
secondary=20queue=20*/=0A-=09=09last->next=20=3D=20first;=0A+=09=09=
next->next=20=3D=20next;=0A=20=09}=20else=20{=0A=20=09=09/*=20add=20to=20=
the=20tail=20of=20the=20secondary=20queue=20*/=0A=20=09=09struct=20=
mcs_spinlock=20*tail_2nd=20=3D=20decode_tail(node->locked);=0A=20=09=09=
struct=20mcs_spinlock=20*head_2nd=20=3D=20tail_2nd->next;=0A=20=0A-=09=09=
tail_2nd->next=20=3D=20first;=0A-=09=09last->next=20=3D=20head_2nd;=0A+=09=
=09tail_2nd->next=20=3D=20next;=0A+=09=09next->next=20=3D=20head_2nd;=0A=20=
=09}=0A=20=0A-=09node->locked=20=3D=20((struct=20cna_node=20=
*)last)->encoded_tail;=0A+=09node->locked=20=3D=20((struct=20cna_node=20=
*)next)->encoded_tail;=0A=20}=0A=20=0A=20/*=0A-=20*=20cna_order_queue=20=
-=20scan=20the=20primary=20queue=20looking=20for=20the=20first=20lock=20=
node=20on=0A-=20*=20the=20same=20NUMA=20node=20as=20the=20lock=20holder=20=
and=20move=20any=20skipped=20nodes=20onto=20the=0A-=20*=20secondary=20=
queue.=0A-=20*=0A-=20*=20Returns=20LOCAL_WAITER_FOUND=20if=20a=20=
matching=20node=20is=20found;=20otherwise=20return=0A-=20*=20the=20=
encoded=20pointer=20to=20the=20last=20element=20inspected=20(such=20that=20=
a=20subsequent=0A-=20*=20scan=20can=20continue=20there).=0A-=20*=0A-=20*=20=
The=20worst=20case=20complexity=20of=20the=20scan=20is=20O(n),=20where=20=
n=20is=20the=20number=0A-=20*=20of=20current=20waiters.=20However,=20the=20=
amortized=20complexity=20is=20close=20to=20O(1),=0A-=20*=20as=20the=20=
immediate=20successor=20is=20likely=20to=20be=20running=20on=20the=20=
same=20node=20once=0A-=20*=20threads=20from=20other=20nodes=20are=20=
moved=20to=20the=20secondary=20queue.=0A+=20*=20cna_order_queue=20-=20=
check=20whether=20the=20next=20lock=20waiter=0A+=20*=20is=20on=20the=20=
same=20NUMA=20node=20as=20the=20lock=20holder;=20if=20not,=0A+=20*=20and=20=
it=20is=20not=20a=20prioritized=20waiter,=20move=20it=20onto=0A+=20*=20=
the=20secondary=20queue.=0A=20=20*/=0A-static=20u32=20=
cna_order_queue(struct=20mcs_spinlock=20*node,=0A-=09=09=09=20=20=20=
struct=20mcs_spinlock=20*iter)=0A+static=20u32=20cna_order_queue(struct=20=
mcs_spinlock=20*node)=0A=20{=0A-=09struct=20cna_node=20*cni=20=3D=20=
(struct=20cna_node=20*)READ_ONCE(iter->next);=0A-=09struct=20cna_node=20=
*cn=20=3D=20(struct=20cna_node=20*)node;=0A-=09int=20nid=20=3D=20=
cn->numa_node;=0A-=09struct=20cna_node=20*last;=0A-=0A-=09/*=20find=20=
any=20next=20waiter=20on=20'our'=20NUMA=20node=20*/=0A-=09for=20(last=20=
=3D=20cn;=0A-=09=09=20/*=0A-=09=09=20=20*=20iterate=20as=20long=20as=20=
the=20current=20node=20is=20not=20priorizied=20and=0A-=09=09=20=20*=20=
does=20not=20run=20on=20'our'=20NUMA=20node=0A-=09=09=20=20*/=0A-=09=20=20=
=20=20=20cni=20&&=20cni->numa_node=20!=3D=20CNA_PRIORITY_NODE=20&&=20=
cni->numa_node=20!=3D=20nid;=0A-=09=20=20=20=20=20last=20=3D=20cni,=20=
cni=20=3D=20(struct=20cna_node=20*)READ_ONCE(cni->mcs.next))=0A-=09=09;=0A=
+=09struct=20mcs_spinlock=20*next=20=3D=20READ_ONCE(node->next);=0A+=09=
int=20numa_node,=20next_numa_node;=0A=20=0A-=09if=20(!cni)=0A-=09=09=
return=20last->encoded_tail;=20/*=20continue=20from=20here=20*/=0A+=09if=20=
(!next)=0A+=09=09return=20LOCAL_WAITER_NOT_FOUND;=0A=20=0A-=09if=20=
(cni->numa_node=20=3D=3D=20CNA_PRIORITY_NODE)=0A-=09=09cni->numa_node=20=
=3D=20nid;=09/*=20Inherit=20node=20id=20of=20primary=20queue=20*/=0A+=09=
numa_node=20=3D=20((struct=20cna_node=20*)node)->numa_node;=0A+=09=
next_numa_node=20=3D=20((struct=20cna_node=20*)next)->numa_node;=0A=20=0A=
-=09if=20(last=20!=3D=20cn)=09/*=20did=20we=20skip=20any=20waiters?=20*/=0A=
-=09=09cna_splice_tail(node,=20node->next,=20(struct=20mcs_spinlock=20=
*)last);=0A+=09if=20(next_numa_node=20!=3D=20numa_node)=20{=0A+=09=09if=20=
(next_numa_node=20!=3D=20CNA_PRIORITY_NODE)=20{=0A+=09=09=09struct=20=
mcs_spinlock=20*nnext=20=3D=20READ_ONCE(next->next);=0A=20=0A-=09/*=0A-=09=
=20*=20We=20return=20LOCAL_WAITER_FOUND=20here=20even=20if=20we=20=
stopped=20the=20scan=20because=0A-=09=20*=20of=20a=20prioritized=20=
waiter.=20That=20waiter=20will=20get=20the=20lock=20next=20even=20if=0A-=09=
=20*=20it=20runs=20on=20a=20different=20NUMA=20node,=20but=20this=20is=20=
what=20we=20wanted=20when=20we=0A-=09=20*=20prioritized=20it.=0A-=09=20=
*/=0A+=09=09=09if=20(nnext)=20{=0A+=09=09=09=09cna_splice_next(node,=20=
next,=20nnext);=0A+=09=09=09=09next=20=3D=20nnext;=0A+=09=09=09}=0A+=09=09=
}=0A+=09=09/*=0A+=09=09=20*=20Inherit=20numa=20node=20id=20of=20primary=20=
queue,=20to=20maintain=20the=0A+=09=09=20*=20preference=20even=20if=20=
the=20next=20waiter=20is=20on=20a=20different=20node.=0A+=09=09=20*/=0A+=09=
=09((struct=20cna_node=20*)next)->numa_node=20=3D=20numa_node;=0A+=09}=0A=
=20=09return=20LOCAL_WAITER_FOUND;=0A=20}=0A=20=0A@@=20-307,7=20+287,7=20=
@@=20static=20__always_inline=20u32=20cna_wait_head_or_lock(struct=20=
qspinlock=20*lock,=0A=20=09=09=20*=20Try=20and=20put=20the=20time=20=
otherwise=20spent=20spin=20waiting=20on=0A=20=09=09=20*=20=
_Q_LOCKED_PENDING_MASK=20to=20use=20by=20sorting=20our=20lists.=0A=20=09=09=
=20*/=0A-=09=09cn->partial_order=20=3D=20cna_order_queue(node,=20node);=0A=
+=09=09cn->partial_order=20=3D=20cna_order_queue(node);=0A=20=09}=20else=20=
{=0A=20=09=09cn->partial_order=20=3D=20FLUSH_SECONDARY_QUEUE;=0A=20=09}=0A=
@@=20-323,18=20+303,23=20@@=20static=20inline=20void=20=
cna_lock_handoff(struct=20mcs_spinlock=20*node,=0A=20=09u32=20=
partial_order=20=3D=20cn->partial_order;=0A=20=0A=20=09/*=0A-=09=20*=20=
check=20if=20a=20successor=20from=20the=20same=20numa=20node=20has=20not=20=
been=20found=20in=0A-=09=20*=20pre-scan,=20and=20if=20so,=20try=20to=20=
find=20it=20in=20post-scan=20starting=20from=20the=0A-=09=20*=20node=20=
where=20pre-scan=20stopped=20(stored=20in=20@pre_scan_result)=0A+=09=20*=20=
Check=20if=20a=20successor=20from=20the=20same=20numa=20node=20has=20not=20=
been=20found=20in=0A+=09=20*=20pre-scan,=20and=20if=20so,=20try=20to=20=
find=20it=20in=20post-scan.=0A=20=09=20*/=0A-=09if=20(partial_order=20>=3D=
=20MIN_ENCODED_TAIL)=0A-=09=09partial_order=20=3D=0A-=09=09=09=
cna_order_queue(node,=20decode_tail(partial_order));=0A+=09if=20=
(partial_order=20=3D=3D=20LOCAL_WAITER_NOT_FOUND)=0A+=09=09partial_order=20=
=3D=20cna_order_queue(node);=0A+=0A+=09/*=0A+=09=20*=20We=20have=20a=20=
successor=20in=20the=20main=20queue=20('next'),=20so=0A+=09=20*=20if=20=
we=20call=20cna_order_queue()=20above,=20we=20will=20find=0A+=09=20*=20a=20=
local=20waiter,=20either=20real=20or=20faked=20one.=0A+=09=20*/=0A+=09=
WARN_ON(partial_order=20=3D=3D=20LOCAL_WAITER_NOT_FOUND);=0A=20=0A=20=09=
if=20(partial_order=20=3D=3D=20LOCAL_WAITER_FOUND)=20{=0A=20=09=09/*=0A-=09=
=09=20*=20We=20found=20a=20local=20waiter;=20reload=20@next=20in=20case=20=
we=20called=0A-=09=09=20*=20cna_order_queue()=20above.=0A+=09=09=20*=20=
We=20found=20a=20local=20waiter;=20reload=20@next=20in=20case=20it=0A+=09=
=09=20*=20was=20changed=20by=20cna_order_queue().=0A=20=09=09=20*/=0A=20=09=
=09next=20=3D=20node->next;=0A=20=09=09if=20(node->locked=20>=201)=20{=0A=
@@=20-342,7=20+327,13=20@@=20static=20inline=20void=20=
cna_lock_handoff(struct=20mcs_spinlock=20*node,=0A=20=09=09=09((struct=20=
cna_node=20*)next)->intra_count=20=3D=0A=20=09=09=09=09cn->intra_count=20=
+=201;=0A=20=09=09}=0A-=09}=20else=20if=20(node->locked=20>=201)=20{=0A+=09=
}=20else=20{=0A+=09=09WARN_ON(partial_order=20!=3D=20=
FLUSH_SECONDARY_QUEUE);=0A+=09=09/*=0A+=09=09=20*=20We=20decided=20to=20=
flush=20the=20secondary=20queue;=0A+=09=09=20*=20this=20can=20only=20=
happen=20if=20that=20queue=20is=20not=20empty.=0A+=09=09=20*/=0A+=09=09=
WARN_ON(node->locked=20<=3D=201);=0A=20=09=09/*=0A=20=09=09=20*=20When=20=
there=20are=20no=20local=20waiters=20on=20the=20primary=20queue,=20=
splice=0A=20=09=09=20*=20the=20secondary=20queue=20onto=20the=20primary=20=
queue=20and=20pass=20the=20lock=0A--=20=0A2.21.1=20(Apple=20Git-122.3)=0A=
=0A=

--Apple-Mail=_DBB9AD1D-9F49-43E3-9D5A-72FD3E01F661
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> 
> Cheers,
> Longman
> 
> 
> <0008-locking-qspinlock-Limit-CNA-node-scan-after-the-lock.patch>


--Apple-Mail=_DBB9AD1D-9F49-43E3-9D5A-72FD3E01F661--
