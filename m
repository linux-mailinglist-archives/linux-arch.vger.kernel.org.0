Return-Path: <linux-arch+bounces-3808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5268D8A9FC2
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 18:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06501F2362E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E378916F8F3;
	Thu, 18 Apr 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M66D379U"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435023D7;
	Thu, 18 Apr 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456821; cv=none; b=b5gXJpVfXCTedyIO9rdVajN0bQEu/RPKLlNCRzsKU8ScYvRtNPDSy+y/U+fKd02JKK2CaR7HcFYb4BPOIyFxiSNIgXkb/SThSfCOXikPnN+0pOJobb3VYuGfp+T5F0gLQoKRldfNWQE0qTxtIGc1m1PGCIkyA4TKroO9XRDtyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456821; c=relaxed/simple;
	bh=q/TFlw8SQh+Cko4nU/ng2SJ+spicGdHxGtHPBf/Abnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa5qnWUQX0RErrpdnnxH7GgWCr5lEqhJwDAuJnGGize3UarOoOIuloejC7OxMSPLUwwPPT1eEdd9me6y0BaubUNVx7nV5Dix2Fj+CvTEwHFU2X31FKk5Xed6nJQ+i3oeN2e/Doq0jWcPc62fTzQTO1p+xnswM3qk9TRO4PfG7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M66D379U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FA7C32783;
	Thu, 18 Apr 2024 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456821;
	bh=q/TFlw8SQh+Cko4nU/ng2SJ+spicGdHxGtHPBf/Abnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M66D379UjZi2pzII5y0MS95jTIIdgeaP5CeOU5t6T8ugoVGoFqm+PLgIbtbjL7jJB
	 NWZmI3wmyAW6yd89gdzYoIAx8VH5oZAnUb+Nm6vIWzmLAIwB+yayQqOZ7130lPGtZc
	 76JyrlVTFHePR2a2syZozERpds1Ug/Dsrn50BaO6JXr296Nahb9Dr77AX8YroHZzWq
	 ciX+VZkyUUoI9u3hjnf+cfLWuwOsKCHK6cQNotuS8wjUQA9NYe2vZrosUyMIWeB+1J
	 tItBnOKtFJxbN9219aDk9FhAD2AC9p6dPGaByqxXhKspOCjdnFu5QP7jGAJaqTXGND
	 Hk/edIrXHleKg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5196fe87775so1055976e87.3;
        Thu, 18 Apr 2024 09:13:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzxuaphsl+RABbKWgK+hHzWpVoE5uljVBdLb52fmQ0owrzbH3CEcvvjgOCi5BH9Kyow2XR2gNjz+j65gOSvQuBKFO7vv/Rx787BrFVcKQF2toqDopOnNBcDMgwIxPCbBeBVah/xoVOxcH6QBZMzbn+Bz0mwpNeIgh23YBHjPRyDcEJXse08UfAEJSpArLWBpHd7YcJfnJBwhxF6tbG7Trce9qqIPM5nEL+OLV2VLnsaL9eQsQMlSzM6e1OGKpKfTjCwMcaYUIOd4txRINW1sBWAQxyJfKcnnIL7Cmh1ag2Sq9WE5b12vaF8fIZ3rwGK557FUEvg8Fo4mzjwSjuhjx2QNw+aOaGkWpsdsHdbSLAruZytryCfxkikgcKk0WI/sx9mQE3oYxhoJzzPyOCXEfgmpqimuGlMpAK5Ofy4XHmjECTrH0Y3XgIifc=
X-Gm-Message-State: AOJu0YwmiN4vTEBt/JgaK4RfY8DCk8e/WtC0+HAR6P6/ODoCrPpahoYl
	Fl1u33dU7gW4WNBpEHPDJEOuhZSfyJ8cRzLZymo5mR8lTKpNwRux4SIYTchgMsu9LcgjJwJuIZM
	uq6vAGlg/julyKhA4aAUTNtsK/QU=
X-Google-Smtp-Source: AGHT+IHLiDWbpJNv5cpg7tSucX1RJbILlT9QE6EE0zaOt0RsDuLJ8JfO9fqfVmmivnqe0091gRHYHRJJ+tsSYBR5kLA=
X-Received: by 2002:ac2:5fad:0:b0:519:569b:361b with SMTP id
 s13-20020ac25fad000000b00519569b361bmr1973077lfe.63.1713456819439; Thu, 18
 Apr 2024 09:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411160051.2093261-1-rppt@kernel.org> <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net> <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org> <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org>
In-Reply-To: <ZiE91CJcNw7gBj9g@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 18 Apr 2024 09:13:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
Message-ID: <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Topel <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:37=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
[...]
> >
> > Is +/- 2G enough for all realistic use cases? If so, I guess we don't
> > really need
> > EXECMEM_ANYWHERE below?
> >
> > > >
> > > > * I'm not sure about BPF's requirements; it seems happy doing the s=
ame as
> > > >   modules.
> > >
> > > BPF are happy with vmalloc().
> > >
> > > > So if we *must* use a common execmem allocator, what we'd reall wan=
t is our own
> > > > types, e.g.
> > > >
> > > >       EXECMEM_ANYWHERE
> > > >       EXECMEM_NOPLT
> > > >       EXECMEM_PREL32
> > > >
> > > > ... and then we use those in arch code to implement module_alloc() =
and friends.
> > >
> > > I'm looking at execmem_types more as definition of the consumers, may=
be I
> > > should have named the enum execmem_consumer at the first place.
> >
> > I think looking at execmem_type from consumers' point of view adds
> > unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kpro=
be,
> > and bpf (and maybe also module text) all have the same requirements.
> > Did I miss something?
>
> It's enough to have one architecture with different constrains for kprobe=
s
> and bpf to warrant a type for each.
>

AFAICT, some of these constraints can be changed without too much work.

> Where do you see unnecessary complexity?
>
> > IOW, we have
> >
> > enum execmem_type {
> >         EXECMEM_DEFAULT,
> >         EXECMEM_TEXT,
> >         EXECMEM_KPROBES =3D EXECMEM_TEXT,
> >         EXECMEM_FTRACE =3D EXECMEM_TEXT,
> >         EXECMEM_BPF =3D EXECMEM_TEXT,      /* we may end up without
> > _KPROBE, _FTRACE, _BPF */
> >         EXECMEM_DATA,  /* rw */
> >         EXECMEM_RO_DATA,
> >         EXECMEM_RO_AFTER_INIT,
> >         EXECMEM_TYPE_MAX,
> > };
> >
> > Does this make sense?
>
> How do you suggest to deal with e.g. riscv that has separate address spac=
es
> for modules, kprobes and bpf?

IIUC, modules and bpf use the same address space on riscv, while kprobes us=
e
vmalloc address. I haven't tried this yet, but I think we can let
kprobes use the
same space as modules and bpf, which is:

ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF

Did I get this right?

Thanks,
Song

