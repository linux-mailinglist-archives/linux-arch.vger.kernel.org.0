Return-Path: <linux-arch+bounces-7663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962998F3E4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CBE1C219AC
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991941AB505;
	Thu,  3 Oct 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DDl+6k7t"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0B1AAE10;
	Thu,  3 Oct 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971990; cv=none; b=dQTmKFB06Deu/961F092KuiZbUaopEl0GaoyLJt8O4DthXyA78ChO5pPSwq00a4xln++Hv+h4AvgkXkWz4GyOHnNONnnZp75D3D5SwTAP6Rzvo/kEsvCIV4N/M06zsFUQKdBgLHiW4iTHFICbxzrw0R2SyHzCDvwrNeVUIfi9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971990; c=relaxed/simple;
	bh=T8Cgc/gHHRgrkKf5Qi9Z34zTzlpQLyLMmWWUdvR3Aic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw2k8EtsFYXVbBLTcvVWp4IaCA19BOIJEeBezyPV7tnwhDUK/KV5qTJRp8YTCS3iflYWXRzfG7ltFlhqUgEnjckbg9sj7obawnnOHEbQ7TvyqSKKPPhLhukCvc+X5sU2Cpek23NqFPpzx42p721D/t7uVuBqndtwUPz4aWZzgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DDl+6k7t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hEcfuIGAIskv8Oce0iUVPJ3XBsfzajuHJThTZpyVaVE=; b=DDl+6k7tCl2tJW8xADRccoAmdw
	lt0d3vK689VZFTYTL7MhMRugM04JITw2epZ4/NxhjFmNYky4cDXWA7pcYA1QXmiIW6uVJgrtiKzVB
	Uug410fDZ7hB4l23sdRB5+KNxVyZgZF3J6WYF/cTND+aAlkW5uhKmlyVyzgzjVuWPQjti5y+EdoZw
	I/J+QDpb9sYzIOut0erfu5Ev8nDEJPmCkSOmnSdnGWoLK3CZmsyvUDAA6ESpgO2OR6BpOWBLkwPat
	lz/raurbo7HziXOFgPQkpDlRqD+/f63OczgD0NYwBLWz6NVPCFhNTgHW0KzTK8Z0U1eB0RkkL1/F3
	JvRnqVYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swORm-00000003iXS-06Mx;
	Thu, 03 Oct 2024 16:12:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A255B30083E; Thu,  3 Oct 2024 18:12:57 +0200 (CEST)
Date: Thu, 3 Oct 2024 18:12:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rong Xu <xur@google.com>,
	Han Shen <shenhan@google.com>,
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
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
Message-ID: <20241003161257.GZ5594@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net>
 <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>

On Thu, Oct 03, 2024 at 09:11:34AM -0700, Nick Desaulniers wrote:

> > It makes it absolute crap for all of us who 'render' text documents
> > using less or vi.
> 
> "It hurts when I punch myself in the face."

Weirdly enough I have a job that entails staring at text documents in
text editors all day every day :-) sorry for thinking that's a sane
thing to do.

