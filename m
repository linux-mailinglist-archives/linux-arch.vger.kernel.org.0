Return-Path: <linux-arch+bounces-2730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FF86789B
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36391C2A856
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8BD12C533;
	Mon, 26 Feb 2024 14:33:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863C433CE
	for <linux-arch@vger.kernel.org>; Mon, 26 Feb 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957987; cv=none; b=YZQlFovBmjKdPNtpZLtMcM/gjhcN8/xO/GWULnSq/94ra9frjy/JuxHFFG+vOwAYpa4QPtsN8bdtbgCZ3xgCSdjR1wCxojgpr4ha0dutCJTH2A1FXpnZOKlUnYcPbTJeuAbJIeE9DESbC5nuX4qZQeGL+6zs2xaq9GM/LxC6Qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957987; c=relaxed/simple;
	bh=8lBjv3w8DA/De0xjG4YAOs58xFeChbpwlxvyyaVDuRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S408kMnFGL5ft411yWA6W2D/NFcIagaxkv3C9TN29I8i+do4w1W08TQrWpR29GtU1UtBQqCieCd+LZI5BXvVjjB0i/kNsBizqcOQVxKUWDu72vBDKLgeh4b8V86vKwcCb2QQOOe2yRdxpRezkL9B3pcjqp83oUE882TV2bYWsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aerifal.cx; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aerifal.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Mon, 26 Feb 2024 09:33:16 -0500
From: Rich Felker <dalias@aerifal.cx>
To: Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Arnd Bergmann <arnd@arndb.de>,
	Icenowy Zheng <uwu@icenowy.me>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xiaotian Wu <wuxiaotian@loongson.cn>,
	WANG Rui <wangrui@loongson.cn>,
	Miao Wang <shankerwangmiao@gmail.com>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Message-ID: <20240226143315.GA22081@brightrain.aerifal.cx>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
 <6bf460d17b9f44326497ffb41e03363b112d6927.camel@xry111.site>
 <20240226-siegen-desolat-49d1e20ba2cd@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226-siegen-desolat-49d1e20ba2cd@brauner>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 26, 2024 at 01:57:55PM +0100, Christian Brauner wrote:
> On Mon, Feb 26, 2024 at 07:57:56PM +0800, Xi Ruoyao wrote:
> > On Mon, 2024-02-26 at 10:20 +0100, Arnd Bergmann wrote:
> > 
> > /* snip */
> > 
> > > 
> > > > Or maybe we can just introduce a new AT_something to make statx
> > > > completely ignore pathname but behave like AT_EMPTY_PATH + "".
> 
> I'm not at all convinced about doing custom semantics for this.

I did not follow the entirety of this thread. I've been aware for a
while that the need to use AT_EMPTY_PATH (on archs that don't have old
syscalls) is a performance problem in addition to being a sandboxing
problem, because the semantics for it were defined to use the string
argument if present, thereby requiring the kernel to perform an
additional string read from user memory.

Unfortunately, I don't see any good fix. Even if we could add
AT_STATX_NO_PATH/AT_STATX_NULL_PATH, libc would not be using it,
because using them would incur EINVAL-then-fallback on kernels that
don't support it.

In regards to the Chromium sandbox, I think Chromium is just wrong
here. Blocking statx is not safe (it also does not work on 32-bit
archs -- it breaks time64 support! and riscv32 doesn't even have
legacy stat either, just like loongarch64), and there is really no
serious security risk from being able to stat arbitrary pathnames.
Maybe it's annoying from a theoretical purity standpoint that you
can't block that, but from a practical standpoint it doesn't really
matter.

I'd like to see a solution to this, but all the possible ones look
bad. And it's all a consequence of poor consideration of how
AT_EMPTY_PATH should work when it was first invented/added. >_<

> > > I think this is better than going back to fstat64_time64(), but
> > > it's still not great because
> > > 
> > > - all the reserved flags on statx() are by definition incompatible
> > >   with existing kernels that return -EINVAL for any flag they do
> > >   not recognize.
> > 
> > Oops, we are deeming passing undefined flags in "mask" undefined
> > behavior but not "flags", thus "wild software" may be relying on EINVAL
> > for invalid flags...  We *might* make this new AT_xxx a bit in mask
> > instead of flags but it would be very dirty IMO.
> 
> Uhm, no. AT_* flags have nothing to do in statx()'s mask argument at all.

They definitely cannot go in mask; that's semantically wrong.

Rich

