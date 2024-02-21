Return-Path: <linux-arch+bounces-2546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9685D088
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 07:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14642287612
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18612AEF1;
	Wed, 21 Feb 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dqrHdjnV"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EE8464;
	Wed, 21 Feb 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497437; cv=none; b=W+g4sXcWtumS0ihpg0SOzSIQ7XwRpmMqicdc4N6kIa/VMlPWyVKvGon1xqi11KTkQychbDrDi/XrlQsUMGDNnsBSGYqhuHjEoiYVS+Pe4CC7+E0goQ7ayJ2xe9Mf6s+AstidfnVGD1wiv1z/gCfyn7fkCROUqVg4vc5n+t1kUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497437; c=relaxed/simple;
	bh=cMPrnGzN+ogkgu90StJkUN75mH793GVfs2DsMEIqQBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsnKL3WlBjX4Ktkt52cgr0PN3v/EVTP0OHdK8+Aj2fI/231/KJzZVaWLaPx/QWhEONiuUu3hXyahpKoC7zWJW2DUHGw3AplU+k9Qtf9FrCS91wU/bEUvaFThsXl3lwzjvLjAKQ5B+Jfxcd5nnpknQltVYp2+DtJlcKKAW3Sdx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dqrHdjnV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708497085;
	bh=cMPrnGzN+ogkgu90StJkUN75mH793GVfs2DsMEIqQBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dqrHdjnVqPyK89vn3kkQkzW2lVhL0QNWJ4PsjLlB/34Pos4Dx/HCA9zLywbogIoYM
	 wb0KbhaC+Nnx9JmLkJi/CTmGiMfeN1G+2mEL1nzXBDurpWS2SMrP3YWWL0ZX0mjef7
	 k3Y+Oh+OKywb/R/09Sk/Y/ouTw3NXbGxySqMVGcg=
Received: from [IPv6:240e:454:8210:4ef6:8084:b400:afd2:c12] (unknown [IPv6:240e:454:8210:4ef6:8084:b400:afd2:c12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5D42366F2E;
	Wed, 21 Feb 2024 01:31:12 -0500 (EST)
Message-ID: <f1a1bc708be543eb647df57b5eb0c0ef035baf8b.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
 Kees Cook <keescook@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, Miao
 Wang <shankerwangmiao@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, linux-arch
 <linux-arch@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Wed, 21 Feb 2024 14:31:02 +0800
In-Reply-To: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 14:09 +0800, WANG Xuerui wrote:

> - just restore fstat and be done with it;
> - add a flag to statx so we can do the equivalent of just fstat(fd,=20
> &out) with statx, and ensuring an error happens if path is not empty in=
=20
> that case;

It's worse than "just restore fstat" considering the performance.  Read
this thread:
https://sourceware.org/pipermail/libc-alpha/2023-September/151320.html

> - tackle the long-standing problem of seccomp deep argument inspection (!=
).

Frankly I'm never a fan of syscall blocklisting.  When I develop the
Online Judge system for the programming contest training in Xidian
University I deliberately avoid using seccomp.  This thing is very
likely to break innocent programs with some system change innocent as
well (for example Glibc or libstdc++ update).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

