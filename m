Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919F51314DB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFPdi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jan 2020 10:33:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgAFPdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 10:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578324816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMyCQTp0fB4Db18PuYA/44oZs6gxi7/BoRwlS9h67Ow=;
        b=iTudxLPJifjMuy9Qprah7FZYcuulXAKgX+UEyW7w1Wt7HId1lMbT65E4H4DMjiAKy8/8Pg
        3WHbXy2tmLXG326EmMYzcO5QugFdW9/Z7vOPHXzt/1fb+lbg+zKGlPYLs4bQsAQhta9Yj3
        Vd4agzLavFsa0r+4+r+QgHrdqgBk8og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Zo8vYXixMtWEGYG8rFdCOw-1; Mon, 06 Jan 2020 10:33:33 -0500
X-MC-Unique: Zo8vYXixMtWEGYG8rFdCOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021331005502;
        Mon,  6 Jan 2020 15:33:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B852108131B;
        Mon,  6 Jan 2020 15:33:27 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <53b08fc3-f29f-65ec-f2e9-0f469cd79744@redhat.com>
Date:   Mon, 6 Jan 2020 10:33:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191230194042.67789-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/30/19 2:40 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++
>  kernel/locking/qspinlock.c                    |  3 ++
>  kernel/locking/qspinlock_cna.h                | 41 ++++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b68cb80e477f..30d79819a3b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3200,6 +3200,14 @@
>  			Not specifying this option is equivalent to
>  			numa_spinlock=auto.
>  
> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
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
>  #if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>  #define _GEN_CNA_LOCK_SLOWPATH
>  
> +#undef pv_init_node
> +#define pv_init_node			cna_init_node
> +
>  #undef pv_wait_head_or_lock
>  #define pv_wait_head_or_lock		cna_pre_scan
>  
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index 3c99a4a6184b..30feff02865d 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -51,13 +51,25 @@ struct cna_node {
>  	int			numa_node;
>  	u32			encoded_tail;
>  	u32			pre_scan_result; /* encoded tail or enum val */
> +	u32			intra_count;
>  };
>  
>  enum {
>  	LOCAL_WAITER_FOUND = 2,	/* 0 and 1 are reserved for @locked */
> +	FLUSH_SECONDARY_QUEUE = 3,
>  	MIN_ENCODED_TAIL
>  };
>  
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs before
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees. The default setting can
> + * be changed with the "numa_spinlock_threshold" boot option.
> + */
> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;

Another minor nit. (1 << 31) is negative for an int value. I will
suggest that you either make intra_node_handoff_threshold an unsigned
int or limit the upper bound to 30.

Cheers,
Longman


