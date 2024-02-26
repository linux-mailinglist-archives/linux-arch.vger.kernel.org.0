Return-Path: <linux-arch+bounces-2734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA6867C14
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F2BB27406
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15112C7F4;
	Mon, 26 Feb 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeKh5YG0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A212C55C
	for <linux-arch@vger.kernel.org>; Mon, 26 Feb 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963797; cv=none; b=NdIMzA6JupL/rAX9BEwCRz3Fa0oDVsomX8g/ItFPloZel3FqvFEd3MU3ehsdvcmPgTTNPfpxrL9g4TEYZwGr3geVHSlIjeD/DAUcM3TZP0HpJ13XwfhARycr0hajwOzOs7RYwVuMeMokRSaADRhwWXPoU+j13in5c+7gCZDRf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963797; c=relaxed/simple;
	bh=PG9T0E4ZcsWjvdpfHUOgdfPJ9G3s6+OiDx3FL9PDAwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR/VNDTjag5NY3xfnzRb66cr0Jg1Tbhtd1lZLOkQRiAy62d8l6EqOZxAREMiu4BPflEqBZmY4TXyB8ElJ/Fz4XLwXHwDV99GXeo9qtqhLl+5zc5QpP1Ga9tQBBicArYKJzUH1uJtSTYEuNlQcUd+NVHD/43xcP3irD6CraNdYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeKh5YG0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3599457276.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Feb 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708963794; x=1709568594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2i9nu0Yj7jZAbH4EMUTPvr2EXed0SrW18ZEoR5sBFQ=;
        b=IeKh5YG0zG4QERv9OQmrbe53HbIMQJBWFJgDUjkuYrDQu3Pqoo6CI9Ih3XSXBvEnYs
         0FEGEwMRrfRUvaAqMDAi/A8z4Y3x/vBes2nRxkZ9ZuWyrxEC+GHUKsGZLm5IEz8DgH1x
         XeIgBHkciWSrGcb9Vmcf9M6/9K9hTpMXbb32I9TORsVFJU0kNzJIdkwsDzTTmaLdnunU
         /wFIrevrF6GtW65Kub+qU5kr0EIuZpFUePKPgI3XdDimaO24aLTLTn6ILiYicTP2tzvb
         vgbOELcE6WdrW1nnzBu2zFr5XymqaZziUszPvM2TvaD2YJKWnaJV9+0jVipbTWxKg+nT
         pQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963794; x=1709568594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2i9nu0Yj7jZAbH4EMUTPvr2EXed0SrW18ZEoR5sBFQ=;
        b=GW34EWWw5YC30cQhhaX/vdTvMnH9OJDOhjffcTvvMdGa84T3OmtBY6mlMOzBfi+1Rg
         DS05XgfjO+iX7KkiA8wEnFaY6/prqgJDIrr3Uhh9holsHSznmWZRZ+h+Addd1fz7iSG2
         6W8/4EwcKJdVtt3x85u9NAsgyIVNB29WXRaTZS+gAc3GTqpQ/fdEMaTXW7nvrB4GI8pX
         XbCbmyXpbjnC4asA79TJ3dH2jcesoOrdJfq7SBuhar/DmQEanKa9LLv3WofpU2CRnxYG
         1sMgOktt17pfYA8QMTFNH3ButFBEeQCeVMYe2ph+Q8T+uvy5yqxzoCqmRgqWTOnu46DK
         fs7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmY+51BWpkGf+gbr6CSYbLubVDb+I2zlYFyq6aeI/6rzWb77XCzbD7rtv+orlhYEQRXW05J9p4gUh5Rx57Uu0v1ZEconYDua3riA==
X-Gm-Message-State: AOJu0Yw2zChF0bHvI4f++Z2CNXM3mtCOgE6cqz26fb/J3joKo1mcGZTr
	mlCj8B59JjAK5RQo2L+dBi/9+GyXJXHsg5r9GrPhRvYFJYL/ZIuluCp7R8+gaEoSpoXt56X4+rp
	eMwlJhzjp55p1R/uq08Z3M4chLkUAWaFRIA1C
X-Google-Smtp-Source: AGHT+IFiv+y72N/mXVEJcRlho2bUNXrJYvtkNjNCkqw5WfMbaDfjXaMlMUIsggVwW64saHx2yjHtEvViFdZhB2+giI8=
X-Received: by 2002:a25:ef4a:0:b0:dcd:3575:db79 with SMTP id
 w10-20020a25ef4a000000b00dcd3575db79mr4289171ybm.6.1708963793723; Mon, 26 Feb
 2024 08:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-4-surenb@google.com>
 <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
 <CAJuCfpHBgZeJN_O1ZQg_oLbAXc-Y+jmUpB02jznkEySpd4rzvw@mail.gmail.com>
 <d8a7ed49-f7d1-44bf-b0e5-64969e816057@suse.cz> <CA+CK2bBggtq6M96Pu49BmG_j01Sv6p_84Go++9APuvVPXHMwvQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBggtq6M96Pu49BmG_j01Sv6p_84Go++9APuvVPXHMwvQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 08:09:40 -0800
Message-ID: <CAJuCfpE_=A3H+FKwHeu-XLX5rDCqrV8dUT40=EVm4w_q8A=EwQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Mel Gorman <mgorman@suse.de>, dave@stgolabs.net, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Jonathan Corbet <corbet@lwn.net>, void@manifault.com, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, mcgrof@kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, dennis@kernel.org, Tejun Heo <tj@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, paulmck@kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, dhowells@redhat.com, 
	Hugh Dickins <hughd@google.com>, andreyknvl@gmail.com, Kees Cook <keescook@chromium.org>, 
	ndesaulniers@google.com, vvvvvv@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Alexander Potapenko <glider@google.com>, elver@google.com, dvyukov@google.com, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <songmuchun@bytedance.com>, jbaron@akamai.com, 
	David Rientjes <rientjes@google.com>, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:21=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
>
>
> On Mon, Feb 26, 2024, 9:31=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>>
>> On 2/24/24 03:02, Suren Baghdasaryan wrote:
>> > On Wed, Feb 21, 2024 at 1:16=E2=80=AFPM Pasha Tatashin
>> > <pasha.tatashin@soleen.com> wrote:
>> >>
>> >> On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
>> >> >
>> >> > From: Kent Overstreet <kent.overstreet@linux.dev>
>> >> >
>> >> > It seems we need to be more forceful with the compiler on this one.
>> >> > This is done for performance reasons only.
>> >> >
>> >> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> >> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> >> > ---
>> >> >  mm/slub.c | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/mm/slub.c b/mm/slub.c
>> >> > index 2ef88bbf56a3..d31b03a8d9d5 100644
>> >> > --- a/mm/slub.c
>> >> > +++ b/mm/slub.c
>> >> > @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, voi=
d *x, bool init)
>> >> >         return !kasan_slab_free(s, x, init);
>> >> >  }
>> >> >
>> >> > -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>> >> > +static __always_inline bool slab_free_freelist_hook(struct kmem_ca=
che *s,
>> >>
>> >> __fastpath_inline seems to me more appropriate here. It prioritizes
>> >> memory vs performance.
>> >
>> > Hmm. AFAIKT this function is used only in one place and we do not add
>> > any additional users, so I don't think changing to __fastpath_inline
>> > here would gain us anything.
>
>
> For consistency __fastpath_inline makes more sense, but I am ok with or w=
ithout this change.

Ok, I'll update in the next revision. Thanks!

>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
>>
>> It would have been more future-proof and self-documenting. But I don't i=
nsist.
>>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> >>
>> >> >                                            void **head, void **tail=
,
>> >> >                                            int *cnt)
>> >> >  {
>> >> > --
>> >> > 2.44.0.rc0.258.g7320e95886-goog
>> >> >
>>

