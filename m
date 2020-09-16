Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196E426BA8F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPDNM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 23:13:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgIPDNL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 23:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600225989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zzn+D/zO+vxG92X/ztZuyi5D19ExpWVl0Ma3JmS6+Y=;
        b=iBA+DFbAp/Q/QEnUyrgKUu80RFng5HTXMNcxFCQlsn9cJ4w8mnREDYEcLlQW9W+9mt7AWn
        AL3vfpoA5KrSXwaY7cWkfzvvkVsaRbLtFRD9yo4EJiQlYVj04yGEkGtY3tuNpf9CFLOQ/L
        XdmG+j9I+zOSDXnaVdevzSNEUISzNZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-TmN-0tXWMUOJ4U1Pfi9p-w-1; Tue, 15 Sep 2020 23:13:05 -0400
X-MC-Unique: TmN-0tXWMUOJ4U1Pfi9p-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8C71021D27;
        Wed, 16 Sep 2020 03:13:03 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-115.rdu2.redhat.com [10.10.113.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D48519C71;
        Wed, 16 Sep 2020 03:13:00 +0000 (UTC)
Subject: Re: [PATCH v11 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200915180535.2975060-1-alex.kogan@oracle.com>
 <20200915180535.2975060-5-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <424bb6c1-aef8-e81f-49bc-6710b245d633@redhat.com>
Date:   Tue, 15 Sep 2020 23:13:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200915180535.2975060-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/15/20 2:05 PM, Alex Kogan wrote:
> Keep track of the time the thread at the head of the secondary queue
> has been waiting, and force inter-node handoff once this time passes
> a preset threshold. The default value for the threshold (10ms) can be
> overridden with the new kernel boot command-line option
> "numa_spinlock_threshold". The ms value is translated internally to the
> nearest rounded-up jiffies.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  9 ++
>   kernel/locking/qspinlock_cna.h                | 95 ++++++++++++++++---
>   2 files changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 51ce050f8701..73ab23a47b97 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3363,6 +3363,15 @@
>   			Not specifying this option is equivalent to
>   			numa_spinlock=auto.
>   
> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
> +			Set the time threshold in milliseconds for the
> +			number of intra-node lock hand-offs before the
> +			NUMA-aware spinlock is forced to be passed to
> +			a thread on another NUMA node.	Valid values
> +			are in the [1..100] range. Smaller values result
> +			in a more fair, but less performant spinlock,
> +			and vice versa. The default value is 10.
> +
>   	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>   			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>   			Some features depend on CPU0. Known dependencies are:
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index 590402ad69ef..d3e27549c769 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -37,6 +37,12 @@
>    * gradually filter the primary queue, leaving only waiters running on the same
>    * preferred NUMA node.
>    *
> + * We change the NUMA node preference after a waiter at the head of the
> + * secondary queue spins for a certain amount of time (10ms, by default).
> + * We do that by flushing the secondary queue into the head of the primary queue,
> + * effectively changing the preference to the NUMA node of the waiter at the head
> + * of the secondary queue at the time of the flush.
> + *
>    * For more details, see https://arxiv.org/abs/1810.05600.
>    *
>    * Authors: Alex Kogan <alex.kogan@oracle.com>
> @@ -49,13 +55,33 @@ struct cna_node {
>   	u16			real_numa_node;
>   	u32			encoded_tail;	/* self */
>   	u32			partial_order;	/* enum val */
> +	s32			start_time;
>   };
>   
>   enum {
>   	LOCAL_WAITER_FOUND,
>   	LOCAL_WAITER_NOT_FOUND,
> +	FLUSH_SECONDARY_QUEUE
>   };
>   
> +/*
> + * Controls the threshold time in ms (default = 10) for intra-node lock
> + * hand-offs before the NUMA-aware variant of spinlock is forced to be
> + * passed to a thread on another NUMA node. The default setting can be
> + * changed with the "numa_spinlock_threshold" boot option.
> + */
> +#define MSECS_TO_JIFFIES(m)	\
> +	(((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ))
> +static int intra_node_handoff_threshold __ro_after_init = MSECS_TO_JIFFIES(10);
> +
> +static inline bool intra_node_threshold_reached(struct cna_node *cn)
> +{
> +	s32 current_time = (s32)jiffies;
> +	s32 threshold = cn->start_time + intra_node_handoff_threshold;
> +
> +	return current_time - threshold > 0;
> +}
> +
>   static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>   {
>   	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -98,6 +124,7 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node)
>   	struct cna_node *cn = (struct cna_node *)node;
>   
>   	cn->numa_node = cn->real_numa_node;
> +	cn->start_time = 0;
>   }
>   
>   /*
> @@ -197,8 +224,15 @@ static void cna_splice_next(struct mcs_spinlock *node,
>   
>   	/* stick `next` on the secondary queue tail */
>   	if (node->locked <= 1) { /* if secondary queue is empty */
> +		struct cna_node *cn = (struct cna_node *)node;
> +
>   		/* create secondary queue */
>   		next->next = next;
> +
> +		cn->start_time = (s32)jiffies;
> +		/* make sure start_time != 0 iff secondary queue is not empty */
> +		if (!cn->start_time)
> +			cn->start_time = 1;

My version of the patch set the end_time while yours set the start_time. 
The differences are

1) When the node time is 0, yours will reduce the jiffies count by 1. My 
version will increase it by 1.
2) The intra_node_handoff_threshold is accessed here in my version when 
setting the end time while yours will access it in 
intra_node_threshold_reached().

It is largely a matter of preference, but I am just curious about what 
you think about the advantage of doing it this way.

Cheers,
Longman

