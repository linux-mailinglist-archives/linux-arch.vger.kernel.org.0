Return-Path: <linux-arch+bounces-5597-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2EA93AA86
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39501C22E5E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8318F48;
	Wed, 24 Jul 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dQ7pvkaa"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71584522A
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784036; cv=none; b=RHkiEmlP//oggyknc/rz3vUy2VbkZC/QOjiLRdT9Z9D1hz8zJTW+TTnmfI38mEgUAMfGZXw1/CRh9Wc9ovkKHk54Wf5J27X7geAv61hOXwBoTJYJxlj7OYKYe5pXS2MWIzrADXlduMK2OuKhu0elRfWn4s2l3IVCYZpv/shboKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784036; c=relaxed/simple;
	bh=AC8Bel9UEYnaROjqC9+2e8CVf6gW/SwN5KaatGqwuRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDJ5Gwva4CrfHBOPoUdzg4z39p6Vu7w4Imr7guRW1fKkmUncbkuf39dA05uUABsEq9zhaX8i+ef0AbiNdYWTpMEnY2/+CD3RyO+OL8owdN2LUJiQMtV9qpqCsE9KIS7Wc5k+IB4H0wOiNQ2IP+cOlyY58WFe2vsDNjaYE7Wyo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dQ7pvkaa; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da41a162-9f6d-4607-9055-ffc21fe1771e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721784032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEhyMpF2beLnKk2jNCAd0kL3ECpPY/WBwUXHZaKgEPc=;
	b=dQ7pvkaawQNIB+BCzRzvtJY0Wq6NMR8kNLAXFxl1E0sHcVC61q5kr1NayEOKt2/T4r5rr/
	TUUUJheElULcwdIdWT3AjkAP0Ab7PzaCezqqmnT9Aifbt56O8FoM5KawiUhjGZdR7imDB3
	NOvrBa2TpNxpWQwFSLrlC5J9ef6FHxg=
Date: Wed, 24 Jul 2024 09:20:17 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@mbosol.com>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <4570c972-de09-4818-bd1b-3112f651b49d@mbosol.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <4570c972-de09-4818-bd1b-3112f651b49d@mbosol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Mika

On 23/07/2024 17:58, Mika Penttilä wrote:
> On 7/23/24 11:32, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> In theory init/exit should match their sequence, thus normally they should
>> look like this:
>> -------------------------+------------------------
>>      init_A();            |
>>      init_B();            |
>>      init_C();            |
>>                           |   exit_C();
>>                           |   exit_B();
>>                           |   exit_A();
>>
>> Providing module_subinit{_noexit} and module_subeixt helps macros ensure
>> that modules init/exit match their order, while also simplifying the code.
>>
>> The three macros are defined as follows:
>> - module_subinit(initfn, exitfn,rollback)
>> - module_subinit_noexit(initfn, rollback)
>> - module_subexit(rollback)
>>
>> `initfn` is the initialization function and `exitfn` is the corresponding
>> exit function.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   include/asm-generic/vmlinux.lds.h |  5 +++
>>   include/linux/init.h              | 62 ++++++++++++++++++++++++++++++-
>>   include/linux/module.h            | 22 +++++++++++
>>   3 files changed, 88 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 677315e51e54..48ccac7c6448 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -927,6 +927,10 @@
>>   		INIT_CALLS_LEVEL(7)					\
>>   		__initcall_end = .;
>>   
>> +#define SUBINIT_CALL							\
>> +		*(.subinitcall.init)					\
>> +		*(.subexitcall.exit)
>> +
>>   #define CON_INITCALL							\
>>   	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
>>   
>> @@ -1155,6 +1159,7 @@
>>   		INIT_DATA						\
>>   		INIT_SETUP(initsetup_align)				\
>>   		INIT_CALLS						\
>> +		SUBINIT_CALL						\
>>   		CON_INITCALL						\
>>   		INIT_RAM_FS						\
>>   	}
>> diff --git a/include/linux/init.h b/include/linux/init.h
>> index ee1309473bc6..e8689ff2cb6c 100644
>> --- a/include/linux/init.h
>> +++ b/include/linux/init.h
>> @@ -55,6 +55,9 @@
>>   #define __exitdata	__section(".exit.data")
>>   #define __exit_call	__used __section(".exitcall.exit")
>>   
>> +#define __subinit_call	__used __section(".subinitcall.init")
>> +#define __subexit_call	__used __section(".subexitcall.exit")
>> +
>>   /*
>>    * modpost check for section mismatches during the kernel build.
>>    * A section mismatch happens when there are references from a
>> @@ -115,6 +118,9 @@
>>   typedef int (*initcall_t)(void);
>>   typedef void (*exitcall_t)(void);
>>   
>> +typedef int (*subinitcall_t)(void);
>> +typedef void (*subexitcall_t)(void);
>> +
>>   #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>   typedef int initcall_entry_t;
>>   
>> @@ -183,7 +189,61 @@ extern struct module __this_module;
>>   #endif
>>   
>>   #endif
>> -
>> +
>> +#ifndef __ASSEMBLY__
>> +struct subexitcall_rollback {
>> +	/*
>> +	 * Records the address of the first sub-initialization function in the
>> +	 * ".subexitcall.exit" section
>> +	 */
>> +	unsigned long first_addr;
>> +	int ncalls;
>> +};
>> +
>> +static inline void __subexitcall_rollback(struct subexitcall_rollback *r)
>> +{
>> +	unsigned long addr = r->first_addr - sizeof(r->first_addr) * (r->ncalls - 1);
>> +
>> +	for (; r->ncalls--; addr += sizeof(r->first_addr)) {
>> +		unsigned long *tmp = (void *)addr;
>> +		subexitcall_t fn = (subexitcall_t)*tmp;
>> +		fn();
>> +	}
>> +}
> How does this guarantee the exit calls match sequence? Are you assuming
> linker puts exit functions in reverse order?
Take btrfs for example:
Initialize the function sequentially in init_btrfs_fs() using
module_subinit{_noexit}, storing the corresponding function addresses
in the specified ".subinitcall.init" and ".subexitcall.exit" sections.

Using gcc to compile btrfs to.ko, the view section contains the following:
```
$ objdump -d -j ".subinitcall.init" fs/btrfs/super.o

fs/btrfs/super.o:     file format elf64-x86-64


Disassembly of section .subinitcall.init:

0000000000000000 <__subinitcall_register_btrfs.0>:
     ...

0000000000000008 <__subinitcall_btrfs_run_sanity_tests.2>:
     ...

0000000000000010 <__subinitcall_btrfs_print_mod_info.3>:
     ...

0000000000000018 <__subinitcall_btrfs_interface_init.4>:
     ...

0000000000000020 <__subinitcall_btrfs_prelim_ref_init.6>:
     ...

0000000000000028 <__subinitcall_btrfs_delayed_ref_init.8>:
     ...

0000000000000030 <__subinitcall_btrfs_auto_defrag_init.10>:
     ...

0000000000000038 <__subinitcall_btrfs_delayed_inode_init.12>:
     ...

0000000000000040 <__subinitcall_ordered_data_init.14>:
     ...

0000000000000048 <__subinitcall_extent_map_init.16>:
     ...

0000000000000050 <__subinitcall_btrfs_bioset_init.18>:
     ...

0000000000000058 <__subinitcall_extent_buffer_init_cachep.20>:
     ...

0000000000000060 <__subinitcall_extent_state_init_cachep.22>:
     ...

0000000000000068 <__subinitcall_btrfs_free_space_init.24>:
     ...

0000000000000070 <__subinitcall_btrfs_ctree_init.26>:
     ...

0000000000000078 <__subinitcall_btrfs_transaction_init.28>:
     ...

0000000000000080 <__subinitcall_btrfs_init_dio.30>:
     ...

0000000000000088 <__subinitcall_btrfs_init_cachep.32>:
     ...

0000000000000090 <__subinitcall_btrfs_init_compress.34>:
     ...

0000000000000098 <__subinitcall_btrfs_init_sysfs.36>:
     ...

00000000000000a0 <__subinitcall_btrfs_props_init.38>:
     ...

```

```
$ objdump -d -j ".subexitcall.exit" fs/btrfs/super.o

fs/btrfs/super.o:     file format elf64-x86-64


Disassembly of section .subexitcall.exit:

0000000000000000 <__subexitcall_unregister_btrfs.1>:
     ...

0000000000000008 <__subexitcall_btrfs_interface_exit.5>:
     ...

0000000000000010 <__subexitcall_btrfs_prelim_ref_exit.7>:
     ...

0000000000000018 <__subexitcall_btrfs_delayed_ref_exit.9>:
     ...

0000000000000020 <__subexitcall_btrfs_auto_defrag_exit.11>:
     ...

0000000000000028 <__subexitcall_btrfs_delayed_inode_exit.13>:
     ...

0000000000000030 <__subexitcall_ordered_data_exit.15>:
     ...

0000000000000038 <__subexitcall_extent_map_exit.17>:
     ...

0000000000000040 <__subexitcall_btrfs_bioset_exit.19>:
     ...

0000000000000048 <__subexitcall_extent_buffer_free_cachep.21>:
     ...

0000000000000050 <__subexitcall_extent_state_free_cachep.23>:
     ...

0000000000000058 <__subexitcall_btrfs_free_space_exit.25>:
     ...

0000000000000060 <__subexitcall_btrfs_ctree_exit.27>:
     ...

0000000000000068 <__subexitcall_btrfs_transaction_exit.29>:
     ...

0000000000000070 <__subexitcall_btrfs_destroy_dio.31>:
     ...

0000000000000078 <__subexitcall_btrfs_destroy_cachep.33>:
     ...

0000000000000080 <__subexitcall_btrfs_exit_compress.35>:
     ...

0000000000000088 <__subexitcall_btrfs_exit_sysfs.37>:
     ...


```

 From the above, we can see that the compiler stores the init/exit function
in reverse order.

Thanks,
Youling.

