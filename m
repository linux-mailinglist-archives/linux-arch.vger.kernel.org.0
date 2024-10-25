Return-Path: <linux-arch+bounces-8573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700419B0F46
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F17A1C215E1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAE20EA50;
	Fri, 25 Oct 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="F5HZK9Zy"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CE20EA3A;
	Fri, 25 Oct 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885278; cv=none; b=TcwKvM7vhf+zubtElbfN7oD+t/0uc/UQpSIB0RUlisUGC3yuni4tptHtgF38a9YnLmOMiXkHg8yDVoh9gHJXcVWmSL8zhrzaU1S4JqTqZxDVdKVtbFOBbjTfBa2DgV4mcIQcCWRqICsR5I9lN8+45HmjCUdx+iUGqIi11vJq870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885278; c=relaxed/simple;
	bh=HmSSwqaEV93zmIkQQrgyN/H+4SpePg2bLhbZrxFkUvE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iHsCh2Gn+jaWJ41zqgN/C2eI9m23alYSjLz+QPMp9lVnIYMHtCwe/bLN0H+zDTq4zKr+5XNPoyX4awypS/6iO5OgLvDavS2Q38wl0Ir6Kh2ugycAZJuP5XrkUUHZz3G0Vndqk9shis3EX0+pncYc13EUzLeeH83UXsLATTOlP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=F5HZK9Zy; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729884534;
	bh=HmSSwqaEV93zmIkQQrgyN/H+4SpePg2bLhbZrxFkUvE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F5HZK9Zyud8fxXPO9yzo8uVn8HvBmJzw3ALph0CQUV/52RTu0J43yWQYy66x7qIac
	 fdFV/idJwlHWRF1mMoJce2/a4Uyql2W004hVL02EJAjMDq+rzmCkTrhZ4Ezu6I6eSy
	 Ln882vz9nxSGn40SIoBYxbCde0eHZpoXclU/rbrs=
Received: by gentwo.org (Postfix, from userid 1003)
	id A19F6409C3; Fri, 25 Oct 2024 12:28:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 9F74640681;
	Fri, 25 Oct 2024 12:28:54 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:28:54 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com, 
    dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com, 
    Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, 
    hch@infradead.org, lstoakes@gmail.com, Arnd Bergmann <arnd@arndb.de>, 
    linux-api@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
    malteskarupke@web.de, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
In-Reply-To: <20241025093944.485691531@infradead.org>
Message-ID: <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org>
References: <20241025090347.244183920@infradead.org> <20241025093944.485691531@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Peter Zijlstra wrote:

> Extend the futex2 interface to be numa aware.
>
> When FUTEX2_NUMA is specified for a futex, the user value is extended
> to two words (of the same size). The first is the user value we all
> know, the second one will be the node to place this futex on.
>
>   struct futex_numa_32 {
> 	u32 val;
> 	u32 node;
>   };
>
> When node is set to ~0, WAIT will set it to the current node_id such
> that WAKE knows where to find it. If userspace corrupts the node value
> between WAIT and WAKE, the futex will not be found and no wakeup will
> happen.
>
> When FUTEX2_NUMA is not set, the node is simply an extention of the
> hash, such that traditional futexes are still interleaved over the
> nodes.


Would it be possible to follow the NUMA memory policy set up for a task
when making these decisions? We may not need a separate FUTEX2_NUMA
option. There are supportive functions in mm/mempolicy.c that will yield
a node for the futex logic to use.

See f.e. linux/include/uapi/mempolicy.h for the types of memory policy
that can be set for a task in current->mempolicy.


MPOL_DEFAULT	get local memory / use system default policy
MPOL_INTERLEAVE interleaved over nodes
MPOL_BIND	use the node specified in the task policy.
MPOL_LOCAL	get_local_memory

etc.

You will get a page or objects with the correct node by calling
alloc_pages() or kmalloc without GFP_THISNODE.

If you just need the node to use then use

mempolicy_slab_node()

and assign that to the node of the futex.

The function will determine which node to use depending on the active
memory policy.


