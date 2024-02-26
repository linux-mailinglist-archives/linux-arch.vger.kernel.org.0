Return-Path: <linux-arch+bounces-2724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952486761E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C9B2DE57
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1918002F;
	Mon, 26 Feb 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK1+HtAK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832760860;
	Mon, 26 Feb 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952283; cv=none; b=CX83Haseh1tTacA4ZWB8l0l4s0jIpWa7cJnqjSWCvJzCjQgUE8bKfingE46xYw7Mby3ukCutoQNdDZbY3qQujY/oVjAHAOq7cz9r6GgDrsWMmwff1I5LtpagKzpt7nJA88gnMw6w7444/EAxgOKwey7ixxI0dtmS7VNlCexCFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952283; c=relaxed/simple;
	bh=CjFIPUkkS+Qt/prOonASRo/mzH/YIL1BtI+UQyUBfKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiQNbWh3fTiugEKjonYT9fkAHDYebZWi06DbMRLHJkcPrLc8TfpMfvEnwc5e/CDYkhJrLaSHOSeHB6CKdgDHK2uszuWmXsrCs95UKgrqq94KNhAj96lKEw8JpHojnovOvvJN4b4Ydl2w38hGXUk73Rxgn9WbNwx5ME7xoHTOpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK1+HtAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F1CC433C7;
	Mon, 26 Feb 2024 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708952282;
	bh=CjFIPUkkS+Qt/prOonASRo/mzH/YIL1BtI+UQyUBfKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK1+HtAKtz9XUQba3ay0uwssAFD/GYurbGeO9bMf94k18HC61N+8sMd5TvNV9VTwO
	 V17qqAOyGjMk+Y6Sh3PodVeaLk5X4F97eq7uO2cJLcIMrwrfBmdfy5kVisuE6ZMBOD
	 a0bD3zSECVXQEH9OOXxWmq1iwRE7yYY6w0CfA7L/tttXQpLXeslaDfAVPlZAZw0PHj
	 nIjP/hhlB4UhtRwY9mhTGnWVa7GTMBhhys4NdsyVHT0PmiZxxnBcAxQ5pqSZx5GjR2
	 LnvKcV1ODtrNB66zzhGzMsP5FFFsVu8CE8Jxhzt0G4Xpcs4t4b2SvG2umy+79defWF
	 d4HERxjAX8vvg==
Date: Mon, 26 Feb 2024 13:57:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Arnd Bergmann <arnd@arndb.de>, Icenowy Zheng <uwu@icenowy.me>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Rich Felker <dalias@aerifal.cx>, linux-api@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Message-ID: <20240226-siegen-desolat-49d1e20ba2cd@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
 <6bf460d17b9f44326497ffb41e03363b112d6927.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bf460d17b9f44326497ffb41e03363b112d6927.camel@xry111.site>

On Mon, Feb 26, 2024 at 07:57:56PM +0800, Xi Ruoyao wrote:
> On Mon, 2024-02-26 at 10:20 +0100, Arnd Bergmann wrote:
> 
> /* snip */
> 
> > 
> > > Or maybe we can just introduce a new AT_something to make statx
> > > completely ignore pathname but behave like AT_EMPTY_PATH + "".

I'm not at all convinced about doing custom semantics for this.

> > I think this is better than going back to fstat64_time64(), but
> > it's still not great because
> > 
> > - all the reserved flags on statx() are by definition incompatible
> >   with existing kernels that return -EINVAL for any flag they do
> >   not recognize.
> 
> Oops, we are deeming passing undefined flags in "mask" undefined
> behavior but not "flags", thus "wild software" may be relying on EINVAL
> for invalid flags...  We *might* make this new AT_xxx a bit in mask
> instead of flags but it would be very dirty IMO.

Uhm, no. AT_* flags have nothing to do in statx()'s mask argument at all.

