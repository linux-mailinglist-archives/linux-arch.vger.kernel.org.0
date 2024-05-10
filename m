Return-Path: <linux-arch+bounces-4322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46C8C2D96
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8763FB225B1
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F014F1F2;
	Fri, 10 May 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EbCzuplo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C213D250
	for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383769; cv=none; b=STQexZIsWUCWKIQzYldTQIx7GXfInpVmQE0KPNG8itMlTz2D5/2NQPaYhmvV/VpF3CRYblt/wUrf4JfkPQ68csOMxOS711CR/ZKguKEq7jHuWlxfRdCWUvC39w/F87ssaBgMP5zpzW9x2etMsXjdgfE30Z3TB8NArEBHTKpnuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383769; c=relaxed/simple;
	bh=E7rGfOrSF7E1TwZm/9Gxf/skroZH98+3oQO8OhUUcys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejiC5yUF50qNt+yzkYJSYVAdLhgLySfbMb8RcLWaPN4OiHkFy8bs6lPtlfh4DDKmdUPZBNaAoV7l9lo23hJJ3vE1eMaYnha2x7q+XHoThTcoHkXqAj9F9Q1Fub+4xzTXpiLBWP/E/1UrN4dG9xHwh0kmRSYn0GImGsTgShp1jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EbCzuplo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1734994a12.0
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715383766; x=1715988566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vz2Ea5vDvTd7NZaHdWli7Zi0tzSRPfvayQLC9Zmwn4=;
        b=EbCzuplog0nF/scl4+UlUuXFz8FMPe7kOvGXwd7NSGzg9JQy9PCPmqu15fmq4TQ51J
         Xfi1B54r6TUcp1gjUEwQYO1UCshtOlmN7Rcll5DC7zbh/hzZ94I4SffWvQgfpgOLuHfx
         W2sKNymOy8QiAw1r+o0CmhToS69kQ05XN4c8Q4BWdt1aJrWtoQ25tgyc4w2qWV13AXCv
         ScO3SH1NR63S7CIW85S0F9MD7GN/pdhPAF+x8A5k7VFIwQ72/z1DlmxJGeUSbG0KwJUG
         x3xHZWp944i5nwvaoTkSb1CG9M7INu9RHrCSgfAZ2ADw1SwsmB2hfJ43pfbOKBRf6TlZ
         bYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383766; x=1715988566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vz2Ea5vDvTd7NZaHdWli7Zi0tzSRPfvayQLC9Zmwn4=;
        b=elQldlXGSmpcklVpBudzmt9aqkW4cWz7pAZm7riHeWxZ51OO+V+L0iO1xiQUBjNJxp
         Bo/foLF5mYHF7GlyMunNnYAOsV6ebtki/ml3mTkdSFVHIvlBU/OKN7IucrpVDpjUJkJk
         Sl+Bv3f89uD91I/db8MwPJeyGdsaS+ZO/+g2hOx86jhinv9BFsmV5xPpts8BBkHhQtY+
         qlf/EnD1TFKiWXE/0KsRXFG6zw+5gOvd0K9ocu7+3YmT5aqAdt9su9rRI7NByFQt7QqL
         vPUCTf3Vd/tAvAYJ0vt1H5udzTCnzJplRmwS/ejgGP0Z7zB0DkORwUoEL1Q760WGM1GE
         BnMg==
X-Forwarded-Encrypted: i=1; AJvYcCUhU9CSkudH3O/vtMXExxfii5jAjBriYhg9KbHX4h/LOYoAUTTH+2pq9CEm1vMU3HbV8mIYsziOBbqUL2CdXwVSx5qBxloOBcjsVA==
X-Gm-Message-State: AOJu0YxQ4NG/WQCrJ4BzUlY8NEMme/OZv/7nphyILXz4er1OpJsU0zMh
	fifHj8FWqHgjTFvDj1iEMhmrOTst3Cj3L9QrAMqGYPUtSTNAYZq/19BD8myv0pE=
X-Google-Smtp-Source: AGHT+IFtRGEgJNgaXpQi4rnaLmSdVV1xvKctjw8cDKjjnX0+o8uhHRNsHVhKbF+1oYccjQdTEuSLLg==
X-Received: by 2002:a05:6a20:96d5:b0:1af:5d8b:87f3 with SMTP id adf61e73a8af0-1afde0d5537mr4236824637.23.1715383765853;
        Fri, 10 May 2024 16:29:25 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c3b4sm3755016a91.45.2024.05.10.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 16:29:25 -0700 (PDT)
Date: Fri, 10 May 2024 16:29:19 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
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
Subject: Re: [PATCH v3 17/29] prctl: arch-agnostic prctl for indirect branch
 tracking
Message-ID: <Zj6tzxWFj4H+250p@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-18-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-18-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:35:05PM -0700, Deepak Gupta wrote:
> Three architectures (x86, aarch64, riscv) have support for indirect branch
> tracking feature in a very similar fashion. On a very high level, indirect
> branch tracking is a CPU feature where CPU tracks branches which uses
> memory operand to perform control transfer in program. As part of this
> tracking on indirect branches, CPU goes in a state where it expects a
> landing pad instr on target and if not found then CPU raises some fault
> (architecture dependent)
> 
> x86 landing pad instr - `ENDBRANCH`
> aarch64 landing pad instr - `BTI`
> riscv landing instr - `lpad`
> 
> Given that three major arches have support for indirect branch tracking,
> This patch makes `prctl` for indirect branch tracking arch agnostic.
> 
> To allow userspace to enable this feature for itself, following prtcls are
> defined:
>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>    branch tracking.
>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>    tracking.
>    Following status options are allowed
>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>          thread.
>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>          thread.
>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>    tracking for user thread.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
>  kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 3c66ed8f46d8..b7a8212a068e 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -328,4 +328,31 @@ struct prctl_mm_map {
>   */
>  #define PR_LOCK_SHADOW_STACK_STATUS      73
>  
> +/*
> + * Get the current indirect branch tracking configuration for the current
> + * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
> + */
> +#define PR_GET_INDIR_BR_LP_STATUS      74
> +
> +/*
> + * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
> + * enable cpu feature for user thread, to track all indirect branches and ensure
> + * they land on arch defined landing pad instruction.
> + * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
> + * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
> + * riscv - If enabled, an indirect branch must land on `lpad` instruction.
> + * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
> + * branches will no more be tracked by cpu to land on arch defined landing pad
> + * instruction.
> + */
> +#define PR_SET_INDIR_BR_LP_STATUS      75
> +# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
> +
> +/*
> + * Prevent further changes to the specified indirect branch tracking
> + * configuration.  All bits may be locked via this call, including
> + * undefined bits.
> + */
> +#define PR_LOCK_INDIR_BR_LP_STATUS      76
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 242e9f147791..c770060c3f06 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2330,6 +2330,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
>  	return -EINVAL;
>  }
>  
> +int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
> +{
> +	return -EINVAL;
> +}
> +
> +int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
> +{
> +	return -EINVAL;
> +}
> +
> +int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
> +{
> +	return -EINVAL;
> +}
> +

These weak references each cause a warning:

kernel/sys.c:2333:12: warning: no previous prototype for 'arch_get_indir_br_lp_status' [-Wmissing-prototypes]
 2333 | int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/sys.c:2338:12: warning: no previous prototype for 'arch_set_indir_br_lp_status' [-Wmissing-prototypes]
 2338 | int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/sys.c:2343:12: warning: no previous prototype for 'arch_lock_indir_br_lp_status' [-Wmissing-prototypes]
 2343 | int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)

Can the definitions be added to include/linux/mm.h alongside the
*_shadow_stack_status() definitions?

- Charlie

>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>  
>  #ifdef CONFIG_ANON_VMA_NAME
> @@ -2787,6 +2802,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = arch_lock_shadow_stack_status(me, arg2);
>  		break;
> +	case PR_GET_INDIR_BR_LP_STATUS:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
> +		break;
> +	case PR_SET_INDIR_BR_LP_STATUS:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_set_indir_br_lp_status(me, (unsigned long __user *) arg2);
> +		break;
> +	case PR_LOCK_INDIR_BR_LP_STATUS:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_lock_indir_br_lp_status(me, (unsigned long __user *) arg2);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> -- 
> 2.43.2
> 

