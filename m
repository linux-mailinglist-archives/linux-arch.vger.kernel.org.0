Return-Path: <linux-arch+bounces-14878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D390C6A021
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 15:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 465762C496
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E03570B6;
	Tue, 18 Nov 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxlviAJd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA43559FB
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476456; cv=none; b=Oz+eaO+ifncG/1kgOIluFSo8ZQcuC4yTYp1JbsEQvZSBa84vjlHFCeud2BDCg/50RTXld4p5H7b1mjDVEXGEhr+85mEKQL9zXXyHaXXW9UY+OM/dI/6LDc/r+eisCDW/dUgGUXhnuOy1rIw5vqA1BEA5SexvGevK1SQE5r2Ym3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476456; c=relaxed/simple;
	bh=oZw/G/YivSJQARxgSBgtPlPynJj/rFrGjeRiYZyYBDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaX0PcZrztU50/q46UkGkzQOW8ElV8zhMhbD/4Pr4YisHNGv3yl/kk9aqF7zHz/j43Z2eVWWoovCB3aUWyuv1uxaRA32jSK0YhCq7AJVPPjZUlfBl4QLfUrpQqNmBo7CAR+FGnE3y8RYvUVRPVr+7hwBS/g1EkurK7NRUBRn7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxlviAJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB94C4AF09
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476455;
	bh=oZw/G/YivSJQARxgSBgtPlPynJj/rFrGjeRiYZyYBDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bxlviAJdZ1MKRs9xB6Gq9WUHzMb85YhYtbV8pCrfw3ZMqUxhlrxbLEGuRgA0Quzqq
	 osx2mKbpGXoe2aSoEL0rF14dFkPonV69BvSdKTpk79EmWlPnhZfm2IlnYji/69uNuy
	 BsYgyZM8filtAPuuF0ghICfNZ12o0Xva4l12+m/ZQeKjqhflbqVH+uS1ZZdPsl6zC6
	 Ad1FaahpDWItf0ZvKAkFroyDoIFzIxPR8xUrNjjWJH0uAq6n4dELNC3n2nvEm7WMrp
	 F1d1a/lQo20QikOVQY0pQem3CeTFSOcE0pc85ewMFd1yHFN+0gmbpGLDmXMS00exGy
	 lZfU2wJY+Oyag==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so9404814a12.3
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 06:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvV7zjaTzNkTE/guPFql8CHBuoW1mJLpa+UzvsIDxeqkDTWpKg07lqr3qYrEdAweWvHp1C/YUqnR8W@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1B+xkMpc/wA6Dqq/DGR0PbVhFaN80leJA/tYqWg66U1I8/ts
	UWot4hvhxCwwXS3Nx3sKnX3CRHnFy2MQGWIskbNwkMpVuZEuh0B2a0VYQa+Ds/v2VYzA2mYo+Z1
	ooUl8lPaTWcT6cNitoxdG2tzXJaEPtnM=
X-Google-Smtp-Source: AGHT+IFy5sREltVG9yzsEtOi1XV0juUxvmkxQkiHNFl9nPlyLybu7jk/cbcs0JHoNBya8/YOWJ4RfsiEbxv5CcuO4Qk=
X-Received: by 2002:a17:907:1c27:b0:b72:b289:6de3 with SMTP id
 a640c23a62f3a-b7367bff073mr1771104066b.58.1763476454170; Tue, 18 Nov 2025
 06:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-13-chenhuacai@loongson.cn> <4155a60c-81da-4c23-8a66-9a748b3383e4@app.fastmail.com>
In-Reply-To: <4155a60c-81da-4c23-8a66-9a748b3383e4@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Nov 2025 22:34:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5__bTzjTbrHq++k3H+xuAfM5c-bLYa6A_GjHev8CbS4g@mail.gmail.com>
X-Gm-Features: AWmQ_blyY4_3l3ootl-6tRAwB4KzXAszmPGaIvnkWWY4aO1M43O19NNB_3Tr4do
Message-ID: <CAAhV-H5__bTzjTbrHq++k3H+xuAfM5c-bLYa6A_GjHev8CbS4g@mail.gmail.com>
Subject: Re: [PATCH V2 12/14] LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Tue, Nov 18, 2025 at 9:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> > Adjust VDSO/VSYSCALL because read_cpu_id() for 32BIT/64BIT are
> > different, and LoongArch32 doesn't support GENERIC_GETTIMEOFDAY now.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Are you planning to add vdso_clock_gettime() later, or is the
> architecture missing hardware access to the timer register
> on loongarch32?
Hardware has no problem, vdso_clock_gettime() will be added later.

Huacai

>
> It would be good to add some comments here to ensure this is
> done correctly if someone adds the vdso32 support later:
> There should be clock_gettime32 support, but not the old
> clock_gettime(), clock_getres() or time().
>
>        Arnd
>

