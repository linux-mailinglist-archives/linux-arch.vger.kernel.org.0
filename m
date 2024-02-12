Return-Path: <linux-arch+bounces-2180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3FA8510A6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ACA280FA1
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A418030;
	Mon, 12 Feb 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lcKaCn4O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2D17C74
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733437; cv=none; b=ATu5OsAF+kuIO8kwDI6yUFLHmhQitGQaTFsycJ2FbxlYaXre0FUduxnYG2jBbv1hWFetGg8DscPxzUYvQ4KltbCeGfpoEwETOcaXOiaBgHNo7FNVL9B8ZiZZ0Xhvaz8fyYtMkpp3FNNe6JruM9i1Dvyzs7EbEv816chpStJjStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733437; c=relaxed/simple;
	bh=TLWj/r7Pgt5h2SbwNEGy7ntlN2xmuVp2ucImosJuV3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgu4ph8f2VrGo+cBSbpzfYUu+LV0+Soh7obwKptGWc1K3E6nd/HzL77jONAg6Igsiuilm+u9egw5BzPQq9Sa3DMIJZ8d2nFZANEen21rfdLkeaS4WrRN+j5IEEPdYBhTWz9hl5n5FJ2ERYTfL57UDElyoayoP97bPP1BJM/gBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lcKaCn4O; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a34c5ca2537so368846466b.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707733434; x=1708338234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=er7uqV/3pxqI9E15uDGZ9iWhLJcFGSi+T2B/hFaMbBg=;
        b=lcKaCn4O8jWvmQj4JVY2b3Hu8aDVbmgdz2MSKl3Gjad+fU4f4dik8oxq9eDiS+drGl
         IjnyN318J4XOb1A1odLv62vyT/9YQR+VKcjQf+iI5YfGKGVq5MN02f5JMRnUVROj+ci+
         bgN6ua1ifcd/6Xn2Cq3+expZKP7zP+BLuY3vmbwELmnICmFKL/TIImS6Y1Hxv7f/z8Xm
         ogdt9pzj4EtkGrvtpwPOUXbxRPoezbAyZUlCuRGBfevvUbQZ4SGChvBUsrPg+3HsQK0a
         R9Wo59Amv+y1NlFIeZZZHE9ocdY6qyuHG9QFjEZGS1YHvVA9YuCliQYtyVExkaKTnP0I
         JU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733434; x=1708338234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er7uqV/3pxqI9E15uDGZ9iWhLJcFGSi+T2B/hFaMbBg=;
        b=XBlsCC31d05sJZbciD4XLdnwDXZnd7MedWQDHJWmZCHTXm8Dg+WXKZjqoSd0N2XRhd
         Z9F2qfmYQb7am/cJlnCm3jWARmAum78yvH1jj8lVTzGEtaBKEIz1nu7kqoW7KSsrc1+O
         tx3w8bSwIiL821Y+h5yKpd419IOfUmOd2p7nyImtDqqPQlLrK24gOKR/LQaUscGiDNIp
         4qWMcpWj9B8TNLQmOwvgQ9Vx2N6HmfyLepOiOPpv27sHReygvR5Hk6LRal+kc1iFbQTA
         4tm6iDryuDvrJ5He7rE7ua/wv125jTggo27o3fv4oEIoxcCneyAgGD6SqiN4LCETAAl8
         jjSg==
X-Gm-Message-State: AOJu0YxqjSYeh2mflptwoCGM+mKT5iZUo06oWIATWgdRXmTVOJ+klv2c
	9wZHTyO4o/mAwK5T77LDa7YjvCOIUVCWMBhGnP6hnnV/I6/quCb9lc2kwW8utfI=
X-Google-Smtp-Source: AGHT+IEIVVAUpTpqdBT16MY7gnKOm8Wgm8lU/UhtOte8u9qNN7LVPAHblq+h85cUkD6/Ed6GGvCddQ==
X-Received: by 2002:a17:906:a88b:b0:a3c:cebc:9e0e with SMTP id ha11-20020a170906a88b00b00a3ccebc9e0emr567479ejb.66.1707733433939;
        Mon, 12 Feb 2024 02:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPAzE+xdeF9TrZSKLD2pHEr88oRydbkgxmrvinHSvSQxUcUIyGSd4eufO2JDcBJ7dp7k0omkE0TZm5KqaV2RSmopwEH9KJUBeAuNEnCQZp/Na3kZyhqGhtsPoWUFMQWLjH8g1/XK5jmvnK3onAoGGYAjWJYmG20MsKxc8Yn9hXfF2DIBZZzGU6LHBehpCvPsVjofyX2DVddSWuIv/g8ypG3DrQoeVz4cIaOtpF0w2aQFPxniQSHtJKifQoI36QcqUz+GTeRa25cUcHcaFSIQmeIhQc0JSMEzlS4c0IEEQuh4BCexsaE+Q2RkgtWWZhpOa/zFS9tiBq7NOlJoD7GObmq5y2nTJbzou3e8N/JqJSg+NdzdwTTJUpVKPs29VIz44lxoHm6/kZeP4Smk1W08JaOjCzXRt8PuEeZ/ZindEfAW3sw5G8/+7SeMUmw0s+pjY5aq6PL8Es9QTI+gFjyh5aBJdPU11Mw/b8r+ggEfN9EqNFco+lICueODov2KMWeF9NjaBVj7iuEimn1MzGt8h09gt++g3M+hv8cjkxyNnKs568+BR8yc2MOxQQfPS10utFK8+zFVEhGgYzQdUVImLwxe37lmPhh60wZlbX9IzH8qQrJ6pXMKqI7ua/HuD+egoIQG7OQAblqLWyAAYzgzeBywNTlp4Txdjmklview3xwwTap1D5fOGoJcX3j6hu48qZsuyeGsyC9nsBmohNR1DagrdFR+BQPMd8gUJY++R62GwIzRAH4E9fbyPamjyvb3f65wE2mOTSc9FZUoRQcF639WAouaosGVNVx1Lb+cyBEU6FitjgZXDhOSgLIEDineFX73GZcKSrIBtz4oK2eq7mAoQvQNaGVZKmYrzVDunSfj481sy1kH7T62OUcjxcEqkvFA6AoU8syAnrTA/2MrCiJ2cTSBnstrRgHXEzdtHuRyNWjIHVyXNF4EoXfIjpHWpKwC
 eFJ5J+101mb/s4Q/1cmQ4Wz11QZhp5DbbKlvzcjLsFg2m3gpryp3twJqX5TrxCAcFt/wAV3BkzPRN88+roOQEXkWbekKlM46Y71IoxRtiUkdHJN5WqFsqlTyD5KyCw2GGJTw3SH6T/MmHAr+oOwvKSIc3aC0hV24YWulCM2OsuRuhclbmlzyt6Y2JJxxnVKaEqRxDeMNsLrGMeiDbuUhtua8pSpKm3dNm1G1WDslPC35cV5XDKSWmKAb1/M2wkuq5SETC7B1gv6XnzZnlR1wQSLix+8+kin8J6JO3gm3X+McNhBRLrxx2loxFJMo2c/xjh7wF3wDssyxKjHX5A+5fcuPqv50ODa5GDub27T0Uc32g162GnVdCC+VeowGyq11KgvugkpIVtk10/sJDfMFGpZuviKTl3msRZRr3qrlPR4dQveuCxGTOo6Oyav0FytnJtGp3LnLOhGFP3ew0jwPCoPc6cw6K+VeKW8qiwGLv/Zb8bgVl3bujL9JS6Qo/52tJiC0ZuLRKF0FHpPoBy/q+YQhTYHMl18uxLehORfxoVvopoQWyWBYfdFhJ6Zw4rz8Q3MZWMxMDQ3CncpPaKx2ctow9uTjN8qQgbOhE/nRr55TRTZYeL2J9umD0EbRUOAPfKrtRYeRcln+faWGY1RFXS0SkOu8ul3zt4sehJkmrrwdGMZP7KTM7JcjoVtmgaa5ny3FdpkRXFN6TbIN0bGzTgwdO8Q47IPyS1xFnDgY3d3inqjDrNKZ+ApxxPH0VXmkBGBMUz3yomR0ChsvRgC5CMHBStwF4uSxPqonHfDFzPjINLbSkuK5J1iq1mGTAGg/z4AFlUd/6W2ARQswjf42gEBah0qBZ/jxD0NzH+A1BvfORnnJDXSaxlJzogY3Yqw7ulEjTbff7wBfEAQd1+H23TSbMHcfcEg8bJq1L8w8lzRqmE3x5zY1gHR9uI3y8tKtTr166Quq7EosM5SUUfT9LoO3vcs6beCXmhNk7
 vesJ1Ft9sE1alaQEh
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id cd6-20020a170906b34600b00a34c07816e3sm61419ejb.73.2024.02.12.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:23:53 -0800 (PST)
Date: Mon, 12 Feb 2024 11:23:52 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: debug@rivosinc.com
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com, 
	kito.cheng@sifive.com, keescook@chromium.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, alexghiti@rivosinc.com, 
	corbet@lwn.net, aou@eecs.berkeley.edu, oleg@redhat.com, 
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, shuah@kernel.org, 
	brauner@kernel.org, guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com, 
	xiao.w.wang@intel.com, apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	waylingii@gmail.com, greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org, 
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com, 
	panqinglin2020@iscas.ac.cn, willy@infradead.org, vincent.chen@sifive.com, 
	andy.chiu@sifive.com, gerg@kernel.org, jeeheng.sia@starfivetech.com, 
	mason.huo@starfivetech.com, ancientmodern4@gmail.com, mathis.salmen@matsal.de, 
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com, ruscur@russell.cc, 
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il, zhangqing@loongson.cn, 
	catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com, 
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/28] riscv: abstract envcfg CSR
Message-ID: <20240212-cf2c44241bfd5e942a4e3752@orel>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-2-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125062739.1339782-2-debug@rivosinc.com>

On Wed, Jan 24, 2024 at 10:21:26PM -0800, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> This patch abstracts envcfg CSR in kernel (as is done for other homonyn
> CSRs). CSR_ENVCFG is used as alias for CSR_SENVCFG or CSR_MENVCFG depending
> on how kernel is compiled.
> 
> Additionally it changes CBZE enabling to start using CSR_ENVCFG instead of
> CSR_SENVCFG.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h   | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 306a19a5509c..b3400517b0a9 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -415,6 +415,7 @@
>  # define CSR_STATUS	CSR_MSTATUS
>  # define CSR_IE		CSR_MIE
>  # define CSR_TVEC	CSR_MTVEC
> +# define CSR_ENVCFG CSR_MENVCFG
>  # define CSR_SCRATCH	CSR_MSCRATCH
>  # define CSR_EPC	CSR_MEPC
>  # define CSR_CAUSE	CSR_MCAUSE
> @@ -439,6 +440,7 @@
>  # define CSR_STATUS	CSR_SSTATUS
>  # define CSR_IE		CSR_SIE
>  # define CSR_TVEC	CSR_STVEC
> +# define CSR_ENVCFG CSR_SENVCFG
>  # define CSR_SCRATCH	CSR_SSCRATCH
>  # define CSR_EPC	CSR_SEPC
>  # define CSR_CAUSE	CSR_SCAUSE
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b3785ffc1570..98623393fd1f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -725,7 +725,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>  void riscv_user_isa_enable(void)
>  {
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> -		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
> +		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

