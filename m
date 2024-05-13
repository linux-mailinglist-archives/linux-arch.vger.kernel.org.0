Return-Path: <linux-arch+bounces-4372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE378C4669
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83D81C22818
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF52940B;
	Mon, 13 May 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pm4i718F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC3224CF
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622456; cv=none; b=WRQOx/MMceWWrFCbr1IU8hNRJkapkYm0bRvuGQioxTCTelHkuW83REg3J+L8roOBqOxlAJfqZ1TF+ofp69Rywh70/kyJT6dt2yoBLSwkdZE2w5PAonrpjgKZvNo/lxuVIkldi3vAwsxsINK6YvQgpjBBuRsMZClmcS3LguEM3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622456; c=relaxed/simple;
	bh=Fg+Nj1DQuuL02Ilzi8jCFAbiXMFR3aYYTKYOamODzJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfm+XysF6hsdNwZGz7NH13CELkhIC8HlCOSxOhurgpilRDM/puOaXgOnynFbfsPmxlwox3yV3yyy1A1e5NYRa27ijZPeOZZWWhNRUkhXyC4RN840GVPy81CehO6nJigGY44OHmUkf7yRBVuVSUd7dnJs520V7m7ABVfBuPVn/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pm4i718F; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3982477a12.3
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715622453; x=1716227253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LaUfYbhjgFs2AjjPA78Kswq4d56jrbrUI3xg3pcRhk=;
        b=pm4i718FrX0J+PdCM61GxXfkEEsTDgw7pIv5KSdohz5pBokET272CSI+F76igf+hAZ
         Q97dzxgb6/+g6WDJ8cksOyUjoWkjKxOxGq52KWA/6QgcIJr0wRItMK5/xhg0lueqnjq7
         lHt/xvQ0imJuVLKypzmj/mlDYQmJBUtGk3gY7eGh8yrsD7DnqooA88X7b+bUpJspCihK
         PWizX1YkdUvV4IB3thskOXNiZ5PJsbzmabWPVCTd4tnnP+GwlC0++xzoytWpbA6kN5kO
         IAK5ATtSq1NSlIk7FijjkO/EgnrRNX/UdewVQPsTzYQoCKVRQVi+n2dRHjCJ/OvWOB0z
         ROvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715622453; x=1716227253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LaUfYbhjgFs2AjjPA78Kswq4d56jrbrUI3xg3pcRhk=;
        b=BkS1/LsOF3xGlRthD05pL6DHFc6fwM7Xb/j0tPBSV7SkoHQOjVrFT/h7oAKsunZjwn
         1c1APN/RjL/6tFf/zyG8y454DD7mgi6RgYuvpo11CrDJZ/F+lg8lrO3sKs6IBiRz74zm
         XzqwXmeDbg8gjrxbuBxQTeER1wKMsVie93HKMQzQZvuhxG2beAugcyxuUKeHnClcWZUo
         kJK3/avcD6+Ru16bfXDiIuD5+knqDTksp5B++kAmxVlAhQGGgB/uLnd88mcCUW7wuKwD
         Jko1W55/82L7HjrXGTdSnXBhWQuRZbwkWecWTyaNpsVZhw7H/1OFNSjgdKi14TAO8s6o
         Nb0w==
X-Forwarded-Encrypted: i=1; AJvYcCVKslBxbC2qysFVfu9lGt7u5tw6DDtBuTZyZXz0AnOvG4zTNIszQSCLga/YannSkI1Y/dNveHdjGLxI+o7QPfLeYmWcp2AFtoEa1g==
X-Gm-Message-State: AOJu0YzllWRXnX0SVeQKadYerP6G967H8JNfkzG1yGqh+S7YlLTHsRD1
	Q60qVfJenVdVENonZy5YTrvW/BP2QMbbayLdympabhx3atoEXAhj6Ao5KmaE6K8=
X-Google-Smtp-Source: AGHT+IGjx0AoLZdsnPMmBtuPR7WiUWSxaNpuC/v1kUd2jvw2APP6WDzK0//bbc0udBP7gghTi2HA6A==
X-Received: by 2002:a17:90b:106:b0:2b6:c4d7:fc31 with SMTP id 98e67ed59e1d1-2b6cd1e4ba4mr11564581a91.40.1715622451120;
        Mon, 13 May 2024 10:47:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6c10sm10010384a91.53.2024.05.13.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:47:30 -0700 (PDT)
Date: Mon, 13 May 2024 10:47:25 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 10/29] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Message-ID: <ZkJSLTk1iWFGJZCQ@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-11-debug@rivosinc.com>
 <Zj6LfpQhOjTLEx2O@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zj6LfpQhOjTLEx2O@ghost>

On Fri, May 10, 2024 at 02:02:54PM -0700, Charlie Jenkins wrote:
>On Wed, Apr 03, 2024 at 04:34:58PM -0700, Deepak Gupta wrote:
>> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
>> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
>> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
>> This is to make sure that any existing apps using PROT_WRITE still work.
>>
>> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
>> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
>> encodings for shadow stack. Above changes ensure that existing apps
>> continue to work because underneath kernel will be picking
>> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
>>  arch/riscv/include/asm/pgtable.h |  1 +
>>  arch/riscv/kernel/sys_riscv.c    | 11 +++++++++++
>>  arch/riscv/mm/init.c             |  2 +-
>>  mm/mmap.c                        |  1 +
>>  5 files changed, 38 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/include/asm/mman.h
>>
>> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
>> new file mode 100644
>> index 000000000000..ef9fedf32546
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/mman.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_MMAN_H__
>> +#define __ASM_MMAN_H__
>> +
>> +#include <linux/compiler.h>
>> +#include <linux/types.h>
>> +#include <uapi/asm/mman.h>
>> +
>> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> +	unsigned long pkey __always_unused)
>> +{
>> +	unsigned long ret = 0;
>> +
>> +	/*
>> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
>> +	 * Only VM_WRITE means shadow stack.
>> +	 */
>> +	if (prot & PROT_WRITE)
>> +		ret = (VM_READ | VM_WRITE);
>> +	return ret;
>> +}
>> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>> +
>> +#endif /* ! __ASM_MMAN_H__ */
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 6066822e7396..4d5983bc6766 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
>>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>>  					 _PAGE_EXEC | _PAGE_WRITE)
>> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>>
>>  #define PAGE_COPY		PAGE_READ
>>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> index f1c1416a9f1e..846c36b1b3d5 100644
>> --- a/arch/riscv/kernel/sys_riscv.c
>> +++ b/arch/riscv/kernel/sys_riscv.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/syscalls.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm-generic/mman-common.h>
>> +#include <vdso/vsyscall.h>
>> +#include <asm/mman.h>
>>
>>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  			   unsigned long prot, unsigned long flags,
>> @@ -17,6 +19,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * If only PROT_WRITE is specified then extend that to PROT_READ
>> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
>> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
>> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
>> +	 */
>> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>
>The comments says that this should extend to PROT_READ if only
>PROT_WRITE is specified. This condition instead is checking if
>PROT_WRITE is selected but PROT_READ is not. If prot is (VM_EXEC |
>VM_WRITE) then it would be extended to (VM_EXEC | VM_WRITE | VM_READ).
>This will not currently cause any issues because these both map to the
>same value in the protection_map PAGE_COPY_EXEC, however this seems to
>be not the intention of this change.
>
>prot == PROT_WRITE better suits the condition explained in the comment.

If someone specifies this (PROT_EXEC | PROT_WRITE) today, it works because
of the way permissions are setup in `protection_map`. On risc-v there is no
way to have a page which is execute and write only. So expectation is that
if some apps were using `PROT_EXEC | PROT_WRITE` today, they were working
because internally it was translating to read, write and execute on page
permissions level. This patch make sure that, it stays same from page
permissions perspective.

If someone was using PROT_EXEC, it may translate to execute only and this change
doesn't impact that.

Patch simply looks for presence of `PROT_WRITE` and absence of `PROT_READ` in
protection flags and if that condition is satisfied, it assumes that caller assumed
page is going to be read allowed as well.


>
>> +		prot |= PROT_READ;
>> +
>>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>>  }
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index fa34cf55037b..98e5ece4052a 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -299,7 +299,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>  static const pgprot_t protection_map[16] = {
>>  	[VM_NONE]					= PAGE_NONE,
>>  	[VM_READ]					= PAGE_READ,
>> -	[VM_WRITE]					= PAGE_COPY,
>> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>>  	[VM_EXEC]					= PAGE_EXEC,
>>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index d89770eaab6b..57a974f49b00 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -47,6 +47,7 @@
>>  #include <linux/oom.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/ksm.h>
>> +#include <linux/processor.h>
>
>It doesn't seem like this is necessary for this patch.

Thanks. Yeah it looks like I forgot to remove this over the churn.
Will fix it.

>
>- Charlie
>
>>
>>  #include <linux/uaccess.h>
>>  #include <asm/cacheflush.h>
>> --
>> 2.43.2
>>

