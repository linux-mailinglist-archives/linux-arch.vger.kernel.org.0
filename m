Return-Path: <linux-arch+bounces-7661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B308498F37A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7841F223D2
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634661A4F1F;
	Thu,  3 Oct 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RPVqJf8w"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163C19C56A;
	Thu,  3 Oct 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971409; cv=none; b=VxLXDr1Chs/S2Zf0maZN8bQNOoa/GFcgsAuvwXjusevskoiqWzp/vXv7zgjSGMIqGU6+7KA3nIjuN/wX3pjzLQ3Q0E+kTj2eltXwev+PS6UqpwSMvoh4LsbspZzk0F5GIG1EbYRb3R2RK9q9xrR5I231gG696fwzh+AQP52FRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971409; c=relaxed/simple;
	bh=61qEN/YCscHNOig6i20As7XWTvl9SxCymkBybXoPYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx/129Onb/NurK7BY7u3p5+pIfY2G6Nt6LrfRmhNd3HO8WwTzH/2t4Mm05UwvQacaUpeAZsDY/WgwZU8c1sliPJBmbiqj21Pr5iu+uA9QAfR8BryZwEDNY2ELJLGkSr+kWyfSJHL3ZezKfT/QSs+bbJU2T9ddN+fo46snHI/2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RPVqJf8w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gpd5V+d+CGGGVKU2lsWnOPdzNPm+k/zF8I9UOAIh1g4=; b=RPVqJf8w7F9hXykHPNDPquHHS1
	VJg/35Evvgx5Ec0UO85NIYbZSBpkvyppu6p0CT1o4I17+5/COs0iVj2vqHyL34UCt6rvHAzYcv9Pq
	fZ5maKa8MHD/Ci06FS38QjqhTn+3y81adapd3VrvyvsKySrvVcwychRDhdMFyyUpUoe1FJfqNnRZV
	ZoVnsvkH0f+sAHGKfsPi1km4ujK73+4WW5GAU0y7ykgq3mCzM9slk+omHnDYhi60HEZW/Hxi7HfFV
	6hy3x5uVwh3xM+tZG69jB+hVNyrtKRF5aRJb7IebZxqoAsnNkSWPOjJCNWv3T/yVcRPPb35AWn8Bc
	rbyOUKaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swOII-00000003iT8-1hAy;
	Thu, 03 Oct 2024 16:03:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9DF4630083E; Thu,  3 Oct 2024 18:03:09 +0200 (CEST)
Date: Thu, 3 Oct 2024 18:03:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
Message-ID: <20241003160309.GY5594@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>

On Thu, Oct 03, 2024 at 08:51:51AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 3, 2024 at 8:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 04:34:00PM -0700, Rong Xu wrote:
> > > +6) Rebuild the kernel using the AutoFDO profile file with the same config as step 1,
> > > +    (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> > > +
> > > +      .. code-block:: sh
> > > +
> > > +         $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file
> > > +
> >
> >
> > Can this be done without the endless ... code-block nonsense?
> 
> Dunno, I think it looks pretty nice once rendered. Makes it

It makes it absolute crap for all of us who 'render' text documents
using less or vi.

