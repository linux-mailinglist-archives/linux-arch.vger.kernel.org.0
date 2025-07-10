Return-Path: <linux-arch+bounces-12640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1488B00B72
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41E15C0F00
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273F2F3638;
	Thu, 10 Jul 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOtLXRKS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1C1E0489;
	Thu, 10 Jul 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172375; cv=none; b=CSKaeqJw42VarKHs8j7Q7hYXtnWk5905haDzYbkhx1ymf+OPQsldrvqIO/BXWlVCr2v3YwDYBBXOwUW1U98GZ5NktbyUILWCKhY6hMYiZbElBVMJE9OmQYJx9kkV96Bpmmk7Td8jndE2K9h/XNUZjxh9RRK3bxqQ3csjRq2Mm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172375; c=relaxed/simple;
	bh=WepPI1QEsb7KVPco0eNErLMr0WYuLRbteu135zLMSYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knCVVmgpW+LFKTXv/HbPOoWta+uwP4gxXvTXZJnG/7UXCLB1mnra1/0ecBHvaZX4hAmwjvmJcuTJ9RvqetUVGypSuFIiyijSm79KoZ41E3oBOQdTeq/QYV6CCs5znKBzDHTl+hWLvJlFtgLbxWB8OY9Zw02b//70lca1BBC40PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOtLXRKS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b122f2feso1108375ad.0;
        Thu, 10 Jul 2025 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752172373; x=1752777173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WepPI1QEsb7KVPco0eNErLMr0WYuLRbteu135zLMSYg=;
        b=WOtLXRKS8u2QY0/zPyBP/SU7lqkJu3mkcXI42Pk3Ng61I6VeBO5oaCZh3drRqlJrrL
         RGYJiaFkeOx2Y9UDIMQIcOg9tleFuRmBwHckfdhDFYRwKr6ENdUlyiYxWVHZbU09jJ4q
         FoIsmub/J5ipNwUo9D1Mcw4slSTDvSlIw+etGn2jQLIgQVwYe+1uBVKF88emrbAnk9xJ
         8M+/S1+Zpxf+Tif7mVJPlZwkXxPEka8VpugVsz+///mHH332NH/H1UiCoIBq5EJkrcER
         6K24+V2U9QtOHpoI/RNtlw4jonDPqDHjz37NdFm/s/34QjHrqdNALAdRplVfBS9qO2YX
         3heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172373; x=1752777173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WepPI1QEsb7KVPco0eNErLMr0WYuLRbteu135zLMSYg=;
        b=R9v5MRjLx1mNS4orjpnO4S2GK8ixky4sWV1FJqhgNrxRsny8W5/g0aJHe5tDYmnz+g
         aegqsjdVHBjUmg59fqso0v5HY0ddbFYer79nF31rSiEbKSt0gmlhv5VXQyEmYeFHcXC2
         3U2yFih58ED4kQ1VJU0h0k90xeboOzIzBxEhSAHIpCqAs7LLPblw8CkvwAkFY36b2mUI
         bt96ZXWcwckeSA3lsWtWDKiqmrI+9qWek404Fdf+BEwzjiDB4EEcIew9oi6bUrBWU+PG
         8lw8B0jMoE6OzKYkXamoNadvn4kqEGcXj3obLhqfRPzfPD8+yfHHwcXwZBzFwtUh/7xU
         MHXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0pWz3grwPZ+Zz8Z40SDkhPBmFuo5ynG2+VsYnZwm5Q8Fn+55Dp9Q7Uho0DbsuNUVPpdEcSSfZgO4Su8CF@vger.kernel.org, AJvYcCVfrdG/SGJv3G1PwBXMIIjy+VtAYp0RTZUWWhBavZfmbIl8v/D2NeYxbBNY4vnjZoTI8AJ27AElIQVa@vger.kernel.org, AJvYcCXos4JRX2w7e7Ugl/dqhsvZdjpBu+09Esirs50PTWL3fIMmq+jdIoPTIT5svD2L5wjoS3T48wEKEkbaiDK1sfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CbU9ylubf+ByGbMui5dkmU8mqz00A3ufHbqDdFUuJVgWj6ou
	+QsIQSESqlPx0RnZUc8Jkw0zBVQOyZFcXFGVV4g2eR0aF1xGL65f66pM0HqDKdQpOkT3JY0EUq8
	VXwdNUGyLSE+GHsJfR4agOcv2JSc8sbQ=
X-Gm-Gg: ASbGnct3ak6wcS1CSTZJermz4oOwfs2l9h4UofvIS1ox1KXrU69nJIqDEU5Pw/x7F6t
	UJuCqEqMYt6dCFkMxLhMPouHTZAMtLzZ4rE83qRgr7MEd91UCUNu1F5Jobl6t5cEpNHOtlV3ovx
	whS18njdPrbqkcTcOUlZ5fdLjyTa3ScCwSYzFiMgPC
X-Google-Smtp-Source: AGHT+IFTkKMM44D0WTx8T2njTBo+Lj4fPVbE0SyMH8GHthy2NxnMMGZoDLNlGDght6fNtjTJq1SCULKC7PXatR5fYYs=
X-Received: by 2002:a17:902:d504:b0:236:9302:bf11 with SMTP id
 d9443c01a7336-23dede81473mr1222765ad.13.1752172373216; Thu, 10 Jul 2025
 11:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060052.11955-1-boqun.feng@gmail.com> <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid>
 <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org> <87v7o0i7b8.fsf@kernel.org>
 <aG_RcB0tcdnkE_v4@Mac.home> <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org>
In-Reply-To: <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Jul 2025 20:32:40 +0200
X-Gm-Features: Ac12FXxC1iNg6z30MULXJfC5bntwimdqt0Ot5Oz7qXD1RzXTBtdQy9P9OvPMxcw
Message-ID: <CANiq72=Oq-JHkBuTAZPVYO5omuXswgGfLXu+nAGwEdRdgkU-0w@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation types
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lyude Paul <lyude@redhat.com>, 
	Ingo Molnar <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:05=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> I don't think we have a lint for that, so I'd prefer if we avoid that...
>
> Someone is going to just `use ...::ordering::Any` and then have a
> function `fn<T: Any>(_: T)` in their code and that will be very
> confusing.

I guess there could be a lint that detects a given item being `use`d
which we could use in some cases like this.

I took a quick look, and I see `enum_glob_use`, but that seems global
without a way to filter, and it doesn't cover direct `use`s.

Then there is `wildcard_imports`, and that seems fairly usable (it has
an allowed list), but of course doesn't cover non-wildcard ones.

Cheers,
Miguel

