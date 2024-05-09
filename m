Return-Path: <linux-arch+bounces-4288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3008C151B
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4451F2374E
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD33653;
	Thu,  9 May 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JJqxJHRe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56077F465
	for <linux-arch@vger.kernel.org>; Thu,  9 May 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281251; cv=none; b=Bt+RTJBJfFH77XAGm7NXNzaJOvLkNvFRmuYJ0QfIF9r35kjfk86blwYus5vhd8SCzCyQIvpYMBblp3SyAZNP3El5/GnzoZY9NT6hFEDwhdvW346rlQgHoOJngdKW2kfl3j82RidTQsT/nYPgNP3Tj+93cLS9ZzzvcCc0D+4jtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281251; c=relaxed/simple;
	bh=xF39L+hs0TY+8aNmea7VYtJ+NEfSYKkZrUTY8FQHMiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOq+e4dxyZwxya5qiWsUjPpY86SKCmIpJ13blBrxBs+rzDGq1WnpF15hKPlNTMjHujRV+H5ykeiYNkIUbAYQtbceUGPsgMM9at74xuYmFGNcMoVxEPyZCKkdJS9uXImB6o+TxEpARSFqMvOrA8rqrKp0c+Os5SgEA1fDAxhg7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JJqxJHRe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so1116384b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2024 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715281242; x=1715886042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suVrTFWe4Q9EJfAXikAfGsbIG5FwHp88I8wjDmo5qhw=;
        b=JJqxJHRelJ7QcM2PM36uXftB9ooQUS6iPJ+3M48VB7n1Rt0Qvw8nwkvwQdK7vDOnbS
         aGOCUnx0yvWjP5VLhv8aqijkQH2PhO71MfbI8y33/IpWtnZiY6xNDPK0U8dCpwyd0xpG
         3dlf94UK2jlFf37YfJTq20Hjh3qjs16ULJthd1fBhrPnwa34PZTYrTwDx0jC2sU1i/0n
         vsGn9/NidfMsoQPz+QPJfwiNmFIVVlgzvW7oSE4yaFwoFEz1PjPZqXy+FpRLbeyIDEsN
         mr50KSsUPaB3x61aY+qwHMBle46w/Gy+HE1Vj0UoExGhiAFSeN5W4WLz23Ex5zBWYhf/
         CT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281242; x=1715886042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suVrTFWe4Q9EJfAXikAfGsbIG5FwHp88I8wjDmo5qhw=;
        b=C5Kcd9DVxCo2J/6Eqt9/A526YWGHh7jQjDqqzoLun46Ktl0dPzRLtt5COX2uCDKXUM
         45AqEqcE/v197VC7rT9Q78Tl3l7SqzT02O9xRAxh8K2GvSlbpFkfdf93r3cSgQhGJrr0
         wgBgcYCBOc1BZj7HxCAZGz4uPMpq64kXharghF0MAdG2nC3osB1bcphVsAkepWzhy9IY
         GkdFk+S0rKztq9D47x+oIJynkuPkVSMw5P3HuK9UY3/t3SltAZHYNg5lmWYENIBpjv/J
         0yX+D7Onr7t99YRxhUR+MGt7BaXuzKFL84exF8hEUQg8OAOy6bJrpbXnS4Cl+mAN7KdJ
         WiiA==
X-Forwarded-Encrypted: i=1; AJvYcCUDWyut4mC2v5PDyTO5otkQTrlOcEU9M+JQplick9jNz43A0wE2Hq9oWjM6iIq2+lc4YksI+iHku0TupDqXcJRmEV1kv0SZR5RT+Q==
X-Gm-Message-State: AOJu0YyQCnjo5DqgX3sqVjk1yeAKP6+FaG/aM+DDpo41gTW9HTRJm51a
	LzAlzOOpYXB8l4BPO4ZKqEp14jZqGc+Y4QUuNnbXZDZB9wXU8i6IaNySWJ+rvJc=
X-Google-Smtp-Source: AGHT+IHE3J/hwAQsHqywRim+p5Loya/dtj3SbYe2Ez8JQSaJRUzBly/edfRtpEMzoFQPu7m0vRKdfQ==
X-Received: by 2002:a05:6300:8002:b0:1af:62a6:e2 with SMTP id adf61e73a8af0-1afde1fb753mr598976637.56.1715281241943;
        Thu, 09 May 2024 12:00:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6654asm1626451b3a.43.2024.05.09.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:00:41 -0700 (PDT)
Date: Thu, 9 May 2024 12:00:36 -0700
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
Subject: Re: [PATCH v3 01/29] riscv: envcfg save and restore on task switching
Message-ID: <Zj0dVJ20D05ELAoH@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-2-debug@rivosinc.com>
 <ZjwUhvLBv13qi77a@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZjwUhvLBv13qi77a@ghost>

On Wed, May 08, 2024 at 05:10:46PM -0700, Charlie Jenkins wrote:
>On Wed, Apr 03, 2024 at 04:34:49PM -0700, Deepak Gupta wrote:
>> envcfg CSR defines enabling bits for cache management instructions and
>> soon will control enabling for control flow integrity and pointer
>> masking features.
>>
>> Control flow integrity enabling for forward cfi and backward cfi are
>> controlled via envcfg and thus need to be enabled on per thread basis.
>>
>> This patch creates a place holder for envcfg CSR in `thread_info` and
>> adds logic to save and restore on task switching.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/switch_to.h   | 10 ++++++++++
>>  arch/riscv/include/asm/thread_info.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
>> index 7efdb0584d47..2d9a00a30394 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -69,6 +69,15 @@ static __always_inline bool has_fpu(void) { return false; }
>>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>>  #endif
>>
>> +static inline void __switch_to_envcfg(struct task_struct *next)
>> +{
>> +	register unsigned long envcfg = next->thread_info.envcfg;
>
>This doesn't need the register storage class.
>

yeah. will fix it. thanks.

>> +
>> +	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0", 0,
>> +							  RISCV_ISA_EXT_XLINUXENVCFG, 1)
>> +							  :: "r" (envcfg) : "memory");
>> +}
>> +
>
>Something like:
>
>static inline void __switch_to_envcfg(struct task_struct *next)
>{
>	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
>		csr_write(CSR_ENVCFG, next->thread_info.envcfg);
>}
>
>would be easier to read, but the alternative you have written doesn't
>have the jump that riscv_has_extension_unlikely has so what you have
>will be more performant.

Yeah looked at codegen of `riscv_has_extension_unlikely` and I didn't like un-necessary jumps,
specially in switch_to path. All I want is a CSR write. So used alternative to patch nop with
CSR write.

>
>Does envcfg need to be save/restored always or just with
>CONFIG_RISCV_USER_CFI?

There is no save (no read of CSR). Only restore (writes to CSR).

There are pointer masking patches from Samuel Holland where senvcfg needs to be context
switched on per task basis.
https://lore.kernel.org/lkml/20240319215915.832127-1-samuel.holland@sifive.com/T/

Given that this CSR controls user execution environment and is per task basis, I thought its
better to not wrap it under CONFIG_RISCV_USER_CFI and rather make it dependend on
RISCV_ISA_EXT_XLINUXENVCFG. If any of the extensions which require senvcfg, then simply
restore this CSR on per task basis.

>
>- Charlie
>
>>  extern struct task_struct *__switch_to(struct task_struct *,
>>  				       struct task_struct *);
>>
>> @@ -80,6 +89,7 @@ do {							\
>>  		__switch_to_fpu(__prev, __next);	\
>>  	if (has_vector())					\
>>  		__switch_to_vector(__prev, __next);	\
>> +	__switch_to_envcfg(__next);				\
>>  	((last) = __switch_to(__prev, __next));		\
>>  } while (0)
>>
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> index 5d473343634b..a503bdc2f6dd 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -56,6 +56,7 @@ struct thread_info {
>>  	long			user_sp;	/* User stack pointer */
>>  	int			cpu;
>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>> +	unsigned long envcfg;
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  	void			*scs_base;
>>  	void			*scs_sp;
>> --
>> 2.43.2
>>

