Return-Path: <linux-arch+bounces-2721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF33866C1A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279A3280CB4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD771CA9C;
	Mon, 26 Feb 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNmznQSW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E51CA97;
	Mon, 26 Feb 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936005; cv=none; b=FCgf22hHmP0VL5+rJeaohWGcICKIuW6alxOADmmwar5UDKh0AJu4IRVqy6PPum19ZvSvFlVSNdXEhqIq248yBOlhVMYu+JtHmGrq5vWeNUT1D3/WAyfhwpxn+4H3SKLznstB6c/mM5oCHT01jJekxsIVtlfnIlx28bXeMYZD11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936005; c=relaxed/simple;
	bh=haGI4n0YbA/4IGvdyThAvozbIdXURA6fZt37AbQcuwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofgLHtjW3ijlVWOheD4/5aMINbb0KdlIrEjS7WSFmhgfReTT2sj04CeBCuhNm6WPRjTWyFZgmfImBfoKn359HMuTXGbyBLzp/6TU19X+6g2OtcRjbrIYMf4BAGUMy2gtgNKVzynUQtL5Y9DGXTNUcU2qetpcyORMeV1SDX/8JM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNmznQSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF2C433F1;
	Mon, 26 Feb 2024 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708936005;
	bh=haGI4n0YbA/4IGvdyThAvozbIdXURA6fZt37AbQcuwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNmznQSWN2MhRkWhQYUIWP+Q7rle+L3MEZFkSXk5ZDHhsdKwJ3eKwV4yUx2xGVc4I
	 nULj0FswhucxGEgmahSlP9vZQFhLMOChl5XMThaYhBcYOhMGRu9lJmLes4bYQ86Ojr
	 SRE22RvpV0wPnWE+EZnfXbnSj8bp6h0jlq/aw+4smaqf+9FpCLumPKq+4k2ooPltCK
	 est+fM5foWvlrRE+Dikaboekn76SBl4/WXLB2TiOnMt0bWzd0usIgjp3890azDNTm5
	 chJjME7RTUEGY2OP1CYvdRqhUxiQJABmduh8XNhmVEZXqkPLY1D2ocCrIv5PgV0Yl7
	 h0lp69Wyrzwmg==
Date: Mon, 26 Feb 2024 09:26:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Kees Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Message-ID: <20240226-granit-seilschaft-eccc2433014d@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>

On Mon, Feb 26, 2024 at 02:03:48PM +0800, Icenowy Zheng wrote:
> 在 2024-02-25星期日的 15:32 +0800，Xi Ruoyao写道：
> > On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
> > > > From my point of view, I prefer to "restore fstat", because we
> > > > need
> > > > to
> > > > use the Chrome sandbox everyday (even though it hasn't been
> > > > upstream
> > > > by now). But I also hope "seccomp deep argument inspection" can
> > > > be
> > > > solved in the future.
> > > 
> > > My idea is this problem needs syscalls to be designed with deep
> > > argument inspection in mind; syscalls before this should be
> > > considered
> > > as historical error and get fixed by resotring old syscalls.
> > 
> > I'd not consider fstat an error as using statx for fstat has a
> > performance impact (severe for some workflows), and Linus has
> > concluded
> 
> Sorry for clearance, I mean statx is an error in ABI design, not fstat.

We will not be limited arbitrarly in system call design by seccomp being
unable to do deep argument inspection. That ship has sailed many years
ago. And it's a bit laughable to disalow pointer arguments and structs
in system calls because seccomp isn't able to inspect them.

