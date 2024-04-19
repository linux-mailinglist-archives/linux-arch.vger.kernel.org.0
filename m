Return-Path: <linux-arch+bounces-3832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C88AB68E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 23:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA362837EF
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D413CFB5;
	Fri, 19 Apr 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3GIF3P/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA213CF83;
	Fri, 19 Apr 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562951; cv=none; b=cazohCjQntChEdyj2M3HDCzuE4mejGNeXiLENMWI0fTKFEXIicbvWKO+4LCZiKoZkunO5/3kH5JOIZSQ8oSkFUwFwmuQ1VI1yC/hahrR5CRXgxQ0RNkw+Vb56AHU3s/gXeqcM0OJllVUTvMaf+V7h/Za5sIXn+tVWKHX9MGaePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562951; c=relaxed/simple;
	bh=TCFccoU0QynIlhNVSwfE9PBflv6m2g3eer2smjEjHo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH/PPm6n+1GFffV4eCyFCu44GODztqpIPITkiLlC0LPGtDxEdKTuFjMJWnlratHLjsmHJ3aU2Px4aVuB11bHa64vUhcVb4tzbEVj5aRsLsc8LZ283MuQwF/PRoy+5jkPpykqJyyl/RiytDZjQMM+Upq2MSTywuXs9kXQgeCx4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3GIF3P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37403C4AF0B;
	Fri, 19 Apr 2024 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713562950;
	bh=TCFccoU0QynIlhNVSwfE9PBflv6m2g3eer2smjEjHo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3GIF3P/lDyeKxFIF4pk3NB4voyc3jDBvrFx7J4R0RQPC7qB48PFG4JdR+LWTb5VG
	 TVulfp4sZtTnavHG7YfjZx+qr0QC9dnKVswTmcKFscRs89DTdJ23BJZNcgr5rE8cTP
	 GCYa7AVlhR6m2vNKGUfB4+E4ZP2+XMRA/mcbxKvZziVuxteHhStK2mndLtDfNVjE2Q
	 rzZN4Ndc6tabVJQRtfseS5l8TWvfuyZ7Mgpj8k3neEzSInMxgygeIakC9HPWB8pW1A
	 KTMwYXzpirJYjOMMHMhlNA3kWiCrgIQzk8AyhFrzS/yZyyqTAd0BMIA4fStLj4N5Cc
	 q3NQekhLjCLew==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so3034818e87.2;
        Fri, 19 Apr 2024 14:42:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU60prFRWB6VKhtng5Uq8uprJ4pnlQJhq3BvWZPthcxwoC5zi3YZYEIJIsORsFh4uUQno3c2ENqcb3GO0BnMJy3U5bIsD0oFJdLBCv/gkEyxKfty0MTukwGUPq5VRA5HqPYsOrot0jkgfXjYjXOsKXH13B9hlzi91guyoB4neAm7It/gloqfGWsOS4Zw/ZqSPO2b6PobgniVy2ZkYB53tzvCNj8CBI7yT6eKS50pkeLeBQi78GKGSAAEsNxKgPpRmt55aovdklsaMpUz8XNUwWqr2M4D0ux8G+xi7oB0cxhLEy60udwNwUtOGmaMb1PysHr1HPj4X5IIuMg8MlqdRwsOWKlRF6r2sFZe0QTtwVZl5RB45w1RKWZRvGV1DLweFCgYKdptzeRflh3rvDugEJNkWTubWBPLahdnQUho2TD2rQydosGIksvZo=
X-Gm-Message-State: AOJu0YzFFLhSlRvGvDmc/YE9tvA6UFuX3e5OXU47SvW8ghwd9J4HiLEB
	pTTy74IhfnHLOGIPqkeXeyQ6DBytR2hq1uL/xmxlKaMwiW+63Q5DTLwdYX3OmsyxwSahBSzT0NN
	7h4SOseSPZTrCdyUXhH9Lcny4RYg=
X-Google-Smtp-Source: AGHT+IH4AnwX5zN14P6kYOA/5jMldeW1Bv8FPwjpWGtVTE89ihBaxTYgE7/68A2MjqxVZZCm/ny8Sr/SdDVp6qchZyo=
X-Received: by 2002:a19:5f4d:0:b0:519:5b84:1038 with SMTP id
 a13-20020a195f4d000000b005195b841038mr1897119lfj.20.1713562948432; Fri, 19
 Apr 2024 14:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zh4nJp8rv1qRBs8m@kernel.org> <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org> <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org> <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org> <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
 <ZiKjmaDgz_56ovbv@kernel.org> <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
 <ZiLNGgVSQ7_cg58y@kernel.org>
In-Reply-To: <ZiLNGgVSQ7_cg58y@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Apr 2024 14:42:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4KRM4O4RFbYQrt=Coqyh9w29WiF2YF=8soDfauLFsKBA@mail.gmail.com>
Message-ID: <CAPhsuW4KRM4O4RFbYQrt=Coqyh9w29WiF2YF=8soDfauLFsKBA@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 1:00=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Apr 19, 2024 at 10:32:39AM -0700, Song Liu wrote:
> > On Fri, Apr 19, 2024 at 10:03=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > [...]
> > > > >
> > > > > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@ker=
nel.org
> > > >
> > > > For the ROX to work, we need different users (module text, kprobe, =
etc.) to have
> > > > the same execmem_range. From [1]:
> > > >
> > > > static void *execmem_cache_alloc(struct execmem_range *range, size_=
t size)
> > > > {
> > > > ...
> > > >        p =3D __execmem_cache_alloc(size);
> > > >        if (p)
> > > >                return p;
> > > >       err =3D execmem_cache_populate(range, size);
> > > > ...
> > > > }
> > > >
> > > > We are calling __execmem_cache_alloc() without range. For this to w=
ork,
> > > > we can only call execmem_cache_alloc() with one execmem_range.
> > >
> > > Actually, on x86 this will "just work" because everything shares the =
same
> > > address space :)
> > >
> > > The 2M pages in the cache will be in the modules space, so
> > > __execmem_cache_alloc() will always return memory from that address s=
pace.
> > >
> > > For other architectures this indeed needs to be fixed with passing th=
e
> > > range to __execmem_cache_alloc() and limiting search in the cache for=
 that
> > > range.
> >
> > I think we at least need the "map to" concept (initially proposed by Th=
omas)
> > to get this work. For example, EXECMEM_BPF and EXECMEM_KPROBE
> > maps to EXECMEM_MODULE_TEXT, so that all these actually share
> > the same range.
>
> Why?

IIUC, we need to update __execmem_cache_alloc() to take a range pointer as
input. module text will use "range" for EXECMEM_MODULE_TEXT, while kprobe
will use "range" for EXECMEM_KPROBE. Without "map to" concept or sharing
the "range" object, we will have to compare different range parameters to c=
heck
we can share cached pages between module text and kprobe, which is not
efficient. Did I miss something?

Thanks,
Song

