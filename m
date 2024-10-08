Return-Path: <linux-arch+bounces-7843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E09951DD
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3736D1F25769
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172B1DFE36;
	Tue,  8 Oct 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmUog/XW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BA1DFE17;
	Tue,  8 Oct 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398179; cv=none; b=nWL4YamAYOBUMnVel+vkt2OycmsrM6gfmDlH2MbpFl2FLspuMV3NuJE2XJdkQ7LtK5GSI7sjcBMsOtRY7gvHqtU/sjKqiBg5Wa4yVKd+HnzoP3qvqklI3ixi0GqDU70YSG9JLtSPUlWxetsufsAFYWbnMEfhRPqmLnOXOLScy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398179; c=relaxed/simple;
	bh=gxxx5O9eecv163qWQ61f/5In0s1MkC0h2hYsYBgpd4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/zO1Y80mmqXqTMlScSxEJVGhXux7CI3+0h3l1ITSR0pAxNutZWEtYPlD1L1ILqXY4Obv1k3kDD/b0fs47HVIWiJ+KR5gxwzJvwngpKZV88XMLkADWzqKt4dbEa4UHxZDAO+MsCJysGykz8ZvJ6j3ZtlKUC9Gu0oF4qBFkqm5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmUog/XW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398df2c871so6110679e87.1;
        Tue, 08 Oct 2024 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728398176; x=1729002976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAzASSCUQ2aUVsiLqBLU+OR2T2BBF/GKBA/6/Hrht2Y=;
        b=nmUog/XWxHE98vP1aRBWOdqqiTdra1AWS575jFpoHyM53Y6e7zQN/FcquPeBMs14bf
         aPuy8kgYFX4JqI1OEv6cuEYAJkv41Tv58BA3MLW378DfwBfALhXp0zSiXBDrK6w7hoW3
         SG9RMRTkD8IVJ42W+dtP+a6tAMQEg1rJYKi/saiMrSfX5FJsZrQrmOEKrYBQV59PGzpI
         IgXkUWLLJ3LOEIu4wlQNrUJEkpUiZ7oLKlMCMO5E3EhblLMHa1t47qP28WXxD19DHR4I
         rTKc3hWJ5y8llNFRd5BhofZh2BWz/9wUnCLGFOznXC6rfN+BioUMPiQDaJZ7Ke4/hRW4
         NwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398176; x=1729002976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAzASSCUQ2aUVsiLqBLU+OR2T2BBF/GKBA/6/Hrht2Y=;
        b=cYrnuD6RbOItIqsgKi4Co2aWslD+EwsN3jUQhNiAtOp6qvExTX6N9+ftVK+/AZGwiH
         JxTsDcZhuTt+TMDo2KtZsyRGE6t6Bto6S4ayh9f47KEolDx1AVBt2hYdXjWNsFGdVY8G
         +6HtqRc7CWHDRV6iq1c0e+aLo/dS3rthVgz3OLWpP0xe3ME93FK+H67o0MNpAIqiQ2mP
         3EY3L+6H9cWtEnM4/hw3HSRIBRgXupPWhFZhnEBgzymHGSDH5MxhWC8ByX3HiUEKa0/4
         BPEu3CoBjRl3COPCGOinc3kVND830H7LjlrvpDM/jCSBPiG1GXFF9v6aduIhwNK6R6mR
         jjvA==
X-Forwarded-Encrypted: i=1; AJvYcCUJtH3awfDZ/nC626VnAxYOHkTfVIoH3kIfaoPqDVOK+deP8D57oWriGhIVI7f1VE1Nc88=@vger.kernel.org, AJvYcCUbgGK+kyLacPBfXwZh6DEUgiTVHXLqk+aXtuYMPOhFH+/s+wGhu0dOB7i0wxyaju3rnxRqg/5J97wWBAJ+OeU=@vger.kernel.org, AJvYcCV2rCp5g1JppC/inIrPY76DYPlOaZ2xdBwksr4sgPt/Jd/MlJKupA6Ss8yv/s7PmIv0dqsyysSJTTA=@vger.kernel.org, AJvYcCV9IJ38l6X5LroDzXttFFINdkD3yzgOGnA1lfHoX1xiWG07l8nircOfoo/CsvDyIKP8qCEoSAbLz9hRx0Fi@vger.kernel.org, AJvYcCVWn6u/U1hLaeP8nOPLa/UO6ryUAre4UzB1KTNdeCyAeBTsUrbB955DjqJ/0egzzQSkzPZFeRObE6bh@vger.kernel.org, AJvYcCVZr08z2eEiFB9qZZQPQKg8EQQs1YfSFER4TatCiaj9fipOsjvktYDR35dyW9iYDSkA8vsM9JAdwBB0i5AJ@vger.kernel.org, AJvYcCVzdyFAcpZ+cokUng73bgS8Mm6UjHR1k2FuWrlvxUoysZiXou+QER3OJJFz/rCqDionXvoGGH39/cyMTa34HNMNVA==@vger.kernel.org, AJvYcCW2ura4tB0AkWNuocgWJ/GET8txWB1PrLflKqFDMyIXRUY+r7qInkWU7DBBDWFKZ3mASs4deA9mHlQuCU4b@vger.kernel.org, AJvYcCXOwPz5SHzaAEeTdRy4S8wp0rdekZ+too4VPiu6TVIcNiu1UZgMWkMEqQIw9/6EEkH6qPERZIuOt1AOmQ==@vger.kernel.org, AJvYcCXRdDe3dubXYb9lSLHe
 HJulIH3EjKyZ63P0AScc+aR+KbyToGrF5T8LxAHKUceMsS0bCo0zyrlwIn5B@vger.kernel.org
X-Gm-Message-State: AOJu0YzliAqJ64I6yuE+5ZCA/YTG3cGnD2sjQRftKzH5Y0Ebmv6K1Sl/
	C4xahBG5gp7Vs51HXDV0eE5S8WzB4cq5Df6LvATxzE6KbikHc3Na75TCB4u8MbFmIeHdl+CRyiR
	6oNV9T++a/Dw7Kxvp+mbzH/8JrA==
X-Google-Smtp-Source: AGHT+IFk7uSGpMKxSJMgul6omDcmQyMQl5Zy1l8C5NVTbpCgjnnjxrxdxyhpPaT355keXYtQRCu422aiN8olYIcP4XU=
X-Received: by 2002:a05:6512:3085:b0:539:8a9a:4e56 with SMTP id
 2adb3069b0e04-539ab8c6fb8mr8574397e87.53.1728398175714; Tue, 08 Oct 2024
 07:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-35-ardb+git@google.com> <CAFULd4ZNwfPZO-yDjrtT2ANV509HeeYgR80b9AFachaVW5zqrg@mail.gmail.com>
 <CAMzpN2j4uj=mhdi7QHaA7y_NLtaHuRpnit38quK6RjvxdUYQew@mail.gmail.com> <CAMj1kXF3_Hj9j2f_cBtwTFWvEmB0UoEs_cGkRiWc4AErDx0ftQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF3_Hj9j2f_cBtwTFWvEmB0UoEs_cGkRiWc4AErDx0ftQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 8 Oct 2024 10:36:03 -0400
Message-ID: <CAMzpN2jWRV8-JzM2FjSvSz+VoDrNVeEJPgF7N5ksLaADHpnHsA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:15=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Sat, 28 Sept 2024 at 15:41, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 2:33=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@goog=
le.com> wrote:
> > > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Specify the guard symbol for the stack cookie explicitly, rather th=
an
> > > > positioning it exactly 40 bytes into the per-CPU area. Doing so rem=
oves
> > > > the need for the per-CPU region to be absolute rather than relative=
 to
> > > > the placement of the per-CPU template region in the kernel image, a=
nd
> > > > this allows the special handling for absolute per-CPU symbols to be
> > > > removed entirely.
> > > >
> > > > This is a worthwhile cleanup in itself, but it is also a prerequisi=
te
> > > > for PIE codegen and PIE linking, which can replace our bespoke and
> > > > rather clunky runtime relocation handling.
> > >
> > > I would like to point out a series that converted the stack protector
> > > guard symbol to a normal percpu variable [1], so there was no need to
> > > assume anything about the location of the guard symbol.
> > >
> > > [1] "[PATCH v4 00/16] x86-64: Stack protector and percpu improvements=
"
> > > https://lore.kernel.org/lkml/20240322165233.71698-1-brgerst@gmail.com=
/
> > >
> > > Uros.
> >
> > I plan on resubmitting that series sometime after the 6.12 merge
> > window closes.  As I recall from the last version, it was decided to
> > wait until after the next LTS release to raise the minimum GCC version
> > to 8.1 and avoid the need to be compatible with the old stack
> > protector layout.
> >
>
> Hi Brian,
>
> I'd be more than happy to compare notes on that - I wasn't aware of
> your intentions here, or I would have reached out before sending this
> RFC.
>
> There are two things that you would need to address for Clang support
> to work correctly:
> - the workaround I cc'ed you on the other day [0],
> - a workaround for the module loader so it tolerates the GOTPCRELX
> relocations that Clang emits [1]
>
>
>
> [0] https://lore.kernel.org/all/20241002092534.3163838-2-ardb+git@google.=
com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit=
/?id=3Da18121aabbdd

The first patch should be applied independently as a bug fix, since it
already affects the 32-bit build with clang.

I don't have an environment with an older clang compiler to test the
second patch, but I'll assume it will be necessary.  I did run into an
issue with the GOTPCRELX relocations before [1], but I thought it was
just an objtool issue and didn't do more testing to know if modules
were broken or not.

Brian Gerst

[1] https://lore.kernel.org/all/20231026160100.195099-6-brgerst@gmail.com/

