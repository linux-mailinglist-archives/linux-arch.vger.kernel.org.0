Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6680D12FEA2
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2020 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgACWPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jan 2020 17:15:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgACWPH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jan 2020 17:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578089705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPZhm/vIH+Q7uLs6GXhd/00uE+wGFl4irig6QN7h72k=;
        b=FS57Po99cy6AsSUUfpATjD35bypbrGEvXzPYNkgA1TiYTEvJMkYA8oZ79TM5OhfWJlrLq4
        1R4nyF9YJHqonWEaAwRLwvQayx5RbqtMZt9O34bFh//azD1hNcxaAJvBNdQzq1/tFHgkfx
        1b/aLxi4XHejxOONfRWByuAAYK5il2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-s8l_3ktoP7i4XmtoQVfOvg-1; Fri, 03 Jan 2020 17:15:01 -0500
X-MC-Unique: s8l_3ktoP7i4XmtoQVfOvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 322CD1801266;
        Fri,  3 Jan 2020 22:14:59 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-142.rdu2.redhat.com [10.10.122.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43F1F84673;
        Fri,  3 Jan 2020 22:14:56 +0000 (UTC)
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fcba7eee-b98f-5381-ea33-6fd94a9e66a6@redhat.com>
Date:   Fri, 3 Jan 2020 17:14:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191230194042.67789-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/30/19 2:40 PM, Alex Kogan wrote:
> +/*
> + * cna_scan_main_queue - scan the main waiting queue looking for the first
> + * thread running on the same NUMA node as the lock holder. If found (call it
> + * thread T), move all threads in the main queue between the lock holder and
> + * T to the end of the secondary queue and return 0
> + * (=SUCCESSOR_FROM_SAME_NUMA_NODE_FOUND); otherwise, return the encoded
Are you talking about LOCAL_WAITER_FOUND?
> + * pointer of the last scanned node in the primary queue (so a subsequent scan
> + * can be resumed from that node).
> + *
> + * Schematically, this may look like the following (nn stands for numa_node and
> + * et stands for encoded_tail).
> + *
> + *   when cna_scan_main_queue() is called (the secondary queue is empty):
> + *
> + *  A+------------+   B+--------+   C+--------+   T+--------+
> + *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
> + *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
> + *   |cna:nn=1    |    +--------+    +--------+    +--------+
> + *   +----------- +
> + *
> + *   when cna_scan_main_queue() returns (the secondary queue contains B and C):
> + *
> + *  A+----------------+    T+--------+
> + *   |mcs:next        | ->  |mcs:next| -> NULL
> + *   |mcs:locked=C.et | -+  |cna:nn=1|
> + *   |cna:nn=1        |  |  +--------+
> + *   +--------------- +  +-----+
> + *                             \/
> + *          B+--------+   C+--------+
> + *           |mcs:next| -> |mcs:next| -+
> + *           |cna:nn=0|    |cna:nn=2|  |
> + *           +--------+    +--------+  |
> + *               ^                     |
> + *               +---------------------+
> + *
> + * The worst case complexity of the scan is O(n), where n is the number
> + * of current waiters. However, the amortized complexity is close to O(1),
> + * as the immediate successor is likely to be running on the same node once
> + * threads from other nodes are moved to the secondary queue.
> + *
> + * @node      : Pointer to the MCS node of the lock holder
> + * @pred_start: Pointer to the MCS node of the waiter whose successor should be
> + *              the first node in the scan
> + * Return     : LOCAL_WAITER_FOUND or encoded tail of the last scanned waiter
> + */
> +static u32 cna_scan_main_queue(struct mcs_spinlock *node,
> +			       struct mcs_spinlock *pred_start)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +	struct cna_node *cni = (struct cna_node *)READ_ONCE(pred_start->next);
> +	struct cna_node *last;
> +	int my_numa_node = cn->numa_node;
> +
> +	/* find any next waiter on 'our' NUMA node */
> +	for (last = cn;
> +	     cni && cni->numa_node != my_numa_node;
> +	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> +		;
> +
> +	/* if found, splice any skipped waiters onto the secondary queue */
> +	if (cni) {
> +		if (last != cn)	/* did we skip any waiters? */
> +			cna_splice_tail(node, node->next,
> +					(struct mcs_spinlock *)last);
> +		return LOCAL_WAITER_FOUND;
> +	}
> +
> +	return last->encoded_tail;
> +}
> +
>
> +/*
> + * Switch to the NUMA-friendly slow path for spinlocks when we have
> + * multiple NUMA nodes in native environment, unless the user has
> + * overridden this default behavior by setting the numa_spinlock flag.
> + */
> +void cna_configure_spin_lock_slowpath(void)
Nit: There should be a __init.
> +{
> +	if ((numa_spinlock_flag == 1) ||
> +	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
> +		    pv_ops.lock.queued_spin_lock_slowpath ==
> +			native_queued_spin_lock_slowpath)) {
> +		pv_ops.lock.queued_spin_lock_slowpath =
> +		    __cna_queued_spin_lock_slowpath;
> +
> +		pr_info("Enabling CNA spinlock\n");
> +	}
> +}

Other than these two minor nits, the rests looks good to me.

Cheers,
Longman

