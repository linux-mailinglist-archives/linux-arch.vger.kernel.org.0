Return-Path: <linux-arch+bounces-8178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA6B99EFF4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA0284CE5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7061B2188;
	Tue, 15 Oct 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQWy9uv/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834613E022
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003566; cv=none; b=l14BFyU6CKvEtLSiC3zFzciJCccbPDv3htoOiMXwqBPVLJzn/j1zA8fJUR9TTtFCLk87GIb70p6IOCP28WRraUfseUVd3ns/GOSh8OHPIJz5H8MIMCaNhkqqYz3fUGGIXLt8cJa+osdATMHp37prFdh/EVrxoP3isyGpoGwH35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003566; c=relaxed/simple;
	bh=1bEhqwEHmxJs9+B05nsJYv9A3NKyJkdV9GS5A58QEEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmwRG+fE3V7/3WFQcu96dBdqARICxsF5s3S3oB/HRK4SEmTVQFpO23iTIOW6qa4n834WsOcXjhcGVc2u5yz1eGVwHKm/dJIe7MMbFVVYuIWb+XRhXHf6S6PLOy2lkG0FKLvQeAaz36hDrqBcBXuFhyy3z8DHL5DsNbVU1OWr5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQWy9uv/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3873932f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729003563; x=1729608363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bEhqwEHmxJs9+B05nsJYv9A3NKyJkdV9GS5A58QEEw=;
        b=wQWy9uv//SfRwrrDqH78SDvEnd0GeE85qS6kcu0mPJZ4gJE8hzQVp4KPb1dF+1wmnc
         /C9iAHWIhoLqKATCEWCOB0UqML95jjZAymJXa4PqQPPLkngmcYHhmaf0spO5I2SYAVH3
         aZbrdm8oNuhbip+uFTT5TZxPKUGmL/HcCt33hxnnAlJ3NOqv+X4J0ej+z5R8/2GqVOZt
         vLFX9lHEKiTVBkZFvuY3zp2CyKJ36Tzgqg/uc2kJewMzrtCKHQ66RTH4B/pRqg3wBJnU
         D5LoOFKXYl61rXNxZP6DTf7TnijraWex7iJ+5k6AsBXZt5mNNKkoQkKM8tlQaz20NllZ
         6JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003563; x=1729608363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bEhqwEHmxJs9+B05nsJYv9A3NKyJkdV9GS5A58QEEw=;
        b=EI2ZCRKk2QFb+IkMtCLYMPEBo71CnrqYaxmyqn7quqHV9haAXDvO18IkUauKOQ3i6Y
         SgT5SVcea54RYT6f6wniRUa8TcJsnOBr+PVWigtJulyowOUMIfCgYFfCoFgy5vO/yf/X
         GGTe4zaszaM+9LIr4bkxRN5XEucoM4Cx0Isrg3u9HBDH3DFbqrXv7Zh9fuNHgdaNpBte
         BPUqbeg/SE7xOgivRMYXJ7SFRuQmv7X+uEegVuDcFqKDWWr1nSL3nKivyhWsxQU0xmaC
         SqKZ+fBNO+37GtfUBdDzwMlT7y7lSnutyC0ZNMmo4Bb5xjazD4QVSuKyBVHWl0T9ilU6
         XaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD84a3dBKTOgYflQI9fN554Z7yHjhEt6T46ZHclNhRqmDWJE2znVnZCYyA2/qSLCqE1OOY2/1Yz0hX@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqucLLW5sUhVWWNTGfKgv1PGZyu7dySPFhBCnL68nHVkWRrX/
	qQOU93ReSP6tlR0knGsnXgPxyzMazq5X/EfG3vw/f3wHgKN8n3o4JZfcezn3mrzvUvf8IxDVn/9
	8JhbwivB78tzdmEcxYO1goU7ulexn/5qcnOvs
X-Google-Smtp-Source: AGHT+IEK4Wl6/jw5iBhBo/Fx/Cp0uqUqlmPb/nuYJU9OSwXavYyNFlXi/fqkdToVUNxEJNnuM34srOxgnvxgq3tp3J8=
X-Received: by 2002:a5d:584f:0:b0:37d:5359:1ec1 with SMTP id
 ffacd0b85a97d-37d86d793acmr386815f8f.57.1729003563300; Tue, 15 Oct 2024
 07:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>
 <202410151814.WmLlAkCq-lkp@intel.com> <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
 <CAH5fLghJrrq2nJu7S08bBg2sAjdibkZ4D14K9cqETafnr4CR4w@mail.gmail.com> <CANiq72kRiQvw3xWbMGRxcVJhHN0LMRa0RewxnkofVr=71KQvEA@mail.gmail.com>
In-Reply-To: <CANiq72kRiQvw3xWbMGRxcVJhHN0LMRa0RewxnkofVr=71KQvEA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 16:45:51 +0200
Message-ID: <CAH5fLgjFFmm-m8=4Qbad6X-EOjKfCytE3ncevO1u-sSn-jJF9w@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 15, 2024 at 3:07=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Thank you. I was able to reproduce the error locally. It only happens
> > when CONFIG_JUMP_LABEL is disabled. I've verified that this fixes it.
>
> You're welcome!
>
> By the way, if you end up sending a new version, then you could
> simplify to `ifdef CONFIG_JUMP_LABEL`.

Too late! But I can do that if I send yet another version.

Alice

