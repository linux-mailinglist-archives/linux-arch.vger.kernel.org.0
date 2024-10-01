Return-Path: <linux-arch+bounces-7565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAD98C75F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 23:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D8E1F21A55
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A591BC9F4;
	Tue,  1 Oct 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fFyy47TS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB52B9A5;
	Tue,  1 Oct 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817230; cv=none; b=Fw7IYn05cBgXi53/wKfDPSCGNRdHlAdAwHTVKjH6ym1xPNxueqxVY7HL6uuL18O5o+xwk5qPvrElfO3m+AFT8osFv16T6CEKvB1KcdtbpMEWomHzjjIK9SFNlYI5zByignzUJDW+D39HOXN0tdnayYKdHiGk/+DRj1SQh/FbTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817230; c=relaxed/simple;
	bh=j81CnBWvqOKNQiCSd1M8Swgo9ngyNf4oE5eH74hHfdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijoro9dU7rNvxT+dRNlLtvxkon/68v3+HEzv2qVH0YZp20voBEmwBE8pMb3RIdjIDAsem/q2UAfQvhg4xo7uW4pkDnf3g6ApelJJzRkRBdFlJRw13xOvwK0u47FxfySnqBDGaKuvHdiWIwdDp1WPkUk1Vrr76GKNxcBFwAMGtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fFyy47TS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 491LD64E3981901
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 1 Oct 2024 14:13:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 491LD64E3981901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1727817189;
	bh=wg2nnHYJORGEr++gsU/2zXcuEVhCMPKS9pnMCvzGs8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fFyy47TSOntzOAbS8blAkeCl3x/YS5bSFuROsOg+3vqmY7On1biRz2UTqs/9m38X8
	 nRscKmyWainHTfaY3YP7t1lB5f0PwyK8Aa8UwTBK3xVt41BmFDAR0Um12z0DGAw83q
	 rwR5I38BRHrDozoz5SrS6vamdT7nw+/vhni+WCK/fVluUznobKmjSIoBtoiVawRvP+
	 PUadiCuuNcRhOsdYeao3WLhh4ZW9WjTBE8wKA16DWrk/uqHDWUrIlDPNYSPdY4zgNa
	 7+S7kpQ6qLWXT6nHjxx8l5aWS59Y1Fee+kpF52DDp2Ey5vGtIiW4dMiN+Lin831+/a
	 7/yrVpIWWLvhA==
Message-ID: <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
Date: Tue, 1 Oct 2024 14:13:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240925150059.3955569-55-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 08:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> As an intermediate step towards enabling PIE linking for the 64-bit x86
> kernel, enable PIE codegen for all objects that are linked into the
> kernel proper.
> 
> This substantially reduces the number of relocations that need to be
> processed when booting a relocatable KASLR kernel.
> 

This really seems like going completely backwards to me.

You are imposing a more restrictive code model on the kernel, optimizing 
for boot time in a way that will exert a permanent cost on the running 
kernel.

There is a *huge* difference between the kernel and user space here:

KERNEL MEMORY IS PERMANENTLY ALLOCATED, AND IS NEVER SHARED.

Dirtying user pages requires them to be unshared and dirty, which is 
undesirable. Kernel pages are *always* unshared and dirty.

> It also brings us much closer to the ordinary PIE relocation model used
> for most of user space, which is therefore much better supported and
> less likely to create problems as we increase the range of compilers and
> linkers that need to be supported.

We have been resisting *for ages* making the kernel worse to accomodate 
broken compilers. We don't "need" to support more compilers -- we need 
the compilers to support us. We have working compilers; any new compiler 
that wants to play should be expected to work correctly.

	-hpa


