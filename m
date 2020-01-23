Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E18147229
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWTzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 14:55:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgAWTzg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 14:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579809334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TC1aPguYbO4LyZ/z5OOvapVO0qs9innz+fiEUFsArMw=;
        b=KhA1MIMDf/Bg8zPqUZD5sgKrk6YdZA1l0KLQ3+rVBmELqbCSjMWMcx9DEKkd4MEUH9nd44
        EtCtPKGypPJGmK2DCl7C6wWMHVy8E/on1JjD/Byyuyc6gN/PISG7CrX4rMHzCQOV+Ymypn
        GgwcpO9k0A9FHpW030HXfF8PaRZNWfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-_Xk029daMc20sZmGUDfqxQ-1; Thu, 23 Jan 2020 14:55:30 -0500
X-MC-Unique: _Xk029daMc20sZmGUDfqxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D09FF107ACC5;
        Thu, 23 Jan 2020 19:55:26 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69F51001901;
        Thu, 23 Jan 2020 19:55:24 +0000 (UTC)
Subject: Re: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-5-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
Date:   Thu, 23 Jan 2020 14:55:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115035920.54451-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/14/20 10:59 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++
>  kernel/locking/qspinlock.c                    |  3 ++
>  kernel/locking/qspinlock_cna.h                | 41 ++++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> index b68cb80e477f..30d79819a3b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3200,6 +3200,14 @@
>  			Not specifying this option is equivalent to
>  			numa_spinlock=3Dauto.
> =20
> +	numa_spinlock_threshold=3D	[NUMA, PV_OPS]
> +			Set the threshold for the number of intra-node
> +			lock hand-offs before the NUMA-aware spinlock
> +			is forced to be passed to a thread on another NUMA node.
> +			Valid values are in the [0..31] range. Smaller values
> +			result in a more fair, but less performant spinlock, and
> +			vice versa. The default value is 16.
> +
>  	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>  			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>  			Some features depend on CPU0. Known dependencies are:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 609980a53841..e382d8946ccc 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -597,6 +597,9 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
>  #if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPIN=
LOCKS)
>  #define _GEN_CNA_LOCK_SLOWPATH
> =20
> +#undef pv_init_node
> +#define pv_init_node			cna_init_node
> +
>  #undef pv_wait_head_or_lock
>  #define pv_wait_head_or_lock		cna_pre_scan
> =20
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_=
cna.h
> index 8000231f3d51..a2b65f87e6f8 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -51,13 +51,25 @@ struct cna_node {
>  	int			numa_node;
>  	u32			encoded_tail;
>  	u32			pre_scan_result; /* encoded tail or enum val */
> +	u32			intra_count;
>  };
> =20
>  enum {
>  	LOCAL_WAITER_FOUND =3D 2,	/* 0 and 1 are reserved for @locked */
> +	FLUSH_SECONDARY_QUEUE =3D 3,
>  	MIN_ENCODED_TAIL
>  };
> =20
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs =
before
> + * the NUMA-aware variant of spinlock is forced to be passed to a thre=
ad on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lo=
ck
> + * that does not have any fairness guarantees. The default setting can
> + * be changed with the "numa_spinlock_threshold" boot option.
> + */
> +unsigned int intra_node_handoff_threshold __ro_after_init =3D 1 << 16;
> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -97,6 +109,11 @@ static int __init cna_init_nodes(void)
>  }
>  early_initcall(cna_init_nodes);
> =20
> +static __always_inline void cna_init_node(struct mcs_spinlock *node)
> +{
> +	((struct cna_node *)node)->intra_count =3D 0;
> +}
> +
>  /* this function is called only when the primary queue is empty */
>  static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val=
,
>  				       struct mcs_spinlock *node)
> @@ -232,7 +249,9 @@ __always_inline u32 cna_pre_scan(struct qspinlock *=
lock,
>  {
>  	struct cna_node *cn =3D (struct cna_node *)node;
> =20
> -	cn->pre_scan_result =3D cna_scan_main_queue(node, node);
> +	cn->pre_scan_result =3D
> +		cn->intra_count =3D=3D intra_node_handoff_threshold ?
> +			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);
> =20
>  	return 0;
>  }
> @@ -262,6 +281,9 @@ static inline void cna_pass_lock(struct mcs_spinloc=
k *node,
>  		 * if we acquired the MCS lock when its queue was empty
>  		 */
>  		val =3D node->locked ? node->locked : 1;
> +		/* inc @intra_count if the secondary queue is not empty */
> +		((struct cna_node *)next_holder)->intra_count =3D
> +			cn->intra_count + (node->locked > 1);

Playing with lock event counts, I would like you to change the meaning
intra_count parameter that you are tracking. Instead of tracking the
number of times a lock is passed to a waiter of the same node
consecutively, I would like you to track the number of times the head
waiter in the secondary queue has given up its chance to acquire the
lock because a later waiter has jumped the queue and acquire the lock
before it. This value determines the worst case latency that a secondary
queue waiter can experience. So

@@ -332,8 +334,12 @@ static inline void cna_pass_lock(struct
mcs_spinlock *node,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 val =3D node->locked ? node->locked : 1;
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not empty */
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 next_cn->intra_count =3D cn->intra_count + (node->locked > 1=
);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /*
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * inc @intra_count and pass it down if the secondary q=
ueue
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * is not empty
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (node->locked > 1)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_cn->int=
ra_count =3D cn->intra_count + 1;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (node->locked > 1) {=
=C2=A0=C2=A0=C2=A0 /* if secondary queue is not
empty */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* next holder will be the first node in the secondary
queue */

Maybe rename it to jump_count or some other more meaningful name. With
that change, we could probably reduce the default threshold from 64k to
maybe 256 or 512.

I changed the threshold to 256 and run a 96-thread locking stress test
for 10s, the lock event counts:

cna_flush_queue=3D15687
cna_intra_max=3D256
cna_mainscan_hit=3D13
cna_merge_queue=3D15691
cna_prescan_hit=3D4344037
cna_prescan_miss=3D21
cna_splice_new=3D15701
cna_splice_old=3D1289
lock_pending=3D4384
lock_slowpath=3D47998292
lock_use_node2=3D16778

Of the prescan hits, only about 0.4% of that resulted in a queue flush
which I thought is reasonable. I didn't see any noticeable degradation
in the performance of the stress test by reducing the threshold from 64k
to 256.

Cheers,
Longman

