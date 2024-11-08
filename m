Return-Path: <linux-arch+bounces-8932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031C9C25B0
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 20:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4717A28102B
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5551AA1E2;
	Fri,  8 Nov 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="eFof62/o"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD517A5BE;
	Fri,  8 Nov 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094871; cv=none; b=i9wPpjIVB550ua6+92nuTXF7+dRKN1kpM/RJFysMz5tbR6FewF+KvgfQOzTVnx5MelSiaUNuTMGGsiKS23gli+OsYivLYQWJ2geZ2lxz8DsqdIyD2ehUKjonSUd2RWOTzdNF3IS91QInzAypY2RdJTT0aBw6rwQ+lnLN5e1YAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094871; c=relaxed/simple;
	bh=KhWTv6Xz+p6/uRt5a0JjkR7Y5OsaggoRDeYnfKiG8p8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UqNav30XEILnAyhWhhefAWxsGw+Pn8aHwJziVyCnY7XIL3pe4vMNVA0T0EClNM/XV/BF6TE6bTQKWaJB0o9jebMPUkZs/nPVLTVJVhl5KXThiStLq1kKQ40pOUivlCvxQDGha6/Zgpe873G472Y2WXiwbNm3u4MPLYyr4cuEd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=eFof62/o; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1731094868;
	bh=KhWTv6Xz+p6/uRt5a0JjkR7Y5OsaggoRDeYnfKiG8p8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eFof62/o+3Ah7YL4swFSXp9NNbyWhpE/jpxAp1V0hqddWcsJbT70qSYUBEJ9Cc6Nq
	 i1Ht5pUIVwOv7ozD3OuoIfG8ndi7iDXyHZeqyBUFw9vDsX5T9JYdLuGNuomxOnNfZp
	 lPZXw/EGjMFvq/nlF4MyDGcxz4ho4GZfDRp3RCKo=
Received: by gentwo.org (Postfix, from userid 1003)
	id C978D40681; Fri,  8 Nov 2024 11:41:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C7119401C7;
	Fri,  8 Nov 2024 11:41:08 -0800 (PST)
Date: Fri, 8 Nov 2024 11:41:08 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
    tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
    dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org, 
    daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de, 
    lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com, 
    mtosatti@redhat.com, sudeep.holla@arm.com, maz@kernel.org, 
    misono.tomohiro@fujitsu.com, maobibo@loongson.cn, zhenglifeng1@huawei.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-Reply-To: <87v7wy2mbi.fsf@oracle.com>
Message-ID: <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com> <20241107190818.522639-2-ankur.a.arora@oracle.com> <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org> <87v7wy2mbi.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Nov 2024, Ankur Arora wrote:

> > Calling the clock retrieval function repeatedly should be fine and is
> > typically done in user space as well as in kernel space for functions that
> > need to wait short time periods.
>
> The problem is that you might have multiple CPUs polling in idle
> for prolonged periods of time. And, so you want to minimize
> your power/thermal envelope.

On ARM that maps to YIELD which does not do anything for the power
envelope AFAICT. It switches to the other hyperthread.

> For instance see commit 4dc2375c1a4e "cpuidle: poll_state: Avoid
> invoking local_clock() too often" which originally added a similar
> rate limit to poll_idle() where they saw exactly that issue.

Looping w/o calling local_clock may increase the wait period etc.

For power saving most arches have special instructions like ARMS
WFE/WFET. These are then causing more accurate wait times than the looping
thing?



