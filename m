Return-Path: <linux-arch+bounces-3783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94D8A9165
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 05:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D3D1F21906
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1384F218;
	Thu, 18 Apr 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyuRU+nb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C16138;
	Thu, 18 Apr 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409407; cv=none; b=dLQaXfdzMlZDGhEWrQIgNOuAJPzIMKlJmzir68nb/BC0QhcTaHUZcSeQrVfhOt9iMpSetsLpfFh9dLZtXngpJQOFeLvTJLkVmHQIFJQO230Xoe0GmUDXtzKHmKf56NuQNTJ2ylSYGjZaZoQhsuf8nP8+wdGWCii2NtE/L5W8Wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409407; c=relaxed/simple;
	bh=kfEJQjTwgGJh4Zkx43Z0VD1r+pL2rJMimsZzyjREVEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idbxgrIsfyS/1CyxhANwP59PhrAA7nkhxu0xyZQ2ermbCrKljh5KOAhva0SIVVADTWhU5jurGaLCbweT0OL7tZl4p1dNZjqOYxfQQZibJneayX6xGCxa5qsE2JGRF9JfAsPXF0ubJ2VOJ2aUNIn0FFqHw6cG+5sELUrsM6/CU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyuRU+nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4761C3277B;
	Thu, 18 Apr 2024 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713409406;
	bh=kfEJQjTwgGJh4Zkx43Z0VD1r+pL2rJMimsZzyjREVEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DyuRU+nbBlfEefDgkjYMaeHuZxrD+lMlRPMalkQi5IC69YYTWZ6zEdir/RupkAap0
	 17RzMJVBVaskBzoD8lhK/LtZy2kUP7k21+CDiY0gBXnPmT64owTkQbxHdf0JyAPAYx
	 tx0a4zLTnGo0CFjFFObQkeT4Qn82jY+d6vAZT/fd9qDpC/vddsmWPQ9f5r1pkH+Cb2
	 yh2V+NoEvWckhqYS09yUlUYUkVb0oMebHG0BQarTzSCq4o2/7SwOGQyDEXewhte9Sg
	 Lhmm69YwKDOmE0MM0CShULZ5v9DJpyzWisMvETTr/zB7h29YiU62z1Gam5322XaIMS
	 pcQhx3sXD225A==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a557044f2ddso14279466b.2;
        Wed, 17 Apr 2024 20:03:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYKBvBKXRyEWqu+7BMTN77g23vYSb9E9bArH7hfvTIghiag/MV+qvk4XmR5INFtomffqPPFlh+s8vQWKAi4RnQo85AkDORjSw451cYRAndTDWtxewb3sSYp29xO9zLAfnOrmE8IJ2ABj7V18PlQRY8973N2Y2YKNz8hiBgxA==
X-Gm-Message-State: AOJu0YwTmdPOq6cIBzMY6EttEpJ6P48l+q/jzt9p7qRSflkzKL6A2qnN
	gQZx6cmmVQKpw+SE3FrN3Ru5bXY0cEu9Q4J08AmXVKoTNaxtZD8726TNrmwXp5NKClwqWG+BxVX
	aFcE24gn1dYoTXmH3RufPXhh1N0M=
X-Google-Smtp-Source: AGHT+IEGnzxcLzKogVMafWt/io2wledXtCG2nYVIAR7Lu4aQp3Gm16la5nxK3JKrgyWlsMhlzCjZG627hEMlqWAR0dk=
X-Received: by 2002:a17:906:f8da:b0:a55:596b:c9ca with SMTP id
 lh26-20020a170906f8da00b00a55596bc9camr830982ejb.39.1713409405224; Wed, 17
 Apr 2024 20:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416144926.599101-1-david@redhat.com> <CANiq72kACt+FfeYXJxfQpmGH=uPqkDA0oprfnebw52VSKyn7kQ@mail.gmail.com>
 <CAAhV-H5mt0GaaZ3s44CYb4aKqYeDYm+Q16hY__FdQ6xYJh+bgg@mail.gmail.com> <20240417135834.ddaa9c038a8a8af2bd9e39aa@linux-foundation.org>
In-Reply-To: <20240417135834.ddaa9c038a8a8af2bd9e39aa@linux-foundation.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Apr 2024 11:03:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4O6_9Ukgz-GrPcWTq3cAN2c1OkXQWRbUgMR2ZwUuQQHA@mail.gmail.com>
Message-ID: <CAAhV-H4O6_9Ukgz-GrPcWTq3cAN2c1OkXQWRbUgMR2ZwUuQQHA@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch/tlb: fix "error: parameter 'ptep' set but
 not used" due to __tlb_remove_tlb_entry()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Hildenbrand <david@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, llvm@lists.linux.dev, 
	Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

On Thu, Apr 18, 2024 at 4:58=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 17 Apr 2024 11:18:27 +0800 Huacai Chen <chenhuacai@kernel.org> wr=
ote:
>
> > On Wed, Apr 17, 2024 at 3:25=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 4:49=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > > >
> > > > With LLVM=3D1 and W=3D1 we get:
> > >
> > > Hmm... I didn't need W=3D1 to trigger it (LLVM 18.1.2).
> > >
> > > > Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > >
> > > Thanks, looks good to me -- built-tested:
> > >
> > > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > > Tested-by: Miguel Ojeda <ojeda@kernel.org>
> > >
> >
> > Queued for loongarch-fixes, thanks.
> >
>
> (top-posting repaired so I can sensibly reply to this.  Please avoid
> top-posting!)
Sorry, I only top-posting with "Queued ...", "Applied ..." because I
saw others do like this. If this is also unacceptable, I will not do
it again.

>
> I'd rather carry this in mm.git with your ack please.  Otherwise mm.git
> won't compile without it and if I retain this patch we'll get
> duplicate-patch emails from Stephen and I won't be able to merge
> mm.git's mm-nonmm-stable tree into Linus until loongarch-fixes has
> merged.
loongarch-next always merges loongarch-fixes, so when I apply a patch
it will be in linux-next. Now this patch I have already applied to
loongarch-fixes and loongarch-next. In future, I will give an Acked-by
for you if needed.

Huacai

>
>

