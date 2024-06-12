Return-Path: <linux-arch+bounces-4849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B272290599B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B59C1F236DC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5D183082;
	Wed, 12 Jun 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="lcQdRquv"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635B28DB3;
	Wed, 12 Jun 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212066; cv=none; b=A7BiQBrqmG0GhcFtuy7lqROZCys1/aOiPLnaBcTDgdh0JXNnitnAow7LUN5u8sibPs+OFAIOZi/9lOvnxVxRR5qeFuWPcyPD/KZX/sMwesMY4Q4FE16s7w6jO8WYpCLH70bql0J/v7/uPBZ8Crge70ApsAL+9WxdMlt25vVDnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212066; c=relaxed/simple;
	bh=xsj24dHhKoMLJ7CzV3x/NjfHEv7T3k5WjG1vf1Kod+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GIwJvhtftBkgX05eRGS7gz9L9k3/BeRPRWXzrOi8fLDB5QzM13Zp9HJuIKBXDfiXbih0q0DLzJOkACFgXQii3kpKqOJmbD0cEy88IFaYziOAArwj6Uy1yxB38pvNCA6RL7KgZnX1VxNL9tLsXeI2PP92jOnY4/Cb+CN7WdpwrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=lcQdRquv; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1718212064;
	bh=xsj24dHhKoMLJ7CzV3x/NjfHEv7T3k5WjG1vf1Kod+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lcQdRquv/VYTh7djrfsx3XHM9g3Q1riiDTNzxQvdc64gRHzWWR1VbnkIsFXv0/CeW
	 maKz1jRS77F8dMoqTWf8BjkCuCaGcBU3ZOoZyvxE+pNlZ56ZnKP/k18tx9hmh6wZiQ
	 Vr73nyGYFVk9u39Pko5AQhBRUNAt7BHrD1wzllb0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 087F040A8F; Wed, 12 Jun 2024 10:07:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 06FBF40A8C;
	Wed, 12 Jun 2024 10:07:44 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:07:44 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk, 
    linux-kernel@vger.kernel.org, mingo@redhat.com, dvhart@infradead.org, 
    dave@stgolabs.net, andrealmeid@igalia.com, 
    Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, 
    hch@infradead.org, lstoakes@gmail.com, Arnd Bergmann <arnd@arndb.de>, 
    linux-api@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
    malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230731180320.GR29590@hirez.programming.kicks-ass.net>
Message-ID: <2eb23678-e1c7-816d-4807-f324c771e6ed@gentwo.org>
References: <20230721102237.268073801@infradead.org> <20230721105744.434742902@infradead.org> <87pm48m19m.ffs@tglx> <20230731180320.GR29590@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 31 Jul 2023, Peter Zijlstra wrote:

>> Is nr_node_ids guaranteed to be stable after init? It's marked
>> __read_mostly, but not __ro_after_init.
>
> AFAICT it is only ever written to in setup_nr_node_ids() and that is all
> __init code. So I'm thinking this could/should indeed be
> __ro_after_init. Esp. so since it is an exported variable.
>
> Mike?

Its stable and lots of other components depend on it like f.e. the size of 
cpumasks.


