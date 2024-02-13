Return-Path: <linux-arch+bounces-2331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3185401B
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 00:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CAF28642A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C663124;
	Tue, 13 Feb 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+eIh+Pf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58A63108
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866925; cv=none; b=l0xJdWNd9uxiecsyr7nUCdMCdSkg9jKzMKFbMOQYF2ivwUorvwN6SdaAc9TDUMhDfxEN1GzKNll/o1cJhRz+eRAzkEBjfmYJQoxHaaF0torHl71wU5R51x4vaI9sWkOThdiDut0gS4RL64m1iXsJORSvuIKkzx+6TacePqq0dOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866925; c=relaxed/simple;
	bh=Fh7ErxUCpzMchpW5XvBpyJH6+JOUDYjAM9H3p1A49z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9sC7ykHwlFIFbahDIFN+Tnbko/VTDaDGPCLS48l228uPsXlxSQSTN8rg8PeRtNSKaW7I2Y4L6672Cf8fUVYFo3Du92IQRVX1ElmnToAhjedhq41k123wxSynvrGAmTOdlpNWPHOpQFNvrUNy8U0v+rsrkqw9fTcwdYx0UT43TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+eIh+Pf; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so1378985276.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707866922; x=1708471722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh7ErxUCpzMchpW5XvBpyJH6+JOUDYjAM9H3p1A49z8=;
        b=Y+eIh+PfzekHyDxlBTBK2q6zRDs/sxfUKXOLpAcUocxRXX2VO9E1pNbjQLlnW/TOhT
         KpPh0ON5ge9Qr4oxa7f3Y471vujgzH7lkicB1EuFt4qyDG0yeqBBCFP/uHaau5LbwXya
         gTk4C7Epj7N/DDLcCtfb3FFlNWOuwDSvhiPKza5+M3/gP8bb6B6r815esNNv8sUzwE7+
         XApu2XC9IR3Cvo36gxjdIIxmsPr4pK7rM/kBuZlnjLNs3pbrXz9oNcF5BkhxUH2tD1ys
         uiCukottR2GXWSD6CLW0Aej+u1dgAvtRIFE9wjLB1Qj4oN4wxL6KYbSisROvnmRjPYXM
         f6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866922; x=1708471722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh7ErxUCpzMchpW5XvBpyJH6+JOUDYjAM9H3p1A49z8=;
        b=TzxFZ8RaS/eUeEut+kw73rT41617gzYmyMIn04p/2GmgZphiIhJ+xOTApKlHvlHktH
         JtsvF3zhl9+qPDui2tbbJjn3hC6Yv/oSqVomOHEE7nNTyHsgVtOo7pe0s/Hgx8RWIKEI
         ylnT91lOhRDmZzBs9StS1gvvs0vnzd+7QTNqBtqtGzvK8qwOK+hSBYk7H4Ai2SifbJFp
         9lZnZA16FJZnPWCP05VhdzP8BAlkAC+d2VhODOQ6IXVdzG5u3VdcvnR9Rx8lwDQAFYuP
         x7nfm9rTHG20XvKm+uYqMH4rubyBkVWWH1ND5PLDWQY7WozKQjenV1MSJZgnfbIXPhyz
         nmAw==
X-Forwarded-Encrypted: i=1; AJvYcCVDpxwFbvM8QSYJ7hxoH7pV+ez9Ix4Vzz11rgbGRFPi0MoF+tT7/OoewJBzcEuhkWBVNOqAnGe+6DwcazJwDAh6kkvAiUaHc2XerQ==
X-Gm-Message-State: AOJu0YwFMiVbUZvWwE8cRiE7eoRY4sLE+9f+UbsU2FlMc+guOG7QUJ23
	IS3eIm/5gHk+79X9vIwl5wN+fRE1iJE34PHTVfID8bRKhQ6p5ry1oViiDOOzJTg+8AYNq9YRTnj
	8ENMPQ9qBxhiOjqAtQWv3AfCO4wp32yZn6FWL
X-Google-Smtp-Source: AGHT+IH1cx91N1JNhTYTGrGxO4dPJb5P83emWz32j1FEf6NDT97WWgdnPVQTmEze6DwfHHV7j4kW4vXwyGP73AwNRVA=
X-Received: by 2002:a25:84d2:0:b0:dcd:6a02:c111 with SMTP id
 x18-20020a2584d2000000b00dcd6a02c111mr818389ybm.11.1707866922283; Tue, 13 Feb
 2024 15:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zctfa2DvmlTYSfe8@tiehlicka> <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com> <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com> <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com> <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com> <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
 <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com>
In-Reply-To: <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 15:28:28 -0800
Message-ID: <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
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

On Tue, Feb 13, 2024 at 3:22=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.02.24 00:12, Kent Overstreet wrote:
> > On Wed, Feb 14, 2024 at 12:02:30AM +0100, David Hildenbrand wrote:
> >> On 13.02.24 23:59, Suren Baghdasaryan wrote:
> >>> On Tue, Feb 13, 2024 at 2:50=E2=80=AFPM Kent Overstreet
> >>> <kent.overstreet@linux.dev> wrote:
> >>>>
> >>>> On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
> >>>>> On 13.02.24 23:30, Suren Baghdasaryan wrote:
> >>>>>> On Tue, Feb 13, 2024 at 2:17=E2=80=AFPM David Hildenbrand <david@r=
edhat.com> wrote:
> >>>>>>>
> >>>>>>> On 13.02.24 23:09, Kent Overstreet wrote:
> >>>>>>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrot=
e:
> >>>>>>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
> >>>>>>>>>> On Tue, Feb 13, 2024 at 4:24=E2=80=AFAM Michal Hocko <mhocko@s=
use.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> >>>>>>>>>>> [...]
> >>>>>>>>>>>> We're aiming to get this in the next merge window, for 6.9. =
The feedback
> >>>>>>>>>>>> we've gotten has been that even out of tree this patchset ha=
s already
> >>>>>>>>>>>> been useful, and there's a significant amount of other work =
gated on the
> >>>>>>>>>>>> code tagging functionality included in this patchset [2].
> >>>>>>>>>>>
> >>>>>>>>>>> I suspect it will not come as a surprise that I really dislik=
e the
> >>>>>>>>>>> implementation proposed here. I will not repeat my arguments,=
 I have
> >>>>>>>>>>> done so on several occasions already.
> >>>>>>>>>>>
> >>>>>>>>>>> Anyway, I didn't go as far as to nak it even though I _strong=
ly_ believe
> >>>>>>>>>>> this debugging feature will add a maintenance overhead for a =
very long
> >>>>>>>>>>> time. I can live with all the downsides of the proposed imple=
mentation
> >>>>>>>>>>> _as long as_ there is a wider agreement from the MM community=
 as this is
> >>>>>>>>>>> where the maintenance cost will be payed. So far I have not s=
een (m)any
> >>>>>>>>>>> acks by MM developers so aiming into the next merge window is=
 more than
> >>>>>>>>>>> little rushed.
> >>>>>>>>>>
> >>>>>>>>>> We tried other previously proposed approaches and all have the=
ir
> >>>>>>>>>> downsides without making maintenance much easier. Your positio=
n is
> >>>>>>>>>> understandable and I think it's fair. Let's see if others see =
more
> >>>>>>>>>> benefit than cost here.
> >>>>>>>>>
> >>>>>>>>> Would it make sense to discuss that at LSF/MM once again, espec=
ially
> >>>>>>>>> covering why proposed alternatives did not work out? LSF/MM is =
not "too far"
> >>>>>>>>> away (May).
> >>>>>>>>>
> >>>>>>>>> I recall that the last LSF/MM session on this topic was a bit u=
nfortunate
> >>>>>>>>> (IMHO not as productive as it could have been). Maybe we can fi=
nally reach a
> >>>>>>>>> consensus on this.
> >>>>>>>>
> >>>>>>>> I'd rather not delay for more bikeshedding. Before agreeing to L=
SF I'd
> >>>>>>>> need to see a serious proposl - what we had at the last LSF was =
people
> >>>>>>>> jumping in with half baked alternative proposals that very much =
hadn't
> >>>>>>>> been thought through, and I see no need to repeat that.
> >>>>>>>>
> >>>>>>>> Like I mentioned, there's other work gated on this patchset; if =
people
> >>>>>>>> want to hold this up for more discussion they better be putting =
forth
> >>>>>>>> something to discuss.
> >>>>>>>
> >>>>>>> I'm thinking of ways on how to achieve Michal's request: "as long=
 as
> >>>>>>> there is a wider agreement from the MM community". If we can achi=
eve
> >>>>>>> that without LSF, great! (a bi-weekly MM meeting might also be an=
 option)
> >>>>>>
> >>>>>> There will be a maintenance burden even with the cleanest proposed
> >>>>>> approach.
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>>> We worked hard to make the patchset as clean as possible and
> >>>>>> if benefits still don't outweigh the maintenance cost then we shou=
ld
> >>>>>> probably stop trying.
> >>>>>
> >>>>> Indeed.
> >>>>>
> >>>>>> At LSF/MM I would rather discuss functonal
> >>>>>> issues/requirements/improvements than alternative approaches to
> >>>>>> instrument allocators.
> >>>>>> I'm happy to arrange a separate meeting with MM folks if that woul=
d
> >>>>>> help to progress on the cost/benefit decision.
> >>>>> Note that I am only proposing ways forward.
> >>>>>
> >>>>> If you think you can easily achieve what Michal requested without a=
ll that,
> >>>>> good.
> >>>>
> >>>> He requested something?
> >>>
> >>> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> >>> possible until the compiler feature is developed and deployed. And it
> >>> still would require changes to the headers, so don't think it's worth
> >>> delaying the feature for years.
> >>>
> >>
> >> I was talking about this: "I can live with all the downsides of the pr=
oposed
> >> implementationas long as there is a wider agreement from the MM commun=
ity as
> >> this is where the maintenance cost will be payed. So far I have not se=
en
> >> (m)any acks by MM developers".
> >>
> >> I certainly cannot be motivated at this point to review and ack this,
> >> unfortunately too much negative energy around here.
> >
> > David, this kind of reaction is exactly why I was telling Andrew I was
> > going to submit this as a direct pull request to Linus.
> >
> > This is an important feature; if we can't stay focused ot the technical
> > and get it done that's what I'll do.
>
> Kent, I started this with "Would it make sense" in an attempt to help
> Suren and you to finally make progress with this, one way or the other.
> I know that there were ways in the past to get the MM community to agree
> on such things.
>
> I tried to be helpful, finding ways *not having to* bypass the MM
> community to get MM stuff merged.
>
> The reply I got is mostly negative energy.
>
> So you don't need my help here, understood.
>
> But I will fight against any attempts to bypass the MM community.

Well, I'm definitely not trying to bypass the MM community, that's why
this patchset is posted. Not sure why people can't voice their opinion
on the benefit/cost balance of the patchset over the email... But if a
meeting would be more productive I'm happy to set it up.

>
> --
> Cheers,
>
> David / dhildenb
>

