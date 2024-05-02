Return-Path: <linux-arch+bounces-4149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67E8BA2FC
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3450C281033
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F057C9B;
	Thu,  2 May 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iMB91K3R"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB857C94;
	Thu,  2 May 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687689; cv=none; b=dxbW/yG93XyWCA6vg+rl53UGW/sW/fMjqrDu09FtWApsXGl+9BQ026z4WgitCzhhFA03quoUpWoLqrUXg1NCYUqvuwR/HAB2kmpYxaQJwNtJENYwsHsVQ5DSAggsK1x54fgRD575F0V2OTmnm7F/r17anR3p2LK8gdwB3DJharA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687689; c=relaxed/simple;
	bh=/BAA5c79Wa7t4adxxNrqVPJhat8YkwbF3fqHNiTElJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImMwHr7//reBGpijhVOOs/Kl51aYeurLn/dvkcuvH1YYjqqNTypmTqeIwP6tg/+XUilXD5bqG26nymsnE4np5SVlHyLxAXTimdwO9M8gD8y0Qs1D8h7fiGtEDTkBYmiuFmmqGjRu/0N2zwRWylI3cpqpB0tZl2vPFOXgy7FF+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iMB91K3R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=seYHSXYkV1trl6VN0DlFpuplz5ntu1a0/ARsq6mIPMw=; b=iMB91K3RforkLDg+IiiJljEU64
	s1gVrMrepR2bqqyq7rLOjT+iVFWY8zz9TIUdWpzKLpL6h1SGUlkE4dx0ET2glWeaTfrIM3O5VLZuT
	c1a7HDulqaJpejzz4pMNT7VtWHQThqJKb36umYdCtKfidTWztFylpuTcZ2lLNS+2RDEyayqWJzm85
	olAGeWrCMbHnGElrcvdC+RiG4TR1FfgW3Ll/HDHncJIjA3cfs7+GjlkVA+xvjrcXvH/+y3rBVphy2
	bkbxWVapuHZ4UcQPAdfyjo+aWKglyhAeIi5OsfF6ZGyDc67fR3LSJt2RTXOqrTIMJTY6gA9+V6r9+
	htWlt8gA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2ear-009naF-2z;
	Thu, 02 May 2024 22:07:58 +0000
Date: Thu, 2 May 2024 23:07:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <20240502220757.GL2118490@ZenIV>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 02:18:48PM -0700, Paul E. McKenney wrote:

> If you are only ever doing atomic read-modify-write operations on the
> byte in question, then agreed, you don't care about byte loads and stores.
> 
> But there are use cases that do mix smp_store_release() with cmpxchg(),
> and those use cases won't work unless at least byte store is implemented.
> Or I suppose that we could use cmpxchg() instead of smp_store_release(),
> but that is wasteful for architectures that do support byte stores.
> 
> So EV56 adds the byte loads and stores needed for those use cases.
> 
> Or am I missing your point?

arch/alpha/include/cmpxchg.h:
#define arch_cmpxchg(ptr, o, n)                                         \
({                                                                      \
        __typeof__(*(ptr)) __ret;                                       \
        __typeof__(*(ptr)) _o_ = (o);                                   \
        __typeof__(*(ptr)) _n_ = (n);                                   \
        smp_mb();                                                       \
        __ret = (__typeof__(*(ptr))) __cmpxchg((ptr),                   \
                (unsigned long)_o_, (unsigned long)_n_, sizeof(*(ptr)));\
        smp_mb();                                                       \
        __ret;                                                          \
})

Are those smp_mb() in there enough?

I'm probably missing your point, though - what mix of cmpxchg and
smp_store_release on 8bit values?

