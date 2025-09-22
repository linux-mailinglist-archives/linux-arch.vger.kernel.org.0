Return-Path: <linux-arch+bounces-13709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC4B8FC0F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A2C3B4EEB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B12868B8;
	Mon, 22 Sep 2025 09:29:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106D284B33
	for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533385; cv=none; b=TZNm+e7FBqd4Sdmb8ulFl5lvrjO98i1QT1kW+rs5gOEzWvRRqqSitL+be1EC1UR/7u/Mcjrm7+K9Uc7W06hw7+e8rPU0ywzUD2fAqt364Ef/EEDcYWbquKsFqXz4j73omgTAx6cy0Ad4oUKy5MiYkm2zKQ+iKDh5srneQ2+oFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533385; c=relaxed/simple;
	bh=gxid6d73FASpgj+Dbo6qkKXdo6ItVd1h5REmlU4F6PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHG5jQpF2OX3Kn+CFjWMsDzCuEKPeJu/bd3hIMAqr6MYIVuKM+rebfY9aY/V7+Lp+Y4QiWkNa5OnfDWSj3+8ohbwBcCXEwzGAFGAjlmXmdUeEIlCszJyHGXYUx5FauOu510SK2he4DoieMdEprkQZuGodivi9nz2mcL085PYpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54a94a48debso620986e0c.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533382; x=1759138182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebw4sp1U8DsoLtMGrD53MUAXHrZ/k+nhfitncmC356Q=;
        b=hQCkQERF2XM2malc0ZuPXl2JEXWMBA0u4T+l2P6qMsw5P5Nq3xA55TuxAesxgrN9Qm
         oa6VhAy9ulrLBxxzlhpVqFjHcMvPPxRu9kdVRw2l31VaxKG4r2y3XUHaaRet/X3csTo9
         vutxjnBFX6JA0jb+j9DA7nEChJW/ng1sZhM7dmBeNqGIf9aCdEQLtwWL3UH0v9tj9q5h
         XHDiEG9RqwOA72sukSO7rLOG0tT/dFb2AUxw715YZ7Sxr3jaNaIaRM9KvmSkf2XQZkJe
         lmafF46L+Vkak0253ZYoqAjlQI/2TPx4frhGBN0HsXZL03p1W+GifXzynjHG3+epEeot
         FIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+lVEPBy94RCLC0P3FI0DOoAmEtkvesJFfeyLcSb46r3ROyUSYni1EdWkZK8PZgtrkZShT3CbszFX@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+nxOBEM02IroBT8FTgkklKGUZ530w5bTRz3oFdmBQ9phrNHc
	uBWLxxKVYwNfuySuGuqN+wdDp1GC1bWVF1/FNlYmQ1dsHM9LnaRroatOWXBw3gue
X-Gm-Gg: ASbGncsk6nJ0nQWpHpQWhRToB5e71HB8podJxprXimfw5S6Yw/B1oNX+jH7QQGXRIdf
	/idD27a3vC/wfZWBTwkSpQnM6XYHW6n2RYnaTahEKdJkAkdwZXZhXG5RYwAGGuSHKZI3SYJ20pC
	IjuY9kIe9dKmCe00wG6aE6vS8ebt+3HsZ2jDsmLijdnzW2GLSsE7wBO1+CQZfVxPDSeu+iLasP5
	lARiEBTA4asZhYUp5lT1iE415zMCPL3uhzBylrtifrLt4GO73tq8dakKBOGrY9/Ifh5t4SIoRQD
	wKGh3BFUtxwKGl4Y0FKXpvMXWETUhBg0RuuNb2v801J1WjufaRlBT6zyUF7hJHRd8x/J4fSyZ3K
	gE/NDzc5ZbNIIkq+Mrly3dMMiu4faE4l1uIXyX6GrEICQANwxypB8UDlW84ts
X-Google-Smtp-Source: AGHT+IGNUtcSsd0WFldOoHBDhq4Vpz29/9XTxB5kfsCKM69+wl9NyTcwolzKTOciD+15pE64ZMs7Gw==
X-Received: by 2002:a05:6122:d88:b0:544:90b1:1a with SMTP id 71dfb90a1353d-54a838a0ff4mr2988391e0c.13.1758533382223;
        Mon, 22 Sep 2025 02:29:42 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a88d5efbbsm1688870e0c.27.2025.09.22.02.29.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:29:41 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8cda57802f3so1025559241.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 02:29:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwahYNZ74p0uCZMyq2W/V9CfnV03OgQ0zkcrZAEvaUL/I9mQbZB1NQyz67dgXL4Pc1rE98qU2e7IoP@vger.kernel.org
X-Received: by 2002:a05:6102:c08:b0:522:255d:4d19 with SMTP id
 ada2fe7eead31-588eb292bb9mr3073422137.23.1758533380886; Mon, 22 Sep 2025
 02:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
In-Reply-To: <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 11:29:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-AG-NeGZKuVy1e=TGKN895F2eHEzkjJeaGvAADv-vOQ@mail.gmail.com>
X-Gm-Features: AS18NWDKBc4eQCJYFdlrfn6McdPM_5-5yG-PRssau5_dGdaYxg2W9cfnnLuZ5PU
Message-ID: <CAMuHMdW-AG-NeGZKuVy1e=TGKN895F2eHEzkjJeaGvAADv-vOQ@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn,

On Mon, 22 Sept 2025 at 10:16, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 22 Sep 2025, Geert Uytterhoeven wrote:
> > This triggers a failure in kernel/bpf/rqspinlock.c:
> >
> > kernel/bpf/rqspinlock.c: In function =E2=80=98bpf_res_spin_lock=E2=80=
=99:
> > include/linux/compiler_types.h:572:45: error: call to
> > =E2=80=98__compiletime_assert_397=E2=80=99 declared with attribute erro=
r: BUILD_BUG_ON
> > failed: __alignof__(rqspinlock_t) !=3D __alignof__(struct
> > bpf_res_spin_lock)
> >   572 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:553:25: note: in definition of macro
> > =E2=80=98__compiletime_assert=E2=80=99
> >   553 |                         prefix ## suffix();
> >          \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:572:9: note: in expansion of macro
> > =E2=80=98_compiletime_assert=E2=80=99
> >   572 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro
> > =E2=80=98compiletime_assert=E2=80=99
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BU=
ILD_BUG_ON_MSG=E2=80=99
> >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #co=
ndition)
> >       |         ^~~~~~~~~~~~~~~~
> > kernel/bpf/rqspinlock.c:695:9: note: in expansion of macro =E2=80=98BUI=
LD_BUG_ON=E2=80=99
> >   695 |         BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D
> > __alignof__(struct bpf_res_spin_lock));
> >       |         ^~~~~~~~~~~~
> >
> > I haven't investigated it yet.
>
> Yes, I noticed that also, after I started building with defconfigs.
> I pushed a new patch to my github repo.
>
> https://github.com/fthain/linux/tree/atomic_t

Thanks, the updated version fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

