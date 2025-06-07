Return-Path: <linux-arch+bounces-12260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE68AD0C06
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB43AEE31
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B71F582E;
	Sat,  7 Jun 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgcbhFwG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612284039;
	Sat,  7 Jun 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286378; cv=none; b=mY8oHPdcmp8azKvqu4xxTAKX7/2diQbCh+6MiTjhfl42kNvfL70dBBlsQ18YfYod3mIf/xfXKRxO/XsDLt9VBxrIguhjI/LZtQsOG6k2BJt7BuQM4Bdlml7037yUjVGA/MoPV3Q0MhZ+ZUunmkFzosXlussnkZfsBNHXFC96ZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286378; c=relaxed/simple;
	bh=vyutQaTYXrN4bm09V9PWZFQHSh8YZLIkVVALBR7R7AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPjt3CF4UTejV6J416skxB6Gd4wL73niYYTd+JH8jN8eVcbwr257GXjfuK7FfRUXPTqsJhJanaxQah5EPmvM/fB+Rf2ofL8PabhCcyBk4WnbyxB1RsMiTtH3JtrfAeEbfl+ecTWufP1YK4oJbWRRBcaLjB/J1A9+KGfYg1u/alk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgcbhFwG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso23333501fa.2;
        Sat, 07 Jun 2025 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749286375; x=1749891175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFyeqit6vTlbw/r6iPxMrJhoHvnvByEOju0HOOfl2RQ=;
        b=EgcbhFwG/Ev5vVX8ivr1hzdlo/7aJjpd3c/3JwqrptFbkXBoJQNy3PW/KUfL7fo72v
         0PnghCzCGuWitC3teMgimhvRWYW+BK1aqoE1Qc+CUVoQ03+urOBPNRKaTFtCDG9+tJS9
         ItYVQGO0ymULQ6ch/Ui2hlwkazplVB8+s5Pcivz/+vJuYfha7zsiNbZaiOnanPaEg7l+
         z6Y+Ewkel/e5qHrelmgWRDISd2lEy2Z/ADBUDXTTsEDEXCfPGWD9JxnTeoLA0zCenq0P
         1xyMFQHnpLTta/pafLXcTAyZAPNr4YilMnuMqGBvXz5c+M/MmHX+Vb/4XKcug2ofhL1r
         WOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749286375; x=1749891175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFyeqit6vTlbw/r6iPxMrJhoHvnvByEOju0HOOfl2RQ=;
        b=jHPIN2wrIHlfJWYWQ/87n8YuEPhAsHLYzV5sodePoemwGY8ng+fQrmEZ6dcBROv0D6
         kwPxjzQsU9LTR4zcP76Z9aHpfksOMlVgTPgTBXXRREWwQHow2BWdJXbRkmn0rAIkhBHo
         TSkSTuoA8VJKcKJwfk3gAjqsEsZkZSTLPtBZfYhJ+bDfTn4UwQ72lhdAtjVJMuF+ePal
         9tB8RFFDJVX7ai5j0wcfKqT8JXTvRSqzYSu1r4PSUOtZlb0EMzFrRMRtmVE6ZPSN42tN
         OJ1Q979hTXWKuk3uuh1gZ+IvY9ILNab/jUvDtJLJ7JfVSaQoIbBBxdQh14E7+KYj9Jqy
         3OvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3mTTT8vQceBFIhqm9GzSWzOw+KWNbm6b9cxeDZXnxVTJ/Fambfg4y9/deaPXW3j+iUD8FylUS@vger.kernel.org, AJvYcCV5RuNMsRPbjz56nPWAdOpzsrZ1MPbRsaHJA3SnLPQ8ZTi/3376qa2+LpHlhHamlgtxjtZ/7HZOgH1g@vger.kernel.org, AJvYcCW0xFUhTy2wXWBb0V0Strfrs3+HDNAQyAOcfMP3qwRW+zMulqoA13NqroN6aYvM1M1y9iYonZN66IjLPRZj+T0=@vger.kernel.org, AJvYcCWbJcdOn7HvA4ktNGmhw5rPA0d/6LBblgqkZeMkYIwM1PR6DZZrzchFaRrxKq6mk+xfEuJCiDoHOND8LF1l@vger.kernel.org
X-Gm-Message-State: AOJu0YwDApWV1FRoSMcGNHN1j30h8YKbkOdPazdFEaSTvEFWE8SeOJOo
	Pp3PpkpvG8mx1t/qX3V6uAO+nfib+hvNcoPTZ9ES50KgVBNj6ADHWupSWAeUQMPDSNLs3pEjhvZ
	gHklUJluDHUnLqkuT3BO3NrxpQVr19LM=
X-Gm-Gg: ASbGncuEKYXNBbzWst5l76qI5/rwUghPBpGCi5BGSCvPnAc2vyO8N3Ym99MvmBAr6au
	EmdjrRJedidbvJwYu8YSu6UfmvQHh4qV1Hvl1JByQqDvRDff/kSbsN6LPx7CH8jxuI00kdfiDGI
	JpVrGybFCNfIhSmyfiwB8Gl396ui7d2wvj
X-Google-Smtp-Source: AGHT+IEv37WjEi+vaAOMeA5SgqO5lvoauaHOHnb329J/YwAGAVcoSaaoQm5IHeU+YLfaL/u+ZCEwVl2jWuJ6emEkASk=
X-Received: by 2002:a05:651c:2125:b0:32a:613b:270e with SMTP id
 38308e7fff4ca-32adfbd6680mr15634651fa.31.1749286374353; Sat, 07 Jun 2025
 01:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
 <9767d411-81dc-491b-b6da-419240065ffe@kernel.org> <6412d84a-edc3-4723-89f1-b2017fb0d1ea@intel.com>
In-Reply-To: <6412d84a-edc3-4723-89f1-b2017fb0d1ea@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 7 Jun 2025 10:52:51 +0200
X-Gm-Features: AX0GCFvfdq2FOXmAZPfE7zBP4TMsOLROw_40PNuCe1ZfMVOzlSJ4vDSOaP8ertQ
Message-ID: <CAFULd4asiDaj1OTrqWNMr5coyPeqM1NT6v2uEqKvJicRUhekSQ@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 5:44=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 6/6/25 02:17, Jiri Slaby wrote:
> > Given this is the second time I hit a bug with this, perhaps introduce
> > an EXPERIMENTAL CONFIG option, so that random users can simply disable
> > it if an issue occurs? Without the need of patching random userspace an=
d
> > changing random kernel headers?
>
> What about something like the attached (untested) patch? That should at
> least get folks back to the old, universal working behavior even when
> using new compilers.

IMO the commit message is unnecessarily overly dramatic. The "nasty
bugs" were in fact:

- unfortunate mix of clang < 19 and new gcc-14 [1], fixed by
robustifying the  detection of typeof_unqual

[1] https://lore.kernel.org/lkml/CA+G9fYuP2bHnDvJwfMm6+8Y8UYk74qCw-2HsFyRzJ=
DFiQ5dbpQ@mail.gmail.com/

- sparse doesn't understand new keyword, patch at [2], but sparse is
effectively unmaintained so a workaround is in place

[2] https://lore.kernel.org/linux-sparse/5b8d0dee-8fb6-45af-ba6c-7f74aff9a4=
b8@stanley.mountain/

- genksyms didn't understand the new keyword, fixed by [3].

[3] https://lore.kernel.org/lkml/174461594538.31282.5752735096854392083.tip=
-bot2@tip-bot2/

- a performance regression, again due to the unfortunate usage of old
gcc-13 [4]. The new gcc-14 would break compilation due to the missing
__percpu qualifier. This is one of the examples, where new checks
would prevent the issue during the development. Fixed with the help of
gcc-14.

[4] https://lore.kernel.org/all/CAADnVQ+iFBxauKq99=3D-Xk+BdG+Lv=3DXgvwi1dC4=
fpG0utmXJiiA@mail.gmail.com/

- the issue in this thread, already fixed/worked around. Looking at
the fix, I don't think gcc is at fault, but I speculate that there
could be some invalid assumption about dwarf representation of
variables in non-default address space at play. I'll look at this one
in some more detail.

Please also note that besides the above issues, the GCC type system
and related checks around named address spaces was rock solid; there
were *zero* bugs regarding __percpu variables, and the referred patch
moves *all of them* to __seg_gs named address space. The patch builds
off an equally stable and now well proven GCC named address space
support, so in my opinion, it *is* ready for prime time. As
demonstrated in the above list of issues, it was *never* the compiler
at fault.

Let me reiterate what the patch brings to the table. It prevents
invalid references of per cpu variables to non-percpu locations. One
missing percpu dereference can have disastrous consequences (all CPUs
will access data in the shared space). Currently, the safety builds on
checking sparse logs, but sparse errors don't break the build. With
new checks in place, *every* invalid access is detected and breaks the
build with some 50 lines of errors.

Hiding these checks behind the CONFIG_EXPERT option breaks the
intention of the patch. IMO, it should be always enabled to avoid
errors, mentioned in the previous paragraph, already during the
development time.

I'm much more inclined to James' proposal. Maybe we can disable these
checks in v6.15 stable series, but leave them in v6.16? This would
leave a couple of months for distributions to update libbpf.

Thanks,
Uros.

