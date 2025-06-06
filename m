Return-Path: <linux-arch+bounces-12256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427BAD06CB
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 18:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7F2188978C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F6288CA0;
	Fri,  6 Jun 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m87KKs5V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB670823;
	Fri,  6 Jun 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227969; cv=none; b=aZbHItjI1Qus5bbrJEm9wgFm2XVYMauGjBr/wI/ATh7dDdaThw5bSiR/yTctuqj5tP1Yto/NsUycGdZSPQBtHLeXIxNEMKWKor5pUtwJ++ZTT1IZTVoBZF2ldakAXeCWHWHy0j4G6wKvrgnD7NSEUCKKFGNoN0bUzlnQ0nuyH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227969; c=relaxed/simple;
	bh=xG9ePX+hhlM2ioCU4Dn4OhL+GFgr0KjnNhY43k95Q7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwe6HqeWETRH8wYmzzyFEqZh4x4Nh7kQb4K3PcVuiW9QHFVuwpLDaiKrr/3eKbYy8ytoId09D+z6FnW8ONtImclJzf4T78aDgjKX6xJiLdVKnY9XigRQRY8P3Ft3MAnf35yTgFVYZiYuma+QJfrJSYl6R0ye+Oj+8uD8C/s30XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m87KKs5V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0ac853894so2062239f8f.3;
        Fri, 06 Jun 2025 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749227966; x=1749832766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG9ePX+hhlM2ioCU4Dn4OhL+GFgr0KjnNhY43k95Q7M=;
        b=m87KKs5Vry+d9Y+FpXYqRrMdBtkwFJsbNDoWUnGYZ4AW8La+bGQkoYzt4Ws2L7D3iy
         6KFSLXtHk6XqFt0qC9QKfL52Yw6s+/3GiYuHjZbVtRlsylfvAdUcasiq3UV0TH8SftEo
         kyjMY/Zceozcc6/tiNfthy0f4PcDWvlEhqAZLW7F6bBG0b96Qq0WjwlSz4n6GPg13NBs
         X35tL3PlFgG2kJK2yMATXRbHyTVZy+7IqFOR/BdNeyq4+Pzgth1Ut/nFk6ADzb6Kf634
         uSgh7zbFjLNU4J7dksyYX2llsSm0WS/9phWq4kKsIAGr2Mu9aFE+TTptyMXYHEhfFPJ/
         kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749227966; x=1749832766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG9ePX+hhlM2ioCU4Dn4OhL+GFgr0KjnNhY43k95Q7M=;
        b=lV/OMB2sWScDWTsY5N7mDQPDXr1QAeHgQQuTyQJ6McBAHsDFBBeAHtf/zm3Hrojjyq
         dhU78mGHODPjYHpMtbzxsdrevLcrEpTf1/9E8hnxx7uEHFi4WSFHGgH0wvcGqPCoA+bT
         ONsaKYKuyiq1Zf0WOFRatX+pOHk8idneME+vgySfG+g6oNoF/CrKyCQS3uufxKhZqDAs
         BTRCSG35EoxhobIGOduJoTM+ACICKyVig2HCQ+FjvT2U0VePkl+BRHr479OY2Og81psJ
         yLVhKP/j4qrKrN+EHRLN6hia6a5890/bY5RWM5PcESRG0VicyMbTWMyyZZ1RbZkfZfHC
         /w9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd445Lmg+/2nbnCNdfHqJg9EHA1aSfrl8NbiEq+1N4oPeYWjtexR6Q13wMOnDnLz1t8clUiZZ1OxR0XpyK+zA=@vger.kernel.org, AJvYcCVIUhCkCwi3fzz8JRH2ukuM+8IedW5MAXlBR6aP8D1NmJjDuGAiJ0A4vL6zY9vA0vTYQVQqQW5h@vger.kernel.org, AJvYcCVa36Hfqf7qsJFHPfE04DIaGpaVQp2gP1rfJfeniWDI44/AWDgchaMl9+3rVPlYcoij2rqKK6zLbdrU@vger.kernel.org, AJvYcCWW/tgPQ3/jOemcsey2Rg1AmsgdBfI3FWhcKab4nS4E5IEtz8fdPEWSm1lH+BNB+bdjFU6wYP1G+wYMZoX/@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMGCx5lxL6xP6S74xjdOKBIRQRlGILFzYMtbGl1HlaMkr76sQ
	3zldnvzY5eqatLSykYi7tt70bSKtfoSBTzHmav7S8Tomg/0vvw7Ur+IssewtGPSqH2/FNmey0AB
	zac/gWINXJJytJLBKKMmidZsJ/o7JnU8=
X-Gm-Gg: ASbGncuuoFKM6sVTwbB4w69lm1d1TfiGoq6UKD8Y79/fS+61HQFqyEoC5IcJAS8gF1k
	Pujsv7OLSE1n9rFvjzoADGe8TbVIQ0SKXxWHKQ255v33XYuoEJBMkASD4W/r9Enq/ulCtJ+gkpT
	MXb0Lh2qto5NgWvVdRDbPE8Q/L/qiNPt0UCJm0Xd1hMSJW+yMHSUgbkg2yy2rGKvxUgvbQ5g6R
X-Google-Smtp-Source: AGHT+IHq3315Dn9d+hwBUjw+Kg7LXaNHoxU48aZvD/S6yAkrZn0JTcP080HQQ7KB6Kt2s68Ve/l1xGCfwKScVzLRx+U=
X-Received: by 2002:a05:6000:250f:b0:3a4:e7b7:3851 with SMTP id
 ffacd0b85a97d-3a531cf3622mr3440431f8f.58.1749227965553; Fri, 06 Jun 2025
 09:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
 <9767d411-81dc-491b-b6da-419240065ffe@kernel.org> <CAFULd4Zf4FOP-h0GVYo=frJ90tF07yvbuLbngnqUwyx9x+qz6w@mail.gmail.com>
In-Reply-To: <CAFULd4Zf4FOP-h0GVYo=frJ90tF07yvbuLbngnqUwyx9x+qz6w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 09:39:13 -0700
X-Gm-Features: AX0GCFvJ_YDCqF1cB2ZxZ3E0i0bq9e0VCZSctUZEDeWlAKAIlg-aO97Jeml91Fg
Message-ID: <CAADnVQ+FG9BH=FrgPctQfC+cSMoP2rZwR1d8cHVqn28xv-Uc1Q@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-bcachefs@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 2:27=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Fri, Jun 6, 2025 at 11:17=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >
> > On 05. 06. 25, 19:31, Uros Bizjak wrote:
> > > On Thu, Jun 5, 2025 at 7:15=E2=80=AFPM Dave Hansen <dave.hansen@intel=
.com> wrote:
> > >>
> > >> On 6/5/25 07:27, Jiri Slaby wrote:
> > >>> Reverting this gives me back to normal sizes.
> > >>>
> > >>> Any ideas?
> > >>
> > >> I don't see any reason not to revert it. The benefits weren't exactl=
y
> > >> clear from the changelogs or cover letter. Enabling "various compile=
r
> > >> checks" doesn't exactly scream that this is critical to end users in
> > >> some way.
> > >>
> > >> The only question is if we revert just this last patch or the whole =
series.
> > >>
> > >> Uros, is there an alternative to reverting?
> > >
> > > This functionality can easily be disabled in include/linux/compiler.h
> > > by not defining USE_TYPEOF_UNQUAL:
> > >
> > > #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > > # define USE_TYPEOF_UNQUAL 1
> > > #endif
> > >
> > > (support for typeof_unqual keyword is required to handle __seg_gs
> > > qualifiers), but ...
> > >
> > > ... the issue is reportedly fixed, please see [1], and ...
> >
> > Confirmed, I need a patched userspace (libbpf).
> >
> > > ... you will disable much sought of feature, just ask tglx (and pleas=
e
> > > read his rant at [2]):
> >
> > Given this is the second time I hit a bug with this, perhaps introduce
> > an EXPERIMENTAL CONFIG option, so that random users can simply disable
> > it if an issue occurs? Without the need of patching random userspace an=
d
> > changing random kernel headers?
>
> In both cases, the patch *exposed* a bug in a related utility
> software, it is not that the patch itself is buggy. IMO, waving off
> the issue by disabling the feature you just risk the bug in the
> related software to hit even harder in some not too distant future.

The typeof_unqual exposed the issue in the way GCC generates dwarf.
The libbpf/pahole is a workaround for incorrect dwarf.
The compiler shouldn't emit two identical dwarf definition for
one underlying type within one compilation unit. In this case
typeof_unqual somehow confused gcc.

