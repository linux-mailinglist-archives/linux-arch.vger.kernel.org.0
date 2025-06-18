Return-Path: <linux-arch+bounces-12392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE1ADF793
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974A816A029
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAB21ABDA;
	Wed, 18 Jun 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCh4StqK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE4217654
	for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278158; cv=none; b=iyX3tlq5CHRwexoEvWIoGYGaFD3nXj627TQr9D5Vx/8PvUNJU8Ethb5+L9c3ob9Ex9aUQrDZ9dSZ6vljYcUnHbZnrlXGIT5EsbaVe8tTb6rhvCeqadR4P6jv3XTovcQsjZAOj911aoKaPl2mePwaR3Jg2lowly3PqzTcUVaY8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278158; c=relaxed/simple;
	bh=wfVliNvMFww4ALoq9h28dDUu/++ZlpOwHD/5kA5/dSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ2N5ciFWtl9nlKk1qZj9XekdPQcFXv8LVSXRf64jd0NRnwq73GqDQdJYQ+m2nXOp94/iSVFsIJxtpl69Y2JDRfSr50Eb1vJTjMJN6p34ff1eQR1fLbPOce6I38G53NdJQUfL8FZagL7r2cNSpLBG6oMdUUncjcNnA3YqDGmXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCh4StqK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a35c894313so94356f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750278155; x=1750882955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpNCGTbJaA4N6AQDacC+X23mlTsnB+mbIqH/SioL/Y8=;
        b=OCh4StqK/Qyk87Od5o0KFR3Nr95QXzP7ndjoVvGfGG2m/guuZQSYhCoKX8F4jimTEt
         jUCPlO50wJPByGLkh4FRXV6hlhCwkHSUUavBP31iz27S+Euv/BxzS8q3bADBJ6Hozq4K
         hTpGJeGdt189+olGO5O3eLS3Q2oNqs2vLgdSqSzjJpjkMoLZZU9KrtvtORk7OdNlYY+B
         6X/tuxOkblKLc7z4n8T4PMD6AICWZY3Y6Kip5KNgoGfRnNml6OpRRvksiTKszXIYcrMX
         FMWc9FqSZaD0zBknXhFKVkmuKDf26SA33YQqjcdAOnY4fhuUU0WDbi/YlGu6EyNRMFcv
         ssrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278155; x=1750882955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpNCGTbJaA4N6AQDacC+X23mlTsnB+mbIqH/SioL/Y8=;
        b=cxGYqdn0VE5wZrA7TeFFoQVr3b/0JG2R5mkLROo5WGl5AfikPTLRnwZnkHFu18rAtA
         vlo1iO1c5cytFmy0iI92orp7ih9cxET5Z4HliKnabkdTfLLtemOGKJFPr6KAXpOTRzJK
         30C5OmoQc2zMxBjs/WO6+WTLJnRiXuNve5tbC5eBiT+xBeOgD5haSf6bKlCd6eyYjM4g
         JQZXqUKQofUjk73ra7kIwIcdCpLwPTYJQQafGguk6YzHUEogbZISUAMgo7Sjepl9pszb
         AzPd8EAcErtMfUs3TLyJR3+/wOPXkhYU5F4oDWWXsGTJPMF6XoSdg07butbtt6mmV3Za
         XZiA==
X-Forwarded-Encrypted: i=1; AJvYcCUxrbyzf8IulZy54SYg8iX+DZCvizbgc7pJySXC7BIZmAOCa87AiUbbuLPD4MfTz+ncLXk9Hqx4WGhV@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdJauRJq8YNPcrYX233WEpONWtUq/kjAtYKox13e0sAMaMjoo
	rgFL/oNDzPHvh4nuFKJz3FuUn8+/sKstLVuHrbV5bEtzm/67VotINLSHbEpL5I3Vp8rF/hCyfD3
	43xaPG/Zj/SVvdA8JsTJNlpQNHQ4JS26gBqiN169B
X-Gm-Gg: ASbGnctCKD3VQl9fDbCP01x/ttaSNpFb0/FbYQoOjQYgeJPvwegp1ckCFds/ZfKcFNa
	en6zbfgS+AfrVwO63uClS7PI5j7HmIoK5Eio8rz86UheS2k+qyFgjKD7WuXoBWNqNnBN2cf2iLm
	MZjX/cNgHuRH3tpVCt6HDPpgRhLIoaQ0+BuHBOva+SV8F7
X-Google-Smtp-Source: AGHT+IGEoyOBlFKES6zAZ/D/8d3NjWy3PFbM8XH1FjI+hWn88pAjWrG3DkriENwDPgzuguMIRV9uDCxNXc9Cb2JGPm8=
X-Received: by 2002:a05:6000:4408:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3a589344d14mr4512138f8f.50.1750278155203; Wed, 18 Jun 2025
 13:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618164934.19817-1-boqun.feng@gmail.com>
In-Reply-To: <20250618164934.19817-1-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Jun 2025 22:22:21 +0200
X-Gm-Features: Ac12FXxUZt-wdvp6IAMzVaJLyh1S-ip7vrrFm_I0iVPAZRuZ3XE-nvLs77lmkZE
Message-ID: <CAH5fLgi1FbCc0euts_e4BmAayE2MtK+AUWiOfswd-qo5+L+VnQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] LKMM generic atomics in Rust
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:49=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi,
>
> v5 for LKMM atomics in Rust, you can find the previous versions:
>
> v4: https://lore.kernel.org/rust-for-linux/20250609224615.27061-1-boqun.f=
eng@gmail.com/
> v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun=
.feng@gmail.com/
> v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun=
.feng@gmail.com/
> v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun=
.feng@gmail.com/
> wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun=
.feng@gmail.com/
>
> The reason of providing our own LKMM atomics is because memory model
> wise Rust native memory model is not guaranteed to work with LKMM and
> having only one memory model throughout the kernel is always better for
> reasoning.
>
> Changes since v4:
>
> * Rename the ordering enum type and corresponding constant in trait All
>   as per feedback from Benno.
>
> * Add more tests for Atomic<{i,u}size> and Atomic<*mut T>.
>
> * Rebase on v6.16-rc2
>
>
> Still please advise how we want to route the patches and for future
> ones:
>
> * Option #1: via tip, I can send a pull request to Ingo at -rc4 or -rc5.
> * Option #2: via rust, I can send a pull request to Miguel at -rc4 or -rc=
5.
> * Option #3: via my own tree or atomic group in kernel.org, I can send
>              a pull request to Linus at 6.17 merge window.
>
> My default option is #1, but feel free to make any suggestion.
>
> Regards,
> Boqun

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

