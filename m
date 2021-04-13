Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391135D7B1
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbhDMGDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 02:03:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:33175 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243829AbhDMGDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 02:03:32 -0400
IronPort-SDR: 60st5OJIVbGvXR0TkvkoUJZIai7IN7b3SJv4Go0nvuTHNFv/4JHjC7hGFtaLrOECQWfqRkx2EG
 +qUr+H0m1sXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="193905530"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="193905530"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 23:03:13 -0700
IronPort-SDR: YfsjmzNVqgEX+RdhsWjbLI5ZVirirOpsD1AM61E0QbDtRsiM7gg9190uv5YFGFNZQx9q7f3c/1
 czWhBSzWKi+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="521476626"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 23:03:12 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D856F301AA9; Mon, 12 Apr 2021 23:03:12 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Subject: Re: [PATCH v14 4/6] locking/qspinlock: Introduce starvation avoidance into CNA
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
        <20210401153156.1165900-5-alex.kogan@oracle.com>
Date:   Mon, 12 Apr 2021 23:03:12 -0700
In-Reply-To: <20210401153156.1165900-5-alex.kogan@oracle.com> (Alex Kogan's
        message of "Thu, 1 Apr 2021 11:31:54 -0400")
Message-ID: <87mtu2vhzz.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alex Kogan <alex.kogan@oracle.com> writes:
>  
> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
> +			Set the time threshold in milliseconds for the
> +			number of intra-node lock hand-offs before the
> +			NUMA-aware spinlock is forced to be passed to
> +			a thread on another NUMA node.	Valid values
> +			are in the [1..100] range. Smaller values result
> +			in a more fair, but less performant spinlock,
> +			and vice versa. The default value is 10.

ms granularity seems very coarse grained for this. Surely
at some point of spinning you can afford a ktime_get? But ok.

Could you turn that into a moduleparm which can be changed at runtime?
Would be strange to have to reboot just to play with this parameter

This would also make the code a lot shorter I guess.

-Andi
