Return-Path: <linux-arch+bounces-5281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715909287E3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278151F219EC
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1B148844;
	Fri,  5 Jul 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JajDcWBb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1721474A4;
	Fri,  5 Jul 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178708; cv=none; b=aP/GSL8lrGmmC4f9IHoRy/A4A1goMCQn+ac+yvvqi8zKeVGYtqevC1jiKRj6AylwgHaOa5uJ5HtzJnUyKlplgqPY+nYDfthS17QsCs15pct+UgkZobcn1UjqMaQa4umxb0JTudv16BmE2Hag7lFQ6ZLqJwU+/aGM/VTQv6qe6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178708; c=relaxed/simple;
	bh=zL5UUf2rkWrONcbOjBn83uC70xqxiAQyDDUJsHOHsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYiKTtPNI59Ta3JMq/jzHFouVLnXsWGB/woCqq6+5veUSCUiJH4ofhIjWZU7/dGWT3ohc1QP+0zbpxHEs69nH835IQo6HVTx5PDOUaGBcHakYzIWrL/m0eQXeGnpsqYzcXlB6JmC6CoDbDXBrflliScpRjXvNSw48ig1YIRZ8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JajDcWBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5916AC116B1;
	Fri,  5 Jul 2024 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178708;
	bh=zL5UUf2rkWrONcbOjBn83uC70xqxiAQyDDUJsHOHsDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JajDcWBbQaWDymEAoQxk7KNr7A7ds2MRAtRX3kPJl8DLJHNsXwiR9ddtSy+HXRW30
	 FKhK+vaaJcJZy9w9DCwXTr9brYqFR+YMlmjrMwxt8g5JfLDmg/FhSbCVabLkszvj2i
	 4t85IXZkCbNvuosNctIDV9RSmkXEtPI0Qi3WutCEdGlKm75psFaYna/8I7qDqH4Yjx
	 YOpW9faSUmPnTvss4WT/gbKbbG8i+fZm5NJTVAMzeVrl2Mgw/+UZrLylwUKrmTWUx8
	 DCrYY12yfv4dS30Tbv4W360xxwabRn9ohKXHIpEoF7sD3fJJkwqLweBNdYBDtoYr/d
	 e6hNklBJlSRPQ==
Date: Fri, 5 Jul 2024 12:25:03 +0100
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Message-ID: <20240705112502.GC9231@willie-the-truck>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jun 30, 2024 at 09:59:36AM -0700, Linus Torvalds wrote:
> On Tue, 25 Jun 2024 at 11:12, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But yes, it would be lovely if we did things as "implement the
> > low-level accessor functions and we'll wrap them for the generic case"
> > rather than have every architecture have to do the wrapping..
> 
> Btw, to do that _well_, we need to expand on the user access functions
> a bit more.

[...]

> Will/Catalin - would that
> 
>         src = masked_user_access_begin(src);
> 
> work on arm64? The code does do something like that with
> __uaccess_mask_ptr() already, but at least currently it doesn't do the
> "avoid conditional entirely", the masking is just in _addition_ to the
> access_ok().

I think we'd need to go back to our old __uaccess_mask_ptr()
implementation, where kernel addresses end up being forced to NULL. In
other words, revert 2305b809be93 ("arm64: uaccess: simplify
uaccess_mask_ptr()"). If we then want to drop the access_ok() entirely,
we'd probably want to use an address that lives between the two TTBRs
(i.e. in the "guard region" you mentioned above), just in case somebody
has fscked around with /proc/sys/vm/mmap_min_addr.

Will

