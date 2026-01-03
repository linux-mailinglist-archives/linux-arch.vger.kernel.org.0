Return-Path: <linux-arch+bounces-15638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646FCEFBCD
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED437300EA39
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B123A9AD;
	Sat,  3 Jan 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrbvOruB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7221ABAC
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767422216; cv=none; b=lC2Ywoa8ZQNApMfbMY7Sa7aoJzJWAuj29DBLLhGjl272c2OXmoUJfA+VAqWOKDddOt3Ja8YD4LT63XP+HHlS9GW7RiLtPJCu0yZ25L1U6MMAvr+n7/cnQinWIO0tsYh/9w69vK7EWyjWY/FDvFvIrb5XxgtcP/BONx/fovoauO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767422216; c=relaxed/simple;
	bh=GcSJTsIdgVF1gHPqEGPZ9hEjZebFvNeOtsDBF78oZCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcYIEVInYXomZFMR2aacHyhjrUs6J3nONz6NSoGc10v568dK5KkjY+MRxCuyf8p1/hax0reUYVrvOPVtLlBYzOJmp6kOKZ/s5LfM7lmeoo7WAeZvLVPb0wjS9k73mRpC4KNvKx/GSmPIrkuXt9DqNivyr+ils+bPlWRpKA5K4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrbvOruB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so12712783b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Jan 2026 22:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767422213; x=1768027013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n009qAjQa1f/gx1JlFPWaK6vp1HVpsaalQe/6LgsF9o=;
        b=JrbvOruBrh8lmpIc7RX7dnszwqV0ZJvn2pS9G1dhEGqecM0sSS3ZzGk6+hKHsts9eB
         C+xP39BkTmzg9evARoi3qoeyq8kZMHZqd11kFj5vYzUOT0YJlcQikJy2h7RKXFZNKe3T
         YA4iYlXRVO/irzy+dZLvgkPjRdXcBD3JIEuQylFoThLU8A12V6+ye6KnIIi1SNK9/Byp
         J7VpDq0SiCBMqmX/Lf2+mbyUNhsDSVuZ6CZxv6A9v1EHFBfLjQ/ucuQHQAJP520mcf/3
         PT2WniBjQ4BN4bXjevPkvTcKpkcc0kRPT/749qf5ZqeYp4MwFJGf0D6Uqv1P6oFi6lTM
         41CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767422213; x=1768027013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n009qAjQa1f/gx1JlFPWaK6vp1HVpsaalQe/6LgsF9o=;
        b=byxSxz6DE7LTSkzvEuARodaBSboQA2L297MEHG0KB5t8KUihGzxmHhxbIwISK5Gqwg
         Y1ONEFjDUQDlJc+Peco9uziaNCPVdzaEOfNfxy2V1wAzhFVGu4kwkSzvDH6eJ69hta7J
         l800HlJCGfORGvCFb0sLj0cMkkNNxof1rQokGmPXP/PI23drMQO3l/RKVAwHtZkNAjZI
         ntDpU9eh2fvGned5x2HJMJNtcMugHZfdOMndw1qJJ1zvjdQTqPEvc++r0PsZvkJZ8Bwo
         +uKkvGvqZBbJqiR6XCPJDXkPLy2aZMpAkw9DriNoJY3HaY71C7VcHR+zqQ6lhK0Hjb2w
         v7gg==
X-Forwarded-Encrypted: i=1; AJvYcCUNaGxjYYlwesh5yqJgKWTwvF0EXD/41LZGpia4BdS39QDXEytSePrzyx/QHk2BhU+BzSpdlKmkeVZH@vger.kernel.org
X-Gm-Message-State: AOJu0YzKG8VPmUuXo5DoP8n35rpuYvonC/ktaUktq13PTvf5U29WQVVG
	czB6pXdWr8Pm1zurWCVeqDlYEv7zpIqigjcGXuhC0zwMm0GiFknEro+zT5F9pHKgsLs=
X-Gm-Gg: AY/fxX48gEJK1j7TG2RDcju66Q5TtKFhmzSzGRkzXXO9T7YmuBIlKWzuACgYavrCIjw
	uUfNukXhEQniOFH6F3D12sgdaDmhcitE3mkep6l2H+gpFPDS7LM+2Rrw9NP1CU7rQPzUJ5Djngp
	YMet3/gqeuS4GZUyQU7AbeWFevJAdN23SbTDmL4RkFdPfROPrWkN9UYb0686A2WRdGiVzb302lE
	dmc43sDrwsfAWBXyuOOomcWpBhSPiIkHx0+lat02KYDFpZENtuSP7vsF/zwbYVN18umJdkgIpT3
	7fhd/+6hrGeFNWaEyKKttBNX/6qTw7TFesmPnZZKy/KEzSEXTnk9oGb572yYkOUIUYaa7lvSwm3
	oW2UuoFn2rUQv/9eASLxIkk362U0zX0qtMFRPIuloS1jDSwCNYpmOJXwZuUrB+tR/3DqjFusiQF
	KyDm7TBx3Gj0ItZuaVWhC7tK3K6aCGOfzG0Z5WlZFVBc+RJefcZIuq1ACyfouDhjZW
X-Google-Smtp-Source: AGHT+IFjVDKmB/xNuLtQKRYfU/ITUXwxCDRtTDnOfIZDb5jRoUr7iNoQ0th445p4ZZcSbNCPgjHtMA==
X-Received: by 2002:a05:6a00:140f:b0:807:c2b9:38ec with SMTP id d2e1a72fcca58-807c2b93f63mr22110230b3a.15.1767422213430;
        Fri, 02 Jan 2026 22:36:53 -0800 (PST)
Received: from ?IPV6:2405:6e00:642:d187:9f0f:f4ff:8fd1:e7bf? ([2405:6e00:642:d187:9f0f:f4ff:8fd1:e7bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a2e3esm41753812b3a.37.2026.01.02.22.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 22:36:52 -0800 (PST)
Message-ID: <4b8953ac-567b-4d68-9c25-72a69afdf1b3@linaro.org>
Date: Sat, 3 Jan 2026 08:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-19-eugen.hristev@linaro.org>
 <aVImIneFgOngYdSn@kernel.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <aVImIneFgOngYdSn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/29/25 08:56, Mike Rapoport wrote:
> Hi Eugen,
> 
> On Wed, Nov 19, 2025 at 05:44:19PM +0200, Eugen Hristev wrote:
>> This memblock flag indicates that a specific block is registered
>> into an inspection table.
>> The block can be marked for inspection using memblock_mark_inspect()
>> and cleared with memblock_clear_inspect()
> 
> Can you explain why memblock should treat memory registered for inspection
> differently?

It should not, at a first glance.

The purpose of the flag is to let memblock be aware of it.
The flag is there to have a "memblock way" of registering the memory,
which inside memblock , it can translate to a meminspect way of
registering the memory. It's just an extra layer on top of meminspect.
With this, it would be avoided to call meminspect all over the places it
would be required, but rather use the memblock API.
And further, inside memblock, it would be a single point where
meminspect can be disabled (while preserving a no-op memblock flag), or
easily changed to another API if needed.
Ofcourse, one can call here directly the meminspect API if this is desired.
Do you think it would be better to have it this way ?

Thanks for looking into it,
Eugen


> 
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>  include/linux/memblock.h |  7 +++++++
>>  mm/memblock.c            | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 221118b5a16e..c3e55a4475cf 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -51,6 +51,10 @@ extern unsigned long long max_possible_pfn;
>>   * memory reservations yet, so we get scratch memory from the previous
>>   * kernel that we know is good to use. It is the only memory that
>>   * allocations may happen from in this phase.
>> + * @MEMBLOCK_INSPECT: memory region is annotated in kernel memory inspection
>> + * table. This means a dedicated entry will be created for this region which
>> + * will contain the memory's address and size. This allows kernel inspectors
>> + * to retrieve the memory.
>>   */
>>  enum memblock_flags {
>>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
>> @@ -61,6 +65,7 @@ enum memblock_flags {
>>  	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
>> +	MEMBLOCK_INSPECT	= 0x80,	/* memory selected for kernel inspection */
>>  };
>>  
>>  /**
>> @@ -149,6 +154,8 @@ unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
>>  bool memblock_overlaps_region(struct memblock_type *type,
>>  			      phys_addr_t base, phys_addr_t size);
>>  bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
>> +int memblock_mark_inspect(phys_addr_t base, phys_addr_t size);
>> +int memblock_clear_inspect(phys_addr_t base, phys_addr_t size);
>>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e23e16618e9b..a5df5ab286e5 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/memblock.h>
>>  #include <linux/mutex.h>
>> +#include <linux/meminspect.h>
>>  
>>  #ifdef CONFIG_KEXEC_HANDOVER
>>  #include <linux/libfdt.h>
>> @@ -1016,6 +1017,40 @@ static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
>>  	return 0;
>>  }
>>  
>> +/**
>> + * memblock_mark_inspect - Mark inspectable memory with flag MEMBLOCK_INSPECT.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_mark_inspect(phys_addr_t base, phys_addr_t size)
>> +{
>> +	int ret;
>> +
>> +	ret = memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_INSPECT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	meminspect_lock_register_pa(base, size);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * memblock_clear_inspect - Clear flag MEMBLOCK_INSPECT for a specified region.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_clear_inspect(phys_addr_t base, phys_addr_t size)
>> +{
>> +	meminspect_lock_unregister_pa(base, size);
>> +
>> +	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_INSPECT);
>> +}
>> +
>>  /**
>>   * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
>>   * @base: the base phys addr of the region
>> @@ -2704,6 +2739,7 @@ static const char * const flagname[] = {
>>  	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>> +	[ilog2(MEMBLOCK_INSPECT)] = "INSPECT",
>>  };
>>  
>>  static int memblock_debug_show(struct seq_file *m, void *private)
>> -- 
>> 2.43.0
>>
> 


