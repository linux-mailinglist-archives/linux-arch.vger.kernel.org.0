Return-Path: <linux-arch+bounces-404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC77F532A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB8A28145B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3351F600;
	Wed, 22 Nov 2023 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TytTOb0H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF2AD;
	Wed, 22 Nov 2023 14:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700691438; x=1732227438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yeWZ3BdyhhUuU0VGr46b+afl1WUFwAC0SYpHXwdB+Hk=;
  b=TytTOb0Hvr0RYxSd5pH2lysLrVqd5uo8v66ICqCi48x3GtIV5NFlhx7B
   Ucq8MsPCTD/JNfk35ybIBxw8vxYtGnDvYkqdksOlZQpy897d5MqfuHncG
   KjE7ngxMnhPrGFhG8NtKdF0gyC5JXRf2wSyVbLJyy6+Qjwl9f2lwUw72N
   dwxL/VKf3BitDRUocQUlo+4Wj/6r9nOk5prorxq7y8IoC6+aFUqZyEMn2
   pjoAUMvx+huD3kNCJrqR+Np2CkOWxEFdhGKBu16+74BIM2YfWjH0IdJHr
   QEmVQ+KcwHg2VIHAf7NLzUnVaCMwQMxWK/4neudT/tMP4OTHhNiFwoy99
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382553921"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="382553921"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 14:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770797680"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="770797680"
Received: from aconradi-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.221.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 14:17:10 -0800
Date: Wed, 22 Nov 2023 23:17:07 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
	bcain@quicinc.com, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
	andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
	andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.org,
	mhiramat@kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mattwu@163.com,
	linux@roeck-us.net
Subject: Re: [PATCH v3 1/5] arch,locking/atomic: arc: arch_cmpxchg should
 check data size
Message-ID: <ZV594z0bNQR-vo2b@ashyti-mobl2.lan>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
 <20231121142347.241356-2-wuqiang.matt@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121142347.241356-2-wuqiang.matt@bytedance.com>

Hi Wuqiang,

On Tue, Nov 21, 2023 at 10:23:43PM +0800, wuqiang.matt wrote:
> arch_cmpxchg() should check data size rather than pointer size in case
> CONFIG_ARC_HAS_LLSC is defined. So rename __cmpxchg to __cmpxchg_32 to
> emphasize it's explicit support of 32bit data size with BUILD_BUG_ON()
> added to avoid any possible misuses with unsupported data types.
> 
> In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
> to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.
> 
> v2 -> v3:
>   - Patches regrouped and has the improvement for xtensa included
>   - Comments refined to address why these changes are needed
> 
> v1 -> v2:
>   - Try using native cmpxchg variants if avaialble, as Arnd advised
> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arc/include/asm/cmpxchg.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index e138fde067de..bf46514f6f12 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -18,14 +18,16 @@
>   * if (*ptr == @old)
>   *      *ptr = @new
>   */
> -#define __cmpxchg(ptr, old, new)					\
> +#define __cmpxchg_32(ptr, old, new)					\
>  ({									\
>  	__typeof__(*(ptr)) _prev;					\
>  									\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
> +									\
>  	__asm__ __volatile__(						\
> -	"1:	llock  %0, [%1]	\n"					\
> +	"1:	llock  %0, [%1]		\n"				\
>  	"	brne   %0, %2, 2f	\n"				\
> -	"	scond  %3, [%1]	\n"					\
> +	"	scond  %3, [%1]		\n"				\
>  	"	bnz     1b		\n"				\
>  	"2:				\n"				\
>  	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
> @@ -47,7 +49,7 @@
>  									\
>  	switch(sizeof((_p_))) {						\
>  	case 4:								\
> -		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> +		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -65,8 +67,6 @@
>  	__typeof__(*(ptr)) _prev_;					\
>  	unsigned long __flags;						\
>  									\
> -	BUILD_BUG_ON(sizeof(_p_) != 4);					\
> -									\

I think I made some comments here that have not been addressed or
replied.

Thanks,
Andi

>  	/*								\
>  	 * spin lock/unlock provide the needed smp_mb() before/after	\
>  	 */								\
> -- 
> 2.40.1

