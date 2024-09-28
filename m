Return-Path: <linux-arch+bounces-7478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E17988F6F
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141361C20E1C
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698151885B7;
	Sat, 28 Sep 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyaRxQfR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122C187FF4;
	Sat, 28 Sep 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530883; cv=none; b=mGNCDUcDJQOi31t4sUEa6CCl7Zp+QYyxZ+ihqZ3jhhwBalaUrJJOJv6CYqp3yajxL81zEiba7SHZXuOFASv88ovXM3ulUQ2ph4RXqSNlpyX9m3meFocaEvwfbxR9D67XG+46zSjIdI4tiJVMxalx8Kk3+yZEgt30e+DbkFarqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530883; c=relaxed/simple;
	bh=orpQEHYHyBoCCUjzbaUktQopXRvr5Ek6mitfHI0agMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tV750czipMfwqyxI75cqmgBddBjWfznr0tE1Bvm/1Fb1gmutKMsOLkDSKMxUj5Qs5itjros78zMXWGSpnHbPG0ZjYbeX0TSkFwUOqV0/5QIwEXKR9E/mil4mLiWWMDWPz9cOfXyBAidGZA6KqcS4z9DeFt5/oqqPCa+Ft8WJwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyaRxQfR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539885dd4bcso1707618e87.0;
        Sat, 28 Sep 2024 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727530879; x=1728135679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNmBSpA2BmR/JT9QNG5130+zMmw0zS2R0933ikB5pGY=;
        b=lyaRxQfR6pDvFtPh03QSIMr42veT9U6yGFpmRrP2MqX05526bN+lCWEpN4RksEXhL1
         PyIKlP1CUMimgQ4B3Bu4d2uyXb2TFIEkoTrGo31BUqnTpBubkJkw85hKAGiaz7mzW/fA
         E5cL7sHVDLP//aPpeMtUrTKdjCApIq9atVmqx413w1pu6vcVoS3BOQShVvsqiwxunwyr
         KfZIvN+kSXjdFqwDqyMRoHxKTMPXFnVmtn+bWMKl/eyV0cYoFIYTf/gLOuDFq1s2I346
         rK+A4iPQBSwBHtHKaLhU/hXB/y3DymiiboXLbNIFiF3m1nOYbAU1Fjyu/RDepQqdkfe1
         f5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727530879; x=1728135679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNmBSpA2BmR/JT9QNG5130+zMmw0zS2R0933ikB5pGY=;
        b=qv+bxZ61UZX5FJbxPnWH/E89lb6JClLFkHCnCybA6m4c40uk/NdEuUvfP3X6P2ZM7T
         kQDRKBgHicqUFf1AkuU3u7Pvqvc9mPmbBf+aOV7wp1DSO3VHwWScNQEZNZN/r0yr2/U+
         TdmuFk2yZB1Wj9rISExG9f1h4+6qC3nB8+WFmIH1xLHmjVomyUfJ1h3rK4xE4pQc1qWC
         ixa9Z2cy1QQkALUq51KmywtK+fVTgpETWH4s3XG+OS+lNKbJ4BbU6i8+02sfG9bLdSPS
         ZqjDbrfGQQilsK9HpcBTkJkdNAVzV2jHgMg0iPHrz3uMzM+4WQEdp+PAuNtRDA5VHnHD
         gvVg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qv90kM8IomWDDyyJcoh5pkluZydfD7eGC46sjT1E8ggpn2PBWnIiP8H564rs2966O5a6qwd6z9dnTO6CJNYLkw==@vger.kernel.org, AJvYcCUUvMQ7ieLv3ItQbpk029ELJzVtz1GHhFKbePsVDvZJRe40wYq9kWFsTyywoSxDeAmViTTEB7wAhhRN/Ypk@vger.kernel.org, AJvYcCV7QMX6j5hd7MCsjdDPxRzYgoV96eHt9/wcqgJfRFTdXDHOBPFQuhI7OSYEexVjmiWzJwEDWqdMSjYmdWXHIOM=@vger.kernel.org, AJvYcCVbLMpQQq0VrWrMmtY3EyavYc86XFtL+SjBOkn1h2EaBF5fmTDRETBg7PPVwx8+6DkSBngli8buW4EDeRT/@vger.kernel.org, AJvYcCVcOUk2z2+u5YMEXT28utuV4AercTvvvUoEhOFoyEux3VVPSsMeZaDUF7v+gCR+eP6VbLo=@vger.kernel.org, AJvYcCW6TONWCmlUtfcd585Zlhu7RkQMs+4g84q9Q9PNx7jnf4ytG92XBczqpY6Vu+BiGP1lrkRtDRmDmKVH@vger.kernel.org, AJvYcCXD6FE9bEQoupm0uzweMZ/FMx9Dqu3EFRbdgwMsKNUjhe2MnKbSK7fCtJCmyP61/mTatJr29EGl6Z8=@vger.kernel.org, AJvYcCXW3wJthV5+gSOj1UYTR3ZnD09rlBis3FvdpwGFNMzfrcX50vkKtc0QCkXMX9zqn61Mpq4ZUKqIjdb41A==@vger.kernel.org, AJvYcCXXt9c5hfXjZgQHacqSgG+kJrMTmKKi1p6/YViKVDImvTOJ859XS6oGvJOnTxtNSvJdaGPtZKx5GHjS@vger.kernel.org, AJvYcCXcNyM/0euV3FTAD3HeNmnv
 lADhPSmhNZSKMYQEkH1k02/LvGYntmcxXahuEQkssflYG29R3O6FITC9hzTV@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQEn6O5hmABLlJpJ4aLSs6mBId9uRGGXF7cHMxjt/n1WeGqtk
	IN8sl3idKTj2+tS2AMqqWNtY3mO+VryadkAw+0FU1ptax2m1Pxhj2ofBEDUkpZDD7azBWQI9eyH
	xRPheeLAXzrdb6hS45kj/+zOwtA==
X-Google-Smtp-Source: AGHT+IHmvDJivNH43Y01ucMKJYFoc8AFcX6hzmgU+8XoeSSFhpvEaQoSvahoajb/ht++NQ+MH1stDT2FsmHiW/GwHn4=
X-Received: by 2002:a05:6512:3f07:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-5389fc7fefemr3962432e87.45.1727530879148; Sat, 28 Sep 2024
 06:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-35-ardb+git@google.com> <CAFULd4ZNwfPZO-yDjrtT2ANV509HeeYgR80b9AFachaVW5zqrg@mail.gmail.com>
In-Reply-To: <CAFULd4ZNwfPZO-yDjrtT2ANV509HeeYgR80b9AFachaVW5zqrg@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 28 Sep 2024 09:41:07 -0400
Message-ID: <CAMzpN2j4uj=mhdi7QHaA7y_NLtaHuRpnit38quK6RjvxdUYQew@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
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

On Wed, Sep 25, 2024 at 2:33=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Specify the guard symbol for the stack cookie explicitly, rather than
> > positioning it exactly 40 bytes into the per-CPU area. Doing so removes
> > the need for the per-CPU region to be absolute rather than relative to
> > the placement of the per-CPU template region in the kernel image, and
> > this allows the special handling for absolute per-CPU symbols to be
> > removed entirely.
> >
> > This is a worthwhile cleanup in itself, but it is also a prerequisite
> > for PIE codegen and PIE linking, which can replace our bespoke and
> > rather clunky runtime relocation handling.
>
> I would like to point out a series that converted the stack protector
> guard symbol to a normal percpu variable [1], so there was no need to
> assume anything about the location of the guard symbol.
>
> [1] "[PATCH v4 00/16] x86-64: Stack protector and percpu improvements"
> https://lore.kernel.org/lkml/20240322165233.71698-1-brgerst@gmail.com/
>
> Uros.

I plan on resubmitting that series sometime after the 6.12 merge
window closes.  As I recall from the last version, it was decided to
wait until after the next LTS release to raise the minimum GCC version
to 8.1 and avoid the need to be compatible with the old stack
protector layout.

Brian Gerst

