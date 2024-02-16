Return-Path: <linux-arch+bounces-2463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514EE8583B3
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E1D1C21A32
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F10132C3D;
	Fri, 16 Feb 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhonjF7i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901613328F
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103491; cv=none; b=QE154zwdDG9g5sg9HFZ4XMpO7qD8/pp8XegKb5T831qHoVhVs880wk/EYOJFjKEDTFAY78KWCnnrFpWgDpGUmFv1FZeA8+F8gED8/YoSVdYyObhEvWjf0/J5CemUNsNxIbyNDeBH5D8qaxVXcxmoAbrIIoAz+gKO3T5iG1r7H4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103491; c=relaxed/simple;
	bh=s5/J21l0Vb16qAasTR2af/DM49VlLYJehTHe2iQrZgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4tQr/33uaUMDdmK+j4dThi/wkjiZsvTcSFcex+XqAVJ4IjjznyQygv08dDKhbhyc8FwPeckZZzpaXuuDiQexw5OCT30VZT9R102RnapQoFV8UtBbeWZGIzHqBb/SVLj1YZWo5sWcdN7Pfb/6iTZxFZjBlNmuyU29cdjAQhs/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhonjF7i; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607bfa4c913so21752377b3.3
        for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708103488; x=1708708288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuBxuiKdZN3KVCrAhLvxlGbAMwEHkyTmKhPVF6pp06o=;
        b=IhonjF7i5YFBSeoTWMrM3zJPshDaeWbhHkyvFnB+NDDQ+Ij7VL1y4CDWuUtJ3qQLKl
         Au2LnVhttTY8EleOOAm8nAZxngUYvF8wO9XVhoNzUP7uRfsFK7nsIze8PDhcPxzxV3D6
         mY5DAN0NDRyj7KYkKpaZbc/I74WFsIAVT6M7orsE99u+Y6LhXh3tpyK0pYUpcZVO14LV
         iRr1SyOi5R2XYruaFZcRpTauoDgU2vsEtDFpLIIU5MvTRJYmFF61013C/57ZufhKGjMe
         7voZSdkoVMKYEfSFym991AfVyG+N6LxkRFWrdXJdC/stdT+Z6pCznTPs3dldYjYueFhU
         aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103488; x=1708708288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuBxuiKdZN3KVCrAhLvxlGbAMwEHkyTmKhPVF6pp06o=;
        b=iLIoCix8hwuAbgc0WM2v+gdoiWf5ceUdMeDkkuSebIB9cHTFD4rGEQfFq9rxQO/oaH
         c42YLf5qEzeJTgTke12eg0nowQ7YEEC4gT9SHzxCQxdzvyjzoAK4dlHF2R0Cb+eey5FU
         sz0pqMk4Pv1umC76z2/Nf6TjGHy9KxtPZY/BlNUdyYZaF2ieudk4O6gWNMjvbc/03fF3
         geKBl7bmrPwCqgvPGdEnV8CkR2IezijAzQFbZvXd0P3YCuzWrZmWTm+byqzBFU+osjeK
         CoGhtVKT5mcPCznimhQAMUSY6v7iiBfl1ggf7VhW/134G9+vYlAel5xhpVUzW+01SBGp
         lVdg==
X-Forwarded-Encrypted: i=1; AJvYcCV29WqVntuWsAbGOUNBeoHYWx1NQNQAilGTQBuRETigBnSemykMXVFhpSMGzeI+Kief3OZsJJh2h7O4xr17EP2oFloJrGs7z5oB+w==
X-Gm-Message-State: AOJu0Yxh9d71qYkMLznlw4HUPZ0ZXxnoV2oRd5y/Iq5HOHpM8dv91jzg
	NFHYIAY3IVcpRWAF4F61zFxM1WMBz5YldIGlrQdFnQr2BuySK/RIwN7NmqLa7PDfkhhvbG84x5Y
	PNEjxGB73Fpvo5rQlldYrjYVD0PfeJWcmivUZ
X-Google-Smtp-Source: AGHT+IGrTdDphKuPSMMFIAFPJovR9x9JDU4EDFPzTY0y3WFZl7FqMruLomlujQStik0SDQEztF8S9x7Y+PwqmZ025HY=
X-Received: by 2002:a81:8391:0:b0:607:e1c0:450b with SMTP id
 t139-20020a818391000000b00607e1c0450bmr4624095ywf.0.1708103488010; Fri, 16
 Feb 2024 09:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-22-surenb@google.com>
 <ec0f9be2-d544-45a6-b6a9-178872b27bd4@suse.cz> <vjtuo55tzxrezoxz54zav5oxp5djngtyftkgrj2mnimf4wqq6a@hedzv4xlrgv7>
In-Reply-To: <vjtuo55tzxrezoxz54zav5oxp5djngtyftkgrj2mnimf4wqq6a@hedzv4xlrgv7>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 09:11:17 -0800
Message-ID: <CAJuCfpEsoC_hkhwOU8dNSe5HCFX-xiKsVivqyXbVmuEE-_F2ow@mail.gmail.com>
Subject: Re: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, mhocko@suse.com, 
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
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:39=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Feb 16, 2024 at 05:31:11PM +0100, Vlastimil Babka wrote:
> > On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > > Account slab allocations using codetag reference embedded into slabob=
j_ext.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  mm/slab.h | 26 ++++++++++++++++++++++++++
> > >  mm/slub.c |  5 +++++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 224a4b2305fb..c4bd0d5348cb 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -629,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s,=
 gfp_t flags, void *p)
> > >
> > >  #endif /* CONFIG_SLAB_OBJ_EXT */
> > >
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +
> > > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s=
, struct slab *slab,
> > > +                                   void **p, int objects)
> > > +{
> > > +   struct slabobj_ext *obj_exts;
> > > +   int i;
> > > +
> > > +   obj_exts =3D slab_obj_exts(slab);
> > > +   if (!obj_exts)
> > > +           return;
> > > +
> > > +   for (i =3D 0; i < objects; i++) {
> > > +           unsigned int off =3D obj_to_index(s, slab, p[i]);
> > > +
> > > +           alloc_tag_sub(&obj_exts[off].ref, s->size);
> > > +   }
> > > +}
> > > +
> > > +#else
> > > +
> > > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s=
, struct slab *slab,
> > > +                                   void **p, int objects) {}
> > > +
> > > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> >
> > You don't actually use the alloc_tagging_slab_free_hook() anywhere? I s=
ee
> > it's in the next patch, but logically should belong to this one.
>
> I don't think it makes any sense to quibble about introducing something
> in one patch that's not used until the next patch; often times, it's
> just easier to review that way.

Yeah, there were several cases where I was debating with myself which
way to split a patch (same was, as you noticed, with
prepare_slab_obj_exts_hook()). Since we already moved
prepare_slab_obj_exts_hook(), alloc_tagging_slab_free_hook() will
probably move into the same patch. I'll go over the results once more
to see if the new split makes more sense, if not will keep it here.
Thanks!

