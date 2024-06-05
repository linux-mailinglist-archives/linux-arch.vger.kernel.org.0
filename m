Return-Path: <linux-arch+bounces-4718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044028FD571
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9272F1F2A8DD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BC155C9F;
	Wed,  5 Jun 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ6XkXN+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EF155C98;
	Wed,  5 Jun 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610723; cv=none; b=IarnCvEzPIlE6v+nPQsJudxgNKKZseft8bTgQRFgwhelH1uZttoW2lKSxJvao7kqP3l+nLAZA/nywqDbs+lnwRIUuWkT5V51e88CN3r53aJx0IGYSRNg7WjD/xCwn24ddwOuKqd/d4eBduzF00vWY5ZbC52UC3mtvrCKfmttFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610723; c=relaxed/simple;
	bh=UUt/b2AZAbP2bHw0Kt5bQRKY/gANQoV5gU6Fp4AYwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN/8fgoV3QLCXIx8dw8fSt3sVMZdXnBGq079i0APtnv6IffwDi2IeQb3DGw2V6+Aukzqg3jw3deb6XWr+JwUHaDS3J6Edve2guu7chxAuwsw7+iQ7ANNydq4kB1FJPZIcjRc5/cF39jkSB5Nn1YLXInhzoGjj/yXGRq0XVxvOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ6XkXN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1981C2BD11;
	Wed,  5 Jun 2024 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610722;
	bh=UUt/b2AZAbP2bHw0Kt5bQRKY/gANQoV5gU6Fp4AYwpg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JQ6XkXN+sLx/LPKeHP7XRefg2ZOk/egCkFe9Zr9MZw/JRGYpC0932zOyDZJxQ1Xby
	 mKBv1Phn1REeUURvL4MRZI4H/P8EMsf+jNfFgPArkMYOsLm4JdVJvN6lTKWgMn0Htl
	 zO9/tvQeR5h+lV9c6VqHnJ0HY4JrdQZO3NdPb2n+KvN9cKAMuKzStOnDcphhGq7CT2
	 CJtW/ZpuvBPZBsvPQEp5WMzyO561FijopJUIILric3JBip0u9pzx4VjmUExahhGrGs
	 4tWUSxSpEOhkpNGYLOOgFeEp+COZyZuCFfrAvSzUamnifiaoP28COpvjImnbjRXnvh
	 pnqObZFbvt3fg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8152FCE0A73; Wed,  5 Jun 2024 11:05:22 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:05:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>, Eric DeVolder <eric.devolder@oracle.com>,
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
Message-ID: <6526c3fb-f4d9-458f-ae8b-6555dcb3b807@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-4-paulmck@kernel.org>
 <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>
 <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
 <CACRpkdYMiaMFmUoXyHdR9kLyAZma-24-m7cofztxd=n_Fr+GYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYMiaMFmUoXyHdR9kLyAZma-24-m7cofztxd=n_Fr+GYQ@mail.gmail.com>

On Wed, Jun 05, 2024 at 10:38:07AM +0200, Linus Walleij wrote:
> On Tue, Jun 4, 2024 at 11:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Thank you for looking this over!  Does the following patch (to be merged
> > into the original) capture it properly?
> 
> Yup, also fix the commit message to be == CPU_V6,
> with that:

Good catch, and will fix.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!  I will apply these on my next rebase.

							Thanx, Paul

