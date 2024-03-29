Return-Path: <linux-arch+bounces-3307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A4891312
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 06:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27652880F1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF73B185;
	Fri, 29 Mar 2024 05:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D57deTiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dx0EnWoZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8033B298;
	Fri, 29 Mar 2024 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688996; cv=none; b=b821XIEZL1UrNvy4ZprsEuJVW4yGFr050u1P7Y8C1Yotz+V+f9qHDf5GzhT1Cvc/R72hVakpcTMyIUj3SIKVp5RgkjbSlCRLVWFCzePBPBy0SmrLppTkkaqcYRgOaqY6Zo5AZ0OE+TpWzlEqx8T4SPUr3tJvQE1RyiHasl9x6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688996; c=relaxed/simple;
	bh=F89jqTE8kynG1Uz9mIsGrS6EtRpxfFfvAHY5kLrYFvE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JLrxnU1BpFTXDAyZpAZ0wOzg8GufWTGPdRCvaHAsesTpWgg22v8w5okER5h88y3FpqCOxa6dTM8HTxGVso7z/E6UwEWnmA1oF0ut4iCOjFQiNwDYf+rY/0oHjVhCVTE6FygTggFvVKQjdoDgROA1f8vauPlS3pvaQRpH33lB/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D57deTiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dx0EnWoZ; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 5684E200401;
	Fri, 29 Mar 2024 01:09:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 29 Mar 2024 01:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711688993; x=1711696193; bh=W43fkf1B1Z
	n+9lZ0QAk0C2vy62l6S5S5PZF98K77Zsk=; b=D57deTiv3kPkh4S6TPaHl6y8IE
	aPyCnh9jL6Dgq2l+DIeKhmF6dkO220TK1L/d6RwblDCqSC6mwWHzhmyZuvr7YYSV
	AzrlX3gJiw/RzCUfZ+5HmZJmJXTocl7CDZGOq4taeeAz/Z8ezaM7BaSpQPB/rZ48
	QFTAvfSNCu+7M3lb3xiLCreORf5pYJj+INeP3Ve7AyoIPJ00BeScF6bLLEUcAXSv
	KtnWDWuUAH7OvfCi1Jj8CpYSvgT6oZq3uWPv0jMpYMSFBDAv9ntlr6DNzU5lq1iK
	VWZCITz09tR3meh2AOo22um/Z1qVALwF0/bp0ebWh8Hwt74NKQPnHls1F75w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711688993; x=1711696193; bh=W43fkf1B1Zn+9lZ0QAk0C2vy62l6
	S5S5PZF98K77Zsk=; b=dx0EnWoZC4wLY2jxQnf35r4uxwLKes4LQcek6hOEmYBf
	ha1OzzK3Tu1tXA/tuFrvf8uCM1rUtWOcpPci2igbAvJ49BiJOT5kIoKXWvsf/tSG
	UMUolriebfkMcpTwBGSaIbgsa5uMry6PTW2RNdrsAza/DoyZOQfCvePurgmwG1fE
	BCUvx8tC/aZuj7e+SAmE9vOIoEsY+A35lC6csanoPa04s0X94KqDLdLfRUplknTc
	9y1uFrYzamLL/pjB0hxNjCcD9f/dhJVPVdHflt5/JIUIE7oLXRBc+tTj9fEauBN1
	jLYMhUEvYa+Sp3SU3fWnR0FO8QNTajWvvt3oPWuJHw==
X-ME-Sender: <xms:H00GZvO0YQEHBvJTSpazf5AjdnE6rCHVPYYSTX6V_VavUmWZ3FGGJw>
    <xme:H00GZp95JjHeLd0W3WLA2dNbgObxHFsEvOufPGQebsvPKRi2A6_7tlBDxWVCN8qjI
    SlVObH8ZKXi5bboVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvtddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:H00GZuT6mnZg6PZNm3YMxPlOjpOdvnu7_Le2EpJ3RKyiwsRo_DHjHw>
    <xmx:H00GZjsXeQTiYYW_-PKbOnBivAr4rahFEt_tvGACTKWbQnro6rNklw>
    <xmx:H00GZneqFYMzWWemdQACIyQaS2sLYkYHsyCjTkFQbcmtpAgco6Pgnw>
    <xmx:H00GZv0a-x8A36YqfhnFQaeYVQDGiLw3JwoWz0H4ZuXRYt3lFktUMg>
    <xmx:IU0GZkOKnyyJltYWiMrDBcB4edL6fcBFOSlpNaNAtTGbD5dytBxouKyTC5Q>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D6E11700093; Fri, 29 Mar 2024 01:09:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7b0aea6-c03b-4e8b-872a-8f0299ed6467@app.fastmail.com>
In-Reply-To: <20240329044459.3990638-5-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
 <20240329044459.3990638-5-debug@rivosinc.com>
Date: Fri, 29 Mar 2024 01:08:12 -0400
From: "Stefan O'Rear" <sorear@fastmail.com>
To: debug <debug@rivosinc.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Mark Brown" <broonie@kernel.org>, "Szabolcs Nagy" <Szabolcs.Nagy@arm.com>,
 "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Andrew Jones" <ajones@ventanamicro.com>,
 "Conor Dooley" <conor.dooley@microchip.com>,
 =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Atish Patra" <atishp@atishpatra.org>, "Alexandre Ghiti" <alex@ghiti.fr>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Samuel Holland" <samuel.holland@sifive.com>, palmer@sifive.com,
 "Conor Dooley" <conor@kernel.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: "Jonathan Corbet" <corbet@lwn.net>, tech-j-ext@lists.risc-v.org,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 oleg@redhat.com, "Andrew Morton" <akpm@linux-foundation.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Liam.Howlett@oracle.com,
 vbabka@suse.cz, lstoakes@gmail.com, shuah@kernel.org,
 "Christian Brauner" <brauner@kernel.org>,
 "Andy Chiu" <andy.chiu@sifive.com>, jerry.shih@sifive.com,
 hankuan.chen@sifive.com, greentime.hu@sifive.com,
 "Evan Green" <evan@rivosinc.com>, "Xiao Wang" <xiao.w.wang@intel.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, "Samuel Ortiz" <sameo@rivosinc.com>,
 shikemeng@huaweicloud.com, willy@infradead.org,
 "Vincent Chen" <vincent.chen@sifive.com>, guoren <guoren@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, songshuaishuai@tinylab.org,
 "Greg Ungerer" <gerg@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>,
 "Baoquan He" <bhe@redhat.com>,
 "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
 "Yangyu Chen" <cyy@cyyself.name>, maskray@google.com,
 ancientmodern4@gmail.com, mathis.salmen@matsal.de,
 "yunhui cui" <cuiyunhui@bytedance.com>, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il,
 "Alejandro Colomar" <alx@kernel.org>,
 "David Hildenbrand" <david@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, revest@chromium.org,
 josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de,
 omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com
Subject: Re: [PATCH v2 04/27] riscv: zicfiss/zicfilp enumeration
Content-Type: text/plain

On Fri, Mar 29, 2024, at 12:44 AM, Deepak Gupta wrote:
> Adds description in dt-bindings (extensions.yaml)
>
> This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
> stands for unprivleged integer spec extension for shadow stack and branch
> tracking on indirect branches, respectively.
>
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
> up bit in cpu feature bitmap. Furthermore this patch adds detection utility
> functions to return whether shadow stack or landing pads are supported by
> cpu.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml       | 10 ++++++++++
>  arch/riscv/include/asm/cpufeature.h                 | 13 +++++++++++++
>  arch/riscv/include/asm/hwcap.h                      |  2 ++
>  arch/riscv/include/asm/processor.h                  |  1 +
>  arch/riscv/kernel/cpufeature.c                      |  2 ++
>  5 files changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml 
> b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 63d81dc895e5..f8d78bf7400b 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -317,6 +317,16 @@ properties:
>              The standard Zicboz extension for cache-block zeroing as 
> ratified
>              in commit 3dd606f ("Create cmobase-v1.0.pdf") of 
> riscv-CMOs.
> 
> +        - const: zicfilp
> +          description:
> +            The standard Zicfilp extension for enforcing forward edge 
> control-flow
> +            integrity as ratified in commit 0036ff2 of riscv-cfi.
> +
> +        - const: zicfiss
> +          description:
> +            The standard Zicfiss extension for enforcing backward edge 
> control-flow
> +            integrity as ratified in commit 0036ff2 of riscv-cfi.
> +

Neither of these extensions is currently ratified (the public review
period started 15 hours ago) and the git hashes are unlikely to be
correct for the ratified version.

-s

>          - const: zicntr
>            description:
>              The standard Zicntr extension for base counters and 
> timers, as
> diff --git a/arch/riscv/include/asm/cpufeature.h 
> b/arch/riscv/include/asm/cpufeature.h
> index 0bd11862b760..f0fb8d8ae273 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -8,6 +8,7 @@
> 
>  #include <linux/bitmap.h>
>  #include <linux/jump_label.h>
> +#include <linux/smp.h>
>  #include <asm/hwcap.h>
>  #include <asm/alternative-macros.h>
>  #include <asm/errno.h>
> @@ -137,4 +138,16 @@ static __always_inline bool 
> riscv_cpu_has_extension_unlikely(int cpu, const unsi
> 
>  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> 
> +static inline bool cpu_supports_shadow_stack(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		    riscv_cpu_has_extension_unlikely(smp_processor_id(), 
> RISCV_ISA_EXT_ZICFISS));
> +}
> +
> +static inline bool cpu_supports_indirect_br_lp_instr(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		    riscv_cpu_has_extension_unlikely(smp_processor_id(), 
> RISCV_ISA_EXT_ZICFILP));
> +}
> +
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h 
> b/arch/riscv/include/asm/hwcap.h
> index 1f2d2599c655..74b6c727f545 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -80,6 +80,8 @@
>  #define RISCV_ISA_EXT_ZFA		71
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
> +#define RISCV_ISA_EXT_ZICFILP	74
> +#define RISCV_ISA_EXT_ZICFISS	75
> 
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> 
> diff --git a/arch/riscv/include/asm/processor.h 
> b/arch/riscv/include/asm/processor.h
> index a8509cc31ab2..6c5b3d928b12 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,7 @@
>  #include <vdso/processor.h>
> 
>  #include <asm/ptrace.h>
> +#include <asm/hwcap.h>
> 
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> diff --git a/arch/riscv/kernel/cpufeature.c 
> b/arch/riscv/kernel/cpufeature.c
> index 79a5a35fab96..d052cad5b82f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -263,6 +263,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>  	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, 
> riscv_xlinuxenvcfg_exts),
>  	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, 
> riscv_xlinuxenvcfg_exts),
> +	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, 
> riscv_xlinuxenvcfg_exts),
> +	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, 
> riscv_xlinuxenvcfg_exts),
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> -- 
> 2.43.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

