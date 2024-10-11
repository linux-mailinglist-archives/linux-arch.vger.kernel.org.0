Return-Path: <linux-arch+bounces-8056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92999AD11
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 21:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0221C213BA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB0A1D0E0F;
	Fri, 11 Oct 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuJ4qsYT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A001D0DCB;
	Fri, 11 Oct 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676128; cv=none; b=NFFiR0NG1DfTYaunyrlNoau9ErWV0P4x2KGzHj2r9D+6g+tsu+oirgoVhYb3jNInSKPvrc13DwmDLEuHJ0kELso9WNVZ6yK3v4MBqrkY2Fg2HNaoN8YHy6jOUBChYyYrF8A9ic3tws95hB7m4TyTSp18KfVzclDrw8gQDDhhyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676128; c=relaxed/simple;
	bh=eHR1pJM+yQAJRr+EhCLcm5xM2IPL3wNgQ41k9P8Ch74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIEblLOYoNyBrx2TBFhlVY8DmDGhN4nSsmWDVGK/nxd+QDPrNMnP2BvebZ7Oe0kYOrtnkt1pxOk+GpeJaJlfJx44Myl4g3e176XFkamLcoXhe5jwC/7sD9eBrbY2aMjo/fKLSiYv+ZhyUjvdCSI57WYUc/5zFcAuVKW8KRsBqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuJ4qsYT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e02ceccd0so294914b3a.0;
        Fri, 11 Oct 2024 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676126; x=1729280926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHR1pJM+yQAJRr+EhCLcm5xM2IPL3wNgQ41k9P8Ch74=;
        b=EuJ4qsYTMtpL7ptb2A5o8sbXNkWJIkDxx2H6yfQVT6/Ykx2AcFtb6OhQ5TF3R/hYml
         sAx3bwas+OINEWD8nUU2MQ/wpPLhaMGAp8uVyOaNZwglxP0/wkv8MoVLnMCuW0M87GkK
         OVg6Y3RpNWVlbm7nlaxReer0AT3SYE1kaTkn05cDOJ/Q19yX0lXCX/1M6jfjjR/yDEu2
         9+O0Mu4wyhg0dxM0pHzvZ7EpuC+SevDBXfsLcRn1dh1IDiz9ST8IvqqLPMoDU9Bxekt7
         TyL8LEBP9HHjJpsDfE9VPD8Fd96D68TKzv9rS1jCrSu8acYUlzR3iQfQnNaGoPr5aN7W
         Aw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676126; x=1729280926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHR1pJM+yQAJRr+EhCLcm5xM2IPL3wNgQ41k9P8Ch74=;
        b=lM+vVSSRy7mC1moOtGQ7VHkM4UbQcD2IJ+KDAbdld71/IujD4nCLtIWLnTiBsoABGA
         3vQJibx9EzXovkuSfG7xZucZxgU/etko5VqtKOKtKj3cFUmi7drwDWCcR8AjjbFPjg3S
         gUHMV/hSHWcxL0XHJRLZt/OuckDQh98AHcRahKK/gR8YtLioXErt+zZlABO2HtWz1z6+
         gKGHlmd0L9+BXgvAEM/xy/qpNJUSmHrljAsdhZ5TJVUp8M10IBkfKMp5I0VOewNoYXAO
         J7LpCw6Y/HfRhdO4NF08eN571B17dMaKvHdCYakwYXeKAQPjuiz/xDpb4oUOk472gDtu
         sM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS+zmL2T89XJtn/vYfltBiBqjBpZAhKNdggR9xrVE+Iy/Evy3ufRHLwn2E2mC9kZmzdmyBNXsr6L+W@vger.kernel.org, AJvYcCUX/GnPxllPO4CM05HNScN/Uwu2GbThIkLzX93qTpSBBVFlNze+cgGX0TIhYIoG5CaJhrFkocW5sNUhrdZq@vger.kernel.org, AJvYcCUfLgzYWJfPv4whYsWvFZUEqmR4dSyN7YWRW5CwahwPZi0YXyUWzBNmd+r2o2HDfM4NMtQYTr7K1Fef687yPG8=@vger.kernel.org, AJvYcCWTaY0T3jva5TyHxTHZ/PXFr38HkQuFwu0SJ9nCqYIy3vE7AO/1X7nL10mX9v0iG+FssbwFlTPUZyfV9qNuPFkB226r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzj8iYKBrI/QNcbZAWb8HFXk21SHqSqQrBYrTEJ4JMJgn/zxvk
	0jGg5/y011+fU5baK12PpSAeBQGdHly6MhW0KEG/O5AuDsQyyjgQ/UJ05bzHsrpWfBqcUej0oQt
	cBQpOW1YDQB3dt0c2vZo5xetmfNU=
X-Google-Smtp-Source: AGHT+IFm+UwkG6WIg1AqvuqnbDwrR2uK/LvnAOy5vxbnvuoTMa/HQ5sfAKze/sYR1OTnuhhXIrv49b/1Hp/O75r3s04=
X-Received: by 2002:a05:6a00:9494:b0:71e:3ee6:f8a8 with SMTP id
 d2e1a72fcca58-71e3ee6f918mr1949743b3a.1.1728676125868; Fri, 11 Oct 2024
 12:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-1-7fbde4d6b525@google.com> <20241011131316.5d6e5d10@eugeo>
 <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com>
 <20241011171251.0bd53f01@eugeo> <CABCJKue7qT9drhgrXPEjBO=gPw79vYELAZxz747Z8WMF=vj2MQ@mail.gmail.com>
In-Reply-To: <CABCJKue7qT9drhgrXPEjBO=gPw79vYELAZxz747Z8WMF=vj2MQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Oct 2024 21:48:32 +0200
Message-ID: <CANiq72nOCkzTyJCydHOrkz3MRizb27sDO_5Y_cKEv3oZDNNqqQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: add static_branch_unlikely for static_key_false
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 7:52=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> It's just one line per helper, but sure, I do see your point.

I guess we will have a lot of helpers added over time, so even if it
is one line, it may end up being a lot of lines in total. The rules
should stay constant, which would be better. Having said that, it is
true the extra complexity of the rules isn't great either.

Cheers,
Miguel

