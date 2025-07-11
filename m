Return-Path: <linux-arch+bounces-12670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD09B01F5A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFEC1CC1183
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588EA2DE714;
	Fri, 11 Jul 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4QPBAsR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8027D760;
	Fri, 11 Jul 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244830; cv=none; b=M+4RFu/tWXgNYsYZK5gT8HJPqwhcW+6B6OVrIK5fBehV7F+Cq8dwYBcpUsC5J3SMwTGHynmyLOZW04N0kBHHm4XF9u9nTH4k5ilncF6uQ+u3qZFkuvTrkSvnLppaSMVvoY2VUdcysnGpVDLcU78DVoMmN1kkgaaLI4bbfuZ/j74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244830; c=relaxed/simple;
	bh=fXZ4vcmfUqsmt2+CSUmCg841TbZJyBu0/JW402XtkNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS5nmTmtc/jWXMCRxY/uXRtz90av79RwMiJb/IRWEr9CZyaEuS/bGQPjttuGsXsJxSzOfeEZU19tpUYWCBv5TuhfPhimf6ySkeOpBw3GE7hqhZKcJbbk41bZO12GuWsR6CjKqZ8i8dVOBG3GTnYHhnScwHEITwD0pjNSbJH5jZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4QPBAsR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b38fdac002bso358057a12.0;
        Fri, 11 Jul 2025 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752244828; x=1752849628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXZ4vcmfUqsmt2+CSUmCg841TbZJyBu0/JW402XtkNc=;
        b=O4QPBAsR+QYtigc0Q+r3IsHIJ7t+X9CboLb4vKa8D9Mw983NZvAPjFtXCYI2HXIAAn
         EF2aRdwDww12P7hxdBlKEQ43R8TPKb/lI6UvXC6sW+wW/jUNXzabZVNL0zIP/ZVy62VE
         aXNKtv1UAZAGhqSqrSjWFgdi2EvRnSVlVgm8l0S5d0PNMLp8Zfxx4tusmLCbwntutP2y
         yhC5LwF+LQvqGhlrYPLCEI1MJ1xfH3eEIZdztdxvP5fXDwEo8KNzFvZl53zULIAXp3y5
         b1MTLvmvBydClX78Mw0Lu6tfn2kGTMv9Yf51fsxSgmUpvBExBG4ComDAJ4JjgP3ATuNC
         omWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752244828; x=1752849628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXZ4vcmfUqsmt2+CSUmCg841TbZJyBu0/JW402XtkNc=;
        b=p3e4gqTD909RTS9IEQoVbIyqUwnj3qNbLChQcnR1BNIfnA+fxvnQmpjm0qybl5luky
         Fc1SFg6+K1u14EwANPiF4E8+OxhkCcvVkb/Cqdim7MeTjOyNnbZo4/BTu/iZSriI4IrZ
         L6Mt+JLuN3S5o5+Gt8KUNa5JAjVv2fF91rtE9aTDFSjnSKNF9wEe+fzKYW4UqF08hZVS
         5Y+D3u5jANY3zSXji3hWYpPa9eFHMAs+uS78vL14x8w4HerZbrQv/Fw+u7rtK4k2b5bI
         NEBP66rZ/ufQWWN8h6sm82hMRbGvB1srrH9TCDxaxJx9UHpLCmWxNApCWqfTxh/I0XwE
         M28A==
X-Forwarded-Encrypted: i=1; AJvYcCW/E72Twvna8df/LPWyyqp+QLlAi/E/l0xwSabBcDdOZ8/mbQwk75i9wcXVnO+PKN8b6gKAt5TbgNNn@vger.kernel.org, AJvYcCX68PvUoO96umJQUTYVk+V3BaynaL7tMRseo0VFnpfNd+g+eNhxgoyWFLO3vEiqRjVWsFhN0B64pywnREkKhBY=@vger.kernel.org, AJvYcCXC9nKGmFST+XnKRXfTYkVIY5CELvpAad8ybE9M/S5JBnSGJSitfrstnKEUF2sYxT2acpA9dm1GrLQxlHyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PqqJFniOJ8vDZeqk/r2qowMkHrXXv1iZfoofby901l99ed+h
	d6lSlTVAaB1hUI5EA7+xDbYmcWJdyvHMbsfRHl8lk4gRUqpARAcEMPwBFgi478C4bVeiua9Gqe9
	WAQsb9CALtjivS0pcNB103vqR79tVcJ0=
X-Gm-Gg: ASbGncuVncNzrKAeyAmOLX3iI7pJpMmPnY7WqT5BC0V8IgiJq4s+Eh4jAx/iqT+n23T
	c6Ue2+ZbCdQmqyxnkQ9hOAGKxkgqfSUO556cCV7StodbPAFgiwoTyNKkuNC4H5G5hnDl/7DB72z
	uKgvzrGY75uMw7kPVhFJkt0qoGVRzmiTipCjCzuhYzPM3HhMROqT02g5CoF05vuHIFbUX0utEey
	vBZC8pg
X-Google-Smtp-Source: AGHT+IFYxwtBgMnIfg/xAT3R3GJa8aE3IrhDbXL2I0lvZC+hZp+4ZPopV91pa6CXgeAX/d6BH2F635YQjTdbLIOr0Bg=
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31c4f37b71cmr1629560a91.0.1752244827632; Fri, 11 Jul 2025
 07:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060052.11955-1-boqun.feng@gmail.com> <20250710060052.11955-10-boqun.feng@gmail.com>
 <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org> <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>
 <aHEasoyGKJrjYFzw@Mac.home>
In-Reply-To: <aHEasoyGKJrjYFzw@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Jul 2025 16:40:15 +0200
X-Gm-Features: Ac12FXybQ3RSq0XqEzQa0Q1OUOc2LkcohPUYOuFRJIKS3VWXUuSmYjCh6kdSjjU
Message-ID: <CANiq72kvZ7-fMoE9g7SBUrBZy4QMbSL1p8KgBqGhOkenrsr=3w@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:07=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Thanks Miguel.
>
> Maybe we can do even better: having a type alias mapping to the exact
> i{32,64,128} based on kernel configs? Like
>
> (in kernel/lib.rs or ffi.rs)
>
> // Want to buy a better name ;-)
> #[cfg(CONFIG_128BIT)]
> type isize_mapping =3D i128;
> #[cfg(CONFIG_64BIT)]
> type isize_mapping =3D i64;
> #[cfg(not(any(CONFIG_128BIT, CONFIG_64BIT)))]
> type isize_mapping =3D i32;
>
> similar for usize.
>
> Thoughts?

Yeah, I wondered about that too, but I don't know how common it will
be (so you may want to keep it local anyway), and I wasn't sure what
to call it either, because e.g. something like `isize_mapping` sounds
like we are talking about `c_long`.

What we want is a Rust fixed-width integer of the same size of `isize`
-- so I think you should try to pick a word that evokes a bit that
part. Something like `fixed_isize` or words like `underlying` or
`repr` perhaps?

Cheers,
Miguel

