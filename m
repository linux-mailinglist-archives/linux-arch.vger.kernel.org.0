Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD179FE7A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjINIdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjINIde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1989B1FC3
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694680372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/v5LVGgI1bCh7IZ5F5HTHb9gqgvRzQ+J2np7/S42Q3I=;
        b=P0C9IWfNUXHy4UOL33TYP4hvbjVD+wgMQ77xOuDZrF6uHa7nmPlSz/qrgXecYZPGJiMFye
        47r9Rrf6Gkcls9SC6u0/4r1Krs84I/zd7Yef+CZ/jmwNJMq/+qmHrAmZ8sP/wd0FkvWcMc
        OYFJIUND9j00vu89G+RLvoF9uoRLkM0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-eA5ebw1oNCK9UtYmdQmBHw-1; Thu, 14 Sep 2023 04:32:50 -0400
X-MC-Unique: eA5ebw1oNCK9UtYmdQmBHw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1b728bfb372so1040897fac.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 01:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680370; x=1695285170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v5LVGgI1bCh7IZ5F5HTHb9gqgvRzQ+J2np7/S42Q3I=;
        b=DU24m/SmvhJeSXF+7fkgRX8W5/M6qGEjDbI3IPhFDTZkHXi7g1BD7uKEd30quhZm63
         I6Yxm9BsCBWfImqPegkmp2B4+qUVufIA3gIlvgOLO6SpKXIz4SP+npYngdU9r3SOabnQ
         ZWpjUU8atK4RVmNoXpvNbhi8Vh7dUIQ89WWfR6tJPk7NPydgIzr84Wro5T+bFJuYV2Ue
         ssyj5uPLnD2+Qi1rSs0s0P3W64pee0T4jLFU4m1SLsTlE5x4zFZ8nIwUjHl6UMroxnWr
         dta07dqoOmveBnz21qaj0pZtvIBLoELDU6zyYf2mty0nj5xEHXqHV6oBgA257Av6ofLF
         kl+Q==
X-Gm-Message-State: AOJu0YxA3JeFWSZFGmcmUtE1gQ3AZPcGIwJ8zY2New536tH9/iOFrTFp
        wVUMCyB0xZXGifl2IuL5Yl4KJxqbMl3erebbgvN+RtRvGqC3wUzRwq0Dmbd4yFQNijuiCkdO0iF
        NEL/1Ubsfb2cE6cO2XqbVNrq1g1MHeA==
X-Received: by 2002:a05:6870:5608:b0:1b0:2f63:4ff6 with SMTP id m8-20020a056870560800b001b02f634ff6mr5153865oao.1.1694680369742;
        Thu, 14 Sep 2023 01:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETspTdZzZYvBIau8sxRS9qB0qJSQdMZkzC5B1Noxo923sXXDhRBNsu3bJAqLvOXStAslAzvg==
X-Received: by 2002:a05:6870:5608:b0:1b0:2f63:4ff6 with SMTP id m8-20020a056870560800b001b02f634ff6mr5153842oao.1.1694680369455;
        Thu, 14 Sep 2023 01:32:49 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id sf23-20020a056871231700b001d4fe4293efsm535197oab.36.2023.09.14.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:32:48 -0700 (PDT)
Date:   Thu, 14 Sep 2023 05:32:39 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 09/17] riscv: qspinlock: errata: Add
 ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <ZQLFJ1cmQ8PAoMHm@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-10-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-10-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:29:03AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The early version of T-Head C9xx cores has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
> 
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig.errata              | 19 +++++++++++++++++++
>  arch/riscv/errata/thead/errata.c       | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h   | 13 -------------
>  arch/riscv/include/asm/rwonce.h        | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/vendorid_list.h | 14 ++++++++++++++
>  include/asm-generic/rwonce.h           |  2 ++
>  6 files changed, 79 insertions(+), 13 deletions(-)
>  create mode 100644 arch/riscv/include/asm/rwonce.h
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 1aa85a427ff3..c919cc3f1a3a 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -77,4 +77,23 @@ config ERRATA_THEAD_PMU
>  
>  	  If you don't know what to do here, say "Y".
>  
> +config ERRATA_THEAD_WRITE_ONCE
> +	bool "Apply T-Head WRITE_ONCE errata"
> +	depends on ERRATA_THEAD
> +	default y
> +	help
> +	  The early version of T-Head C9xx cores has a store merge buffer
> +	  delay problem. The store merge buffer could improve the store queue
> +	  performance by merging multi-store requests, but when there are no
> +	  continued store requests, the prior single store request would be
> +	  waiting in the store queue for a long time. That would cause
> +	  significant problems for communication between multi-cores. Appending
> +	  a fence w.o could immediately flush the store merge buffer and let
> +	  other cores see the write result.
> +
> +	  This will apply the WRITE_ONCE errata to handle the non-standard
> +	  behavior via appending a fence w.o instruction for WRITE_ONCE().
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index be84b14f0118..751eb5a7f614 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -69,6 +69,23 @@ static bool errata_probe_pmu(unsigned int stage,
>  	return true;
>  }
>  
> +static bool errata_probe_write_once(unsigned int stage,
> +				    unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> +		return false;
> +
> +	/* target-c9xx cores report arch_id and impid as 0 */
> +	if (arch_id != 0 || impid != 0)
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_BOOT ||
> +	    stage == RISCV_ALTERNATIVES_MODULE)
> +		return true;
> +
> +	return false;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -83,6 +100,9 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_pmu(stage, archid, impid))
>  		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
>  
> +	if (errata_probe_write_once(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
> +
>  	return cpu_req_errata;
>  }
>  
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 712cab7adffe..fbb2b8d39321 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -11,19 +11,6 @@
>  #include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
>  
> -#ifdef CONFIG_ERRATA_SIFIVE
> -#define	ERRATA_SIFIVE_CIP_453 0
> -#define	ERRATA_SIFIVE_CIP_1200 1
> -#define	ERRATA_SIFIVE_NUMBER 2
> -#endif
> -
> -#ifdef CONFIG_ERRATA_THEAD
> -#define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_CMO 1
> -#define	ERRATA_THEAD_PMU 2
> -#define	ERRATA_THEAD_NUMBER 3
> -#endif
> -

Here I understand you are moving stuff from errata_list.h to 
vendorid_list.h. Wouldn't it be better to do this on a separated patch 
before this one?

I understand this is used here, but it looks like it's unrelated.

>  #ifdef __ASSEMBLY__
>  
>  #define ALT_INSN_FAULT(x)						\
> diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..be0b8864969d
> --- /dev/null
> +++ b/arch/riscv/include/asm/rwonce.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#include <linux/compiler_types.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/vendorid_list.h>
> +
> +#define __WRITE_ONCE(x, val)				\
> +do {							\
> +	*(volatile typeof(x) *)&(x) = (val);		\
> +	asm volatile(ALTERNATIVE(			\
> +		__nops(1),				\
> +		"fence w, o\n\t",			\
> +		THEAD_VENDOR_ID,			\
> +		ERRATA_THEAD_WRITE_ONCE,		\
> +		CONFIG_ERRATA_THEAD_WRITE_ONCE)		\
> +		: : : "memory");			\
> +} while (0)
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif	/* __ASM_RWONCE_H */

IIUC the idea here is to have an alternative __WRITE_ONCE that replaces the 
asm-generic one.

Honestly, this asm alternative here seems too much information, and too 
cryptic. I mean, yeah in the patch it all makes sense, but I imagine myself
in the future looking at all this and trying to understand what is going 
on.

Wouldn't it look better to have something like:

#####

/* Some explanation like the one on Kconfig */

#define write_once_flush()			\
do {						\
	asm volatile(ALTERNATIVE(			\
		__nops(1),			\
		"fence w, o\n\t",		\
		THEAD_VENDOR_ID,		\
		ERRATA_THEAD_WRITE_ONCE,	\
		CONFIG_ERRATA_THEAD_WRITE_ONCE)	\
		: : : "memory");		\
} while(0)


#define __WRITE_ONCE(x, val)			\
do {						\
     	*(volatile typeof(x) *)&(x) = (val);	\
	write_once_flush();			\
} while(0)

#####

	
This way I could quickly see there is a flush after the writting of 
WRITE_ONCE(), and this flush is the above "complicated" asm.

What do you think?

> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index cb89af3f0704..73078cfe4029 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -8,4 +8,18 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
>  
> +#ifdef CONFIG_ERRATA_SIFIVE
> +#define	ERRATA_SIFIVE_CIP_453 0
> +#define	ERRATA_SIFIVE_CIP_1200 1
> +#define	ERRATA_SIFIVE_NUMBER 2
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD
> +#define	ERRATA_THEAD_PBMT 0
> +#define	ERRATA_THEAD_CMO 1
> +#define	ERRATA_THEAD_PMU 2
> +#define	ERRATA_THEAD_WRITE_ONCE 3
> +#define	ERRATA_THEAD_NUMBER 4
> +#endif
> +
>  #endif
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 8d0a6280e982..fb07fe8c6e45 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -50,10 +50,12 @@
>  	__READ_ONCE(x);							\
>  })
>  
> +#ifndef __WRITE_ONCE
>  #define __WRITE_ONCE(x, val)						\
>  do {									\
>  	*(volatile typeof(x) *)&(x) = (val);				\
>  } while (0)
> +#endif
>  
>  #define WRITE_ONCE(x, val)						\
>  do {									\
> -- 
> 2.36.1
> 

