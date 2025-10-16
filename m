Return-Path: <linux-arch+bounces-14163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B073CBE4459
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2103B1F61
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91434F48B;
	Thu, 16 Oct 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="doPubc3P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646834F469
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628675; cv=none; b=J5BSHV+IXqeuh4F89e+sDxIYekY3r3WDdVv1xCkM7I0G5ckhcvLtFe5xn9kQQh4+93tEoTT6XYBNRhfq7TQ2uFLaDb+RxXG9Yhx/y5JdmKd6Y1B4o8+M5GukWtauqwApuGFlHMvHmHqsv1zPA43ZQ92a5mXUWQsq9qocHpwwq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628675; c=relaxed/simple;
	bh=9p3Gr4qeRbg0Ysh2iAnD1VpHOA3SkA6SHTG6Wu71gKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksmlg76COdC3+CTO6s6GiJWtghg1VILFjCh3+4lJHPY/sZ3T2PUTpZXw0ElXDW8n0rzxWtNc9kLn2qh4VQVE/fNCsHxaIU2sSNqCUn90OhvgzXdtdRADRFWl0/NC76tt0wNOjkWdP4ll4zQJtTQy/cBiBzgvxS00FhFbQ4OlxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=doPubc3P; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so585208a12.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2025 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760628671; x=1761233471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPplYqAzpwU4gxjQp2Rw6jkCzCOQWdHbasm8KJuRgKg=;
        b=doPubc3P+gZ+HV7IYjMGh6lGx9ouANOyuXU4B+3+4MAHmWEyWU77V475Dyc9hub6Q6
         snrFK1pfy0QH0ZJfrksGyE/R51FzqaCxy+nN9v5ZVxoRWeiGBkGzHsQkkgRKC8oRGs6A
         Qc4XHh7LpCelOZyfpQFDtzZyfPNzoG7Xxq/MEbhVrfOGCMVpO3ALWzGG8KEXiZ0gTd2U
         kXz5LAeozLbwfJ0qMLwrbxobgJ90xnwvoyp+T3GYAK7Q1A1ZNxveNu/2UBljDFB+2H9T
         hEOfqN2+6TlM6U39FORldh72GZE0OMZnNbyPJlJ28O1jqgCYMcvLbG1m8zRdqkaXZYSZ
         fP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628671; x=1761233471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPplYqAzpwU4gxjQp2Rw6jkCzCOQWdHbasm8KJuRgKg=;
        b=WQUCCK/ITqq5QN+hfOK3LzBYs2029G04Ectjn4FGENcld+2ncd1zInyURiEGEYL+GL
         nvj6De6IFoXo0dfuO/UlO+tktH7JaEe4v/mRHiOGmgPfHza4tQbAik0GQqsjR1Aw4w5R
         j7RSo9orroa4Uphlal87qsMjo5NwdV1z4Jyl8ox4oJJaLaVhbvecuBu27L8nvieC/4YU
         fRB9ICCk+s0nd6DCLH7ZhCtcMbyawWYg5yks+6gzVXvYW366lRkIvByUapZYm12JcvRr
         0JDYi4/WYL/YCDmlfLLt9lpp7G4TSlFso7zpgtgN7S1+3Yhe0kIVHOPupsVOR1z29wqd
         OLHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkLDF4H5ZmYoIEwRWKracDC+rvEgVgmyr4dlQXVwPpu4zLlhbzjOO9JlZvyMJm7Wy0hChx38HkJZhq@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmOV87uOgCqlH/LAWvFBFuoG2tWS+cX2SYr9d06nKrDiKI7BN
	4+6GjBjYr7ZoynZcxjDnQcriNdfefoU2W5j96kJUfzaixcYGxFmRRkx94sYN4IAykw8=
X-Gm-Gg: ASbGncv13m1wgJrfskqvYlVOOVfIBOpfRLz+t2qQdsmMEdPsAQi1LA72/Ltza6eMeQd
	rmNQ9+K8RySgousTpYpJgK+4fwsRCFb+YAqvJzR8yFtxwK8lF8YCnJvYo36fublcDYG7tJWL1cN
	4Isq0u7bO7yOW1du8Z9FNBJEGnRvVmVBYwPNMHwQ/13tx1Hta8gcSlBBV74mCYw58CnneO+gveV
	mIGfZ8yYvPsBNVcdRsKtYhoT4RiGKzBdwSo6Ew/gerOV2S4mMNvqQ5Ji67EXxLQNfZqiF09dcGk
	uRGz/himLE9WarGzuxittfbZI+u4aed8BWJHYhGZxmM0p8Z1zcYZyQQ8Q7wgEPRgEQFk1R/CHKs
	xKrDEzApT1/Mq4rSqOW1pNTvMRWvaGC/vl4HB0hUSb4QOmyuYjODmDs2EqVGFxqimsORj3tNSPe
	8QnlkOIfmpsA==
X-Google-Smtp-Source: AGHT+IHwQKe9LAMk6ozD/GRZ/4wHAc2uQ93fezPeXjgomM0kYDp4EL0uCq03NAVcolelP7TLwPE5CA==
X-Received: by 2002:a17:902:db0b:b0:24c:d6c6:c656 with SMTP id d9443c01a7336-290c9c8a84bmr4369005ad.4.1760628671090;
        Thu, 16 Oct 2025 08:31:11 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm34122695ad.26.2025.10.16.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:31:10 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:31:07 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v21 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Message-ID: <aPEPuyYo_e4DFSMJ@debug.ba.rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
 <20251015-v5_user_cfi_series-v21-25-6a07856e90e7@rivosinc.com>
 <CANXhq0qHT=nnwG3SX3s_D3G2QqKGmQBbdzFwiQ5MMkimxCHJHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0qHT=nnwG3SX3s_D3G2QqKGmQBbdzFwiQ5MMkimxCHJHQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 04:29:48PM +0800, Zong Li wrote:
>On Thu, Oct 16, 2025 at 2:14 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> This patch creates a config for shadow stack support and landing pad instr
>> support. Shadow stack support and landing instr support can be enabled by
>> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
>> up path to enumerate CPU support and if cpu support exists, kernel will
>> support cpu assisted user mode cfi.
>>
>> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
>> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                  | 21 +++++++++++++++++++++
>>  arch/riscv/configs/hardening.config |  4 ++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0c6038dc5dfd..aed033e2b526 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -1146,6 +1146,27 @@ config RANDOMIZE_BASE
>>
>>            If unsure, say N.
>>
>> +config RISCV_USER_CFI
>> +       def_bool y
>> +       bool "riscv userspace control flow integrity"
>> +       depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
>> +       depends on RISCV_ALTERNATIVE
>> +       select RISCV_SBI
>> +       select ARCH_HAS_USER_SHADOW_STACK
>> +       select ARCH_USES_HIGH_VMA_FLAGS
>> +       select DYNAMIC_SIGFRAME
>> +       help
>> +         Provides CPU assisted control flow integrity to userspace tasks.
>> +         Control flow integrity is provided by implementing shadow stack for
>> +         backward edge and indirect branch tracking for forward edge in program.
>> +         Shadow stack protection is a hardware feature that detects function
>> +         return address corruption. This helps mitigate ROP attacks.
>> +         Indirect branch tracking enforces that all indirect branches must land
>> +         on a landing pad instruction else CPU will fault. This mitigates against
>> +         JOP / COP attacks. Applications must be enabled to use it, and old user-
>> +         space does not get protection "for free".
>> +         default n.
>
>Maybe it is default 'y' instead of 'n'

aah yes, this needs to change. thanks.
I'll see if there are other significant issues, if yes then I'll fix it in that
version. Else I request Paul to fix it.

>
>> +
>>  endmenu # "Kernel features"
>>
>>  menu "Boot options"
>> diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/hardening.config
>> new file mode 100644
>> index 000000000000..089f4cee82f4
>> --- /dev/null
>> +++ b/arch/riscv/configs/hardening.config
>> @@ -0,0 +1,4 @@
>> +# RISCV specific kernel hardening options
>> +
>> +# Enable control flow integrity support for usermode.
>> +CONFIG_RISCV_USER_CFI=y
>>
>> --
>> 2.43.0
>>

