Return-Path: <linux-arch+bounces-12513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301AAEE17C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E2C7ABACB
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704D28D8E6;
	Mon, 30 Jun 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lNKkY09p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456728D850
	for <linux-arch@vger.kernel.org>; Mon, 30 Jun 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295066; cv=none; b=YUc80reTFjoyLRGLlTedGs7qyTg54ZveEXMttBz/HHGl+vj6z9+6keTPEsnuFHNh0A85k3I+AhdWg3eM2QRQUo/vS0SSNFuDXJCC8vAC53KDUbA3eGWLfJVuUanITD5q8bgAocWaLmjcWDogWQEm4Sl0tabRnpiJd/OJJlCj9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295066; c=relaxed/simple;
	bh=AvF4LKagJ5DoTnzOZ0qip/9Tmcll8h+LSAzEXGYGWto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m25lHdBjY7/VNdoQZXBo7A0rkzpGT7NdUcNnVVX7+kbbQr2ITcl4nCYd9bgGWqyzHRDT2SFEWL/VbAz3IXSmTkzfCiXVQCJ5mLk5oQxwlt3sH7ZsJaYys14sSi5sRPoD5BH7Kx1oGP2NXBW/ip2fLuSddol5Es6hxE8UMcDF0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lNKkY09p; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d3dd14a7edso348821085a.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Jun 2025 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1751295063; x=1751899863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifhh0Z7U9kfZ8ibHSYCRMf91ur7H8Ree4fiHnfWDjwY=;
        b=lNKkY09p8+EjKxLqvgX5udpkqqCwPqx2ngwVnd6yvAR90CXd1w3wv2oFY7rASFZeCj
         UZHk7YZDzpFVNVFYbYDuPLSk+g1EABqTw+M57vb9vd4fMi5w3lmUMfr5Ln5RZx4mtPXM
         /vYU4M6AW8L3Kta9bHa1K9TOkZPhxEPb3octmgUOaFW8fnvwMKTdGmeLuJpDkXhADHy0
         WpNk+dWry/pXTazGd4lI8fe6SyuFJXf25HaeF53upy/Qd4ImgEMXVgsjNwpwsAmM/4MD
         DzU41P77cBUHiYEm5/srfAZX0fn2LJg0ncyOtPbvptGX34MiGiRBlINqWIIaf3E4cAeL
         pB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295063; x=1751899863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifhh0Z7U9kfZ8ibHSYCRMf91ur7H8Ree4fiHnfWDjwY=;
        b=pDgGrppOnKQO4HVsUa3TYVoai6MnrPMECJ6ew6JE8EW2T0uptFSK7rn06M4vewmlne
         YdN6q5/8gVoijLCsy1ZbKMEht7pbLTkdV24HW9zzecuUFMrml6V4zgxDaDPb4tscKqjA
         r6Ml+FszdheW7kDj7NbYZENULMmB1bf0SRCLRL0bQbLNDkTt8lS6hBhIvHJfdjC9fYpd
         aS/iNOY/4KGRKW7soWURn35LtYwdJ8xCsqU48omR6Ry54LTnhjlr4pGQ8TD/CMgHPpO0
         S33cwjIisWaOQhjGq9wW3SQVi55cu19uMLoXs3uKqRLnhHM62EI1+xCiZF3P4hPR40Ud
         T0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXI0jnOaWof1bKF1eN8G4q0vFGYfYDUoO8PptZM1poyFvIESVI1zN4K0WQdC5CKjxdZ9LekhMYI78Xs@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1OINHykhMeKp64cOYoUgyYt/c0FIZnlJp1cjpnVIdTvtWDd3
	fkXz9BwcSF48VuLYB0SlfxSKl0f7tzbjLOJl/WmcUzpc6vSDpVfP/s4xjoQ2OLlfCQ==
X-Gm-Gg: ASbGncuuOcIRc87j0MGUdwX5dBD9S12TBjX60vATpUJs29ud/pkfYQSlcK6leNoaE2c
	aZcj/niCGWtnc5905i8AjUrImzLr9fZejtyErvi1ccn4JGafYsSQeaYuB4hd9zEqIgryYANiu1D
	xV1Hx78iqrAnvIOg1ViM2kc6FIC0Y1Sk6ecUroCdXzRfYfUtiY2KRapovXOzVYshqzVts42uXse
	5afKSMoHiApHmMPgd1kWrgbbdgpJQ9vTxGZ5CMy3DurwF75J0xpzQT5ClXWNCzgeaAuwnTs9U4D
	pGkEFkxm/UVSNkmO+oabYirgRfV8NtRikIVr0lGOYP7KwweqRP5PouEBc6thHuayuxLMkpwgKqg
	k82F6
X-Google-Smtp-Source: AGHT+IF1yKNUOiHgxQRl5AX5C7pvK8S70B1QEWwBf8quTZXAN2qBcNb7LkpKzCS9x+idNI2rKNHtfw==
X-Received: by 2002:a05:620a:7004:b0:7d4:114:f81d with SMTP id af79cd13be357-7d4438567e9mr1837297885a.0.1751295063336;
        Mon, 30 Jun 2025 07:51:03 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d053sm67765086d6.1.2025.06.30.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:51:02 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:51:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <1cf36f94-7e70-48eb-a79f-ebde218cd716@rowland.harvard.edu>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <jBAtISwM9LKkR7KuCHEnym75NfGOM4z408pMuDfk4U8VzN8PQuk9JJfBc33Usre3YSjbgtFRj8c0ZNeeQMpZsA==@protonmail.internalid>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <87a55uzlxv.fsf@kernel.org>
 <_pLa3zqu-AHBOnxkEz7l13l9W-OsKBtuXIkjRsIJJy6EnYTrM99E8Yr24pzjqwCAj1_qs_PI-cVxRsBsbgiFdA==@protonmail.internalid>
 <aF9bmpX-i6HVMlaj@Mac.home>
 <878ql9zg90.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ql9zg90.fsf@kernel.org>

On Mon, Jun 30, 2025 at 12:16:27PM +0200, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> > in atomic/ordering.rs, I think I can extend it to:
> >
> > //! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
> > //!   following memory accesses, and if there is a store part, it has Relaxed ordering.
> > //! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
> > //!   the annotated operation, and if there is load part, it has Relaxed ordering
> >
> > This aligns with what we usually describe things in tool/memory-model/.
> 
> Cool. When you start to go into details of ordering concepts, I feel
> like something is missing though. For example for this sentence:
> 
>   [`Release`] provides ordering between all the preceding memory
>   accesses and the store part of the annotated operation.
> 
> I guess this provided ordering is only guaranteed to be observable for
> threads that read the same location with `Acquire` or stronger ordering?
> 
> If we start expanding on the orderings, rather than deferring to LKMM,
> we should include this info.

The problem with the word "ordering" is that it is too general, not 
specific enough.  You need more context to know exactly what the 
ordering means.

For example, ordering store A against store B (which comes later in the 
code) could mean that the CPU executes A before it executes B.  Or it 
could mean that a different CPU will see the data from A before it sees 
the data from B.

A more explicit description would be helpful.

Alan Stern

