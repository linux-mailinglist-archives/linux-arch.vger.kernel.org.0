Return-Path: <linux-arch+bounces-8101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681699D62D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7870D1F23167
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79A1C82F3;
	Mon, 14 Oct 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fzxm98e7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB51C3051
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929456; cv=none; b=AuWjXE9gLTET8/Qhw0urh200AxPe8ZY6wmZRWYaDJl4o67HmYCZk3ZEi6+6KypN+nyFn9mpfW+WZF5yLpnfKxHdiml7amQZnR2Ncq0BxzUTvlG2jsp0xXWFs50+mBlsPdv49hKhX2s7OKREE4o/ajaY33upa30hkvO1GV9f3fWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929456; c=relaxed/simple;
	bh=VypHTcUVue86TxJAIpJGKBY4Q20cHX/mFiRLyRntN9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EErC4snsYDe8xNTC5oTo5YMMTCWCF6tP7e3PaZrH8bj8/VfU5SSL4vbjD0l/w99U9ryU+sCjBhZ7aa8PLV41YtE1vHGz6HSnDdymmdU4YBY2Sk/fjbm408wtaNVEno2oIzknkXsItrUuytT+GQXKX+6hsR2UTbHjhlAJgzIqAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fzxm98e7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so567123666b.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728929452; x=1729534252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHeyIJea3ALM6cFmjzsfw35tNiBlMHJavKPAe3QhB+o=;
        b=Fzxm98e7W84vZExoLW9yGRcb5j/rZtMnd0NN8S7bavWsli2U5hD99JxoX6ikmckbl3
         eKU4aWGviqnkgW8uz+4kPetG5wFlGAtybbmGsTNarlgcVWSPHgZV4uEfGc2qea7cKluk
         o1BjmmidfdTMNgsJ3M7oiKmkHgmOhxW6HN5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929452; x=1729534252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHeyIJea3ALM6cFmjzsfw35tNiBlMHJavKPAe3QhB+o=;
        b=YA5UAjdhlB/ReNk2SK7ilv/CFwdaL5PxTDuLD+KO3bvPV94byH8110Dp7mUU7BXNPA
         PhCg9zXVEcHT2KF/TtrzvYCqgJYinC1jT6ye/uqFe4mETagUK6taTOhtCmnkre30Mrul
         kyaZjtqoJOu9wfic5+TfC3Vd/2DGY52lMOD71ky8ExpSDztCehLUL2XiEQFRRXPfeTIH
         RfLNrotjOReUFfRbmscoVOMLuvEYrmW9vCCh277h+RFdJKmM187NJ9TfWX/bmq3B0iCb
         fRI39pjWi3rWbTXMKhZqaI9MXWXI4Rurd19I6sc7jYURa7qmwypdkzoot1e6z5H5JNv2
         QFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQmyhh2OYhfR1MZvCcYD/U3diCc0rME6cqvcvS2P2nOsJ9U1elB7wrCmlRqfoeSWX9MGHr6GvTtgaZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7r91CGItNt+EOVC1s4FKmWdwA8B4kO7r2uJuTk0m83ZLFebLf
	K3f5TQ1vaAlUMje+sucPaB4AXW3ahgrx/217tjIlbrAaYr99WWw1tK/mJ5f8mpgwBEbwuiFfiEg
	LgHXJ2g==
X-Google-Smtp-Source: AGHT+IGcoh5T3FmfdIBbHTkNQ6B97tJWN764alG439+RsJrM4JPOXn5syHuvWIBjebBouWNtUrPvNQ==
X-Received: by 2002:a17:906:c10c:b0:a99:5f2a:444d with SMTP id a640c23a62f3a-a99b966b13dmr1134028966b.56.1728929452369;
        Mon, 14 Oct 2024 11:10:52 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a23f41ff4sm8370166b.49.2024.10.14.11.10.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:10:51 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso42483666b.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 11:10:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2IuxWKDA3jJ6LrCOwB0yq4sRVu0tXR9dt8oF7pKAxrHYrsqsDJDAp/lwP8GqoHBiuNjfE+B0TdMYB@vger.kernel.org
X-Received: by 2002:a17:906:df46:b0:a9a:daa:ef3c with SMTP id
 a640c23a62f3a-a9a0daaf058mr273908566b.14.1728929451045; Mon, 14 Oct 2024
 11:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com> <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
 <CAMj1kXFu=fABi+d=A5PL2yNx2b70toT9KtDfnvU=8mmUBHMutg@mail.gmail.com>
In-Reply-To: <CAMj1kXFu=fABi+d=A5PL2yNx2b70toT9KtDfnvU=8mmUBHMutg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Oct 2024 11:10:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com>
Message-ID: <CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use dot prefixes for section names
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 10:44, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> We have this code in arch/x86/Makefile.postlink:
>
> quiet_cmd_strip_relocs = RSTRIP  $@
>       cmd_strip_relocs = \
>         $(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
>                    --remove-section='.rela.*' --remove-section='.rela__*' $@
>
> Of course, that could easily be fixed, I was just being cautious in
> case there is other, out-of-tree tooling for live patch or kexec etc
> that has similar assumptions wrt section names.

I'd actually much rather just make strip_relocs not have that "." and
"__" pattern at all, and just say "we strip all sections that start
with '.rel'".

And then we make the rule that we do *not* create sections named ".rel*".

That seems like a much simpler rule, and would seem to simplify
strip_relocs too, which would just become

        $(OBJCOPY) --remove-section='.rel*' $@

(We seem to have three different copies of that complex pattern with
.rel vs .rela and "." vs "__" - it's in s390, riscv, and x86. So we'd
do that simplification in three places)

IOW, I'd much rather make our section rules simpler rather than more complex.

Of course, if there is some active and acute problem report with this
thing, we might not have that option, but in the absence of any
*known* issue with just simplifying things, I'd rather do that.

I feel that our linker scripts - and linking rules in general - are
already quite complicated, which is why I'd really like to take this
as a time to try to simplify the rules.

              Linus

              Linus

