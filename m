Return-Path: <linux-arch+bounces-7700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912879909EF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69BC1C209AA
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310091D9A53;
	Fri,  4 Oct 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gj5z4rIy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839361CACC0
	for <linux-arch@vger.kernel.org>; Fri,  4 Oct 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061607; cv=none; b=nCHJZEapZrWw1cmPtbaS4pgt0icPUmZJoKdGiGdKxoq/HewFeHXhQrv7Xb030hPPHCgJhE9V8SufKcgYLH+uwPNZsEXAPdMaXOZd/LWPRkg5rduDlHQ3zSkf5EmOduA+RtdzWGU1SZ/rS8/6QxY1G7nQRaSCsHuriNWJ4NQ6JIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061607; c=relaxed/simple;
	bh=BjiMOaBbb0faHgkP9UM7KVpOSCigooWaCDDnmSzqOfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNjLBkp1mE8+Fe3TfUdTKe9Rk6z/HJsCkNY43W7GBgAhnaq02SrVJB3m2ix/ZkSV5wOftTfhkf3mtjqi3jPPkydvnKjyHBHhlOn2kTm2jh30g/JKeLsTCCVSt66Jqo7/L/VbSqARgGVvvCbIUvY7FMWkKA8JwycL2ezi6fmNyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gj5z4rIy; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a1a662a633so7445ab.1
        for <linux-arch@vger.kernel.org>; Fri, 04 Oct 2024 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728061605; x=1728666405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6cu0/usr2tJa4vPbaqm37ZxgrIgWX+DZr/8ABHb5Pg=;
        b=gj5z4rIyOyRyAXbqPZWbhSX2yvMCkAWjN3h4rPTxJruWjLP8LhuYwYC1mFdHWJBE81
         vbNCpO8uIWyYg1B1mMPg7h5f8wXO6VvnpRAqUibA+9W8B0XyKDsMEABkgUBgLJ1QumVn
         Z7v2Dblc/iXgsAJNJr1LgR13J6lEJcbvj2OzgiBo24kbhJjTU+cYxTqN8s7zXbfq8sU/
         /6QJduLy19AIFaWOZECTzfaanppfRJIou11SM39yq1EgZctZ+BUrFpQzVYAkgRZ/tPz6
         MLs1lz4xh9I/X3G2RotLeMfiJTzgzhzUAUZErD8X0rP6FwU2a/1KjkgmpmhPEMcMaAw8
         QJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061605; x=1728666405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6cu0/usr2tJa4vPbaqm37ZxgrIgWX+DZr/8ABHb5Pg=;
        b=JGPRDetE2B6N4a8qxqxs7xZnrtm44SZI6OFES9GYoxGla4UipF3/mixDzYNi80aO/J
         hwz5d/HAHdJ0EMyoOrFt2ZeTpEAZjEkp8eWqEj21iCwvoIWfY37czrEi9+MqDssPIHbu
         X0lhdIxYlP6CT//aQxnKA514+ta5ux3xio+f5jr5cWZLJGwZmZGTOp6hYwRZWQZGWzRt
         6r6SFgvO4EdhE0agniuc29PhPrPJh+efESEmFg2MnR3HLIFEUgRoS85HaT0DEjJdIbA1
         l8xrUw95J3bLIyBA0sxGu6pq4nWWbVT7U3P4xWCFos6dtSbNP2j20AepIb7qht7gggwu
         hUSA==
X-Forwarded-Encrypted: i=1; AJvYcCVl0RoRSmKJ7rDcqY4YrltJgV4HknGDxNOwJqRg7Ev3XR7O4nZlQijUySOpG+q5BrWu6WeBNn0d+Tlo@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwRmkWv+91zIlW6sN5liC48xMKwCx1qMYtlnK/7OTGm0lcRpO
	FtwdkNhS4kWaygHIpWxgxHghA6K1bdbG3/ptAjAfXKQ07nRyHdMsicavD12/1CJbatwAucLX+RK
	AZ3kVgI62wXKgte8128u1x3/ZSRKvclpVtRpQ
X-Google-Smtp-Source: AGHT+IErDf6Ln07o0AdPteE4Z2MSQLZR5z2/ayMLVov/t1OUkBR776jawppVTTQuFQ07+1/nFJ6gPgMV9aMQcWHF+14=
X-Received: by 2002:a05:6e02:154f:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a3767de7e9mr3340835ab.5.1728061604302; Fri, 04 Oct 2024
 10:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com> <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net> <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net> <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
 <20241003161257.GZ5594@noisy.programming.kicks-ass.net> <CAF1bQ=RAizpP-T_sRGpE2-Kjsk_RZD3r_iz_dpn25W+uDzpWOw@mail.gmail.com>
 <Zv-Fy4hnuscnLH1k@kernel.org> <CAF1bQ=S8Hg0FUThaDU0snVqerVos6ztzVvN6sm1Ng3FnTpJt_A@mail.gmail.com>
 <ZwAZPklXayA1gbQw@kernel.org>
In-Reply-To: <ZwAZPklXayA1gbQw@kernel.org>
From: Rong Xu <xur@google.com>
Date: Fri, 4 Oct 2024 10:06:30 -0700
Message-ID: <CAF1bQ=Q=nnoq4jfLWMK8S_uUuTZncRT1K8af_-yBWTU1R_=uaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, x86@kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:38=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Fri, Oct 04, 2024 at 09:28:36AM -0700, Rong Xu wrote:
> > On Thu, Oct 3, 2024 at 11:09=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Thu, Oct 03, 2024 at 11:20:17AM -0700, Rong Xu wrote:
> > > > Writing the doc with all these code-blocks was not fun either.
> > > > We are happy to change if there is a better way for this.
> > > >
> > > > -Rong
> > > >
> > > > On Thu, Oct 3, 2024 at 9:13=E2=80=AFAM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > > >
> > > > > On Thu, Oct 03, 2024 at 09:11:34AM -0700, Nick Desaulniers wrote:
> > > > >
> > > > > > > It makes it absolute crap for all of us who 'render' text doc=
uments
> > > > > > > using less or vi.
> > > > > >
> > > > > > "It hurts when I punch myself in the face."
> > > > >
> > > > > Weirdly enough I have a job that entails staring at text document=
s in
> > > > > text editors all day every day :-) sorry for thinking that's a sa=
ne
> > > > > thing to do.
> > >
> > > Something like this should do:
> > >
> > > > +- For enabling a single file (e.g. foo.o)::
> > > > +
> > > > +        AUTOFDO_PROFILE_foo.o :=3D y
> >
> > Do you mean we don't use ".. code-block:: " here and just use indented
> > text separated with blank lines?
>
> The double column (::) in the end of a paragraph means that the next para=
graph
> is a literal block:
>
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#l=
iteral-blocks
>
> You'd loose the coloring, but other than that it won't be different from
> the ".. code-block::" and easier to read in a text form.

Sorry that I did not notice the (::) in your suggestion.

This is great. I'll change the docs in this patch to use this method.

-Rong
>
> > -Rong
>
> --
> Sincerely yours,
> Mike.

