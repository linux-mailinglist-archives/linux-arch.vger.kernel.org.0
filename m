Return-Path: <linux-arch+bounces-15721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5907D0A932
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 15:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90EF03050593
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C335CBD1;
	Fri,  9 Jan 2026 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQbDIfcb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364433C534;
	Fri,  9 Jan 2026 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967896; cv=none; b=QkNO1ULHJ31seM0n/9qau7LIxw+pU2YDJ9awaZiwg0C9y9u144AmD67PWlZn75yqD+2sEFomPE0+U0jbwBvPl39uFff4BwVv6s+3rDIbh1Q13NqsSPAWM2WTCRzMWpDl9wxQobbJcFCee7RPtRUPNqMOe0G7G6PMsVlDFZFD6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967896; c=relaxed/simple;
	bh=Nc65wkMyCazsYeM+KI3rb7LhY4lOgQfED4l3qKX4Srs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/D8V3Z9RufBr02j4XXOKj/T4Ytmxne4GlU9+21rbnxm+Mkf8J7B3GjyoyDuWhMgB7pjBE+1UGg3ONTIS38+tpkAObjqkxm80OuKhFvkyBpphIF11eCRvGZ0A4ZJXjHTIR9SCjyXo1PQvUlQxXyQr9CEIgjLrxm/UTvoYpVsp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQbDIfcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03713C4CEF1;
	Fri,  9 Jan 2026 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767967896;
	bh=Nc65wkMyCazsYeM+KI3rb7LhY4lOgQfED4l3qKX4Srs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQbDIfcbMQHPYaONy0xw9eDeUtqr6fNL4fM5tkLehvmUCkfobfoEcTA0ebVhwOpop
	 euUY3QVP9Pw7W8GAbH9hSjYS43dpx26c5gkwD9TEnnb3/OhKE+UlE3J6/SG24oBLX0
	 lyoA3JT/+SjKXC1C3wrikvNCNmJuCErVX/X1N0fnffoxWU55+RywqExZsTwdkN6pMB
	 vsjz27RPhRNXlgXwSPIzwiEh0HHdKf9+iVPFnLI4P6QNKK5Pp4AR6KkGd33FYlhDU3
	 +vxOFyg5OmvWHtnmGNfR5hFgAxbm2LfbVj4+qlNzYv8eNP2iQNd8T98G4x3ov2t3Sh
	 dJC7MnnXMnjLA==
Date: Fri, 9 Jan 2026 14:11:28 +0000
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v8 07/12] atomic: Add atomic_cond_read_*_timeout()
Message-ID: <aWEMkHbBOgOkx_9f@willie-the-truck>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215044919.460086-8-ankur.a.arora@oracle.com>

On Sun, Dec 14, 2025 at 08:49:14PM -0800, Ankur Arora wrote:
> Add atomic load wrappers, atomic_cond_read_*_timeout() and
> atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/atomic.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9..5bcb86e07784 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -31,6 +31,16 @@
>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
>  
> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
> +
> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))

Please update the atomic_t documentation to explain what these do.

Will

