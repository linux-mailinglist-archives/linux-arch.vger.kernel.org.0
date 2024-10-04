Return-Path: <linux-arch+bounces-7693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51419903A8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED6B282237
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861816F0D0;
	Fri,  4 Oct 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjjnc/L9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FD33D5;
	Fri,  4 Oct 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047737; cv=none; b=d9DT47shIa10mgdOzP7sht/xD87J/ufz2CffKYROPQt2ndY1t8yyk65uoxHtIchvcC14WQfGctnnhLrtWZ1jhcJ+/CI0nmW1n5RxnLHmlm5ZyHdfJ7vHcqyvLagyxdkNG4DLXA1/WsMZ7XiiWzpdVxE9uJ3tDnbThUp8OvbFKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047737; c=relaxed/simple;
	bh=1JZwYefyhSOCZB3CuZertgMGY1R4ZnxNXU0IyQGN6qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlgaPWhJ+EOxi1ZQc3ajSdI5kBpOAuwHU4/d0jOy2WK63DXND8085wBbMLqOEhRwllPAyrD60ssL8NqnMcMxSIRPtI390w+HDBYQdQvdhu99zZozOOPrNHB9bvHZvzBXnWMtkyVTASefFQ6kSJrzjqWiZWEr8c0DruvIhJ1f7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjjnc/L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8116C4CEC7;
	Fri,  4 Oct 2024 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047736;
	bh=1JZwYefyhSOCZB3CuZertgMGY1R4ZnxNXU0IyQGN6qM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kjjnc/L90TMtexTjGYxAYy1SQ1QLyKkvF/CbvX4DRZe3QZLNjgmA043In5Mn3i/rw
	 6B5X+WF05mnRkF5MPsreCu1/RWhlYy0+kTzNNOgDa8rsLpPqegA7XxXK7Rhx0nUxa6
	 IBkZJ2pdiTlc6pHGbh4RfTk0ZTnhtJZsbARiZlcRcR6BaSSw9ooGopO2oN7M88zaKP
	 i9ZukewwH6dgft/J+7smkC7XLiCKWNYuCiKQdA/fHzzcPvpm6QIq/WKqZBvWKoD11P
	 SHCZ55g+iyuo9/ex9afVt1+UpR3QIha2xI0NPLiyaKR+gtHkWFsHfMyaquC5SiCFd1
	 mpOvPGs/3yVlw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539983beb19so2824507e87.3;
        Fri, 04 Oct 2024 06:15:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+38R09j1hQxllWs0EaTrFh1t2MRF8v0dzcOegKbfaiS5alnA6Rjl00TvgfJBZhTuhQYhmcALOH+cVNDXP@vger.kernel.org, AJvYcCULDnRsmKZmGZZ98TwuF1ZH4+GH7Fr530imtFW9lxbETVqJVXZfU65rPPvDlmojIxNvhVcVdFKYkLvoQKojN1s=@vger.kernel.org, AJvYcCUVTF6W9Sbppy6KFSyHwLvooq67LPP5VL802W4CWiAe7IpDMTY6khkzpo7hGsWxMvwFstIz5DO0q5KIahrn@vger.kernel.org, AJvYcCV91q/sGry1hbxKADzHDs0ju/SACiuwk/yFnHXON8Sb0iW9D5RNGxPFtCuSBgKe3pXkmkRh4WRAhxiRcOjz@vger.kernel.org, AJvYcCVVVpSpkuylnUz66AK6tJcyw4LZB2j74FsXSFsP0DqiHVPWk5fLLwyai5rqa4y17bBqWT4cJHG5vKMj+jMXhkLiSg==@vger.kernel.org, AJvYcCWA2gfASVi9frLe93G6t17nR1yShVtHaTnLCkoVFhtMIjQ5GeUHLYmbOeTOkZumD6zxFAnLKKMrieJQ@vger.kernel.org, AJvYcCWFdmrYIxjlAVrycNuUVzUwiS2ehdmzsxQi5FyJdWnVQlacT2uPeomp2Rj39SXjQvFEJI54ElEmzJRZ@vger.kernel.org, AJvYcCWtd9b6skN2pLy2u9KwqX+NKHfaGn0v4Eo1OIzGas8ESpGURmF32XiV/9LlvVt1ROFCivAcoJZkyJU=@vger.kernel.org, AJvYcCXKOkcGvbcFlTu4Hf/DZIPOnRvbIM9GbnXAqdnXQ5I5efT3uUdsXrog/lxFo5cNHWM2sZtyCkhdBINWFA==@vger.kernel.org, AJvYcCXrnVncpaUX
 YrLcbTnyhKaiVGFWHwnAFNkCOaIqEWUE9xcl3y/O9QfJdzbzJLPzS8sXceg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7+FGOM+QMg4bA9wtb9EgMm5mg3L7T78RlRBywebeG3xWaWEe
	xwsBzJ8fB6aGyarypEtg6a+7SG31yiREjBfrIsOIqHnNPvJniclUQgEP7RblozXftN1YC0//0MZ
	a5IzbyggY1NuLWKORTrUOKMOkzQ8=
X-Google-Smtp-Source: AGHT+IEuHrt3V5yx40A/FQDIn91vq5WH5zeRnx8eS4s+O/De09fFFzzyl2W2oN2bUPJ3C1JSY+Ea24ADde6nXP4PqRA=
X-Received: by 2002:a05:6512:3096:b0:539:a2e0:4e75 with SMTP id
 2adb3069b0e04-539ab8662d1mr1636973e87.14.1728047734917; Fri, 04 Oct 2024
 06:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-35-ardb+git@google.com> <CAFULd4ZNwfPZO-yDjrtT2ANV509HeeYgR80b9AFachaVW5zqrg@mail.gmail.com>
 <CAMzpN2j4uj=mhdi7QHaA7y_NLtaHuRpnit38quK6RjvxdUYQew@mail.gmail.com>
In-Reply-To: <CAMzpN2j4uj=mhdi7QHaA7y_NLtaHuRpnit38quK6RjvxdUYQew@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Oct 2024 15:15:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF3_Hj9j2f_cBtwTFWvEmB0UoEs_cGkRiWc4AErDx0ftQ@mail.gmail.com>
Message-ID: <CAMj1kXF3_Hj9j2f_cBtwTFWvEmB0UoEs_cGkRiWc4AErDx0ftQ@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
To: Brian Gerst <brgerst@gmail.com>
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

On Sat, 28 Sept 2024 at 15:41, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, Sep 25, 2024 at 2:33=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Specify the guard symbol for the stack cookie explicitly, rather than
> > > positioning it exactly 40 bytes into the per-CPU area. Doing so remov=
es
> > > the need for the per-CPU region to be absolute rather than relative t=
o
> > > the placement of the per-CPU template region in the kernel image, and
> > > this allows the special handling for absolute per-CPU symbols to be
> > > removed entirely.
> > >
> > > This is a worthwhile cleanup in itself, but it is also a prerequisite
> > > for PIE codegen and PIE linking, which can replace our bespoke and
> > > rather clunky runtime relocation handling.
> >
> > I would like to point out a series that converted the stack protector
> > guard symbol to a normal percpu variable [1], so there was no need to
> > assume anything about the location of the guard symbol.
> >
> > [1] "[PATCH v4 00/16] x86-64: Stack protector and percpu improvements"
> > https://lore.kernel.org/lkml/20240322165233.71698-1-brgerst@gmail.com/
> >
> > Uros.
>
> I plan on resubmitting that series sometime after the 6.12 merge
> window closes.  As I recall from the last version, it was decided to
> wait until after the next LTS release to raise the minimum GCC version
> to 8.1 and avoid the need to be compatible with the old stack
> protector layout.
>

Hi Brian,

I'd be more than happy to compare notes on that - I wasn't aware of
your intentions here, or I would have reached out before sending this
RFC.

There are two things that you would need to address for Clang support
to work correctly:
- the workaround I cc'ed you on the other day [0],
- a workaround for the module loader so it tolerates the GOTPCRELX
relocations that Clang emits [1]



[0] https://lore.kernel.org/all/20241002092534.3163838-2-ardb+git@google.co=
m/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?=
id=3Da18121aabbdd

