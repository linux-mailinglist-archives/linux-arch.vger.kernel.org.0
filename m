Return-Path: <linux-arch+bounces-8572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FD9B0F2E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F481C20B7D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2420D516;
	Fri, 25 Oct 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="W4Jes7yt"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91981925AB;
	Fri, 25 Oct 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884997; cv=none; b=fSZLvYpG2jzq7vUYRyMTfpejh0Z73IARo+U1S593twYuFEx0Qv4RIdH4EZLJhsdDNjVgZ6lk6Ui4izUBdPKyUR8oK5VAmKzChI/Of5UprTVD/v5hUI6udEVcay8PGTowmL+NmqcK4RCAZKDEKL8nb5aHXGh3274FxJF1bVFL0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884997; c=relaxed/simple;
	bh=x+Qq9Vx8YNRoZQjfWSXB0H8Q/jg1IHxnyqzO1wQC2po=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZOwngII5weRQt1FkHVIJd/uLtIDBSdOezRquFmBk/XWOA4NKCzvkqFswJtP7dTuok6nTKH6UZYqcMlX37895AFFAHcQQRE9+BgonmYHlWwkiJZnIMicbTdvIVGWlyfIKasuLu3qDpP0bLDvHkP0kD/PtzQTx3fFUps6fidJJHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=W4Jes7yt; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729884988;
	bh=x+Qq9Vx8YNRoZQjfWSXB0H8Q/jg1IHxnyqzO1wQC2po=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=W4Jes7ytlXV9rXvyZdJydttKL5xA9UZzAfrBUrbnFvkgcQ3do4auyKL2SppmTQzLk
	 4U/Oz2+zr97U7hbhOq9AXt0r5KitVEBSJKrRuCbP3LwYV2+6E5ueQhRzxscmpJZu2z
	 zYDML7Iz7A1F9rWYQSf1xA3C8W5PPDdp7InrU9Kw=
Received: by gentwo.org (Postfix, from userid 1003)
	id A35C6409CC; Fri, 25 Oct 2024 12:36:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id A1F8640681;
	Fri, 25 Oct 2024 12:36:28 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:36:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
    mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
    Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20241025085815.GG14555@noisy.programming.kicks-ass.net>
Message-ID: <887eadb6-6142-3edf-0a25-d33b2219b90d@gentwo.org>
References: <20230721102237.268073801@infradead.org> <20230721105744.434742902@infradead.org> <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com> <20241025085815.GG14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Sorry saw this after the other email.

On Fri, 25 Oct 2024, Peter Zijlstra wrote:

> > Could we follow NUMA policies like with other metadata allocations during
> > systen call processing?
>
> I had a quick look at this, and since the mempolicy stuff is per vma,
> and we don't have the vma, this is going to be terribly expensive --
> mmap_lock and all that.

There is a memory policy for the task as a whole that is used for slab
allocations and allocations that are not vma bound in current->mempolicy.
Use that.

> Using memory policies is probably okay -- but still risky, since you get
> the extra failure case where if you change the mempolicy between WAIT
> and WAKE things will not match and sadness happens, but that *SHOULD*
> hopefully not happen a lot. Mempolicies are typically fairly static.

Right.

> > That way the placement of the futex can be controlled by the tasks memory
> > policy. We could skip the FUTEX2_NUMA option.
>
> That doesn't work. If we don't have storage for the node across
> WAIT/WAKE, then the node must be deterministic per futex_hash().
> Otherwise wake has no chance of finding the entry.

You can get a node number following the current task mempolicy by calling
mempolicy_slab_node() and keep using that node for the future.

It is also possible to check if the policy is interleave and then follow
the distributed hash scheme.


> The current scheme where we determine node based on hash bits is fully
> deterministic and WAIT/WAKE will agree on which node-hash to use. The
> interleave is no worse than the global hash today -- OTOH it also isn't
> better.

This is unexpected strange behavior for those familiar with NUMA. We have
tools to set memory policies for tasks and those policies should be used
throughout.


