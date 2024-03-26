Return-Path: <linux-arch+bounces-3193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB888BA0C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 06:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1861F34BB6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 05:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BF12AACA;
	Tue, 26 Mar 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="DwQRSX7x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0696129A7C
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432622; cv=none; b=KT+yH9audWF/wXLFky986al2qm9wWNS42+Q2Nu/6j+OJyzgqscDV5SWxqT33dHciB9geqXyYheOMM9wqxiysVAfvju+DtdmqptGD6tkIj84eq9BZxbJUz+XNQf8A2eb/obQFQbObTw7pjmRLj96mInGYpxrRmwiaKu67FimQ64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432622; c=relaxed/simple;
	bh=ND9Y2sxlabnYJnhIIV0KvAzdrK9FLJxwJWh3pj7SGmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX1F3euAITHf+EkpM+Bnb1c9uPIiatAam4jVRn92PTeDtfqNaz33+f88bB7N6HqwBb3jGC4JayNWq91YJaf+7BJ0jMQbJtgZ/tifAwPpDA35Z0FFpOfsNeq1RbuS2XuDBCR5ER1xo+hsqZ0BpU8SMx85KdacvGZKgNiA3bWe91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=DwQRSX7x; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4915643276.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1711432620; x=1712037420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPkjY6tTJjq9XlGXu2wl3SzG0jXY288ke/okKd5Kw2o=;
        b=DwQRSX7xXn0tiE7O/iVzvcILfAA5V+It8QlyxT+GeYMvSYtObXDUYJfIC0sJ4lbv9k
         Trw5xlTNzUjYovObDw/DDLw4ybvqd/gNC3ZCzpyFxYLSP1cLkQM1sqR78bZPPqg2ECr3
         pd9vvGgT+U+ZO3BHwiMYa+few2d+6Ai3cR29A4AzYy+BU86eQSAzjtGup+7kYoi3Hq+j
         EExhVbzSq0roJ8/CfD2Rob3cBZyA1jje1QdRKEKDm92X/TJte/qplh/WlAn6b75vt9A8
         gdWUQYFVAe8ukaSRtmN1nXAhQqrYPZwkPn7Lu1/HPd4tOWO264NF1OXno3nJrWAjf/0p
         x0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711432620; x=1712037420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPkjY6tTJjq9XlGXu2wl3SzG0jXY288ke/okKd5Kw2o=;
        b=bNSnvrv6q/bnIZYPqklui7tBtpvoszDu2U1wN7Qy93x1YtgtIY4Q7XwSegoJ1RTd9v
         Yf85N+yNXRBULfFnQ1iPj0/uP7rP7VUeRUprOqYTGlfZ5BCauL/mWAzGwzKtFz5LF4MS
         l6Cy2LwE+XQ6PPIRUEoS3RdXoGQTONGVp7XxOwOWhfb6hKQlXem+npYMq9F0G5c+tDdt
         xpqBHftTSrJ5uoATLL+EvRQi1iTXyhJ5JoBEFiqnr5rTlTHkttyAK8A2OhzNneADXDA5
         czmPQUQamGSFxwy1Jc2DGVu3L6VNULEA0B+pt+3YSoE6IatISZJ4H/PJzOzrkWpiQxhM
         eS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUDtQV33SnRqyV+tem0qmFiTEmnyPObSh+AKiJ4XYdYDRak2LeODZQZFXnZt5F1xYsuS/GqloRNtOq3pHFIEuEN+/pyl3fkZM/hw==
X-Gm-Message-State: AOJu0YzfO3yP2QiFLcv1kdU1TG6yIHfFjqEmakw8XspUC81OUG8H/qy3
	haPMklgGoslOhENzx2Rrouh1HnwVx3K0o6Nx4JDmoY5MUSvwOtif1tN7aXiWbQWBfCPjdXaNRfS
	NCePaFFNomCvo9n3wTX4z6jvjfPLT1d2jlafrBQ==
X-Google-Smtp-Source: AGHT+IEZ5qdBLVvKB5XTD+4JNcNopYd0Qw8YU24zs9LsT+BKNrCyfLvgj0YV5WuY7LflHPoWR30CvJt+jqecqoOosTk=
X-Received: by 2002:a25:2fd2:0:b0:dc2:398b:fa08 with SMTP id
 v201-20020a252fd2000000b00dc2398bfa08mr6083186ybv.31.1711432619981; Mon, 25
 Mar 2024 22:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch> <CAH5fLggdVDccDwBa3z+3YfjKFLegh7ZvcSzfhnEbAGSk=THKrw@mail.gmail.com>
 <497668ec-c2d5-4cb4-9c2d-8e6f7129a42e@lunn.ch>
In-Reply-To: <497668ec-c2d5-4cb4-9c2d-8e6f7129a42e@lunn.ch>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 26 Mar 2024 01:56:48 -0400
Message-ID: <CALNs47uEE9f73mtoXtJ52wS4nCOjTVxUtyPfQexF1mzHg6W5JA@mail.gmail.com>
Subject: Re: [WIP 1/3] rust: Introduce atomic module
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 10:10=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
> > > Is it possible to somehow poison rusts own atomics?  I would not be
> > > too surprised if somebody with good Rust knowledge but new to the
> > > kernel tries using Rusts atomics. Either getting the compiler to fail
> > > the build, or it throws an Opps on first invocation would be good.
> >
> > We could try to get a flag added to the Rust standard library that
> > removes the core::sync::atomic module entirely, then pass that flag.
>
> Just looking down the road a bit, are there other features in the
> standard library which are not applicable to Linux kernel space?
> Ideally we want a solution not just for atomics but a generic solution
> which can disable a collection of features? Maybe one by one?

Clippy is an easy way to do this via the disallowed_* lints.
disallowed_types [1] would be applicable here to forbid
`core::atomic::Atomic*`.

I don't think KCI currently checks clippy, but we probably want that
at some point.

- Trevor

[1]: https://rust-lang.github.io/rust-clippy/master/index.html#/disallowed_=
types

> And i assume somebody will try to use Rust in uboot/barebox. It
> probably has similar requirements to the Linux kernel? But what about
> Zephyr? Or VxWorks? Darwin?
>
>         Andrew
>

