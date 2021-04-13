Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308B535D7CA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbhDMGMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 02:12:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:5006 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhDMGMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 02:12:34 -0400
IronPort-SDR: OUQsGR6tpdzz/5H/mYCGsSJXp7K0u1QY/NsNCtbyYowNNybb3KMZYes/DIX5Tx2X2wPfUf2ykm
 UZz4tO6FJxJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="192215473"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="192215473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 23:12:14 -0700
IronPort-SDR: 8BmBhJK0aFEb0A6dirM7HWR6n/PN+I26Mj1zqT9+2QxNRGj+RRG97Us1wmQJfhse4G4wMbbI5k
 Ju5YeNZe0CTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="450267331"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2021 23:12:13 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D426B301AA9; Mon, 12 Apr 2021 23:12:13 -0700 (PDT)
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
        <87mtu2vhzz.fsf@linux.intel.com>
Date:   Mon, 12 Apr 2021 23:12:13 -0700
In-Reply-To: <87mtu2vhzz.fsf@linux.intel.com> (Andi Kleen's message of "Mon,
        12 Apr 2021 23:03:12 -0700")
Message-ID: <87im4qvhky.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

> Alex Kogan <alex.kogan@oracle.com> writes:
>>  
>> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
>> +			Set the time threshold in milliseconds for the
>> +			number of intra-node lock hand-offs before the
>> +			NUMA-aware spinlock is forced to be passed to
>> +			a thread on another NUMA node.	Valid values
>> +			are in the [1..100] range. Smaller values result
>> +			in a more fair, but less performant spinlock,
>> +			and vice versa. The default value is 10.
>
> ms granularity seems very coarse grained for this. Surely
> at some point of spinning you can afford a ktime_get? But ok.

Actually thinking about it more using jiffies is likely broken
anyways because if the interrupts are disabled and the CPU
is running the main timer interrupts they won't increase.

cpu_clock (better than ktime_get) or sched_clock would work.

-Andi
