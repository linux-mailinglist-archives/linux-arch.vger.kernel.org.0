Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAA26BA46
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPCk2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 22:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbgIPCkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 22:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600224021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASyeTVwuUEeU8l0NdXBbwtEToG7x1iFYHSQxl0OiJ2Y=;
        b=Wgr+FMy8V3SlxFb4ssVKhZgVPHaJaXF7PYBy4JLoCP9Fj/S3AujI8+qEIixFzLw1ufOuhz
        QtO+C6BNWbF9YzQX1e0ZcrkJyHh/5veIycTEYQBETqVshYF//zauDh8gu7YLn5mip02m/o
        WgXADXC8CIah4RLgJDla8IUL8wfFkFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-W2XbK7WnMsugWgXerJZpbw-1; Tue, 15 Sep 2020 22:40:17 -0400
X-MC-Unique: W2XbK7WnMsugWgXerJZpbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21313425D1;
        Wed, 16 Sep 2020 02:40:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-115.rdu2.redhat.com [10.10.113.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE4B25FC16;
        Wed, 16 Sep 2020 02:40:11 +0000 (UTC)
Subject: Re: [PATCH v11 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200915180535.2975060-1-alex.kogan@oracle.com>
 <20200915180535.2975060-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <05a65878-d24c-0f8e-c271-24ebc729d7e3@redhat.com>
Date:   Tue, 15 Sep 2020 22:40:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200915180535.2975060-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/15/20 2:05 PM, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a primary queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. After acquiring the
> MCS lock and before acquiring the spinlock, the MCS lock
> holder checks whether the next waiter in the primary queue (if exists) is
> running on the same NUMA node. If it is not, that waiter is detached from
> the main queue and moved into the tail of the secondary queue. This way,
> we gradually filter the primary queue, leaving only waiters running on
> the same preferred NUMA node. For more details, see
> https://arxiv.org/abs/1810.05600.
>
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock between waiters in the main queue. This issue will be
> addressed later in the series.
>
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at the
> boot time only if we run on a multi-node machine in native environment and
> the new config is enabled. (For the time being, the patching requires
> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
> resolved once static_call() is available.) This default behavior can be
> overridden with the new kernel boot command-line option
> "numa_spinlock=on/off" (default is "auto").
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  10 +
>   arch/x86/Kconfig                              |  20 ++
>   arch/x86/include/asm/qspinlock.h              |   4 +
>   arch/x86/kernel/alternative.c                 |   4 +
>   kernel/locking/mcs_spinlock.h                 |   2 +-
>   kernel/locking/qspinlock.c                    |  42 ++-
>   kernel/locking/qspinlock_cna.h                | 336 ++++++++++++++++++
>   7 files changed, 413 insertions(+), 5 deletions(-)
>   create mode 100644 kernel/locking/qspinlock_cna.h
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1068742a6df..51ce050f8701 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3353,6 +3353,16 @@
>   
>   	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
>   
> +	numa_spinlock=	[NUMA, PV_OPS] Select the NUMA-aware variant
> +			of spinlock. The options are:
> +			auto - Enable this variant if running on a multi-node
> +			machine in native environment.
> +			on  - Unconditionally enable this variant.
> +			off - Unconditionally disable this variant.
> +
> +			Not specifying this option is equivalent to
> +			numa_spinlock=auto.
> +
>   	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>   			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>   			Some features depend on CPU0. Known dependencies are:

You will have to move down this hunk according to alphabetic order. 
Other than that this patch looks good to me.

Cheers,
Longman

