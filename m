Return-Path: <linux-arch+bounces-3818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF88AA995
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D39B218F5
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C047F5F;
	Fri, 19 Apr 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcCA9M5S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807EC15D;
	Fri, 19 Apr 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513438; cv=none; b=SmCbPNh5BGCQ2gXTJLg8iYRSVdwhNw03POfDoAzeBk9dbIDpmOUUCDy8u9NMSzT+SSMgjEADIer47lnZNkTuU78Jj/BCl5ypFE23Xd4hoOqC94HvtiFgfyBqdGp1neMFC8cm+ncF8zzjLklXG7qFhsky2RMyfnxJ3BeTvzTi1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513438; c=relaxed/simple;
	bh=1TZ8nYeFpnXiIoNsNPAlgLqamNWJVrnDVh0XwyAvwzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/pz1j1VUNCBq84dDLsFtatzHqLkbZskiU/vSvf/Nal9LihCNv3C/cRLv4zMPVeXchT/6pUm59qWVJg2+Bt52qaZdcpx8UEvF94eQp5K4Al8LgOHVtoeRzjfsB/13aWJavr2fSDXqUZeDsD2WEI8C2IaxWmUgrttNKwO4bkv60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcCA9M5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593BAC2BD10;
	Fri, 19 Apr 2024 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713513438;
	bh=1TZ8nYeFpnXiIoNsNPAlgLqamNWJVrnDVh0XwyAvwzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FcCA9M5SXyan3VbSbTysHYhgiqWpiiiiUIbLTKQOchML+tqiy0o0TOXQAdauqzJZj
	 QDHfDECqC8teTsw8Z2lkigcSQoIVLSQKkA+4jpjfnkJrrsbeBLm48RRwsVSqhz59ie
	 I9wtwjnZmJJh3CiR0Qp+zWdd/snZid+y8bqTDibsMiRuNSS5gP6ZdExGrKhAhGgo1O
	 2svJfDkem5U0s7ICLV4ZWb+M6JIYxnrBwkUtEOt/I2QOmDgQgItHswrjylGZPRQK9J
	 0h6c2dKJVNwG5+pu+zjyYRb3D/Y0ZrK1LSMmt2T8gXQ91Q0mwIf73uOgpYd6/HfZ4Z
	 i0sSrulhJg63A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so5607681fa.3;
        Fri, 19 Apr 2024 00:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/ZIu+GsHBvgKmaS5LlVWRTOzUg4+v9OtZ28izWuq9otIC+BDydoyXjXVEkLIIrNcUOfM6/8bQV2E/1zBlxEmdcsUgChB3lwgrvRx3o1T2GoWT8G0icVPLRBZyYkOTx0VGAisfY1OB4+0gUhS06KWktPgTwVeMC6j3nuDOsSDp82apNpzm4KGRhyNY01pM/C6p4Cbq3GNzPYWSBA==
X-Gm-Message-State: AOJu0YytF6LxqyglF3zuWRhE+B9V88ZqMDZhC9evtymWIS6dIY5m7i/f
	YhjBaVDhOQcCX7Noqt7XNV29/32fW3q3lS7ppON65HpqwZsxfm+YDa5ndZC4G/le81gMW6k7yVQ
	lviTeGL2NftBFA2r39dzmicXBYLs=
X-Google-Smtp-Source: AGHT+IGe0BXzWMTZhMt+wFll+Z29hCabZkKHmFp7RLlW1/LlIWEz4pzHm0vIJmiGDimQtO6B9WSAzRlWCg30klKUvqI=
X-Received: by 2002:a05:651c:4d4:b0:2d8:34ad:7f4e with SMTP id
 e20-20020a05651c04d400b002d834ad7f4emr930276lji.4.1713513436740; Fri, 19 Apr
 2024 00:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
In-Reply-To: <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Apr 2024 09:57:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
Message-ID: <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: patchwork-bot+netdevbpf@kernel.org
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	arnd@arndb.de, martin.lau@linux.dev, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Daniel Borkmann <daniel@iogearbox.net>:
>
> On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Weak external linkage is intended for cases where a symbol reference
> > can remain unsatisfied in the final link. Taking the address of such a
> > symbol should yield NULL if the reference was not satisfied.
> >
> > Given that ordinary RIP or PC relative references cannot produce NULL,
> > some kind of indirection is always needed in such cases, and in position
> > independent code, this results in a GOT entry. In ordinary code, it is
> > arch specific but amounts to the same thing.
> >
> > [...]
>
> Here is the summary with links:
>   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
>     (no matching commit)
>   - [v4,2/3] vmlinux: Avoid weak reference to notes section
>     (no matching commit)
>   - [v4,3/3] btf: Avoid weak external references
>     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
>


Thanks.

Masahiro, could you pick up patches #1 and #2 please?

