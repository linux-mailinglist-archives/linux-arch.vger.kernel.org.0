Return-Path: <linux-arch+bounces-11516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866CA99C69
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 02:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E4F3AA5EB
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 00:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857F2367D1;
	Thu, 24 Apr 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tTIEJaVz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF5339A1
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452836; cv=none; b=mknaRPeIBYijjQnEHkyCwwQYDZlaef4u0h5h0tkbCK0poqSqDDvp0JBJyDhOhjR2kyGtxzG3JpSkFpIQkDVFx7aPkdNkwgQ7x0ZajmTgurYVSuxOngp+6tsdAr9/+9PUDcTvH4wVWrTc8X6dp195fK9MLHvjwNjrOYV0fdfU0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452836; c=relaxed/simple;
	bh=nHkKH6IFU8IHjkmLz+q5PPY9nOouTcwBKlF/qNIPRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAOm66vrDUnTwHIP+R0up/Yv/75rLM5Kr+SqtZ9XSFGSa8akY//3JYuDwHMyODhTYpVdjKGWVvq7qqWCiIecJCXSXRzh5jS5JlNOvXitQt0LXGbHQ2214WFKbpr5nDUlU+lEVdJOZ72KR1LEa6tV9F2UFDnsRWBzNBR3cVdYWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tTIEJaVz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso482330b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2025 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745452834; x=1746057634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5OcT62i+cl9aw1kw4Ux6AcGa3HwoUmmaKY882iOUVM=;
        b=tTIEJaVzjdJp9ipZ75NTtSCuUP5FsTJpAIsQmTmhOb6nBoHSoE5NBs7/7Zqox3GfAv
         Om+ipg+KXnoJc+chlDhK7drmiFi1AM37larOxNRnRMSnrGTgPR3WeDLsInfTNdcctaKY
         d2VzyhhoOY5PxGInEkU80Me/u4KskAzdeS9kEcaBEvJ6NyKNqee9wzzHk7LLgaXWEe4r
         BmkNosNd/QNHS7M+7G+Pup6JiYEN42XaGnxdW50H868rZoclbPLXvRgqA0GP+mmAKw4/
         Gju8xVYa49svVB17sIDqD/0VAFm1fmVBx1VylxvtQTR9JqSKxhZ9vtnB0Cxrwn3yCSTD
         jVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452834; x=1746057634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5OcT62i+cl9aw1kw4Ux6AcGa3HwoUmmaKY882iOUVM=;
        b=kFiUwPN3o2nSy9le0T/BiYDeyDL6OhNjeXoL4nVOx9OWeiXKhhX854K9BqG8SpZIFH
         MPVMBIyl5gGRG7WrGgzuF6ujARKGNyd7Xfeu8tZ6a/d3wCbtKdFdsQtFOKFq6wl5jc3j
         Fnoso2P6XxrnlajloxuJkD8kDuT+vUkMUeOLeZHNW67VW6OGeLWkTAlnk+UlwGcSOD9c
         rQZ5QnLgLMQoWexiPPaq+JtKW2bhT1xMGbyxXdeNiUdAAnTEZF3BWNY3SzBxxDSNelJd
         b5QCQyrYxMMPgCW3aG0IEbKc0/X4jriVDhKsV52vxwHkGPinzex+LysNCrJ4rN+1Fz6+
         o+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCULVHZwZHcuHEEUpd2WApR1ygZZQeUqd2z7DWSckwONEn05j9OoxLUAN94Q/7HXJ76PftbwlKGFMUYY@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBrIP/jBka/bplNHh3cZmlP5+FOFdp2quD0Z6Gs6LD5YUc2B0
	QTfwEtkqfz1L1gjlVI2O9FGQp4duVCntaqP2FTR+l2wce4QYsDfpoBBwQpfIS2U=
X-Gm-Gg: ASbGncsw9CxzHqWw3imPUhllImkoukVCFTm/VEw2b4NmxQpmtM1Eoa4309+JndsivrJ
	IA+fceO/WIesl2XLJrMgK9YyaQIrG7yEACy/iMjzIZn3RIPIyoCbdKx/JFcfoWA9UJAkbaGszmt
	eb76xZm11tSXs+WuPn1qszVi2bGDkDWnvfXD3BNVMO0FcTA8MO/DGjVLdnVvEYD/pbf8wTEcnej
	QXsj4WLD/ZeSYdUB/ukkBzcen8Hi2fdhW0ndqGnT/dxWnYl4BdzyyCw0lDBk2KOTutqWe4/W/8n
	QWeJB4AY5JdDER3dgO+u/4DyVaFFXY33R62x5gdv/TAdny94IHc=
X-Google-Smtp-Source: AGHT+IH4j35h3jLwkaElmed40lsuZThIxCdtbM8R+7icxou6aZCYqN/7j54Ho7tdgxWbsJBSD2dEvQ==
X-Received: by 2002:a05:6a00:3a1d:b0:73c:3f2e:5df5 with SMTP id d2e1a72fcca58-73e2680c3aemr381304b3a.9.1745452833588;
        Wed, 23 Apr 2025 17:00:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm177897b3a.60.2025.04.23.17.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:00:33 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:00:29 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, broonie@kernel.org, rick.p.edgecombe@intel.com,
	Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aAl_HRk49lnseiio@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>

On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> @@ -62,6 +62,9 @@ struct thread_info {
>>  	long			user_sp;	/* User stack pointer */
>>  	int			cpu;
>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	struct cfi_status	user_cfi_state;
>> +#endif
>
>I don't think it makes sense to put all the data in thread_info.
>kernel_ssp and user_ssp is more than enough and the rest can comfortably
>live elsewhere in task_struct.
>
>thread_info is supposed to be as small as possible -- just spanning
>multiple cache-lines could be noticeable.

I can change it to only include only `user_ssp`, base and size.

But before we go there, see below:

$ pahole -C thread_info kbuild/vmlinux
struct thread_info {
         long unsigned int          flags;                /*     0     8 */
         int                        preempt_count;        /*     8     4 */

         /* XXX 4 bytes hole, try to pack */

         long int                   kernel_sp;            /*    16     8 */
         long int                   user_sp;              /*    24     8 */
         int                        cpu;                  /*    32     4 */

         /* XXX 4 bytes hole, try to pack */

         long unsigned int          syscall_work;         /*    40     8 */
         struct cfi_status          user_cfi_state;       /*    48    32 */
         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
         long unsigned int          a0;                   /*    80     8 */
         long unsigned int          a1;                   /*    88     8 */
         long unsigned int          a2;                   /*    96     8 */

         /* size: 104, cachelines: 2, members: 10 */
         /* sum members: 96, holes: 2, sum holes: 8 */
         /* last cacheline: 40 bytes */
};

If we were to remove entire `cfi_status`, it would still be 72 bytes (88 bytes
if shadow call stack were enabled) and already spans across two cachelines. I
did see the comment above that it should fit inside a cacheline. Although I
assumed its stale comment given that it already spans across cacheline and I
didn't see any special mention in commit messages of changes which grew this
structure above one cacheline. So I assumed this was a stale comment.

On the other hand, whenever enable/lock bits are checked, there is a high
likelyhood that user_ssp and other fields are going to be accessed and
thus it actually might be helpful to have it all in one cacheline during
runtime.

So I am not sure if its helpful sticking to the comment which already is stale.

>
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>>
>>  	REG_L s0, TASK_TI_USER_SP(tp)
>>  	csrrc s1, CSR_STATUS, t0
>> +	/*
>> +	 * If previous mode was U, capture shadow stack pointer and save it away
>> +	 * Zero CSR_SSP at the same time for sanitization.
>> +	 */
>> +	ALTERNATIVE("nop; nop; nop; nop",
>> +				__stringify(			\
>> +				andi s2, s1, SR_SPP;	\
>> +				bnez s2, skip_ssp_save;	\
>> +				csrrw s2, CSR_SSP, x0;	\
>> +				REG_S s2, TASK_TI_USER_SSP(tp); \
>> +				skip_ssp_save:),
>> +				0,
>> +				RISCV_ISA_EXT_ZICFISS,
>> +				CONFIG_RISCV_USER_CFI)
>
>(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
> the flow here.  We also already know if we've returned from userspace
> or not even without SR_SPP, but reusing the information might tangle
> the logic.)
>
>>  	csrr s2, CSR_EPC
>>  	csrr s3, CSR_TVAL
>>  	csrr s4, CSR_CAUSE
>> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>  	csrw CSR_SCRATCH, tp
>> +
>> +	/*
>> +	 * Going back to U mode, restore shadow stack pointer
>> +	 */
>
>Are we?  I think we can be just as well returning back to kernel-space.
>Similar to how we can enter the exception handler from kernel-space.
>
>> +	ALTERNATIVE("nop; nop",
>> +				__stringify(					\
>> +				REG_L s3, TASK_TI_USER_SSP(tp); \
>> +				csrw CSR_SSP, s3),
>> +				0,
>> +				RISCV_ISA_EXT_ZICFISS,
>> +				CONFIG_RISCV_USER_CFI)
>> +
>
>Thanks.

