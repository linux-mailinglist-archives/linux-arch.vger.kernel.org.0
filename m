Return-Path: <linux-arch+bounces-4836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5E90441A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4686F1C23B08
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DA7407A;
	Tue, 11 Jun 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HARF3oQJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8A6D1D7
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132383; cv=none; b=Z6W+ZPyzHt4qvVDRbjetM6GNbTBZ4i06Ed0H1qpImlZ1UZqWuqoYYsaMjAnLEK/iIIPlpfNiWGDCLHr/rco/GvLJX5Gol5IzLpVmTMFT3jO/+8+oDsDZaqRgertP3aP0QtsgKxcd5zNFkeD2Fw4OUoV4oD1s7KrRZmlrf06Jfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132383; c=relaxed/simple;
	bh=94I3KscaFLWq+P7YGN1Fyl5KFoU2gBZQ1lhMwCwnJdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+OktCCHEpdhTwEac8XQEtqHG14qaxqSQJxfD7Tw4TRh+hjaX1QeL6xh1pRAJ+MIA16F4wISkO6z0YPpbyDdcVSfIM+F7SF+pWpZd6pkFodFgsRHjvDO+WXyjn+/rUbh2E6uRbY7ZGqMEjYFCzvwJX6z7fk6MU6jKcK2oiexn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HARF3oQJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so5515681e87.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718132379; x=1718737179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naqtn4h8MjWycYEp8tdkv+DK6jY/XqNOfy509OQj180=;
        b=HARF3oQJnZmuejk+ncC2yRQDMv/YQk/uTU6HDcr0rnr5YRWK9ckuhrFj11yUkCCuvw
         olLz8PB1S3saz2gw5cGFqiFUMJvjRyRaR2j01p14VgIPxrLbgPG93yFTIGptvQ2RImkt
         gO/nE7saP9nVX+Eqp3AsYVi7USpS6HflYh9AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718132379; x=1718737179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naqtn4h8MjWycYEp8tdkv+DK6jY/XqNOfy509OQj180=;
        b=TpJ8Ibr5RcazpRnJXE2hQHyr+462pcuxOaadSQRll0bHxLNMZ8O4/G/wBDg1xmDLsl
         mzIWy3pzj3cjK5SbmgRPm9oiDcJPNF4p/C7MvN1lEoEj8n0gJkrHG05XmoKrpCBSeWMi
         amkkijrgNAZr6DPrX/HC5mWC+LPwSBQn8k0IDD0Ii0nqkqA5n0wgjWsGkUJTbgMAdHrU
         qmtJWnXRc5sw4MTcERaXbct98tT8R0sI+UrfMQ7Y3Vb0TyJPP6gbAPenCZePYFIQGXuJ
         FIchBLr5ZiZJM5rkSwxTpU6zwgd8KS7Q7comJKIH4DYBVrRkIyO58o6l+3koM33exMI3
         2FEA==
X-Forwarded-Encrypted: i=1; AJvYcCWvH2pwPHP4jk3WdoJiX1tMOogI0YdMXwwTiw6Gt2QEpsU+tbC4Blc5Lap3JYCdSQUE/JmmaOUxP9B2iN8CiQIiljtyOUkFcBwK7g==
X-Gm-Message-State: AOJu0YwxwqSIWiBhtlSQf/tFlWGHuthKq0zsliUzxJC1pyCX+zCAZMwR
	L6wBAyIQBcLsmoBRLe8/C/bc5wUZypWU1Zkk7YHxJmHn9RhQItT9EtIhB5ls6KAQfQXHiMb24Dx
	Wq0s2Lw==
X-Google-Smtp-Source: AGHT+IGeRXxb3+vEcpzs00adn+wtJnC/cCVGX12hPpg8MfIzP+z6CwdiDxb6zfiN23kkF8wwqtSLDg==
X-Received: by 2002:ac2:4e8f:0:b0:52c:84ac:8fa2 with SMTP id 2adb3069b0e04-52c84ac9110mr4929251e87.7.1718132379265;
        Tue, 11 Jun 2024 11:59:39 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433c6absm2224055e87.251.2024.06.11.11.59.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:59:38 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so5515646e87.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 11:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoq7kOhp3L+iBR71PBtvd4WW452lPXpV5VIIYTeCbKFZ/nTY6c1b/mmaZrOsOpLx4Ud1wCH6hKqW9r1Tfj2TwvyPbqfIS3uOi4DA==
X-Received: by 2002:a05:6512:2254:b0:52c:9523:f0db with SMTP id
 2adb3069b0e04-52c9523f264mr2270564e87.45.1718132377816; Tue, 11 Jun 2024
 11:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <ZmiN_7LMp2fbKhIw@J2N7QTR9R3> <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 11:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>
Message-ID: <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 10:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll look at doing this for x86 and see how it works.

Oh - and when I started looking at it, I immediately remembered why I
didn't want to use alternatives originally.

The alternatives are finalized much too early for this. By the time
the dcache code works, the alternatives have already been applied.

I guess all the arm64 alternative callbacks are basically finalized
very early, basically when the CPU models etc have been setup.

We could do a "late alternatives", I guess, but now it's even more
infrastructure just for the constants.

              Linus

