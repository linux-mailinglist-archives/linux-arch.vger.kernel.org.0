Return-Path: <linux-arch+bounces-12291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA2AAD2490
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0608A18841FC
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB3212D97;
	Mon,  9 Jun 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIh5Y5+d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282D3FC2;
	Mon,  9 Jun 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488588; cv=none; b=Uyjvs2zVLyFvLGGqwZyH87uGZEREx7AzehJCsEsYnbbAfHfCmojs6nVv1snbvNvkHfipfm5INck29EuC/00Z6GZlKD4SVswp717dzJQjYvpbkbt4bcmbdGJrgNv46uVy92Qdw+iSxXmkQDXxX2EQz2T82148HnNE8eKNRw3Wo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488588; c=relaxed/simple;
	bh=VkV6JQ2FgHrRghDrC224nNPTDQSS5mIgKE9tQeHSFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKhaJF34dmY9x3/i+BJEeGtVXxbQ7OdYqfHj305XnkJzkag3RLCv2twDPn4vGb3HmlDvT1pYTP8gEl97lCGYHVJ+YmB9+ECHnaO2Yos7u7reaLbYdAcNtZ0PpRXQiAOj4Ni7N7ncdVy5+1GPyqo0lx6E69npxJ8d4/nhawBYQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIh5Y5+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F812C4CEEF;
	Mon,  9 Jun 2025 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749488587;
	bh=VkV6JQ2FgHrRghDrC224nNPTDQSS5mIgKE9tQeHSFms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIh5Y5+dVVuggziHsrY1euQW4YM6CCJ6DFFV/pTkc1q+JgeIoKw7nmm5WSYCephi8
	 VvlOELS97KNeFSJBXCQEhco7k6T1y6yf9D7GRgAZe8Y5HVMVXcVO2cFV2hkWMLN3n6
	 gV3PTNLjOy+avX2ube/P/tMzEpLPAJw2R96tcwL5eQnEMGttICYytrgWWxyuF9Kg7J
	 zJunmPkmo3xQF2XEm+weySG24pGepoONvjDwUKQjXuD7xhNrb4xNZl5MOcRsvPDTAs
	 UAlr7rBGlp5iojWTzXyHVi50cq3DEFh8i6N7fJWb1YVip8MJmagzRV5LLwWfQ9fi7U
	 1f/qV93uJuX7A==
Date: Mon, 9 Jun 2025 07:03:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <aEcTykJBgyyYYVAR@slm.duckdns.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <0aeb6d8b-2abb-43a7-b47d-448f37f8a3bf@suse.cz>
 <20250604121923.GB1431@cmpxchg.org>
 <20250605123156.GA2812@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605123156.GA2812@cmpxchg.org>

Hello,

On Thu, Jun 05, 2025 at 08:31:56AM -0400, Johannes Weiner wrote:
> On Wed, Jun 04, 2025 at 08:19:28AM -0400, Johannes Weiner wrote:
> > On Fri, May 30, 2025 at 12:31:35PM +0200, Vlastimil Babka wrote:
...
> > > I've just read the previous threads about Barry's proposal and if doing this
> > > always isn't feasible, I'm wondering if memcg would be a better interface to
> > > opt-in for this kind of behavior than both prctl or mctl. I think at least
> > > conceptually it fits what memcg is doing? The question is if the
> > > implementation would be feasible, and if android puts apps in separate memcgs...
> > 
> > CCing Tejun.
> > 
> > Cgroups has been trying to resist flag settings like these. The cgroup
> > tree is a nested hierarchical structure designed for dividing up
> > system resources. But flag properties don't have natural inheritance
> > rules. What does it mean if the parent group says one thing and the
> > child says another? Which one has precedence?
> > 
> > Hence the proposal to make it a per-process property that propagates
> > through fork() and exec(). This also enables the container usecase (by
> > setting the flag in the container launching process), without there
> > being any confusion what the *effective* setting for any given process
> > in the system is.

+1. If something can work as something which gets inherited through the
process hierarchy, that's usually the better choice than making it a cgroup
property. There isn't much to be gained by making them cgroup properties
especially given that cgroup hierarchy, in most systems at this point, is a
degenerated process hierarchy.

Thanks.

-- 
tejun

