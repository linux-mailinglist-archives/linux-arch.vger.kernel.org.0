Return-Path: <linux-arch+bounces-8100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344899D5BE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F201F245C3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E11AC45F;
	Mon, 14 Oct 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnl/7lXS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F2134BD;
	Mon, 14 Oct 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927845; cv=none; b=rjaPjKKl7Mhv3MBUKFhGrcXu90k3Ai04euZzEK0/Kvk6ZqFZY8irmQaxmmy2mQx/14jLx8MUUbs9QdWcB+krCaaKtDqO6slmgaVSYEfk4vFtg6SR+PIyXyj9SFbnDotnWaKGmVZ5PVt2Jz/JezLOyKPzpjUK8uiy7U/obdUtB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927845; c=relaxed/simple;
	bh=NfOu+U/kGbnVFc1O3Injrm6T+UY+dKV9v07LidBjm7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJKuIzTDvUC3zhuFWUMFOJGnWJDcUmv1D0f9JE9r3R6C/wukaCSEZ9ja8uBo2IuwQ/NstvZ7Jh/TF1spEPxkGleOFWPGYCsnjWpAJKkk/iCV+3m3EKzA3vKJMFw/B70hsPSI+XpmQ9MNNH5uot+AK9cA97ALGB4tH91t7l8Fyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnl/7lXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021CEC4CECF;
	Mon, 14 Oct 2024 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728927845;
	bh=NfOu+U/kGbnVFc1O3Injrm6T+UY+dKV9v07LidBjm7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bnl/7lXSBDcXQSQpXizt0C0nTzew6FIKS+LWf9Kw8C1T7b7jMLq2AGO7M6+VCnWYa
	 BLN5MzeHEdRhKJ+hOU0vuU7DDXnTvCw6jkgpSzElizuSfMQGtaoAlpb2eTBKQfM1zO
	 bjI9dXpit6Dg6KUN9GKWOQWAgdDn9RT4/LHuu9MGzvpaknI0iye8PtNZY9SnGwHoCQ
	 gcZE25brQur9xcws2eLd04X0/dBvOOPjEuqC7gITb+p33vqSNCr8GQbaIZbqXo04Ma
	 PNhM+CKZ8sbKknt6PYOIVHJbUL97HEJYHKOCwKpry96aIzSLV5K4b8/08pwEdsrkvn
	 KOP3dEYeFpnGg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1327745e87.0;
        Mon, 14 Oct 2024 10:44:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwL3XSZgzDNfJ+17twBT5SuOAaTDS+Kv8aXvz9S1iVzV/T2h2k9fHzBrimeoSA7NDeDA+zU5wwukHh1kuV@vger.kernel.org, AJvYcCVfnGosJlDaQgkd4/y2xOcs27C1BGce0OWylwvsKljtHIVaoBBPDww9yZb2NI2GcEuh2tXfDiQacMGem20U@vger.kernel.org, AJvYcCWDPfFgkdarBZ5P0axglor8i5XJhYCzT5fjnd/EUUeOm8eXaqaIXGlFeNF0UX58WYu1JZPM0nKIKwVU@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFZNtGOPgsXXvG+GoEUQQn51BasIjHkGGovqgRERoiWofejUs
	/cCmzjF4YE4Id9NmmM1OM6c9mcmY59WiKfhkewgW5zwQHC4/sn4zE/mvewHTlqB/f0Dq8xY/omD
	kR0ng6upms0gkd6vp+0rvNbEDFQI=
X-Google-Smtp-Source: AGHT+IFgjcGwGJGSHKlO7QpDso667UoXGzPxbAShbvR5h2KAmP1C+JMGI1NYIOXsoPHkJkyjCAg8rvnK4mlGkYD1FuU=
X-Received: by 2002:a05:6512:6d0:b0:539:8f68:e036 with SMTP id
 2adb3069b0e04-539e552184bmr4136605e87.34.1728927843338; Mon, 14 Oct 2024
 10:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com> <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
In-Reply-To: <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 19:43:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFu=fABi+d=A5PL2yNx2b70toT9KtDfnvU=8mmUBHMutg@mail.gmail.com>
Message-ID: <CAMj1kXFu=fABi+d=A5PL2yNx2b70toT9KtDfnvU=8mmUBHMutg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use dot prefixes for section names
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 19:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 14 Oct 2024 at 05:57, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > Pre-existing code uses a dot prefix or double underscore to prefix ELF
> > section names. strip_relocs on x86 relies on this, and other out of tree
> > tools that mangle vmlinux (kexec or live patching) may rely on this as
> > well.
> >
> > So let's not deviate from this and use a dot prefix for runtime-const
> > and alloc_tags sections.
>
> I'm not following what the actual problem is. Yes, I see that you
> report that it results in section names like ".relaalloc_tags", but
> what's the actual _issue_ with that? It seems entirely harmless.
>
> In fact, when I was going the runtime sections, I was thinking how
> convenient it was for the linker to generate the start/stop symbols
> for us, and that we should perhaps *expand* on that pattern.
>
> So this seems a step backwards to me, with no real explanation of what
> the actual problem is.
>
> Yes, we have (two different) pre-existing patterns, but neither
> pattern seems to be an actual improvement.
>

We have this code in arch/x86/Makefile.postlink:

quiet_cmd_strip_relocs = RSTRIP  $@
      cmd_strip_relocs = \
        $(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
                   --remove-section='.rela.*' --remove-section='.rela__*' $@

Of course, that could easily be fixed, I was just being cautious in
case there is other, out-of-tree tooling for live patch or kexec etc
that has similar assumptions wrt section names.

