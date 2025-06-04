Return-Path: <linux-arch+bounces-12210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FDACDEE1
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024A53A6F42
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF728F937;
	Wed,  4 Jun 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gKJV9Nw8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E128ECDE
	for <linux-arch@vger.kernel.org>; Wed,  4 Jun 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043290; cv=none; b=J1AuhD1qmPOjmx42/I5BzaKfgDoEfq66yr6Lh6Mb6bc386JUYOGG7djFe2ctIqACpr14c1SC80FyJhftm9SwUDaRkkW5Up6S+nAALtJpJ2XvvxtU+DmrD0LNjpspw4defg5i3XK+Euc5aq5QbMCsO8pcxp1DB1ca+KaagjVoKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043290; c=relaxed/simple;
	bh=gOlSzSaCZlQLzn4CBTyY41/yRuizYmxBDqri/ySzeDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKWqmuVj8Fkc/ae3Jv7XhF0Hl0tKYMWpaEhlX+WKACcxK3EV6elbtBeVK89QeFJktquVy5av+pJ8JvhJzCtyOcwwh6U3Urcom/fETCXzEy7tiIt5oORjGJ97f7c6pJPmeucP6dzKGBb0LL3OoHJZn69XWTn/5+h8tqqAFeQFkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gKJV9Nw8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so734825f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2025 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1749043286; x=1749648086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FoPPyZXh48zUhjz0K7ZmNXk3NCW+1EH6zXuwMWdtUo=;
        b=gKJV9Nw8LHWW0YbSHnEIBMwTjMU7U7P8T6IaRaVrtd6TgMQF3wWG1P1lCGa8H7+Sps
         adKVGE3NP2pAZ4jPy/m+OlqH0gektmSaa4hZTxJk2b9UcBlTfawyK/xv03Tys+Cu76a/
         K9QAiIXty+/Z+Ll2hM2ywB0W0U+3KSmwzTVa/35HNWAHk2732supD+ycFt2csM/G8+kb
         c8ZYBF4ueLVtUBGsGBKfto4tPd1p7hemp7rS+l9w0bjGvSjNwmROMmkr9/c2StsgNMBV
         bbh2rXCwP2qb2EsCgAjLgEFk5T8Clotq4EaW5rqGKqrbAIwQCcx+Mop7DQtvSw293KhC
         BMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043286; x=1749648086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FoPPyZXh48zUhjz0K7ZmNXk3NCW+1EH6zXuwMWdtUo=;
        b=vhRzmmt+3Kzqk1sfkPLo+F1lofV2YOf0FNu3mhTQgPu0SUzvZ845y7Ed+ONnUQKqIR
         YgZV+98Du0z35XYSAyqVENLuWIKqyrBs3v/R6FXsGwLqDsJyEer26PIKCJ58On+8OSpi
         rIlnqi7G/8Maqkps0IReT51MDBFzxN0IjkQ23KQOoV7RDCa/qFKgBKWeujx/dw2t+yKz
         DXve/5S2hu+SF8KQG1WpL/4AfRc282vybOouTnkage9Nc2s36roUS4cuL+pl6oRo9ECa
         f43LfG+p3bWyABPA3v/U2aNuYEOp71vzq2dxiqjIcH1K6CdOvEJbYaDhtIhtfNjPwudT
         RRTw==
X-Forwarded-Encrypted: i=1; AJvYcCVwstaDyrs6r96ZQ/sb219NkUPMETHyAo7dUbFj0rnUO9/i6Ptux6efG/rgTVwbDLLpyW6aI5aYCyfj@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPy6GUjYL5dPxM+99RtootSsUu8akUIol7/qLTwQtn+Piuc3h
	9yAMbVxNl/UWV/ok6RarQ6Q0dXO4oFBR/uuQnNSduuRVzDQfXBHD/IIkPSqC1AUJJyk=
X-Gm-Gg: ASbGnctvU4aD5NCzrtkG0np3Z7yVyAWF6iQyMsb0c9kl+FCO28WppkLzMg0bYWhUx8x
	TyHFFxx+VVuGmTwXc/D66SYKIzmVtFwXtwTpQ8VzJZAHCQqlgJY9DIuPNPes9a9lGE36S/I4yoT
	QxnJGvHiJfdPsHDU2SqAPIpOCRZXOEIsM2iCBg5J5rJdlc63+A2jDI2TvrCylgLfBzPw8Jkfuxi
	t8mRBG0ZmdX7nqoPH4bM7TDvmrkezj4Ly7EQCvsuZXmQAmhLELDdtBCY2q1Q0mGFoBj8b/MI+gL
	okNfLDgPwqo3Ry5hg6nJTIH1j7bZwCVzYnjEy261jKCxnBBj
X-Google-Smtp-Source: AGHT+IGwF9eqMWG6go6awjyG5qynWmhDup7h3GdgJcJVmsx6gfF7MJu3xHvCKuQq4UMz9D9H9ckNww==
X-Received: by 2002:a5d:45cc:0:b0:3a5:24cc:6d5e with SMTP id ffacd0b85a97d-3a524cc711amr548854f8f.3.1749043285998;
        Wed, 04 Jun 2025 06:21:25 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:da11:6260:39d6:12c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f00972e8sm22115596f8f.67.2025.06.04.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:21:25 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:21:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <20250604132121.GC1431@cmpxchg.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <aD3nFMS9kWHp7a4F@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3nFMS9kWHp7a4F@casper.infradead.org>

On Mon, Jun 02, 2025 at 07:01:56PM +0100, Matthew Wilcox wrote:
> On Thu, May 29, 2025 at 05:14:23PM -0400, Johannes Weiner wrote:
> > On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > > Barry's problem is that we're all nervous about possibly regressing
> > > performance on some unknown workloads.  Just try Barry's proposal, see
> > > if anyone actually compains or if we're just afraid of our own shadows.
> > 
> > I actually explained why I think this is a terrible idea. But okay, I
> > tried the patch anyway.
> 
> Sorry, I must've missed that one ;-(

Apologies for my tone. The discussion is spread out over too many
threads...

> > This is 'git log' on a hot kernel repo after a large IO stream:
> > 
> >                                      VANILLA                      BARRY
> > Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> > User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> > System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> > pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> > workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> > 
> > Clearly we can't generally ignore page cache hits just because the
> > mmaps() are intermittent.
> > 
> > The whole point is to cache across processes and their various
> > apertures into a common, long-lived filesystem space.
> > 
> > Barry knows something about the relationship between certain processes
> > and certain files that he could exploit with MADV_COLD-on-exit
> > semantics. But that's not something the kernel can safely assume. Not
> > without defeating the page cache for an entire class of file accesses.
> 
> So what about distinguishing between exited-normally processes (ie git
> log) vs killed-by-oom processes (ie Barry's usecase)?  Update the
> referenced bit in the first case and not the second?

In cloud environments, it's common to restart a workload immediately
after an OOM kill.

The hosts tend to handle a fairly dynamic mix of batch jobs and
semi-predictable user request load, all while also trying to target
decent average host utilization. Adapting to external load peaks is
laggy (spawning new workers, rebalancing).

In such setups, OOM conditions are generally assumed to be highly
transient. And quick restarts are important to avoid cascading
failures in the worker pool during load peaks.

So I don't think OOM is a good universal signal that the workload is
gone and the memory is cold.

