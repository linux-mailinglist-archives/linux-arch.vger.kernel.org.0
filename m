Return-Path: <linux-arch+bounces-12811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124EEB07676
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5723E168E7F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B52F4317;
	Wed, 16 Jul 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObIPHqV3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BA28C2CA;
	Wed, 16 Jul 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670615; cv=none; b=rOz1ScJ9imGsX7+djujdkRXR9bnWY2YWnxRd0yawq0/IpdPrPc1UHNUxZ1P+SlU4A5ggTBN94z7TWS3QSGB6zdle1WiG+GTbEGyn9A/izDZCw8cM/0I5kCsfPtSD70Y/GHRzPo0Wz4pokqNF2JC79C640KuWxfaVhrXAYf8VWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670615; c=relaxed/simple;
	bh=JXFhF7y50LH11OFGXGNP4jEz7JnvQ9mxz2K9JoGfVx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN5e7mcSedfwfJ6B9DRUkP5YqlnXYehdxCcULV2bEc5WPxs0f5pwiTZIB1fR+Y9oSfcgnutwX/hiSKA6bbqBzXmoUqfw8HDvpbBgCr2VzW4I0Pb8YeEBJwFlnpY+NUGrO84FEtOvlgihn3YrlzNC8IOPIQBuk9kIAFgKq+pgBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObIPHqV3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-557e327b54cso809869e87.2;
        Wed, 16 Jul 2025 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752670611; x=1753275411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV6KjEMkjerMX6Ys9+OdIC5+WGtyITwr6vlurratTs4=;
        b=ObIPHqV3a+QH4r8dzWHx12UsJG0RKATjpODofn5gWraNwHkQm1zXMMeVy5IbfbyrOC
         31xDuRAVM4FobZlcfC5wVuE1rOdszlteNXRFgkIHRaA+z/E7ssccI0fMGmN3PxEZmYPt
         vZgaxo+fRhiZps74AxjGNvEu8bMCpi1QJpzh4YX9lSzcV2qde+3mcpEN4hA1kvBM5AET
         SZtA96IiZkSAjYd6caZOMq/p2HaSGT4VTDtHo5CcHEuIqnNa+tY5ku1R8IQOoro9d1rt
         BtsskqzUHbC7guedHn/kX+nrCrUyisKBynwouvoDXH+GjFfaQHRSJZKS+ZreriNu5ARn
         5O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670611; x=1753275411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV6KjEMkjerMX6Ys9+OdIC5+WGtyITwr6vlurratTs4=;
        b=dG1U1eI5YYVMS6B9Gxbnmel4pJjK1tCZaRMMdcs2LLl2tVLxA/nTaL4uLnNZszN/MM
         g6Ix/gWopTmQyQN7snJ8n3gImAHDUzfuElK32F6xl7mpxuRlk8Awc5Kfc5ORAym0rx2u
         cQS6JrA0vrb5/p0d0vJGvCFroZxQtav0NarJb3zm5EdWZZ2V/Ljld/XHKXPlZk3ZoXee
         di1q65ILsLmkyggj43xir0h9gCZfQ+TOhVv5d95B/bSVWOuRKG4n0GcvCvQ3gepTFZmQ
         HtNUSJjU7b/y7N4GZFDwF7n5hW+zkyNee/rHFe2Ljow2PtPVYch+z7+JB+x7mxm8sUop
         voPg==
X-Forwarded-Encrypted: i=1; AJvYcCWjagDhaSy+MCjYfO4eMJ2zh135QL9mk6IJmH2YtPXkjCcTSl7LKOz+spVIWZpDw5aHTgMR5oWRAuPJh5nN@vger.kernel.org, AJvYcCXnYlAxSsC+bVCq4u9EWlVtUfTcNqrs2IQMFAnZ1Cj3PQrEHPe2pF1aWRXpzTFeAvpYf3aJBXTUJI/M@vger.kernel.org, AJvYcCXwXd/IKhr5MDGxC77pydq3mNXltXQxK0qobaA0D6uI27GrBNKaJ8lwItk6hg0Gz2QigneR3cijqxSZXxy7aUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDgAWT4MZpqbx1AKJbMqrG7usm25/ltEgytHI648KoGYKVBtf
	cXOuMosEOrUaUj6rrW5SFyTLXdW/e0trjWNTaNheCx9yO6kJBfZ8O9NAIVzXITY1iFPR8wjW0k7
	I1Ih+ygcdjcRCX3sFxB/Eb5b2uM2Xzwk=
X-Gm-Gg: ASbGnctjIq3C5uqX1dokcBGKpV3zefXmxr59cvIC1ijs6E0Ue/8r7A/lL6F7eT6MDA2
	iech8mSPp6fD0DYwogjl1SSwRzq4xYfkHLAbD3u3O2JAQJjPxNC3/P2kvxxVvam2AZYQe+EtOGX
	IEnxBnMGVYOBmSkX2XU3IQX+38Gn2Rxe6h4HVQFQ6ReVV9iu2wB4nrO6BkAFVghEqN5CB9u7xQ5
	6tZ2LXRhOgG3jZm
X-Google-Smtp-Source: AGHT+IFB8L+gxRBikQfJzkahGzv4HPkHtLZ/WKBOXCMXHBbA5uchb6f/SmPkczeGbdyYpczvg4dxuhsdDOq3/+sQdug=
X-Received: by 2002:a05:6512:1389:b0:553:6514:669e with SMTP id
 2adb3069b0e04-55a233add23mr375618e87.14.1752670611310; Wed, 16 Jul 2025
 05:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714053656.66712-1-boqun.feng@gmail.com> <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh> <20250716124713.GW905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250716124713.GW905792@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Jul 2025 14:56:37 +0200
X-Gm-Features: Ac12FXymJy4M2DTBP9I0YHojvaWeqyESc3dLQe_rOXV0Z6gmdWn8o4HiedYjw9g
Message-ID: <CANiq72ms11yfBVjfpV9PH6LZ3g72-Wd=5dwda3ULxc0PTnP=NA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> It depends on the scripts/atomic/* bits. They hardly if ever change. We
> do it this way because:
>
>  - generating these files every build is 'slow'-ish;
>  - code navigation suffers;
>  - Linus asked for this.
>
> Specifically, pretty much the entire atomic_*() namespace would
> disappear from ctags / code-browsing-tool-of-choice if we would not
> check in these files.

Makes sense, thanks. The Rust helpers one may not be the end of the
world in terms of code navigation (since people will use the Rust
abstractions and nobody should call the helpers from C), but since it
is just 1 more script in the list, I think it is best to keep it as it
is.

Cheers,
Miguel

