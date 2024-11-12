Return-Path: <linux-arch+bounces-9040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA959C5ECD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A2F1F23650
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53226213EC3;
	Tue, 12 Nov 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="oVJynVz4"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8A213124;
	Tue, 12 Nov 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432141; cv=none; b=CeLWZxlqeY+mBBs+swK1mHbexjmT8KY9QlX3Zop4+zUvTfPeHd6S8MGNoAh9Vk4FaH0a6cqIPU57Rv6k97LMpvZCimC3LMeeqswk4qQwNRRsKEwyZNAiWn5+vDxonKAmR0AM3mO+/A9QcMD2Kq1vGnelzkI7l0/XPvbVW3I7LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432141; c=relaxed/simple;
	bh=Sf7+qAtrJ8NfnoJMCnPnCfwyrzglWa3e10oFGgeSTKo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C8aT7O18r/tiWl85/CBAEsiC/Wgu1bZ6qMv4jhwi0FyLswxNPXtdAcaeJnI71CzBGCwV6AmlMDu5jWmgmLCUnOiEpqMe3e7/uilxtK0zxbqi4zti0/DvnGfBygv6r3jYaZvwlS1BpY7fY9m/0RyoSFVymdJz1XRlo3ujsWeJNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=oVJynVz4; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1731430202;
	bh=Sf7+qAtrJ8NfnoJMCnPnCfwyrzglWa3e10oFGgeSTKo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oVJynVz4ntbWelqP3CUy87U5l5emCf0/gVobk/CGKKxDzZBkQFTVNsdpRHvLae3+i
	 SSuNj9dz/y1JcyqnnAE+fbxBZg+T+nrBDzv4hk3ogk+ukZICIsM9JNwEb32noxje7h
	 EjX97JEa305LSQy4msRlzzpP9ZkESShA+T2CUPBA=
Received: by gentwo.org (Postfix, from userid 1003)
	id 13C4F401C9; Tue, 12 Nov 2024 08:50:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 08314401C8;
	Tue, 12 Nov 2024 08:50:02 -0800 (PST)
Date: Tue, 12 Nov 2024 08:50:01 -0800 (PST)
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
In-Reply-To: <87zfm9z812.fsf@oracle.com>
Message-ID: <93d1d8f6-702e-811b-2bf6-0e4739e24c1c@gentwo.org>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com> <20241107190818.522639-2-ankur.a.arora@oracle.com> <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org> <87v7wy2mbi.fsf@oracle.com> <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
 <87zfm9z812.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Nov 2024, Ankur Arora wrote:

> > For power saving most arches have special instructions like ARMS
> > WFE/WFET. These are then causing more accurate wait times than the looping
> > thing?
>
> Definitely true for WFET. The WFE can still overshoot because the
> eventstream has a period of 100us.

We can only use the event stream if we need to wait more than 100us.

The rest of the wait period can be coverd by a busy loop. Thus we are
accurate.


