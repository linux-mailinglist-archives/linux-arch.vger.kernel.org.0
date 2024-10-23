Return-Path: <linux-arch+bounces-8464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68F9AD039
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B48E284BE2
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19D1CB31D;
	Wed, 23 Oct 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKtQ4dhe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C71CACF8
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700611; cv=none; b=Gom+LyqGJb+IfXra1XXoJK6yQde0XU81dhArDqd5sG4ZG5z05Eh7AduUoVvmlM656pU9QBiUTEJ9OKAzCiAcCKzqdcuWAiPEYZ6VjN97BHs3f5SMY1amCW9iFPYkwpCIPG2lLRZ4oVmcZFIWGtKiJoWr7juqWcOHXhR5x8Dc9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700611; c=relaxed/simple;
	bh=+F9vNJ1/djrWjsipasBD8bhmQbboSFemBhQbuVC0gTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhdTf1vVHOzSAd4v3RimLEyCeWBvYAoZzfjrlh8awwu2VQsNUy1VeW0jLSu4/9lEMAh/UP1naHO50slDUpQY+mty/IyoSmWzm6KeDnB7hgfEG8v9QdVHYtBar6sqd2XZlAau7TsrxWDFq8K6Tjgv4/hSOghQLSOSWaN9UKfVa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKtQ4dhe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460a8d1a9b7so276191cf.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729700609; x=1730305409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9BznJlsEbHz6OZfmqFHe4r9gEp0tOVcj12rfA//KDE=;
        b=FKtQ4dheu9v73f/dgGQZvoEqZdIsRfdeC+1RPyNegiA88oR3l8LZdegLlKC5MaE7xg
         8a7VsjyzPwAyr/sjEVWRwQn8XblEHSBagI7Kr2Q0cmv8wKGOKdlQQsMeNAiv1ejI6vIV
         sU6nNUDiSWbT8NrXkoPCzD72A/cbJMY6MtEnObQOzC72ftkviUMVFjscqHEsUlQWHL/n
         X0p428EAnK5e8StpDo/Q4Nqa2KerCqH0O3rUDnuwbncolgIVEqarhyZP0bMqVNiMdpcO
         BUMaPOUQdyXLfF9PPAomzPpj2Yw0YWMRunfHUJpwaPjVmuEk2FAsDQ1f2RGj92ag+QJX
         9gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700609; x=1730305409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9BznJlsEbHz6OZfmqFHe4r9gEp0tOVcj12rfA//KDE=;
        b=fiNtVwwyNvI1w7v0U0TM9sXyRi4nneNLbUlVbEZIZdoreyV0KMK6v7kA4rdZeq884p
         VsSjGYly4M0aPyyo/Q6+Yhx6kFOi7CuPG7mA8RCv6mHgBFq8LRtZtQ47K/SFBBFkCAqq
         a9hi5Uhf37sqGwr7DOa5FEpy9+1DRUOA2/nUMUrou07Oj34joO0jnDSPji20KIVF0dTH
         GkI16ploFJIl1SIbYhCtMIEZyCpjFRdFICVnhzfdzSN6zCOTGbKYFlaxUY6GUXQSMeFc
         GCn1H2mhVaCX4ph8ZucH73cnbeHaCUJjqSjNDNQ/XSGDGjHuuN82B17s+6ei/LR8vcko
         OU6A==
X-Forwarded-Encrypted: i=1; AJvYcCXrSS5xggdRudvVCJ0ZsC2XDNNFQ4rsXAPj2YbLdvxjHlwxdHY0ihf9Jw2x+o6UyNzjH4xIIPiqh8c/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9OeAtxwUT6T5uplPEDc8T4EuDOorMynbYV9Mze+eo+wsd+J+
	qAAn4/yCsr2pmuwiw6PyB00WRtNUUGWyiEJWLVDCbxuBmrCnZcWOA1Xd34sxlzPkQOk92G0HZ1p
	+GjLK1N6D1C9cHCc822t2yVZul3muO47NEpst
X-Google-Smtp-Source: AGHT+IG1FMKW9jEoP384sXUW7ke85OPpn1MSvATc3a4GObiTP9bSiG7WRlmZKZlcz1ig7syTvhf9DR79c1H5TXpjIHs=
X-Received: by 2002:a05:622a:1347:b0:460:46a8:9e67 with SMTP id
 d75a77b69052e-46113afc61emr4399981cf.10.1729700608716; Wed, 23 Oct 2024
 09:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-7-xur@google.com>
 <CAK7LNARfm7HBx-wLCak1w0sfH7LML1ErWO=2sLj4ovR38RsnTA@mail.gmail.com>
 <CAF1bQ=Qi9hyKbc5H3N36W=MukT3321rZMCas0ndpRf0YszAfOA@mail.gmail.com>
 <CAK7LNAQr_EusZyy-dPcV=5o9UckStaUfXLSCQh7APbYh15NC3w@mail.gmail.com>
 <a38a883e-d887-4d79-bb52-f28f5efc99a8@app.fastmail.com> <CAK7LNATfdxBvFxhAQhAuWhVfqfFptCXvjRS2xcWmFFqYo8Qp-w@mail.gmail.com>
In-Reply-To: <CAK7LNATfdxBvFxhAQhAuWhVfqfFptCXvjRS2xcWmFFqYo8Qp-w@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Wed, 23 Oct 2024 09:23:14 -0700
Message-ID: <CAF1bQ=Rc_0xwq+7njaTf1EdsO0fyyKhcvMkC9AqcMf0mFsOt8Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Add Propeller configuration for kernel build.
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While Propeller often works best with AutoFDO (or the instrumentation
based FDO), it's not required. One can use Propeller (or similar
post-link-optimizer, like Bolt) on plain kernel builds.

So I will remove "depends on AUTOFDO_CLANG". I will not use "imply" --
simpler is better here.

-Rong

On Wed, Oct 23, 2024 at 12:29=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Wed, Oct 23, 2024 at 4:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >
> > On Wed, Oct 23, 2024, at 07:06, Masahiro Yamada wrote:
> > > On Tue, Oct 22, 2024 at 9:00=E2=80=AFAM Rong Xu <xur@google.com> wrot=
e:
> > >
> > >> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> > > +
> > >> > > +Configure the kernel with::
> > >> > > +
> > >> > > +   CONFIG_AUTOFDO_CLANG=3Dy
> > >> >
> > >> >
> > >> > This is automatically met due to "depends on AUTOFDO_CLANG".
> > >>
> > >> Agreed. But we will remove the dependency from PROPELlER_CLANG to AU=
TOFDO_CLANG.
> > >> So we will keep the part.
> > >
> > >
> > > You can replace "depends on AUTOFDO_CLANG" with
> > > "imply AUTOFDO_CLANG" if it is sensible.
> > >
> > > Up to you.
> >
> > I don't think we should ever encourage the use of 'imply'
> > because it is almost always used incorrectly.
>
> If we are able to delete the 'imply' keyword, Kconfig would be a bit clea=
ner.
>
> In most cases, it can be replaced with 'default'.
>
>
>
> --
> Best Regards
> Masahiro Yamada

