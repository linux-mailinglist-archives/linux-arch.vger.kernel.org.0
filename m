Return-Path: <linux-arch+bounces-12406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D1AE0B1B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE1E1BC6261
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179ED28B7E1;
	Thu, 19 Jun 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAdppRoe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3C22D4DD;
	Thu, 19 Jun 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349427; cv=none; b=Kl50YMoadC3ELEdkPiloTsiPlqgqIQgmGn3WtWA7ZUyJMOgxMjQi7+cFW5DLgB78VVYcSiiB1TzkocX/aUIkWtkGX5iD1NyR+E7R5pJ/TQ1/g25QlXywtK4SAYfPU+pLkm+XZMaV1W+30wtJ6H4P2K6779jO+p5qnecadb6fUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349427; c=relaxed/simple;
	bh=LMH8MvWT9p01LTh8Zrar1FIeudfVGtDYSmePFlQjQmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUofq9VzvdO37MFlM/LFhtNopWFDpDXoGd5eA1/MTl6UjqPycGTq+Gjxdeb/CIVuWBnp9OOwiiSKVMbIZl76SglwzzFULDQBxmPpTDvhCPz5d3oEsaxxgy17TO05I5ebzpm0WuD1P9xh00rsYvvJa8r2SKDIR8/Cpn+rYuzMEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAdppRoe; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-312f53d0609so154057a91.1;
        Thu, 19 Jun 2025 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750349425; x=1750954225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMH8MvWT9p01LTh8Zrar1FIeudfVGtDYSmePFlQjQmQ=;
        b=dAdppRoe36Dhg493rZerlgqPu8UqfH7wdBsUOrZyt96QgYtORrYkkk8cCkehQrFWNB
         3aTBfzKhS8Fw+7l/0IkksjefKihT+toV8Zf3BPcbtkjG+QqMb1LgtwdpuwSuOF6vHc8R
         oMBEkpB4pbc7j1E2zqCqdy/gBvGc8g0dqHoAj9ty4p9ttLzFUN1PJ972+RkGUqwAQeJ1
         DPSI+xarDE02xAVR7oZdKfQGYOkIXNTRxFBtxioaaasey7qCTKITfL3nHo6kbwLEBRqA
         Im2GQGZsXHzJS8Gs6mUlRiWIJ2aIYpczeHMGNx3pBYLo9VQEyfw+1JhxTAVt6q0b9loe
         5+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750349425; x=1750954225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMH8MvWT9p01LTh8Zrar1FIeudfVGtDYSmePFlQjQmQ=;
        b=aWX6AVntMrwDoa5FfypGLqV6c+KP/DeRfq1hjY+jHHY8qSu30Vg8BTUof6mKWqcCwB
         CkNefWdlpR7ovd9oGU4d+hCMjPYtLYC5IWXPqra5hSq5CWju4ZjjWjIlG0G0E5jLNhAy
         NzTxRRZZ3pr+/rg8GKNpA7/53kDf+Llwxg9lW/wEV04qmpIj+xHDXXpN/kmdIjAhPf+F
         YkbXbreAaL6hg9/5Eyiq/l38+JO8NkE/otU9iaWWAOVw8UhHz53F9NtgymDOLJoAcol7
         KoqEj8opo0Zua9rYmCZBeYMq73nLwvWpto04cbDeaWze2JhGaGHKaU+8ojxq7OQLW0yK
         pb8A==
X-Forwarded-Encrypted: i=1; AJvYcCVDVOeJxujSL7zCg+LEKQu7RcbRsB6yuokcXxtXP2RcoM54Ln1swDLsCvN07QtP8HQZSEQrn/7RGwhw@vger.kernel.org, AJvYcCVKogj54vgRMkiILhVb357gSWduj+7ojDcCvLK8jY/aYcxxhzBi+zvFXr6V77Ew+KdBhBn+H7t8MJnq2vbIqto=@vger.kernel.org, AJvYcCWBnnw8WBxOpJCGD2gW4o+EHwzGgWpC/EW4oMWTP0+3KNAOV0DKJ+uHEge8GTmqCJW90VCkC2OXNyttFRncev4k@vger.kernel.org, AJvYcCXRuLPT6NPouKfg+aRCw4vHMWbSR7Ukl+3cDh/nK47h/JxktlMNyrxkGLRaAHFJPgOqIVRgZASxbn8VDMIm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70seMuCd0zJoWnTB9lpHDCbuXxhWlFBMszgOJ6hiNkUUNvu7M
	JG5Be7ToB+aWmZUMIUhxnWrKDvaJB4sIcwDslR7W06Kw8ZMM1QIYnVvUGISdvqjOrqlzep97ScS
	PutlygIyHjYSwTJYcZ0LORxwfdBWQK2g=
X-Gm-Gg: ASbGncs15qH1bnVdkPmQCw3szjloZSPvroJ3JapxuE0wQawOG+tSFSdx0/+If1cqCtD
	XHhGQxU3r2Wf4SyEaknpMpDCzExGi6hwwY+VQWc48KUAQjqHJaHmOcS+nBCH1R6s8VNuw4WrKDn
	BVPwnUlJVNXikgFvg2nRjCG7qopcqQ4fM5q27nzBQqVJJXnGMFj7lbhg==
X-Google-Smtp-Source: AGHT+IHA1kZM3+30Kh7KI/3Zip3qSV7p770v0+A6KPEYdFDRZEZ7/piUaOGmI0c2RH8JiO02ogUDO/cMxOvTPAK/Zr4=
X-Received: by 2002:a17:90a:f945:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3158bfe52d8mr1733419a91.3.1750349424702; Thu, 19 Jun 2025
 09:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619-rust-panic-v1-1-ad1a803962e5@google.com>
In-Reply-To: <20250619-rust-panic-v1-1-ad1a803962e5@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jun 2025 18:10:12 +0200
X-Gm-Features: Ac12FXz41mL-93--1Ce-xHCq7bVUjTSgqjY5PcH5jvOVitFgWHe_e11AfPrRbbI
Message-ID: <CANiq72=ORd8Y=BiMCWEN7sdjLTGrepnLd58AObVHEPcZE_NVAg@mail.gmail.com>
Subject: Re: [PATCH] panic: improve panic output from Rust panics
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:11=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This patch has the pretty major disadvantage that it unconditionally
> calls panic() when a Rust panic happens.

Yeah, I don't think we should do that.

Other `BUG()` calls in the kernel do a `pr_*` plus a `BUG()`, so what
we currently do is fairly common and I would expect tooling to be
aware of that alreardy. What we are missing to be on par with C is
essentially overriding the file/line.

Now, maybe `BUG()` itself could also have a way to inject a better
one-liner explanation after the file/line.

That way, we could improve not just Rust, but use it to improve other
C reports too.

Cheers,
Miguel

