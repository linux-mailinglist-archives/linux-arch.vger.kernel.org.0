Return-Path: <linux-arch+bounces-6893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83F967EB0
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 07:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D42AB215E2
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019B77F11;
	Mon,  2 Sep 2024 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xPmsiXie"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8936D;
	Mon,  2 Sep 2024 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725253774; cv=none; b=J48TH/NdNMTsyQrm67q0Hoeaal0qC9ki9T734CINIFvDoR5t8QmnMrSeNU4/qPzgbVLykPasQZFMVOhzllKgU22Gw6aQ35QbTmzUUnKFzWR8FOse+Mbq7SYeG+6QosMUnjrextJPWVeB+WeAwkDrrkd2D+x2k6SSVvvqJKbnySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725253774; c=relaxed/simple;
	bh=X/fElT2v7UKGR0s9aVlSettPyqZsEXfP9WW0Hu8Sxck=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AML18a7hPnNVMJiJirf7X0iGfWdT2toeLdiMkD9YuvuTWNBziW6tG9AfSg1dAg5xfBriyHpethsjJ/688cmiNpu7rf2OPEvZXozksleGQ62baBH3F9rgOfPncffnu673m1WPB6eOJQ92dWpE2iablPh5kpOZjrvQKagzYbK36t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xPmsiXie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ECDC4CEC2;
	Mon,  2 Sep 2024 05:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725253773;
	bh=X/fElT2v7UKGR0s9aVlSettPyqZsEXfP9WW0Hu8Sxck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xPmsiXie4OcZUFHlMROAuktSHAy0q+wQlibAK2JCWTHsKT+MggqnGGI4ZHkr78fsF
	 qwpRxYfO51EDhHLxGdpez6MxCew2ofAwAQGAIASG8xN43Ug0owad7b6gSQnQ5qpKeq
	 yp/qX+OEINuNfJhP2Xlx4KsRkB44A0Zu9qSW30hw=
Date: Sun, 1 Sep 2024 22:09:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
 mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com,
 tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com,
 ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
 jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
 rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference
 size configurable
Message-Id: <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
In-Reply-To: <20240902044128.664075-6-surenb@google.com>
References: <20240902044128.664075-1-surenb@google.com>
	<20240902044128.664075-6-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
> page allocation tag references. When the size is configured to be
> less than a direct pointer, the tags are searched using an index
> stored as the tag reference.
> 
> ...
>
> +config PGALLOC_TAG_REF_BITS
> +	int "Number of bits for page allocation tag reference (10-64)"
> +	range 10 64
> +	default "64"
> +	depends on MEM_ALLOC_PROFILING
> +	help
> +	  Number of bits used to encode a page allocation tag reference.
> +
> +	  Smaller number results in less memory overhead but limits the number of
> +	  allocations which can be tagged (including allocations from modules).
> +

In other words, "we have no idea what's best for you, you're on your
own".

I pity our poor users.

Can we at least tell them what they should look at to determine whether
whatever random number they chose was helpful or harmful?


