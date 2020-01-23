Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D64146AF4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWOQH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 09:16:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgAWOQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 09:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579788965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NlvV8sLBYjX4HhniKYbwd4Qsi6bxUolByF4ash31SU=;
        b=II4+EIztUNhrWqkElEHtpPu09cCvhITB1jFUhrDpBZ2nu81dE+TWa1Jqt11Efzn2+Wv/WA
        wF2WYbssEVakEKRrN3A7+8tT8ZMluRREwNhhWq9d2QkFZHp3kAAN73my1lWGn2ZiGqCzj2
        qoCnKiGy6lDmK7fL24VgcdUtFx0IP7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-U4d8_1qPOfexJ9uhx9dzrw-1; Thu, 23 Jan 2020 09:16:01 -0500
X-MC-Unique: U4d8_1qPOfexJ9uhx9dzrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9557A18C8C0D;
        Thu, 23 Jan 2020 14:15:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AB801CB;
        Thu, 23 Jan 2020 14:15:56 +0000 (UTC)
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
Date:   Thu, 23 Jan 2020 09:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115035920.54451-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/14/20 10:59 PM, Alex Kogan wrote:
> +static int __init cna_init_nodes(void)
> +{
> +	unsigned int cpu;
> +
> +	/*
> +	 * this will break on 32bit architectures, so we restrict
> +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> +	 */
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store an ecoded tail word in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> +
> +	for_each_possible_cpu(cpu)
> +		cna_init_nodes_per_cpu(cpu);
> +
> +	return 0;
> +}
> +early_initcall(cna_init_nodes);
> +

I just realized that you shouldn't call cna_init_nodes as an
early_initcall. Instead,

> +/*
> + * Switch to the NUMA-friendly slow path for spinlocks when we have
> + * multiple NUMA nodes in native environment, unless the user has
> + * overridden this default behavior by setting the numa_spinlock flag.
> + */
> +void __init cna_configure_spin_lock_slowpath(void)
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

call it when it is sure that CNA spinlock is going to be used. At this
point, the system is still in UP mode and the slowpath will not be called.

Cheers,
Longman

