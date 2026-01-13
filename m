Return-Path: <linux-arch+bounces-15789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370BD1BBB9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 00:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A5843012A86
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 23:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1636B04B;
	Tue, 13 Jan 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FQzahpKa"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397B350A2F;
	Tue, 13 Jan 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347413; cv=none; b=PiwTbjEo/AMfdXlc2W6FT9lNWxOPipXkzRAZGnDQWWG7/FYPVHZAbhgrEdA/PUhCN1sMkwdlp+5xMVkZifHAEczZT/9d8q2oQ6PaGRVSXOXfpJwNcwA7f6eb5pma19jeK0vtBn46oHvmHmwkG1bCLyX33N9caAXz5CBcdyc4EIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347413; c=relaxed/simple;
	bh=nQ1Er+e6wiAGW985FIUiLA7461AK7NqClc19JOQg8mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOCt25ULWuZWQI0LV71ptOghTERSOAauVII6nHDudlRs0yFVpya2wCte5uewIaPu1qvRwvupbq35nYs7PhoaHX6+YmbGeR3/WvGgaCe7jxMDIMEeapDrYcRqWe1oWesrIFmQzUh9RLZZwvbO3Dh/nQwwexjL6GAiVvDMVJ2LFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FQzahpKa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86B8020B7165;
	Tue, 13 Jan 2026 15:36:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86B8020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768347411;
	bh=EgyExoSDN5kPVh+zTwTWyc3xFjQLCGJpKNu/GKPBTTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FQzahpKaWtI21sUUZuniYfTBtjFbdO9s+OD6cdHUuqrorzru+98HIkrfKvlAuf1KP
	 KMqyt1dLzKY3xTbD6J4jljmDU/HWayD4/jg1j7xd6OJ30gvXnlHfZke8wV1XiebexP
	 ItDGE+/Evq3dlSwivHIGW1hVosiDj66fRAR29qnM=
Message-ID: <88b38aff-51b8-57d8-e548-00d42254a541@linux.microsoft.com>
Date: Tue, 13 Jan 2026 15:36:51 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 5/6] x86/hyperv: Implement hypervisor RAM collection
 into vmcore
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251006224208.1060990-6-mrathor@linux.microsoft.com>
 <20260113111412.GAaWYpBFPPLRG-YxNt@fat_crate.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260113111412.GAaWYpBFPPLRG-YxNt@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 03:14, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 03:42:07PM -0700, Mukesh Rathor wrote:
>> Introduce a new file to implement collection of hypervisor RAM into the
>> vmcore collected by linux. By default, the hypervisor RAM is locked, ie,
>> protected via hw page table. Hyper-V implements a disable hypercall which
>> essentially devirtualizes the system on the fly. This mechanism makes the
>> hypervisor RAM accessible to linux. Because the hypervisor RAM is already
>> mapped into linux address space (as reserved RAM), it is automatically
>> collected into the vmcore without extra work. More details of the
>> implementation are available in the file prologue.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_crash.c | 642 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 642 insertions(+)
>>   create mode 100644 arch/x86/hyperv/hv_crash.c
> 
> This breaks randconfig builds here:
> 
> arch/x86/hyperv/hv_crash.c:631:2: error: must use 'struct' tag to refer to type 'smp_ops'
>    631 |         smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
>        |         ^
>        |         struct
> arch/x86/hyperv/hv_crash.c:631:9: error: expected identifier or '('
>    631 |         smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
>        |                ^
> 2 errors generated.
> make[4]: *** [scripts/Makefile.build:287: arch/x86/hyperv/hv_crash.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:544: arch/x86/hyperv] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:544: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/amd/kernel/linux/Makefile:2054: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> config 01-18-21-randconfig-x86_64-13708.cfg attached. Note that this is
> a clang build:
> 
> Ubuntu clang version 18.1.3 (1ubuntu1)
> 
> It fails with gcc too tho:
> 
> arch/x86/hyperv/hv_crash.c: In function ?hv_root_crash_init?:
> arch/x86/hyperv/hv_crash.c:631:9: error: ?smp_ops? undeclared (first use in this function)
>    631 |         smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
>        |         ^~~~~~~
> arch/x86/hyperv/hv_crash.c:631:9: note: each undeclared identifier is reported only once for each function it appears in
> make[4]: *** [scripts/Makefile.build:287: arch/x86/hyperv/hv_crash.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:544: arch/x86/hyperv] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:544: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/amd/kernel/linux/Makefile:2054: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 

Looks like needs some config option around it, probably SMP. Will take
a look in a day or two. Thanks for letting us know.

-Mukesh




