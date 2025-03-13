Return-Path: <linux-arch+bounces-10744-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE36A5FD82
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4423BD2A2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042B16FF44;
	Thu, 13 Mar 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhhKPC2o"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647D156237
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886186; cv=none; b=lAkrexKAw9PPfVXTi6PziQzHjHUp5PNQKoTaZIUo+qOW1VkwI8Qz8vlneyfsjvc6ccW1uWRW5q37jCMawPzG+pvNYYsAMgozwrE/DIeKQmw6OI0RF3oYAf9WKMMK4AxeUPZRwVygap1ZgQKGgUZ15VEY5gZobPAnHCvVAMUG8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886186; c=relaxed/simple;
	bh=65ynb6Gh/C7olI1InBJQjf4Uy45Ac4TLwO1SIzO2cEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq/58HaJFw7dgihgBKc27f4NG5GdA9FGMgz+UfJ8Ocp/iFkqRVN8fapyRwpOd7eWsNTi7VRLCJj+Osx83+EHldlQgjrS9n3XfbO7YfCNg9cVdYN4ZD72il2wxTH8M3YqQH1vGVi3MQGh8+kRfnn/DgT8Xjj/qq2dcMYWMNpjOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhhKPC2o; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 13:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741886176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4SmU3b6wHvKk5inE+NGrQrAKfK6zUobXoS9IuHdb+o=;
	b=fhhKPC2oco7UjaBJOsogS04mjpzCsBkg8j1JUmpJsBlIHIDibW+PD1yCWrJATcNl6r0k87
	EIJBIkwUMhDBp8uc7lTpuGyzDPUyc+PETkkGofKE4E88fb/aycah0RYCIvQWLnKkfSn3dC
	/YCsyIilB71nWTzp7xfzM53gPeRh1nA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] codetag: Avoid unused alloc_tags sections/symbols
Message-ID: <jmcazyqlkimqhswwqn2du7ik5sbm5fommonrgovy5d6knqbqcr@xebmu4akkkoy>
References: <20250313143002.9118-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313143002.9118-1-petr.pavlu@suse.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 03:29:20PM +0100, Petr Pavlu wrote:
> With CONFIG_MEM_ALLOC_PROFILING=n, vmlinux and all modules unnecessarily
> contain the symbols __start_alloc_tags and __stop_alloc_tags, which define
> an empty range. In the case of modules, the presence of these symbols also
> forces the linker to create an empty .codetag.alloc_tags section.
> 
> Update codetag.lds.h to make the data conditional on
> CONFIG_MEM_ALLOC_PROFILING.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  include/asm-generic/codetag.lds.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
> index 372c320c5043..0ea1fa678405 100644
> --- a/include/asm-generic/codetag.lds.h
> +++ b/include/asm-generic/codetag.lds.h
> @@ -2,6 +2,12 @@
>  #ifndef __ASM_GENERIC_CODETAG_LDS_H
>  #define __ASM_GENERIC_CODETAG_LDS_H
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
> +#else
> +#define IF_MEM_ALLOC_PROFILING(...)
> +#endif
> +
>  #define SECTION_WITH_BOUNDARIES(_name)	\
>  	. = ALIGN(8);			\
>  	__start_##_name = .;		\
> @@ -9,7 +15,7 @@
>  	__stop_##_name = .;
>  
>  #define CODETAG_SECTIONS()		\
> -	SECTION_WITH_BOUNDARIES(alloc_tags)
> +	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
>  
>  /*
>   * Module codetags which aren't used after module unload, therefore have the
> @@ -28,6 +34,6 @@
>   * unload them individually once unused.
>   */
>  #define MOD_SEPARATE_CODETAG_SECTIONS()		\
> -	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> +	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
>  
>  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
> 
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> -- 
> 2.43.0
> 

