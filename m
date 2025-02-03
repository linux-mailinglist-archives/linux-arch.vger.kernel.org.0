Return-Path: <linux-arch+bounces-9977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2080A265B7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AF51884E95
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6311FE478;
	Mon,  3 Feb 2025 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGRgTysc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB031A31;
	Mon,  3 Feb 2025 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618433; cv=none; b=jTGz55vjhi7XKxKnGS+F7eYq510q41+R2jo66dE1im/0d/vJqQoCX0UEZinB1pW8FH9z6N3N8DpY18R2izlqsZLtPOy8IL3gstzZSFcYAMJAcVpkax61lugIhbMWJtVLv7RdiyP/SGZLB/A9tGpX1A9q6NDscW2NrmhNYt2l1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618433; c=relaxed/simple;
	bh=1mlaWCTrBrjSa0L+d8pSQwcBOgfwLLhUqX/gRxJbXYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7GhWa28yj8LI010+982hF8sHGKqkZtZadwsBr2ny9Uq2qGIw2n4VbSkHdaR8+gg+N2xvtFznHZLzqk+HZu/RM0y98u5NxZIqQMdi/GRDgrenJzPN8fI3OyJB9P44Cc0mYcAJE9CT9xupKq/0wJQiAC9cIxJife5NkEYQCLsDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGRgTysc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso35034075e9.1;
        Mon, 03 Feb 2025 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738618430; x=1739223230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrVMD2Z2i/6S/QLajy8AAiCtXVC5nD5sHVdo7QcfCdY=;
        b=MGRgTyscMpcmoK6u3zkKQgZ+FmPV58t26jeNA/Hh40oy6R5lbr7uzCd6mxPaAXKGwm
         gb5X48ymvaK2DBwhG4ZLkj9iwxjet2okBGNA+LOg+M0rPINTb0dyiO1hfyXtI4Iv2eW2
         zTWp3fB0+uCQcUQ7PrDqYgMWEA8hGeQeNmnU71VJdi77+Yc3vevaZ0ojxCspt4malqxj
         iUylOg4A4hradq4j4iHm+0L9iK8qXUarkLFo8HsyGdh/mhMjX+JubWkxbnu68iU0J5bG
         Nsv1m2CxMs2JI5FVcyO5oC3TKlN+0YtWI5F+XdPa7PttG7Qyelpbm0G+jOFBQo2uFtc6
         Ui4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738618430; x=1739223230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrVMD2Z2i/6S/QLajy8AAiCtXVC5nD5sHVdo7QcfCdY=;
        b=oFv7enib4xs3fpHu2Kxjs+Vp0sD3TkoCW8QYzpJJ/0yZn+4MEoouysvKgaDDb4V2T+
         ptu8GWxFS5gDflCozP69CRAIzgOsAzT268lOm2a/nXeijwGl/PtUvaMX7kcrhp2avkW1
         3xzjxMW7VhWuFT/G/Aq0NUYz7J4nFGmELcEyMfhnj+zccJmLPBVNQ3kARaKxIVWVwhXl
         WeULwNKgXsZi4kyI6dui6MyZZ3fOWQSFVDVDNQgETv0pAkOgr1iaGS+mA4i6Y2jW/DxF
         1b/10+7xmhlPYOsUvicB2uSjQY7PFdKFpwKyNp01jKUawIW6QhgMZU1Wj0Exr92GY1q5
         0LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOtmsB1OVnOB2xQeKWML/rsrORZEOsD4fhl3LmjiolTgq46Rr3nFpWP8SR2W2b/v86mykCxPhclHaSEWuV@vger.kernel.org, AJvYcCUXotuVTkaS4fmzuYfa7D0xOFksq7Jxzm3ZfdSdImZ4R9qk2flSogd9Crr46mIiQXm854Y=@vger.kernel.org, AJvYcCWfwwf84pDCmBPyKf4tw2BJYhQCMy8tUmBf6nlL+nGZENgYG+1vqwFuqz7A7ar2MttB3srtsVsMOBRSHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJoY9h5JEw2XGypymwsoLvbBAxJWN3jXFXWwZRCV/meSmwgvM
	AcVPgdFjlhRGCPqylGdk7QHOSBhjQdr0QqOn+vch5FfWkHBBLnAh
X-Gm-Gg: ASbGncvHNVdyOSOfkpyyjjVQOxJCUWZz9DQQtN8NJr0lkOPfHolkI9iLQzkCO3q2Q3C
	pYz3ZYPKZZ5BCS6G2Vy6qEgtd4ujqDEMTDZGMOfI6roPBP/eyh9Zwr+wa8mQa7Qq8NMK0K7Ugs5
	wh1LJDHZBIgxExU+7ANB/lLpK1c3tSk2FY+Ypy6fg2Dyu1Tt+kkNFN/nfvi1GqigncmYydnzA90
	L1hfuZGZYRAspwi42/y/ykviegFcObzTLvIXuZKGskOlDMYrT7CbJwgPWS2Z680kpyADmjM/w1i
	vsrv0qkT8cEAmw2LOtZ+pzXAzfoMA17ipeBbUpWHyXd3t1AYqvYQmA==
X-Google-Smtp-Source: AGHT+IGSI4NMuXgo3YRTck+DTapndecyGzycBjJbvBcnwmDddI78Rk3ypPub97NycklrivXvcN7N3A==
X-Received: by 2002:a05:600c:4e52:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-438dc3fc2b0mr196556595e9.23.1738618429820;
        Mon, 03 Feb 2025 13:33:49 -0800 (PST)
Received: from ?IPV6:2001:861:73:f8d0:2866:6e4b:d20:c37c? ([2001:861:73:f8d0:2866:6e4b:d20:c37c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23e6181sm166240945e9.18.2025.02.03.13.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 13:33:49 -0800 (PST)
Message-ID: <a87f98bf-45b1-4ef5-aa77-02f7e61203f4@gmail.com>
Date: Mon, 3 Feb 2025 22:33:48 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v22 19/20] ftrace: Add ftrace_get_symaddr to convert
 fentry_ip to symaddr
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Florent Revest <revest@chromium.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
 <173519011487.391279.5450806886342723151.stgit@devnote2>
Content-Language: en-US
From: Gabriel de Perthuis <g2p.code@gmail.com>
In-Reply-To: <173519011487.391279.5450806886342723151.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I got errors building Linux 6.14-rc1 that were solved by reverting this 
patch and the one after (19/20 and 20/20).

Errors look like:

In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
                  from <stdin>:3:
./arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_get_symaddr':
./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of 
function 'get_kernel_nofault' [-Wimplicit-function-declaration]
    46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip 
- ENDBR_INSN_SIZE)))
       | ^~~~~~~~~~~~~~~~~~

Will send .config on request if needed.

Le 26/12/2024 à 06:15, Masami Hiramatsu (Google) a écrit :
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This introduces ftrace_get_symaddr() which tries to convert fentry_ip
> passed by ftrace or fgraph callback to symaddr without calling
> kallsyms API. It returns the symbol address or 0 if it fails to
> convert it.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412061423.K79V55Hd-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412061804.5VRzF14E-lkp@intel.com/
> ---
>   Changes in v21:
>    - On arm64, fix the macro name to ftrace_get_symaddr() correctly.
>    - Define ftrace_get_symaddr() outside of CONFIG_DYNAMIC_FTRACE.
>   Changes in v19:
>    - Newly added.
> ---
>   arch/arm64/include/asm/ftrace.h |    2 +
>   arch/arm64/kernel/ftrace.c      |   63 +++++++++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/ftrace.h   |   21 +++++++++++++
>   include/linux/ftrace.h          |   13 ++++++++
>   4 files changed, 99 insertions(+)
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 876e88ad4119..bfe3ce9df197 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -52,6 +52,8 @@ extern unsigned long ftrace_graph_call;
>   extern void return_to_handler(void);
>   
>   unsigned long ftrace_call_adjust(unsigned long addr);
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
> +#define ftrace_get_symaddr(fentry_ip) arch_ftrace_get_symaddr(fentry_ip)
>   
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
>   #define HAVE_ARCH_FTRACE_REGS
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 570c38be833c..d7c0d023dfe5 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -143,6 +143,69 @@ unsigned long ftrace_call_adjust(unsigned long addr)
>   	return addr;
>   }
>   
> +/* Convert fentry_ip to the symbol address without kallsyms */
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +	u32 insn;
> +
> +	/*
> +	 * When using patchable-function-entry without pre-function NOPS, ftrace
> +	 * entry is the address of the first NOP after the function entry point.
> +	 *
> +	 * The compiler has either generated:
> +	 *
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * Or:
> +	 *
> +	 * func-04:		BTI	C
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
> +	 * bytes in either case.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> +		return fentry_ip - AARCH64_INSN_SIZE;
> +
> +	/*
> +	 * When using patchable-function-entry with pre-function NOPs, BTI is
> +	 * a bit different.
> +	 *
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * Or:
> +	 *
> +	 * func+00:	func:	BTI	C
> +	 * func+04:		NOP		// To be patched to MOV X9, LR
> +	 * func+08:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * The fentry_ip is the address of `BL <caller>` which is at either
> +	 * `func + 4` or `func + 8` depends on whether there is a BTI.
> +	 */
> +
> +	/* If there is no BTI, the func address should be one instruction before. */
> +	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +		return fentry_ip - AARCH64_INSN_SIZE;
> +
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
> +		if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
> +			return 0;
> +	} else {
> +		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
> +	}
> +
> +	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
> +		return fentry_ip - AARCH64_INSN_SIZE * 2;
> +
> +	return fentry_ip - AARCH64_INSN_SIZE;
> +}
> +
>   /*
>    * Replace a single instruction, which may be a branch or NOP.
>    * If @validate == true, a replaced instruction is checked against 'old'.
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index cc92c99ef276..f9cb4d07df58 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -34,6 +34,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>   	return addr;
>   }
>   
> +static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	u32 instr;
> +
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> +			return fentry_ip;
> +	} else {
> +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> +	}
> +	if (is_endbr(instr))
> +		fentry_ip -= ENDBR_INSN_SIZE;
> +#endif
> +	return fentry_ip;
> +}
> +#define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
> +
>   #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>   
>   #include <linux/ftrace_regs.h>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 4c553fe9c026..07092dfb21a4 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -622,6 +622,19 @@ enum {
>   	FTRACE_MAY_SLEEP		= (1 << 5),
>   };
>   
> +/* Arches can override ftrace_get_symaddr() to convert fentry_ip to symaddr. */
> +#ifndef ftrace_get_symaddr
> +/**
> + * ftrace_get_symaddr - return the symbol address from fentry_ip
> + * @fentry_ip: the address of ftrace location
> + *
> + * Get the symbol address from @fentry_ip (fast path). If there is no fast
> + * search path, this returns 0.
> + * User may need to use kallsyms API to find the symbol address.
> + */
> +#define ftrace_get_symaddr(fentry_ip) (0)
> +#endif
> +
>   #ifdef CONFIG_DYNAMIC_FTRACE
>   
>   void ftrace_arch_code_modify_prepare(void);
>
>

