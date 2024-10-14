Return-Path: <linux-arch+bounces-8103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324399D64F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF681C22266
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC821C876B;
	Mon, 14 Oct 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLQJMeWZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26221FAA;
	Mon, 14 Oct 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929986; cv=none; b=rxaQtcDcxd+Z6gXhjmQHl/I2aZUViBGNo9cVlnLL/zuAElafoCj3N25iuxPryLB35ttI/KRo2e0w3dwjgl0mZhJPAtgSObOfGpgGrU0+r5iBSCbEKOg7GnOb1HnFdfJAw8d96aGqC8ZUmNKbRaliHrdOVX4tOmsbwxdXaWi3kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929986; c=relaxed/simple;
	bh=TxUCyeeMRm5Ud8o4aIEwmIXkL6gZ6PeV1NLiBEmUvIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqOBuzjvQUzzamxDPFvXQH6IMXaYz7iXXAo2NIWNxWX2/c3UcOw6sxOBi1oy1GrRzyI7vegPuyGOwBu+lIzx4wPOPbWy61yJI+5tYiz9/Zf+zDw1KG/Mb4OIM2EuS25qw4tR/dKFeGto5DFmSzDsO7W1dvPGfaY0UGUsYKh1MrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLQJMeWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB3C4AF09;
	Mon, 14 Oct 2024 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929986;
	bh=TxUCyeeMRm5Ud8o4aIEwmIXkL6gZ6PeV1NLiBEmUvIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KLQJMeWZmBRBilWM3CeyUn/o79CkeC+YNNkqYV6767Kb4j9xQPqBjuFD+FHkt1ONx
	 dBAMMWU21EVqxgXI93HwT7HhfdtHAr1dl6pn/QW2L2n0EIL2zEnLAb3MTpol1i+jqF
	 vmT//qe6x6hGxBxZUkKMgSAIU+IpKCw8gICfLuR6OPJnKf7sbkzb/eibObPhc8Wcp3
	 69x48BnXxHPUbuSDgnqo/t7ltAEatLU6MeRXko5mbq2AsQSQneMqEPhM+tYL0dyFWg
	 0lVe6PN+Pm7YubNvB2FLn4eq/qc4sDi2sXYk+w16AAlOXF4HVJjXNFYdDce4hsVb/P
	 aydqcMyjLGqBQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1936369e87.2;
        Mon, 14 Oct 2024 11:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfhz+hFYf4bCiduspliSRnbnPN0jTsQwuQUkgt9zUXpgVUwJYJrQuuZCCJcRVuctqYjlADlMZCNRA5@vger.kernel.org, AJvYcCWbDRBiuut00ol53XbDiQ4Eu1Jq7KUYf32h7zZ/bq25K/BneOLszqy1KSj2umWY54pxzE33FPaxiCEV4GxZ@vger.kernel.org, AJvYcCX47wZ39u01OtbkjePLFY6tvA3drApQW5JaTKwzS1afZvuixgHQD36lHDoRGtUfIVtrbsTbkrIst3s6FKs6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxao42DOX1tFcgTSuiDZtdVufE74xiro1TKyuySVNaHMCB6q1qD
	m/PTTQwQdGrR+Ot3j6YKGX6hHL4aONpMqvTQBle2ToD1slnSENk51Y5fhbGGdWTc2cOJ/mok7I6
	gE09sggZ86v1zSEmmokq/jPUxCY4=
X-Google-Smtp-Source: AGHT+IFalTDh2wE6xZEIhn9mgV3+/I7S44kAaMJvf18IdkYh70pwRaujyo7n88yZg0/BpxXhbx5ooo6luSKvrxdRAog=
X-Received: by 2002:a05:6512:3d15:b0:534:3cdc:dbfe with SMTP id
 2adb3069b0e04-539e55142d5mr4375599e87.28.1728929984515; Mon, 14 Oct 2024
 11:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com> <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
 <CAMj1kXFu=fABi+d=A5PL2yNx2b70toT9KtDfnvU=8mmUBHMutg@mail.gmail.com> <CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 20:19:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtruDm81Yor8hrOnSj7-J1vKKB1c-H0ZAtyMG_mZgWMg@mail.gmail.com>
Message-ID: <CAMj1kXGtruDm81Yor8hrOnSj7-J1vKKB1c-H0ZAtyMG_mZgWMg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use dot prefixes for section names
To: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 14 Oct 2024 at 10:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > We have this code in arch/x86/Makefile.postlink:
> >
> > quiet_cmd_strip_relocs = RSTRIP  $@
> >       cmd_strip_relocs = \
> >         $(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
> >                    --remove-section='.rela.*' --remove-section='.rela__*' $@
> >
> > Of course, that could easily be fixed, I was just being cautious in
> > case there is other, out-of-tree tooling for live patch or kexec etc
> > that has similar assumptions wrt section names.
>
> I'd actually much rather just make strip_relocs not have that "." and
> "__" pattern at all, and just say "we strip all sections that start
> with '.rel'".
>
> And then we make the rule that we do *not* create sections named ".rel*".
>
> That seems like a much simpler rule, and would seem to simplify
> strip_relocs too, which would just become
>
>         $(OBJCOPY) --remove-section='.rel*' $@
>
> (We seem to have three different copies of that complex pattern with
> .rel vs .rela and "." vs "__" - it's in s390, riscv, and x86. So we'd
> do that simplification in three places)
>
> IOW, I'd much rather make our section rules simpler rather than more complex.
>
> Of course, if there is some active and acute problem report with this
> thing, we might not have that option, but in the absence of any
> *known* issue with just simplifying things, I'd rather do that.
>

I don't disagree with any of this. CC'ing folks working on live patch
in case they have any insights.

Full thread here:
https://lore.kernel.org/all/20241014125703.2287936-4-ardb+git@google.com/

