Return-Path: <linux-arch+bounces-12145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9FAC839C
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5403A6A39
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CCF20E00A;
	Thu, 29 May 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OHMTkxR7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6681D63D8;
	Thu, 29 May 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554296; cv=none; b=nY4AT+S5gnGSHA+D+8A2q9QwU0r76bwYlDY5+o07cWzSvfU/Bsz2Jg/iiwHe1TrXmGaYnhgX4L4yLN0GFK6Y7rk/QoXHYGW1dtQBzZ8BmagsNJDreQlYx26L9Ro9/llwJh5Ex6O+JVqpmxvouas2eRwoclX3T6sgfO7R4jvhYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554296; c=relaxed/simple;
	bh=24J7hnSNm1uw3mEgE31KPQL8dhDGCtL3IZ027WICqx8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W0KCmmRLkDU0twC5yRw/A/Jy8rKXDga6Bd31OCh7b4ArVVswhEjv7zstgplFgozUeYch4FSOgBXo04kaHfZagO7XIyraX0mk2sJMsaZ19/euze5O5KN6+QQOCosDpnz4rnjUs5AY5JLq74G5hS48UTNaT1X16aXHNukuERBziuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OHMTkxR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06688C4CEE7;
	Thu, 29 May 2025 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748554293;
	bh=24J7hnSNm1uw3mEgE31KPQL8dhDGCtL3IZ027WICqx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHMTkxR7OzCENCECw7Cm8RvBt0XqphjOkaMbzv34OUHnZ5R0CeJapNpDxOQTpjt5o
	 +7unNKYQlFjV3mF1oB88TTmE90OZvStPudpLJqLjgTFLxbd+ymOlgeYBC1i6Riclw7
	 k5yfzT/nZUoce5KTvqXh4FeLMXWW4vICXUUvbd3k=
Date: Thu, 29 May 2025 14:31:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, Vlastimil
 Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, SeongJae Park
 <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>, Mike Rapoport
 <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Barry Song
 <21cnbao@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Pedro Falcato
 <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-Id: <20250529143132.b22099b8ce3452bbba25f813@linux-foundation.org>
In-Reply-To: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 15:43:26 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

>
> madvise()
>
> ...
>
> process_madvise()
>
> ...
>
> prctl()
>
> ...
>

Yeah.  I think there has always been an attitude "ooh, new syscalls are
scary and I probably need permission from someone so let's graft it
onto something which is already there and hope nobody notices".

New syscalls are super easy and are cheap - it's just a table entry! 
If it makes sense as a standalone thing, do that.

> The proposed interface is simply:
> 
> int mctl(int pidfd, int action, unsigned int flags);

Well, why `flags'?  One could even add a syscall per operation. 
Debatable.

> Of course, security will be of utmost concern (Jann's input is important
> here :)
> 
> We can vary security requirements depending on the action taken.
> 
> For an initial version I suggest we simply limit operations which:
> 
> - Operate on a remote process
> - Use the MCTL_SET_DEFAULT_EXEC flag
> 
> To those tasks which possess the CAP_SYS_ADMIN capability.
>
> This may be too restrictive - be good to get some feedback on this.

Permissions needs careful consideration on a case-by-case basis.
Clearly in many cases, user A should be able to manipulate user A's
mm's.

And if different modes of mctl() end up with different permission
structures, one wonders why everything was clumped under the same
syscall!  mctl() becomes "prctl() for memory".

Anyway, fun discussion.  I'm with willy ;)

