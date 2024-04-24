Return-Path: <linux-arch+bounces-3938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACA8B1651
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6D1C21390
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF016E86B;
	Wed, 24 Apr 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RE5QUlyV"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210016DEDE;
	Wed, 24 Apr 2024 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998522; cv=none; b=XhdVhszAlzSDuyAF8KXvf/DFc+RF2Tzky2/pFOOBblIl5DDeEzBbxa2ud8DF5qpMjBJOtq/3CDeXz0TIt3Ro2PZoO9wy9Z6XE7CeKMYspHWCAMC4X6HPR+uzUPPzSQjZ/q4xzqgGI7+IjoOE8oN//y9N3elbZSjQCzoSA6lV5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998522; c=relaxed/simple;
	bh=I84fytRW8RAO4I14CXSokqeSS4YK/44PsOPnBAk8gSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKjUgaJbbGtENhLimanAVBRWF5df5VgW642bC9afqejF55RyIRjNvYQ5Gx2zBlZzSBop6uzQZEzreJtk25xcb0bspnw03jHGd9VMTI7r51qG5vOZncTgC8bjW4UXKjdF0dTluoVTXO92YOhaF9Km5GfdxSJKCuRNf7fxwJY9cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RE5QUlyV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WC01BChjfLiCxvTf81kaHLBrwZI8ocIBxX8N7T/Yecw=; b=RE5QUlyV3i854Efn5mgdt2iDsf
	RB5NXVlzPmUD48spV4HYj2oJcTLmI4QMgCIFURVCuSD2pxnQjesnzLaFUBrUgfUce/3Hf8EMSDkS/
	UeBYFNSok9xOOKBwDK1svwGsSzphKFrGZCFSuwqYip4nDqtTW0cZ9Np+6TWxcGMMR0legu/kfk4G9
	EZ1TcCVeCPKK2ffgaPOw151PEwE+jPlNWWC7c1Vq8Lvm2W7LYvz9zLNmAZ0Qq5zsa5XRUe23so/aC
	G5JDnadmOnznrDXzoDYEWoZmD4ek1OAo/6u3JxrFXPXTRG7Ay8HrgUUXj1rAfGGrAj2wbTrDM6BtN
	Ol+D4lxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlJ8-00000001pU6-173r;
	Wed, 24 Apr 2024 22:41:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D0FE330043E; Thu, 25 Apr 2024 00:41:41 +0200 (CEST)
Date: Thu, 25 Apr 2024 00:41:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <20240424224141.GX40213@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424191740.3088894-1-keescook@chromium.org>

On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:

> @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
>  
>  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
>  {
> -	return i + xadd(&v->counter, i);
> +	return wrapping_add(int, i, xadd(&v->counter, i));
>  }
>  #define arch_atomic_add_return arch_atomic_add_return

this is going to get old *real* quick :-/

This must be the ugliest possible way to annotate all this, and then
litter the kernel with all this... urgh.


