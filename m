Return-Path: <linux-arch+bounces-12286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48AAD1953
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D8C3A9BAA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336F280A52;
	Mon,  9 Jun 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHVe0TfS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E1155342;
	Mon,  9 Jun 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455539; cv=none; b=LGHhgJIN44ntERxMrM6WZXSyHFcLbYbGI+e4nUKP+XL7rQOg7DDtD9i63VzhWQyBaJsUhn9t5lyhFhnuCz9J36g6NmCBrWp2KwtQTO+JJNAYa3T0iC1MrBTXyt9bg3r+8OQfvH5rfBPIsSZbX9yoZQEGSCnJ1mH8mfcysyM4FeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455539; c=relaxed/simple;
	bh=BTR/+BDfpyqb4CQUH6yv9SYEkc+AI0IUKUwHqaIgIGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnhBgk+CJHLIHBrVys04Xm+ynOf+S49xrXQz0MBCDwfX1hoHbVkGKZgpcBVjPXteqqzMtkjttGQu/cAVkSa2G8+zohwkQ+ojN0kZgGto1KCKHK0gO5lYpibdHYhvpW3jgl6gbKmEw8QPrFftxLHzxRNrbBMPiDAgOXsE2doiB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHVe0TfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D55C4CEEF;
	Mon,  9 Jun 2025 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749455538;
	bh=BTR/+BDfpyqb4CQUH6yv9SYEkc+AI0IUKUwHqaIgIGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHVe0TfSTdBDOdv/NXfI90O+E7DsN3VJgpmW8qxET7Ad+1aD7J7NGHgAllTwb3LX8
	 k+MBzDzhQ8vv+1EM+jYm1/o2QYHYDO8jRf7u4VF1NLUae8+RpE/4Nt2oMdcaEuAYLk
	 sYG1CmMpwpTxsVhLH5rorlvHjdNygejTLWCsTEBu7O3sbNodmjmqQLaVrNzfZxaDNj
	 wbiu0FZnYV0M1aOG6Wue8HbSAfnSwcIvBma34Ilr2VBWQeHLZ4mLLhJcfor5g+yx4k
	 pYRixcOsTmB8j2hTFcT7VQy+r4pEP1C8d10ZODDP/Xm012dLR5pTrontxxvq+DDi1n
	 yyvzFIjQXBL8Q==
Date: Mon, 9 Jun 2025 09:52:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 00/15] Implement CONFIG_DEBUG_BUGVERBOSE_DETAILED=y, to
 improve WARN_ON_ONCE() output by adding the condition string
Message-ID: <aEaSr7XkRT9icKZ7@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250522213944.5ba1eabc@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522213944.5ba1eabc@pumpkin>


* David Laight <david.laight.linux@gmail.com> wrote:

> On Thu, 15 May 2025 14:46:29 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Changes in -v2:
> > 
> >  - Incorporated review feedback:
> > 
> >     - Make the expanded strings conditional on the new
> >       CONFIG_DEBUG_BUGVERBOSE_DETAILED=y switch, to address concerns
> >       about the +100K kernel size increase, disabled by default.
> > 
> >     - Expanded the Cc: fields
> > 
> >  - Rebased to v6.15-rc6
> > 
> > This tree can also be found at:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git WIP.core/bugs
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> > =========================>  
> > Original -v1 announcement:
> > 
> > This series improves the current WARN_ON_ONCE() output, if
> > the new CONFIG_DEBUG_BUGVERBOSE_DETAILED=y option is enabled,
> > from:
> > 
> >   WARN_ON_ONCE(idx < 0 && ptr);
> >   ...
> > 
> >   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
> 
> What happens if the condition contains #defines?
> Does it output what is in the source file, or the (bloated) expanded text?
> For instance:
> 	WARN_ON_ONCE(min(foo, bar) < baz);
> doesn't really want to show the expansion of min().

I'm using the '#' 'stringizing' CPP token to stringify the expression, 
which doesn't expand macros but turns macro arguments into string 
literals:

	WARNING: [ptr == 0 && (min(0,1) < 1)] kernel/sched/core.c:8509 at sched_init+0x20/0x410, CPU#0: swapper/0

Thanks,

	Ingo

