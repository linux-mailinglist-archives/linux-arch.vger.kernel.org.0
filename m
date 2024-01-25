Return-Path: <linux-arch+bounces-1670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E201083CB12
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6201E1F26A13
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABD137C37;
	Thu, 25 Jan 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ndRNjLNt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1ED13667A
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207187; cv=none; b=V6ZebKFUSOFc5dGBwdjIDoqR1aiFPmMmxxvfOTu7BJXWMVEEn+nyfe/RgoE6axaiRzXUf9cX6eLsBEVhNy2+2TxN7WYILD/ZjfKWG5wxM0io0TrNQ0LkHO+zswcWZo76L20rcC0gSRgNYbaB6tyxdGH5HkX/IbPpuu607I3A2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207187; c=relaxed/simple;
	bh=jx00gY1ANnXUmZbXujxCZw5ack5kqcVrRKjf2wSzAGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8sNJhoMExmoTbtyZpIARcNafIjIqPi03uNwKdGEiOwxw033te1LNT89CK6v7wAhT/zC9zlkgCkLod0NXTuwpFIeBHHgtPE2uTA09wtC5HRnc2Re8IQdZ53qzevVWU5b6GYx5YROp98zWPmtmDyvsXX6Zycxzdh0f4vNlStpbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ndRNjLNt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2538932a12.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706207184; x=1706811984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyuZ0gVdBuvlPmtjlhSz8uJtD77t/nVDJ3cBvemqEj0=;
        b=ndRNjLNtyb2HSEDOmH/SyIDmrte0pVJhbjx5ZFOqTVaN7zTiNt5Hv0poqPgH1fvEvW
         o4qDLhKbdvSU8IfpisXd196IA9OWyysxT9b6MZ/eBWwz+s+GogE5RDlWdvAZ6Pv7CqeX
         d1nZwoWmgxZh8V3wrRsluC8eWBvyzqJMrD1yWLdPmXld+IZZ2zckxZ7vER8J/2glMQMQ
         DNtMgs5Iwnxpov8tsBR+gQpM/ZaS8IorzAJ5KtBQs0MLqSmcIN6bJGDpJOdOaNkkBFXq
         Tq0YI3Ng8+ZVomByK6VtS5pDVUXFVyRFuNVKXd5CbYV60X5g0mGS76qtBFj6D+YS6wIs
         im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207184; x=1706811984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyuZ0gVdBuvlPmtjlhSz8uJtD77t/nVDJ3cBvemqEj0=;
        b=ikVmlAyMAFuq1hAGk3qt/7uTzOW0xHZzCps5bFrNg2wxjHp8w3K2H8CT00HoShFHzj
         1c0EcqNSWRtJVRRMN+V/LcZy4vcNofpm46NMM0bAtQD8kfIrdF/OCUpa8+nG0HIJoBmT
         XhZurE3+DB+mwbhGEhE9ACbsO7yyG+pisJII+3nrRpVwuWp0S/hv/l4OhIs7SyHC5H1Z
         /m/tFFUz4wyppMkXP4kLSRf6j9fQP5sqmPipdCH8vrRgVuOWsgjfNx0Lk2BZE4Y+Fl8w
         EtKElimfJxKgSwC6edduLg4n4mIPedW/18YPhFnk4EJ+Iq8PFW6zCCwUK0c01s4Oh1ar
         GKZA==
X-Gm-Message-State: AOJu0YxOEbq7abhz6O21KvNu1WjodMgspwFYnz9aPEaZzPi6j/dDM1OH
	osqm9uEDETdJ7K3Ob2zPTu1+RstP5Sk6JNH4kGQXmEaa7J8HT65vGPO+qdSk1nQ=
X-Google-Smtp-Source: AGHT+IFBV2oC78chsLzac9k77DXS5/WbnhoEAPatEDRZ6lhNeqqRGgEsUCPUu1zeHuG1e8R3Jwt8hg==
X-Received: by 2002:a05:6a20:1453:b0:199:ad49:ea79 with SMTP id a19-20020a056a20145300b00199ad49ea79mr78878pzi.63.1706207184482;
        Thu, 25 Jan 2024 10:26:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j38-20020a635526000000b005cf7c4bb938sm13685563pgb.94.2024.01.25.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:26:24 -0800 (PST)
Date: Thu, 25 Jan 2024 10:26:19 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, ruscur@russell.cc,
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
	zhangqing@loongson.cn, catalin.marinas@arm.com, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 05/28] riscv: zicfiss/zicfilp enumeration
Message-ID: <ZbKny7ZAG5FWHwwF@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-6-debug@rivosinc.com>
 <20240125-unscathed-coeditor-31f04e811489@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240125-unscathed-coeditor-31f04e811489@spud>

On Thu, Jan 25, 2024 at 05:59:24PM +0000, Conor Dooley wrote:
>Yo,
>
>Series is RFC, so not gonna review it in depth, just wanted to comment
>on this particular patch.
>
>On Wed, Jan 24, 2024 at 10:21:30PM -0800, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
>> stands for unprivleged integer spec extension for shadow stack and branch
>> tracking on indirect branches, respectively.
>>
>> This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
>> up bit in cpu feature bitmap. Furthermore this patch adds detection utility
>> functions to return whether shadow stack or landing pads are supported by
>> cpu.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h | 18 ++++++++++++++++++
>>  arch/riscv/include/asm/hwcap.h      |  2 ++
>>  arch/riscv/include/asm/processor.h  |  1 +
>>  arch/riscv/kernel/cpufeature.c      |  2 ++
>>  4 files changed, 23 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index a418c3112cd6..216190731c55 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -133,4 +133,22 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>>  }
>>
>> +static inline bool cpu_supports_shadow_stack(void)
>> +{
>> +#ifdef CONFIG_RISCV_USER_CFI
>
>In passing, I don't see any reason for not using IS_ENABLED() here.

No reason. I should probably do that. More readable.
Thanks.

>
>> +	return riscv_isa_extension_available(NULL, ZICFISS);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static inline bool cpu_supports_indirect_br_lp_instr(void)
>> +{
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	return riscv_isa_extension_available(NULL, ZICFILP);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>  #endif
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index 06d30526ef3b..918165cfb4fa 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -57,6 +57,8 @@
>>  #define RISCV_ISA_EXT_ZIHPM		42
>>  #define RISCV_ISA_EXT_SMSTATEEN		43
>>  #define RISCV_ISA_EXT_ZICOND		44
>> +#define RISCV_ISA_EXT_ZICFISS	45
>> +#define RISCV_ISA_EXT_ZICFILP	46
>>
>>  #define RISCV_ISA_EXT_MAX		64
>>
>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> index f19f861cda54..ee2f51787ff8 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -13,6 +13,7 @@
>>  #include <vdso/processor.h>
>>
>>  #include <asm/ptrace.h>
>> +#include <asm/hwcap.h>
>>
>>  #ifdef CONFIG_64BIT
>>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 98623393fd1f..16624bc9a46b 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -185,6 +185,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>> +	__RISCV_ISA_EXT_DATA(zicfiss, RISCV_ISA_EXT_ZICFISS),
>> +	__RISCV_ISA_EXT_DATA(zicfilp, RISCV_ISA_EXT_ZICFILP),
>
>Anything you add to this array, you need to document in a dt-binding.

You mean Documentation/devicetree/bindings/riscv/extensions.yaml
(or possibly any other yaml if needed?)

>Also, you added these in the wrong place. There's a massive comment
>before the array describing the order entries must be in, please take a
>look.

I see the comment.
In my defense, looks like I missed it when I was rebasing.

Will fix it.

>
>Thanks,
>Conor.
>
>
>>  };
>>
>>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv



