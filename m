Return-Path: <linux-arch+bounces-4232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A08BDD06
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F5BB21905
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205E13C80B;
	Tue,  7 May 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZfKEVUD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194D73530;
	Tue,  7 May 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069812; cv=none; b=Ky1gwL0shFRN2GjKEJCEa0F62ofocmfAkquWIdnMC6qBJBpiLYKDmKznUmZxmt5ej7FJE1PFzpQ5ViG7THBbN7xqC9s5oGFskZASVZj50VX8aI6jJ+2EiJb4Gtzrj6nSrYYIhaznd2lWxYrKSDm6bUgcgScoLy/DFZXJmwvNh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069812; c=relaxed/simple;
	bh=TBYk1hqbWT/AZ3S/6TKTtK/W2HY/XNM/rZYM5H7/Tz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1PDKM3OUZ8iXk48YTiSutjg0LiZrBGucoxZUQ0PNL7jZSiGsIPWqvOyiMmNOPwL/fnmuWYa8FL3sK2+tvfwFbqQeYG8t+vGVWXYQnE2b9WjN65RdfUqjzYQLnODyqFed0w5BOOPHe3U/Q9Sq/dZCIy61TuQTlFt45mZo9RAfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZfKEVUD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ce1e8609so289436766b.0;
        Tue, 07 May 2024 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715069809; x=1715674609; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maPe74un1UQbFXNUNtNwtmyr5vBb7tDiWAcBESvmSQ4=;
        b=eZfKEVUDO2pNYhb12pOShKDLJ6xFGD+3thA2oRHQiwj9PI9R1XvBxBS5ZT3PQ1ptao
         CW3VAnetszWKGeH8tNhTqsi8GNUFHUCpAuBIBwsxQtl2S1clNFJKu5oVPW9/4eq26Ll1
         9zZdBnw+vLq/PqRZXvKjgYJWaBYoBBSa+J53VJ6l5+vaup1B+vg9xxFo2z9lC9s1ssj9
         hAHclsJNJsvlwo8czIZUZ90kjNg/Df0FvnHg/C27hRRz47DLvXVBGvhoH0qKo6oIQiPH
         R7c6ddcSodf4avEs9jBR59Djw4+U9/EWt3Id6lNpgcDrVXmfl5F6yTS5x+0igWqgtlsp
         TMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069809; x=1715674609;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maPe74un1UQbFXNUNtNwtmyr5vBb7tDiWAcBESvmSQ4=;
        b=Jsnb0IHu3Ftk03kbR9UzE8pdCw3ifOrWExyrKH4aMZ6dEYtH7cZSSi8WjzR6Zlqwrb
         pITVf60f7Q+8UMN1QeSzdn+4x1xzXfhKT2vetbOYxBA+qV75ChrJz7gh6XoG9cF02GYA
         kK4piDP/bLExDuPXdMZaRyczk0n8vqrCAcVx9x9g/OsY4GUAGRbYb3QGv3wFemorYCjN
         T+OJoGfvWF2JqNfd7dwX21TUyX2FhFgX4tzJ6Zm6EjQWmIDZk0lvOCqdFvnJrYQ074qc
         0PenpwFf8snsW09Y3niss1A6MJ8tak+lUXQyZ8ugrNlMNzBV5WxbrfLzzH0RWCkFjMaE
         CxCw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjJgwVHkzX/OP3vFql9uwemdhejc9s/n0fjPb+FT3MZSCGtiGSpsdYOrQFdADBRUJ6FtlAA8AHiJF9tzEArgdd/hlN6F5X3M6wFjl5Gt7v1sXKhWa158lED8zwVhgr5E8gzw9yCtE8Q==
X-Gm-Message-State: AOJu0YyiA7/7ZpIedtOVLriHlISc+iclyOj9U8a8FS68BLW21HatGaYh
	Tikas9YqbnAWnLJScZRP/5oLkREG8Tuq68surIFS0nSXv8Xf975G
X-Google-Smtp-Source: AGHT+IGguKbFCboPibTCI7Xs36D/0JStkhieejoqZsvCp1T4ZXAkr3vT0GKhxI2ErSNLSH3s+TcQWw==
X-Received: by 2002:a17:906:2c49:b0:a55:b67c:bd04 with SMTP id a640c23a62f3a-a59e4cbc8femr160702266b.4.1715069809147;
        Tue, 07 May 2024 01:16:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dx3-20020a170906a84300b00a58e8d08b40sm6062079ejb.21.2024.05.07.01.16.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2024 01:16:48 -0700 (PDT)
Date: Tue, 7 May 2024 08:16:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, arnd@arndb.de, rppt@kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <20240507081647.2x2l7fwjnyiud6ee@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240506012104.10864-1-richard.weiyang@gmail.com>
 <5f9e5d19-8a38-4e98-8cbb-e5501c76f740@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9e5d19-8a38-4e98-8cbb-e5501c76f740@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, May 06, 2024 at 03:30:54PM +0530, Anshuman Khandual wrote:
>
>On 5/6/24 06:51, Wei Yang wrote:
>> When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
>> code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
>> neither.
>
>When CONFIG_ARCH_KEEP_MEMBLOCK is not set memblock information both for
>normal and reserved memory get freed up but should the memblock related
>code and data also be freed up as well ? Then I would also believe such

If not freed, those functions would access unpredictable area.

>memory saving will be very minimal given CONFIG_ARCH_KEEP_MEMBLOCK code
>is too limited scoped in the tree.

Not very much, it shows 12K more in it.

>
>Also could you please explain how it is related to CONFIG_MEMORY_HOTPLUG
>config being set or not.
>

This is in file include/asm-generic/vmlinux.lds.h.

MEM_KEEP/MEM_DISCARD is conditionally defined by CONFIG_MEMORY_HOTPLUG.
So even __init_memblock is defined as __meminit when CONFIG_ARCH_KEEP_MEMBLOCK
not set, it is not discarded.
                    
>>                  
>> This patch puts memblock's .text/.data into its own section, so that it
>> only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
>> data. After this, init size increase from 2420K to 2432K.
>
>Is not this memory size saving some what insignificant to warrant a code
>change ? Also is this problem applicable only to CONFIG_ARCH_KEEP_MEMBLOCK

Yes, this is not significant.

>config. Could you also provide details on how did you measure these numbers ?
>

Kernel print related info in mem_init_print_info(). One of is it
init size, which includes init_data and init_text.

>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
>>  include/linux/memblock.h          |  8 ++++----
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index f7749d0f2562..775c5eedb9e6 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -147,6 +147,14 @@
>>  #define MEM_DISCARD(sec) *(.mem##sec)
>>  #endif
>>  
>> +#if defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>> +#define MEMBLOCK_KEEP(sec)    *(.mb##sec)
>> +#define MEMBLOCK_DISCARD(sec)
>> +#else
>> +#define MEMBLOCK_KEEP(sec)
>> +#define MEMBLOCK_DISCARD(sec) *(.mb##sec)
>> +#endif
>> +
>>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>  #define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
>>  #define PATCHABLE_DISCARDS
>> @@ -356,6 +364,7 @@
>>  	*(.ref.data)							\
>>  	*(.data..shared_aligned) /* percpu related */			\
>>  	MEM_KEEP(init.data*)						\
>> +	MEMBLOCK_KEEP(init.data*)					\
>>  	*(.data.unlikely)						\
>>  	__start_once = .;						\
>>  	*(.data.once)							\
>> @@ -573,6 +582,7 @@
>>  		*(.ref.text)						\
>>  		*(.text.asan.* .text.tsan.*)				\
>>  	MEM_KEEP(init.text*)						\
>> +	MEMBLOCK_KEEP(init.text*)					\
>>  
>>  
>>  /* sched.text is aling to function alignment to secure we have same
>> @@ -680,6 +690,7 @@
>>  	KEEP(*(SORT(___kentry+*)))					\
>>  	*(.init.data .init.data.*)					\
>>  	MEM_DISCARD(init.data*)						\
>> +	MEMBLOCK_DISCARD(init.data*)					\
>>  	KERNEL_CTORS()							\
>>  	MCOUNT_REC()							\
>>  	*(.init.rodata .init.rodata.*)					\
>> @@ -706,7 +717,8 @@
>>  #define INIT_TEXT							\
>>  	*(.init.text .init.text.*)					\
>>  	*(.text.startup)						\
>> -	MEM_DISCARD(init.text*)
>> +	MEM_DISCARD(init.text*)						\
>> +	MEMBLOCK_DISCARD(init.text*)
>>  
>>  #define EXIT_DATA							\
>>  	*(.exit.data .exit.data.*)					\
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index e2082240586d..3e1f1d42dde7 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -100,13 +100,13 @@ struct memblock {
>>  
>>  extern struct memblock memblock;
>>  
>> +#define __init_memblock        __section(".mbinit.text") __cold notrace \
>> +						  __latent_entropy
>> +#define __initdata_memblock    __section(".mbinit.data")
>> +
>>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
>> -#define __init_memblock __meminit
>> -#define __initdata_memblock __meminitdata
>>  void memblock_discard(void);
>>  #else
>> -#define __init_memblock
>> -#define __initdata_memblock
>>  static inline void memblock_discard(void) {}
>>  #endif
>>  

-- 
Wei Yang
Help you, Help me

