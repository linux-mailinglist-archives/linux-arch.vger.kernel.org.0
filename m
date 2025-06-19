Return-Path: <linux-arch+bounces-12394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B10AE0563
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BEC17A39D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63323B637;
	Thu, 19 Jun 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG0ytBXt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3222B585
	for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335580; cv=none; b=SSQj3psHZAReH99v2g/dPSFPbuNqDel/d/MwEhmWLwPMeYC40Pvoghs0dSfrSEMlioN4iPz1yqqwnzU/unPdZhRR8u6hVTP9dHa/vS4RhSXQgBZVi6XFvOoaFMdVCYbFUx1CsPXGIkDbPI3wYvZAoXXaF+I6AEopvzujqER7hVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335580; c=relaxed/simple;
	bh=7ac51FHNRIWsyGPsA2cT/OoFSdh1Legd6vLnNQpKO8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6PCTJGNaFCEvpEwn5r7rSLpsl8abz6Ff+l16GfwteALneNZicLQlHOb5BF5dmV6khxtNfOwT1pAdtRICjTKs0lz/+oxBHLY3Os3tljnYbznwm8YuoIGqX+EKJP+WBQD/d6OtOnrG8QGFWuHkz/oKSyYvi512NBU0b/eCWFcxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gG0ytBXt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45310223677so6411005e9.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750335576; x=1750940376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ac51FHNRIWsyGPsA2cT/OoFSdh1Legd6vLnNQpKO8c=;
        b=gG0ytBXtmGHLSLatGLouXVMjpdD9PTgyi3phXhmdCWrKH5D2h6HBTzQ7Fpe8ZlMRW+
         QetZ89S/+/mLR2FAtmNPXyYhA4MN9U9UW4cZaigAb/zP08sCpY/xHMCBe/9GF0ClAe4E
         dIc7lEuUtyGijgnNNYp1zberagJRM2xotXY+hwCfLDhKw0X8fw9SRz3KxhgBRY3njF95
         C7KL8pfuqDTb5duEzbql3XqBka1dmTX2TNuRuBd0+X0B0w3FCWvmOWqgskEnEWuvb/cz
         3ry+wOaXh3Z7UCIpM0UMEgIlCQiG4Rh+ScgVJvTh6DfSatOB2yMCHQi/re9Fz/ypfNQp
         jYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335576; x=1750940376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ac51FHNRIWsyGPsA2cT/OoFSdh1Legd6vLnNQpKO8c=;
        b=i/63OECfMTNRDWaofhhEx/avpBun02iylLItAA029O45GegX7BadNiHcX3iVpaetZl
         EvouOb1IDi4YKOrBOXOjkHq6uhz764Z5v2ukkru4CgOGrClKPfKuTNRLx8F/zAU0tPtm
         wAM4QkNDQeh14TBO/WLpf2/46BVuZDARf/sSowBebXWw/PmmgXNo2FB7/tFMJ1n6A3Oi
         4vROed5OZo9cfZqzhPgWA56m7RrOgZTpCOhPhVSVE1u7t3ap2txeQwRQaWAZXZ1sLaRZ
         hdERy8MTzByV+pr5NsK/R0MCFj8GrtP+IQajhaGn6QAeoovhnmiy9K36dkBq7mzycTMD
         RVYA==
X-Forwarded-Encrypted: i=1; AJvYcCXkYFzP/qTJDFINr7ggyM5LFsHFxggRtAb9x4Uze4BcBf7UXvZ5wNY4ndIIIx4i6HaLObIIaOqgOs/q@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPmkP/92GoxxIPgZVMI5MqN353jD7XSuGvjtF8fEGbHCu9zP6
	f3Go1YDj7lXCgLYHO051G9JgCV6gq2fW8KG4Erxqr2SMhEfS+KIuuBbuiUQE2rxLKPyyZKrZ2eU
	jjpDB09L8lFQH1NCeBOgM4aYtzYNt0PWymH7yeeuC
X-Gm-Gg: ASbGncsnGzE/PvPahkjMuNk7rgTAd1y0fFQ4sTC+wqQn+BriDxlx4t5JIneR7id92KH
	YtdtGuwht2a3mIJkSjet7FGR4pEiqJGFsMRrQIEIXcXtAf2yAE3AzI+xwln0Co4nzYC5V0u07gZ
	AVyOj/YPfCHZJkwcmOUVBuXDHtLgyq4T30JXzcxYFEvXvjhRp8jQsWoFsr7B4fcYUbU4xhqPWNb
	F1Sk6txVO3v
X-Google-Smtp-Source: AGHT+IEdN1dcFOkm876VSH5eqAcy40nZdytTN0BHyo53UKISb9ybhB6h26VIwqtDwmUT6/7XOiLspK8lUcD/OvMDcxw=
X-Received: by 2002:a05:6000:430c:b0:3a5:3517:de3e with SMTP id
 ffacd0b85a97d-3a572e6bc97mr18896998f8f.35.1750335576228; Thu, 19 Jun 2025
 05:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618164934.19817-1-boqun.feng@gmail.com> <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Jun 2025 14:19:23 +0200
X-Gm-Features: Ac12FXz2t9QSaVzsNj9MSWHyeQZH7QvXWY1Yd25RYMgxbqiHuVm7qkIrRqBSAbY
Message-ID: <CAH5fLgjhdxdFztu_pXLjngu4cD7g7jw16bcQYz=XNmGxKfThsA@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation types
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lyude Paul <lyude@redhat.com>, 
	Ingo Molnar <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:31=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Jun 18, 2025 at 09:49:27AM -0700, Boqun Feng wrote:
>
> > +//! Memory orderings.
> > +//!
> > +//! The semantics of these orderings follows the [`LKMM`] definitions =
and rules.
> > +//!
> > +//! - [`Acquire`] and [`Release`] are similar to their counterpart in =
Rust memory model.
>
> So I've no clue what the Rust memory model states, and I'm assuming
> it is very similar to the C11 model. I have also forgotten what LKMM
> states :/
>
> Do they all agree on what RELEASE+ACQUIRE makes?

Rust just uses the C11 model outright, so yes it's the same. There's
no separate Rust memory model as far as atomics are concerned.

Alice

