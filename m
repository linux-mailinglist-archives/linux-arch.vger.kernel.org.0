Return-Path: <linux-arch+bounces-8670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECD9B3DBC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 23:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B5B1F22DA8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECA190665;
	Mon, 28 Oct 2024 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="GLKH3sYk"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2B15B12F;
	Mon, 28 Oct 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154776; cv=none; b=qoL0+03iqP0bcpIQsnWI3YIl3LAR59TSNAGHQ+P2LVj8VEA4PWHPbuuSxpua0MhaO2Or3GSot96S6Ay/ZKDZqVZkPxxVloTP6kDkLPRHt4N1rWkGTipO1vnbTqSsVP+y3q77iEConbHFhYVdnhnlHzRHqXVstRjNE2ZYw4P9hT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154776; c=relaxed/simple;
	bh=/SQfm4OrYQgNEi45Oobeb5cLHvXvjVCoOTfBN4ilzVA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F5fPPzThwVS1rsBWt/ZgdvJIIYUQxVYHHJJBiIqXTjR5F5PD+s85SrrmRn8cP50OP5SAZCPmKvH3w4qiZW592w3lhJmxqF0hOuvvOlS+FFEo8je334CmTG24JBllRk9+f/NCp3VfSFbgkgyIXNusoxp5NJEtkrdyH+Qkj1sxtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=GLKH3sYk; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1730154767;
	bh=/SQfm4OrYQgNEi45Oobeb5cLHvXvjVCoOTfBN4ilzVA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GLKH3sYk+S4es0N2N4PStmrEczBQ1YxzIL+RLE5xGsBFuJ8EXAIBI1rA6Vus9OFbe
	 CdoPMeXkRY3Y+lQpGwvA7oa2XvmvSmLAqQlOCnkJTrJ25AAbBlDxhudod85i56OrjE
	 1VLsKD9Aab8OZOvPWSpIqstwFQgcBMVY1IXhGz/g=
Received: by gentwo.org (Postfix, from userid 1003)
	id 2163A40262; Mon, 28 Oct 2024 15:32:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1D9CF401C8;
	Mon, 28 Oct 2024 15:32:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:32:47 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
    mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
    Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20241026072119.GH9767@noisy.programming.kicks-ass.net>
Message-ID: <f0df62e6-c7af-89a1-89ee-4ee55fff00c4@gentwo.org>
References: <20230721102237.268073801@infradead.org> <20230721105744.434742902@infradead.org> <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com> <20241025085815.GG14555@noisy.programming.kicks-ass.net> <887eadb6-6142-3edf-0a25-d33b2219b90d@gentwo.org>
 <20241026072119.GH9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 26 Oct 2024, Peter Zijlstra wrote:

> I'll look into the per task thing, which I'm hoping means per-process.
> We need something that is mm wide consistent.

Each thread can modify its policy and that is used f.e. to control memory
allocations for syscalls. For example a thread wants to allocate kernel
metadata on a specific node then the policy would be set to that node.
Syscall is done and then the tasks resets the policy to the default.

mm wide memory policies are set at an VMA level and are associated with
addresses.

> But since futexes play in the address space, I was really rather
> thinking we ought to use the vma policy.

If they are associated with an address then you can use the address space
policy.


