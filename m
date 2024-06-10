Return-Path: <linux-arch+bounces-4795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB990214F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566C61C20CEF
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D07E0E8;
	Mon, 10 Jun 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9nUgaSM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94B54650;
	Mon, 10 Jun 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021472; cv=none; b=AuNbKm/v5pXU+Wm2SovoQP2arpMd1XQOcO8B2LM3OFHU/qsCCAOcbm540JPn3RupwX9ZGeFZNjEDzTUl61NtDERns+f1/37w43/sDf1IWWM1W3XUf6kIRVRMlD6+/2nj+hHTH7w8YOqjcd/x9wpHfdjBdQDF0h5MgArr2lDiLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021472; c=relaxed/simple;
	bh=SsrJaSs+AW9uiyMtvLrmtA6q/qpj4vGmg7poeLERGao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv8fB/LxKnXqVTGNt6xbXzX6EOeSO9CZPaXs9jk4tcBitO/tCPvbhkWJ9w4iiofqFaoehrrduTfmzboZTPf9qhP48V7ME/vIt/bHBfWdhRLm67PKdqDNTnd/9zbfK7VQ+qXnhv27czslsekEHQ9ZiIg8SDVemUm0aaGefgD3urI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9nUgaSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD27C2BBFC;
	Mon, 10 Jun 2024 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718021472;
	bh=SsrJaSs+AW9uiyMtvLrmtA6q/qpj4vGmg7poeLERGao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l9nUgaSMc7ngDvAYxn0iXULpqduj+siCdU/vnWF4BNEb+GDqzBZeQ7zIK+rPBeOQ4
	 voIN6MFXYfbdZBEbFFC54AdSAI4MdogSYAvq7QeOh4iNFAeHJ/k7L7kyUXuWa92z0V
	 6PitmwDcvzF2OUihD78GY+U/vU0Avt1U3wWiF4ltw/i7ltpYdsUT+Mb/h1lndu04PI
	 6ZoIxJiwyMbY03c6lu88ceGJIym/36N1C7c1oR93FvugyO4ExyhKmcxO4tNxlTaBsr
	 0ELsWFxcCJCvLGCO+XcyhrfTu+5/cTWZ1U/tUUAX/BGr8R61iJHk0zhlD67UAHdMxD
	 4NPzgFRhT88PA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so5072181fa.2;
        Mon, 10 Jun 2024 05:11:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuAZmJyvQXK6S4tydY61Wi4cLRRqvd/45K6HFj4/qJum8G1mhs5SDVh+f39UPBirbiJGBEpTXK1FXhj6CR/hUe19TLE5vWRAjYr4AYAimIEJU0PSqtB7UcHPd4OI+DVpPcJDBpOzrqGg==
X-Gm-Message-State: AOJu0YxZEjIETl11Dd84+Y61bgwMmm2pJnWRGV+sqG9qODD1q19oOX/y
	4CI88R2g5wL+FyUP+FR9eEMZmYm9y7p31d/IYy2ZpHGXKFGnnrSticxsiwNIENBddhycf7iKSlk
	jsK9M0PN7XvLeC0cbNXVHd1YEEqg=
X-Google-Smtp-Source: AGHT+IHCJiixEuKZSjV2co47Y1/kzLQQDyIHYol2+BB/8nf3XYGpLkB0+VDrmw3tzRLVbmgNA719EUUVbdE/zdAcAho=
X-Received: by 2002:a05:651c:507:b0:2eb:df6d:6c36 with SMTP id
 38308e7fff4ca-2ebdf6d6df8mr27958071fa.4.1718021470721; Mon, 10 Jun 2024
 05:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com> <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
In-Reply-To: <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Jun 2024 14:10:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHyhv=J0v9eZKOgLd0xySrZmvnzmD=Oz398C5KS2=48Kw@mail.gmail.com>
Message-ID: <CAMj1kXHyhv=J0v9eZKOgLd0xySrZmvnzmD=Oz398C5KS2=48Kw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Jun 2024 at 05:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Jun 2024 at 13:55, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Think of this patch mostly as a "look, adding another architecture
> > isn't *that* hard - even if the constant value is spread out in the
> > instructions".
>
> .. and here's a version that actually works. It wasn't that bad.
>
> Or rather, it wouldn't have been that bad had I not spent *ages*
> debugging a stupid cut-and-paste error where I instead of writing
> words 0..3 of the 64-bit large constant generation, wrote words 0..2
> and then overwrote word 2 (again) with the data that should have gone
> into word 3. Causing the top 32 bits to be all wonky. Oops. Literally.
>
> That stupid typo caused like two hours of wasted time.
>
> But anyway, this patch actually works for me. It still doesn't do any
> I$/D$ flushing, because it's not needed in practice, but it *should*
> probably do that.
>

arm64 already has so-called 'callback' alternatives that allow the
patching logic for a particular alternative sequence to be implemented
by the user of the API.

A callback implementation to patch a movz/movk sequence already
exists, in arch/arm64/kvm/va_layout.c, used by
kvm_get_kimage_voffset() and kvm_compute_final_ctr_el0().

From inline asm, it gets called like this

static inline size_t __invalidate_icache_max_range(void)
{
  u8 iminline;
  u64 ctr;

  asm(ALTERNATIVE_CB("movz %0, #0\n"
                     "movk %0, #0, lsl #16\n"
                     "movk %0, #0, lsl #32\n"
                     "movk %0, #0, lsl #48\n",
                     ARM64_ALWAYS_SYSTEM,
                     kvm_compute_final_ctr_el0)
      : "=r" (ctr));

  iminline = SYS_FIELD_GET(CTR_EL0, IminLine, ctr) + 2;
  return MAX_DVM_OPS << iminline;
}

This one gets patched after SMP bringup, but they can be updated
earlier if needed.

Doing the same for the immediate field in a single ALU instruction
should be straight-forward, although this particular example doesn't
even bother, and just masks and shifts the result of the movz/movk
sequence.

