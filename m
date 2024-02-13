Return-Path: <linux-arch+bounces-2317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14702853EAF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 23:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFFE28509B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37F6217C;
	Tue, 13 Feb 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUTz5o3S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2360B8D
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863457; cv=none; b=OL3Ai9Z2g3U+SteVJPjICXqs8acix/TY1405/EOJx91949KCbwrdC51ZITSSOXOK42o+JuoRYv1zRRobkOS6iB/DuasVNyvI7lC4Zpr77fGkUlhgOtIgEfcMLg2fVCJUpjJfyK/d/XV7HU8iqbiYmRBa/MwLi1Ji5GKbV/kabE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863457; c=relaxed/simple;
	bh=W3iVhRNI3SJOZTKFO/V2hJvAlU1SxV9FtnbmB6rZ05w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKoot57oHCn5S37S9Ddi+R9CxTDGDi+nzsxSMgCl9qKdT6idbhwEe+bJFiOLqriNMe1nuUYq2V3ye/viUfriHyAASM1dA/4r+njtnRoOVGz4MzqbWDkVueDD45MZROKfj9IgUP8PAri/W63XDMVXPOBFbo9DsCjMyG5Qe2mFS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUTz5o3S; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3546383276.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863455; x=1708468255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3iVhRNI3SJOZTKFO/V2hJvAlU1SxV9FtnbmB6rZ05w=;
        b=XUTz5o3St2k+c67e6r84lL+FM9cwVhsuZsKZLNPusg0EqRzW+KJKjVThZvxdkHGjHH
         YrVVpfl353pSZRfn8wqNfz2oBdd7LsX3vn/jpCLtI0gro3uYcVj9Y5dcke27uqm/Yq6m
         xejOPVpFiiAuLHS4mMi31zFqs5utjqA780dBqQHZ02cfigogRjh0KwtqIy0GsPjdv3Vm
         cbMJdvDi8Y/DHnJr55bdq2IvhOwRICXLsTmA6klzON6BBg3GdxNGHJfPMYoPtCWcLtC2
         3yU09KRaasRMXpr90TU4Jo+Plyvauunl1qIQ24bc8KBw9b1YiRtamW9m28ANfLroFxF9
         dBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863455; x=1708468255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3iVhRNI3SJOZTKFO/V2hJvAlU1SxV9FtnbmB6rZ05w=;
        b=L52JH77T0KXZYj6HNIWiAIj+ig0mXdyDqERttK+Gn0Rv0x6rJFd+CGIfhTVZhvFfdL
         RZtpi7Q+UWmQ13IQY30nNkIM4gCACRxRQ+Br6zqeKRh/eF2UQgjSQVSmZ+ETPKzqF8EI
         geL9854il3fA7RbwIoQoJwUnt7+LzenE+XxDJi/G5PF1VJNxR28D1EFrVSpWk1yN9QoW
         MAlt1qVjsx/govPbjBwFw7lkey6B3rytq8MdnaKxU3IRvCPJnD0g1gvWWEfAQYHkSpjo
         5UiCf2sB1XrJaol1jpjkfa11TtlkAzSQSjBATai+Bp/6Et5mKOifMsIagcno+jpz5u2X
         MF/A==
X-Forwarded-Encrypted: i=1; AJvYcCWpQbiltNSbUbuehfbc+845POrBxL76NIBoyQZ+p8Js/KqzW4s5P0hujkT1BxT5zTkBeMgGpjysxScCfHxmoitxJVzJAgsFT2odBg==
X-Gm-Message-State: AOJu0YwfNH20VK0OjQNZMjzJoBpAnHZhNNocDftb4E83TA4sFiPZrxvg
	qjOcOvDy6Lhb2uAq1MlRdRqXhBlcNzkBgcm9RsVZfW80GmXI4BDITWzMnAHo6Bi7D5IXIR3g6BK
	HaS+rqOMgNe6SwQgAxyzRDArXXfbHYk+8LSqu
X-Google-Smtp-Source: AGHT+IG1FA0jhI08ACtlkU58SUtF8BeY+odMEcGvWTpz8tU2mjZAwusKC+HjyJxosLmKwFVasQmCm2Mj11FO/ftiN4Y=
X-Received: by 2002:a25:e0d2:0:b0:dcd:df0:e672 with SMTP id
 x201-20020a25e0d2000000b00dcd0df0e672mr440832ybg.47.1707863454566; Tue, 13
 Feb 2024 14:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com> <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
In-Reply-To: <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 14:30:41 -0800
Message-ID: <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: David Hildenbrand <david@redhat.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
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

On Tue, Feb 13, 2024 at 2:17=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.02.24 23:09, Kent Overstreet wrote:
> > On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> >> On 13.02.24 22:58, Suren Baghdasaryan wrote:
> >>> On Tue, Feb 13, 2024 at 4:24=E2=80=AFAM Michal Hocko <mhocko@suse.com=
> wrote:
> >>>>
> >>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> >>>> [...]
> >>>>> We're aiming to get this in the next merge window, for 6.9. The fee=
dback
> >>>>> we've gotten has been that even out of tree this patchset has alrea=
dy
> >>>>> been useful, and there's a significant amount of other work gated o=
n the
> >>>>> code tagging functionality included in this patchset [2].
> >>>>
> >>>> I suspect it will not come as a surprise that I really dislike the
> >>>> implementation proposed here. I will not repeat my arguments, I have
> >>>> done so on several occasions already.
> >>>>
> >>>> Anyway, I didn't go as far as to nak it even though I _strongly_ bel=
ieve
> >>>> this debugging feature will add a maintenance overhead for a very lo=
ng
> >>>> time. I can live with all the downsides of the proposed implementati=
on
> >>>> _as long as_ there is a wider agreement from the MM community as thi=
s is
> >>>> where the maintenance cost will be payed. So far I have not seen (m)=
any
> >>>> acks by MM developers so aiming into the next merge window is more t=
han
> >>>> little rushed.
> >>>
> >>> We tried other previously proposed approaches and all have their
> >>> downsides without making maintenance much easier. Your position is
> >>> understandable and I think it's fair. Let's see if others see more
> >>> benefit than cost here.
> >>
> >> Would it make sense to discuss that at LSF/MM once again, especially
> >> covering why proposed alternatives did not work out? LSF/MM is not "to=
o far"
> >> away (May).
> >>
> >> I recall that the last LSF/MM session on this topic was a bit unfortun=
ate
> >> (IMHO not as productive as it could have been). Maybe we can finally r=
each a
> >> consensus on this.
> >
> > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > need to see a serious proposl - what we had at the last LSF was people
> > jumping in with half baked alternative proposals that very much hadn't
> > been thought through, and I see no need to repeat that.
> >
> > Like I mentioned, there's other work gated on this patchset; if people
> > want to hold this up for more discussion they better be putting forth
> > something to discuss.
>
> I'm thinking of ways on how to achieve Michal's request: "as long as
> there is a wider agreement from the MM community". If we can achieve
> that without LSF, great! (a bi-weekly MM meeting might also be an option)

There will be a maintenance burden even with the cleanest proposed
approach. We worked hard to make the patchset as clean as possible and
if benefits still don't outweigh the maintenance cost then we should
probably stop trying. At LSF/MM I would rather discuss functonal
issues/requirements/improvements than alternative approaches to
instrument allocators.
I'm happy to arrange a separate meeting with MM folks if that would
help to progress on the cost/benefit decision.

>
> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

