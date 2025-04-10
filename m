Return-Path: <linux-arch+bounces-11378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703B5A84167
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C613BC604
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D7281530;
	Thu, 10 Apr 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pVFHYrgW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBB26FA69
	for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283084; cv=none; b=Zv4L9+3KXWv5YCxUsLHPXQLbNkjuv8qjEc9U67AD+ZFEwK9iCaEM8RSOW4wKHWW34FADPJJF+kvJFgjsZcTVR/Jq6syGpRo2up3tFb1uQiFV980ycagvPX2FuaRgCApaPRCJoIhYmkFmQuMCnu09AsBJVaqTO5cpNmGGJacnYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283084; c=relaxed/simple;
	bh=kOlPkOa9RAWaHmxwXq9vXkGSssRFc7sUC8EQNbcnfPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tKW3atufKIRoFTJP7/u21PoMEDDoNGy9t2PN8k2UAxqD7StxZTJXDXOjsc6MzQFPEgvbgI6FpmgA+Fv+PS5LsVSwKOIY2+0ro++w1VCGU84i+alieos0Cu+YJdcCgdeZEwZrnt5lDHWZY4JMk4LBr6VLJbQ9pOsT/ay9xiMTBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pVFHYrgW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391295490c8so23865f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2025 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1744283080; x=1744887880; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=pVFHYrgW6CsPBVfhDp8H0SHh07ORi0+k92JSM7WHod+l6GpALDm6Af/8R4cZodTjSI
         tJhmQC0ISSnfE51tew20VXscex2ugzAatyW+gaNQVdqFVsPCNEtL0hzsectLv90gFFtt
         oVuwwysWrn9jEcSsg7T6KkbCebzr4gntAQJheGXE5uqMjbzNUT2JWYiPhRLq9y69avjt
         blLUmxwM5ibExPlEoUUbX0wnvPL/rJd7iUzELewMF/309FFzjGxOdZqxZeMaqwE83MP6
         zgXi1m4nmEywod9fgORmfD+WzNDeuueMfkonfaKqfm00t7VTa2R1DFvAman71MpISxGx
         m5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283080; x=1744887880;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=fMr9R2AJk6kE8ufPuNkOjsQOFSC9oSmbpxCDEkiP0TMQzDl/Kjc4IYjteh6yIEGC7u
         cCyjhn3HTGoNg/mEn6Ao0kB728KjArDFa4nftOUY40rwJiZ4qgkV/cgct/xzzYl5rPSQ
         D/J2ePRcIRqOOkZTFapO5EhjxblUr+V7CeaHo51Q/O0Og3O/uncXV55Mab/McLlWy9m/
         VyiOgGPg6qoa8eClTDpbQUSbrF/wtHLt7cn/6gWtcgwXCU1FEnm8GLWhf/YgF65s1kOL
         pz8CSFKVv++OcsA2vzoAO4E2PogjAAaLnjvOC6gnvtMqo1zfWsvyXDSN7EAePnTLkM1W
         h0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxVY6NI1Yarc4xD9NozK4Qnt2OkWqekSqzM9KUp6ZqaaTjNDnHcFGbfOzuNVTQ0fSVLGwDmCxShuMQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cBUx5d5LcbDv6m1OlI3Wga8OvpVgipYJmZoBRBMIQFLIs/4s
	fcZp1CpeePhxrvtHqpiVWDj3bkzASJK7Zs3ul0rTfO8cTSriLosfyImXYWD5LLY=
X-Gm-Gg: ASbGncsmXR7kDJkNpvrhu7XaIJtDCOEJb8Wnt5ybLs9SBAqgK/cpMyweR74Z/fBDGqj
	XJQXXdYaVxYJ1WXh/jqMutNE8PvQFHxX0kKB78jPWnXfA/k8mCjM9nS7GaJ2u3Lswza525Ujkdm
	8qs4lyQ5Ug9IqT56taZMsIEW1B2ZAayRU4vqrNcqI806eg0IQ9VGnZFOvo6mZ6ZW8j2xtHqF8xG
	OAXd4UQDbSa4APwD3IaGbSKl1RMzMG/V85tLIbr/KEd6qxPFrDqMkwNWMEWRw19UCSeGCO7sJOk
	7Tk44jyC9k82vxX2tJb+6AFkKPGCNLxQsl45a4m16jMtUVkm
X-Google-Smtp-Source: AGHT+IFTHVjvMm7SI9zG+YTo6xP+VuwjrIfNbL14H9cY5sGUQSewGH6hwjaZZsvjM4ZfhfO2SM4RNA==
X-Received: by 2002:a05:6000:18ac:b0:39c:13fa:3e0 with SMTP id ffacd0b85a97d-39d87adcd02mr1983393f8f.9.1744283080239;
        Thu, 10 Apr 2025 04:04:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:7d22:13bb:e539:15ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361186sm4476526f8f.14.2025.04.10.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 13:04:39 +0200
Message-Id: <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, "Eric Biederman"
 <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann Horn"
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>

2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> @@ -62,6 +62,9 @@ struct thread_info {
>  	long			user_sp;	/* User stack pointer */
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status	user_cfi_state;
> +#endif

I don't think it makes sense to put all the data in thread_info.
kernel_ssp and user_ssp is more than enough and the rest can comfortably
live elsewhere in task_struct.

thread_info is supposed to be as small as possible -- just spanning
multiple cache-lines could be noticeable.

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
> =20
>  	REG_L s0, TASK_TI_USER_SP(tp)
>  	csrrc s1, CSR_STATUS, t0
> +	/*
> +	 * If previous mode was U, capture shadow stack pointer and save it awa=
y
> +	 * Zero CSR_SSP at the same time for sanitization.
> +	 */
> +	ALTERNATIVE("nop; nop; nop; nop",
> +				__stringify(			\
> +				andi s2, s1, SR_SPP;	\
> +				bnez s2, skip_ssp_save;	\
> +				csrrw s2, CSR_SSP, x0;	\
> +				REG_S s2, TASK_TI_USER_SSP(tp); \
> +				skip_ssp_save:),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)

(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
 the flow here.  We also already know if we've returned from userspace
 or not even without SR_SPP, but reusing the information might tangle
 the logic.)

>  	csrr s2, CSR_EPC
>  	csrr s3, CSR_TVAL
>  	csrr s4, CSR_CAUSE
> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	csrw CSR_SCRATCH, tp
> +
> +	/*
> +	 * Going back to U mode, restore shadow stack pointer
> +	 */

Are we?  I think we can be just as well returning back to kernel-space.
Similar to how we can enter the exception handler from kernel-space.

> +	ALTERNATIVE("nop; nop",
> +				__stringify(					\
> +				REG_L s3, TASK_TI_USER_SSP(tp); \
> +				csrw CSR_SSP, s3),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
> +

Thanks.

