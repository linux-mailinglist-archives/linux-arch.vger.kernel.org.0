Return-Path: <linux-arch+bounces-2278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824B852AC4
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA21C21D02
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603811E497;
	Tue, 13 Feb 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQC6uG1A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D413249F3
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812242; cv=none; b=NH52hsD4QIlPMjpIBZwl+nXijJubiiQjkHr64FHbhKCjW3Mlvmp5WrUxEcZasuFdlEGFOPDHR2qYVQJI4ECruU7R1ylVhCPb5HFkA542wd/K8trKrsWxyxn3zedLfv6CT3xcLf2dtv8EtmIh4ygI63WKaq3zFATz3qdQxfo3ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812242; c=relaxed/simple;
	bh=k0dlcOpqCeQ859XsaJEpqmX/eHez3ZKf32wZRP8twEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH+jg23hS933+QpuXnrdcfWsjbDJPhEEvgCmIpvSxTdV1uEiAMV6HzNsFzhuf2ch2DpoHCQvQXbdn6BwHCA5gfGZSYOZpXwnRM4lDYPWCBAZu20Tp5XI63YaeOa/Tiv/dWHK2w7d+m1wbUTLWn2Js3WhF92JiZWx6o4iOcTp1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQC6uG1A; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3986885276.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 00:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812239; x=1708417039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC5Sp72DpOGszEFoskDK+zxBIS3uARFrNh6dT/DOYpw=;
        b=aQC6uG1AXej3oTFT3m2fKoYa7LYFxfuAxPkLfo/+dHttTZeAGK1ACiZfvHg7uw0Mk1
         NyffctXcL4SO7EBLTKauvlsluF9l45qqYYS/KQONb+jIPCiLK+c+WbNi/zBkjJmV5iQn
         WsnqaAKYBSrfSkW7fXdosoOrkNwAzcUp43y8upwgTF2pjdBLkjHiuPGOfOCToa6iDsSZ
         CavdtF6mFt5fTzar38xQes3PQzi0/e6CRsAp0GocFdrTQFzMDfarix1y1+EUFBjx1Fx0
         EFHr6x3Um7GcCahg2w7MywWIgN9lVJvVg/DnGOrIZQvRXVxFAH/k3iDSS1SZW7/xRNNz
         zarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812239; x=1708417039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC5Sp72DpOGszEFoskDK+zxBIS3uARFrNh6dT/DOYpw=;
        b=pkQkAqTqYqCk5+qO2eaO33ob7WkvrdZbpC6X1RcNCfXpcG/I47LLC6HLr/pR+NZbMY
         v/iikJ6hnYRRtdAbtaQkdTgrFkHeSnbfIoZt+DEZALflYFqzuPMrCg0JlD6/hOwkwxR/
         fBRN7Wz9IXgS+xvrvNodLeAiyZUCvyvqk/gwS6O7pizhajdZAwfklizIr6OK1OMeP9to
         w5UtPdKqG96QhULboN7mDKHgO/qIM857iP/rL7NraYYFbWh1Cltv4kmIc28y/D1JdPKf
         tRLP1R8MkfkCWJe2EL1tg3nKJk5HA22zFZROeNi7BXP9FcIG8nmi3WJXXw3mCqcMwwo2
         Xutg==
X-Gm-Message-State: AOJu0YwFOxNH1eY7qKl2fRWPjwMKCv7lJXFCZ6ZxsjaM9bdV8gDkJwSU
	6877B2ER1uX/rfrn3Z9cn4LgRnYeA51R45bS9e5Rp51k4ckvmgOo1BFx1SF1o8KlILMPnJOgyc3
	OCimxv9PK9n87xXfTTWaEWYLhG3UQGPsKn6cX
X-Google-Smtp-Source: AGHT+IHjpakmjDseMf+FthsBajS4lohi+4SNf65A0StZavoAeiHzVp/HPng86atAuU0FiQuCDBbDYkv0F+8/PL8mBAs=
X-Received: by 2002:a25:6841:0:b0:dcd:24b6:1aee with SMTP id
 d62-20020a256841000000b00dcd24b61aeemr45209ybc.47.1707812238953; Tue, 13 Feb
 2024 00:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <202402121606.687E798B@keescook> <20240212192242.44493392@gandalf.local.home> <wvn5hh63omtqvs4e3jy7vfu7fvkikkzkhqbmcd7vdtmm7jta7s@qjagmjwle2z3>
In-Reply-To: <wvn5hh63omtqvs4e3jy7vfu7fvkikkzkhqbmcd7vdtmm7jta7s@qjagmjwle2z3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 00:17:04 -0800
Message-ID: <CAJuCfpE2hMx4rUSex3rX_wWiGOt=rX5FWms98Rd6WAaVqW6yvw@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:33=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Feb 12, 2024 at 07:22:42PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Feb 2024 16:10:02 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > >  #endif
> > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > + {
> > > > +         struct seq_buf s;
> > > > +         char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > >
> > > Why 4096? Maybe use PAGE_SIZE instead?
> >
> > Will it make a difference for architectures that don't have 4096 PAGE_S=
IZE?
> > Like PowerPC which has PAGE_SIZE of anywhere between 4K to 256K!
>
> it's just a string buffer

We should document that __show_mem() prints only the top 10 largest
allocations, therefore as long as this buffer is large enough to hold
10 records we should be good. Technically we could simply print one
record at a time and then the buffer can be smaller.

