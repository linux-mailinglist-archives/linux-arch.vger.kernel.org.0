Return-Path: <linux-arch+bounces-4133-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB68B99ED
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988911F21D30
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD74626DF;
	Thu,  2 May 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEKEViO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A14605CE;
	Thu,  2 May 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648897; cv=none; b=XZqnYYs7K7c79g1FjMzyhuhLWLBwFAT4CsP84mbbr8ffifYBGDwdUogyUNXzF44secsfRWLQcbv08BmNVQH6Hgsp2bu9z1v9Wb4tegXZ0QmdNwxO+Xf9aKOJgwm+Gro8nvqjTU/ON4TWHVduiguMkqpjbx0VA92pasgd956FFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648897; c=relaxed/simple;
	bh=0ln9TXID18gsJMnDENXiItJGRtQ3Til5tzw9qOWE/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri+CVDNOo1jI28yXf34FJsPTKbqHucNCdUMUiLDmKTHJDkNL5PPBTBecK6+U7+gX33oBiHUSCTSikj047KAEaKvykKOrXHuYHx1xlyTIZ9POiA8dY9zNWZYPfrRdAkthpZJJUGMFD2NhQPQXGLcMyVUMqLIKzRVnC41+Yft4tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEKEViO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307A2C4AF18;
	Thu,  2 May 2024 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714648897;
	bh=0ln9TXID18gsJMnDENXiItJGRtQ3Til5tzw9qOWE/sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEKEViO8AxOjXR6iIdgwCu7M9Gy8KOg7xF4nyGPC+Q6kiqWHLioCWc+TKN1O1xGFU
	 R5r916favQUmXsHYwF3hhP1H4QIqQhlQ5wBll2sEvQCjHIUs30q9p6EEUJISyRnuoX
	 PHUjcgdQN9lWXGwzx/xhDdXqpWVdoLEkQ1youg+dV29CHaL49sDwtdB0b1hRj6Eg69
	 lcXC8doU0yUE99/DKUCyscpgTShpcBrE9CN7lHget3Yx3haAYwZdFxiJdtAF84yIlo
	 C6EgORkHpFEimOrGiEho7ncdyeWM6rlP3wOVXAEfpup/tHM7MZKMUzUJzKk2OPSgFw
	 Ug3evdCl5UR1w==
Date: Thu, 2 May 2024 12:21:28 +0100
From: Will Deacon <will@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: atomics: lse: Silence intentional wrapping
 addition
Message-ID: <20240502112127.GA17013@willie-the-truck>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424191740.3088894-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 24, 2024 at 12:17:35PM -0700, Kees Cook wrote:
> Annotate atomic_add_return() and atomic_sub_return() to avoid signed
> overflow instrumentation. They are expected to wrap around.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/atomic_lse.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

How come the ll/sc routines (in atomic_ll_sc.h) don't need the same
treatment? If that's just an oversight, then maybe it's better to
instrument the higher-level wrappers in asm/atomic.h?

Will

