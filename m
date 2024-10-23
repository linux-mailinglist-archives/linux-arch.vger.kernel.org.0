Return-Path: <linux-arch+bounces-8500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E805B9AD639
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 23:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A5A1F2537E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F471EF0BF;
	Wed, 23 Oct 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r2uxN5Qd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721341E5731;
	Wed, 23 Oct 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717224; cv=none; b=qPyPD1O32FQq9GdNjUzxirylitH/6GSuteLsqikpJwp9Cy+e2vowHfoUOrgjWSFs78GH7t8qhdmccLhtT+NgE/pbaprGgCDpKrddsXiauDtKK8mEWWjhF7nu1Yci6NhkJl7Fy4FFdwVOiPpKGEqw7T1fie5+I+12v+sw3cprh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717224; c=relaxed/simple;
	bh=4eSmCo6i0if5D6CdJVmAQN9GUXvTbEx1TW8GzU+3oWo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=STnBEeV4IPIZlNeCGW5JcP/z4QRmzr1g+VELgvxpT6YxKd0qlJHi+Qpja3Zyyvn5m1iR8EOEAAeBLvnXnONhHPB8BZ/Cu8DUZxoDcbgu2G90NTVwUdBSECeummAnkiESZSQFWohB9u/Eun6Ukz03TEp265y1MruPQAJtu7q6T9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r2uxN5Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665E7C4CEC6;
	Wed, 23 Oct 2024 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729717224;
	bh=4eSmCo6i0if5D6CdJVmAQN9GUXvTbEx1TW8GzU+3oWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2uxN5Qd5gm76NxG+Qlhr9lMttgqy65AazTAi8k5+n4TtXJdd1yL5LhAGuhhgk0xi
	 Un7unedgoFxkTyTeFCt4VXqOoSSgnu5sM3TwS7VxhOc4WG2sVBqY7a9QsA1wzJ1je2
	 kb9ElqWHIX9krkoGE3oF1hiLvbjrQkZwifaqy1mg=
Date: Wed, 23 Oct 2024 14:00:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
 mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com,
 tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com,
 ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
 jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org,
 petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
 yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org,
 iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, maple-tree@lists.infradead.org,
 linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to
 abstract page tag references
Message-Id: <20241023140017.e165544bf20bcb0c79bfee57@linux-foundation.org>
In-Reply-To: <20241023170759.999909-6-surenb@google.com>
References: <20241023170759.999909-1-surenb@google.com>
	<20241023170759.999909-6-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 10:07:58 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> To simplify later changes to page tag references, introduce new
> pgtag_ref_handle type. This allows easy replacement of page_ext
> as a storage of page allocation tags.
> 
> ...
>
>  static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
>  {
> +	union pgtag_ref_handle handle;
> +	union codetag_ref ref;
>  	struct alloc_tag *tag;
> -	union codetag_ref *ref;
>  
>  	tag = pgalloc_tag_get(&old->page);
>  	if (!tag)
>  		return;
>  
> -	ref = get_page_tag_ref(&new->page);
> -	if (!ref)
> +	if (!get_page_tag_ref(&new->page, &ref, &handle))
>  		return;
>  
>  	/* Clear the old ref to the original allocation tag. */
>  	clear_page_tag_ref(&old->page);
>  	/* Decrement the counters of the tag on get_new_folio. */
> -	alloc_tag_sub(ref, folio_nr_pages(new));
> -
> -	__alloc_tag_ref_set(ref, tag);
> -
> -	put_page_tag_ref(ref);
> +	alloc_tag_sub(&ref, folio_nr_pages(new));

mm-stable has folio_size(new) here, fixed up.

I think we aleady discussed this, but there's a crazy amount of
inlining here.  pgalloc_tag_split() is huge, and has four callsites.

