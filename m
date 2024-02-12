Return-Path: <linux-arch+bounces-2245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A321185211C
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B52812EE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6E94DA1E;
	Mon, 12 Feb 2024 22:12:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F94D584;
	Mon, 12 Feb 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775933; cv=none; b=pM/PGOOhHVV+O4vffmRpy/0mOXXcvXYLHVpFXlPp6nrVGjRNonCS9dzWcLtZWr7JGi7jEL/wCrSkUcFwfC+evPpOZPI6WVDyhrDE5TDFRjBCKC1gpS4/SxXyXR+hYxNj9wrUJ+FqFkS2Y0mbDCGJDo1dBzWDZjnFkMwPUy5gb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775933; c=relaxed/simple;
	bh=mQ24OEKxUf3+tyNALVBAJd3zdQYEVPgzTVv3KI1xCoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lauOqriaBg9nsA69Wqi+6oN2/fVfuAActOUGNWeRCIlGF9m24SBIS4XPyZkI+7/uTFjE3WYPG0DNwaajOpST0kkxduYmpNJlTHt/glXZ9brrSwh/MdTNDZabuVi2Nv0wQk4avgzPByYtFSH3lfnIPbB6OIc8YK/4PM9+KhgIxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rZeWs-0002fz-00; Mon, 12 Feb 2024 23:11:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id DC4A6C0267; Mon, 12 Feb 2024 23:10:50 +0100 (CET)
Date: Mon, 12 Feb 2024 23:10:50 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, Xi Ruoyao <xry111@xry111.site>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
Message-ID: <ZcqXaqCnKuhMDgqt@alpha.franken.de>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>

On Fri, Feb 02, 2024 at 12:30:25PM +0000, Jiaxun Yang wrote:
> Hi all,
> 
> This series fixed extable handling for architecture delay slot (MIPS).
> 
> Please see previous discussions at [1].
> 
> There are some other places in kernel not handling delay slots properly,
> such as uprobe and kgdb, I'll sort them later.
> 
> Thanks!
> 
> [1]: https://lore.kernel.org/lkml/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site
> 
> To: Oleg Nesterov <oleg@redhat.com>
> 
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Ben Hutchings <ben@decadent.org.uk>
> 
> Cc:  <linux-arch@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
> 
> Cc:  <linux-mips@vger.kernel.org>
> 
> Cc:  <linux-mm@kvack.org>
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Reduce diffstat by implemente fallback macro in linux/ptrace.h (linus)
> - Link to v1: https://lore.kernel.org/r/20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com
> 
> ---
> Jiaxun Yang (3):
>       ptrace: Introduce exception_ip arch hook
>       MIPS: Clear Cause.BD in instruction_pointer_set
>       mm/memory: Use exception ip to search exception tables
> 
>  arch/mips/include/asm/ptrace.h | 3 +++
>  arch/mips/kernel/ptrace.c      | 7 +++++++
>  include/linux/ptrace.h         | 4 ++++
>  mm/memory.c                    | 4 ++--
>  4 files changed, 16 insertions(+), 2 deletions(-)

series applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

