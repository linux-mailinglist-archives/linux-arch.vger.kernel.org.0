Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC9415074
	for <lists+linux-arch@lfdr.de>; Wed, 22 Sep 2021 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhIVT1V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Sep 2021 15:27:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhIVT1V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Sep 2021 15:27:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F6E11FF74;
        Wed, 22 Sep 2021 19:25:49 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10C8813D96;
        Wed, 22 Sep 2021 19:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X9AfNDeDS2GScAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 22 Sep 2021 19:25:43 +0000
Date:   Wed, 22 Sep 2021 12:25:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20210922192528.ob22pu54oeqsoeno@offworld>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210514200743.3026725-4-alex.kogan@oracle.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 May 2021, Alex Kogan wrote:

>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index a816935d23d4..94d35507560c 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -3515,6 +3515,16 @@
> 			NUMA balancing.
> 			Allowed values are enable and disable
>
>+	numa_spinlock=	[NUMA, PV_OPS] Select the NUMA-aware variant
>+			of spinlock. The options are:
>+			auto - Enable this variant if running on a multi-node
>+			machine in native environment.
>+			on  - Unconditionally enable this variant.

Is there any reason why the user would explicitly pass the on option
when the auto thing already does the multi-node check? Perhaps strange
numa topologies? Otherwise I would say it's not needed and the fewer
options we give the user for low level locking the better.

>+			off - Unconditionally disable this variant.
>+
>+			Not specifying this option is equivalent to
>+			numa_spinlock=auto.
>+
> 	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
> 			'node', 'default' can be specified
> 			This can be set from sysctl after boot.
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 0045e1b44190..819c3dad8afc 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1564,6 +1564,26 @@ config NUMA
>
> 	  Otherwise, you should say N.
>
>+config NUMA_AWARE_SPINLOCKS
>+	bool "Numa-aware spinlocks"
>+	depends on NUMA
>+	depends on QUEUED_SPINLOCKS
>+	depends on 64BIT
>+	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching work.
>+	# This is awkward, but hopefully would be resolved once static_call()
>+	# is available.
>+	depends on PARAVIRT_SPINLOCKS

We now have static_call() - see 9183c3f9ed7.


>+	default y
>+	help
>+	  Introduce NUMA (Non Uniform Memory Access) awareness into
>+	  the slow path of spinlocks.
>+
>+	  In this variant of qspinlock, the kernel will try to keep the lock
>+	  on the same node, thus reducing the number of remote cache misses,
>+	  while trading some of the short term fairness for better performance.
>+
>+	  Say N if you want absolute first come first serve fairness.

This would also need a depends on !PREEMPT_RT, no? Raw spinlocks really want
the determinism.

Thanks,
Davidlohr
