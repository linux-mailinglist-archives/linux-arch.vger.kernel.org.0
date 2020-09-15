Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6626AD79
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 21:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgIOTYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgIOTYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 15:24:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62FC06178A;
        Tue, 15 Sep 2020 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=V+4IkKNpJfe7Iudt9BhXz9NYz+CKaO32K4RDpUC5uiY=; b=bYn0ZXkls+FF4erz0dicshnWJN
        ZjBlmjvXNtOq1Gp2592t28LNepFk4VvHrMRmxGz9QN1RAZPAxnoaVGaqUKrctSedmclLtQIAi1fj7
        Xn0KKiYnGZGWPAo99gdMWFaWMzP6/hNzMCUnczx8sryfNQUm5SIuK5DKbVDA4n0jtQO7oR8Lk2dyo
        9R5kve+M+hco+uLo7BVHuTJQuthYcncHtx06xWiRkrM7MrAE0LW/VHc6VaEbQLpWz02649Os5l/aI
        oI7yGL4tTxN/CenXjnl1ljUS+syxwfyKTkE0TQE9s8Dr5JR9PqhkA/HgkSRLUYBrlxuZ/b+7ZP7Jk
        qKrONyIA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIGZ8-0007KI-88; Tue, 15 Sep 2020 19:24:34 +0000
Subject: Re: [PATCH v11 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200915180535.2975060-1-alex.kogan@oracle.com>
 <20200915180535.2975060-5-alex.kogan@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8019917d-5e8e-e03d-583c-6809dee7a5c2@infradead.org>
Date:   Tue, 15 Sep 2020 12:24:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915180535.2975060-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Entries in the kernel-parameters.txt file should be kept in alphabetical order
mostly (there are a few exceptions where related options are kept together).



On 9/15/20 11:05 AM, Alex Kogan wrote:
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
>  .../admin-guide/kernel-parameters.txt         |  9 ++
>  kernel/locking/qspinlock_cna.h                | 95 ++++++++++++++++---
>  2 files changed, 92 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 51ce050f8701..73ab23a47b97 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3363,6 +3363,15 @@
>  			Not specifying this option is equivalent to
>  			numa_spinlock=auto.
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
>  	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>  			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>  			Some features depend on CPU0. Known dependencies are:


This new entry and numa_spinlock from patch 3/5 should go between these other 2 NUMA entries:

	numa_balancing=	[KNL,X86] Enable or disable automatic NUMA balancing.
			Allowed values are enable and disable

	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
			'node', 'default' can be specified
			This can be set from sysctl after boot.
			See Documentation/admin-guide/sysctl/vm.rst for details.


Oooh, that cpu0_hotplug entry is way out of place.  I'll send a patch for that.


thanks.
-- 
~Randy

