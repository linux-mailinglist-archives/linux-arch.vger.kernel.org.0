Return-Path: <linux-arch+bounces-6434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93A95A430
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D721C211B6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01041B2EEF;
	Wed, 21 Aug 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La+OxHUF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AF1B253B;
	Wed, 21 Aug 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262905; cv=none; b=pV6n7HTs1fRdmrz97cWLZGygJXWyX8IikbESd+mrzxkbtZUibGMCCbjGpDcOVIvPYAvXfp8W9oC36A+9xtKBhLhNlovbSs2HmrOSoskaZXItgnqYRaai83xiikOzCPiF7yZMcqoU2L03mLy98o3TKE6CmJGDKTv9Jj+Ej8bENUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262905; c=relaxed/simple;
	bh=gR41Sagi3MVianUSnce+ZoVIT1ol5TlwXr/MDVUkl4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrWZxgFcFDKXIh4S29KlmYMWU/CvjHh0rla/crSCbTT/YdAQNtOQF/G3uj4ihiCA8bt924s7r2sSXByMJZ46KxvstNnGsTRgGod30IarHeDqokZoj4hUTBuYMWU2MMwoon6ejt5BwV8d4QLKzBDwoeCh8rxqLBKwgEF2LFSFUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La+OxHUF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d22b6dab0so115588b3a.1;
        Wed, 21 Aug 2024 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724262904; x=1724867704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99UTJcdmOMSq3QL9Ld/ZYDtqRpwRWCrHaSBTyLsenAI=;
        b=La+OxHUFGPzFnuzLmMpxRdtApbmCPaO9oHbAl7DSTa0Na0Srs2QN8k+SSFiXKAdt32
         ITwRU1QbSfFV2OA+zt4zuYDAcOmcc87DTo9c9D+uWIJJ95/O+7RZnBHLPcpcNTcgC2jS
         HUGoKTjYgMAwqsq7eXqqx7hJ1og7UyEjUZBfsQHufFmOx+1JJf931J1wGa+DfWbWoBTo
         5rD+7hnNQQf5oapT+I9y/d4tkUh03SlOMbXOGw/XS4RUMU0HwyaQIkWXCiyZxcLE3Bsu
         8rbpGmpqjV5T+asqKHm3f01qdwfnBwbI46Wia6swgmgap+VCX4z3S/Q9LLEbWt1Ru7eA
         911g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262904; x=1724867704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99UTJcdmOMSq3QL9Ld/ZYDtqRpwRWCrHaSBTyLsenAI=;
        b=BhoI7tLCIIilMX3e3+iEt+MVJn+3/sIin8wv3lE9L9R2nGXJUogWpYxxQS02dSLcRv
         lYAxeiNqbAR3T+CYz3rxvPY3XSckUIbRexiu6NuR7saXwFEIB1XuOnomRZ7/97tJBlEG
         XmO+s+N+I2fvgf7cm7mHmauwSGm/TBzwLRjkE8aixJFLHPASjQJykaN7hXHZYbPJDFPk
         ZBVL1YBLFniVdlPVWfgWMMATYBU7oDo9QXjy9RWqeK7yw/iOki58IINvJktVvMDK/w5J
         pKGoucjPe92i3KQIxJOZ87VcFPE4tDjDLE9v62XIgF97fcI6p+i2M+leqOJLEkLUexcq
         VfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVW85OFbr7OHXZ9GGyDYxk2fIX1Z8wkVZcMt7muZaHHyKO3//68TLaRqaNfN6ykYhSn9EWUZ2adV1KxuCH79s=@vger.kernel.org, AJvYcCVp3qrQwlxI9JqjVuJbpU6P7FjBa+kePvG+uWYDhfBJnyhRy+G2EQq9aPC+gIbiunKYjptUEvIdqWm8hBsQ@vger.kernel.org, AJvYcCWZkFvWbauxD2DyCBiCtATTiYmJyuorZYk+/DtPrHpjhktnyQ8v+IOHM8KmEBKr70yRdbpq8F37M6wPEft3fhGRWPUc@vger.kernel.org, AJvYcCXDwKcFLQIxDpa8pa+3lYNPo2RABVdnP7a4eWwBRWtgND8KlbSzTxVliXvbLVWBDYHtiSFRqhXMHXvB@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfOh2LVz3C+J9L69jc0A/1fjcNSjIzhLr6sMVdtxqOCk4IomW
	i5u5tdXqRg6V2POdMz7UAn0TeMCkpWAdFFYNBcmTPGal639eR2r7vKh3qKnCVg9DMRhyxE8JLsh
	CjwywDIwN6SrimZAB9n1CgpjO1qQ=
X-Google-Smtp-Source: AGHT+IEzWQ9FWxtgUqDPIkbMELTDsn643+uCsx+x59lAbwOzM67Cgp8McbVys7i78Q39WJ4bizO6S55PWpHdgZM9zIQ=
X-Received: by 2002:a05:6a00:2d90:b0:710:5243:4161 with SMTP id
 d2e1a72fcca58-714235d73ecmr2136069b3a.5.1724262903448; Wed, 21 Aug 2024
 10:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
 <20240816-tracepoint-v7-5-d609b916b819@google.com> <ZsYfAFrBFVewchGM@boqun-archlinux>
In-Reply-To: <ZsYfAFrBFVewchGM@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 19:54:51 +0200
Message-ID: <CANiq72np8GhZ4V22b7RekvQOhCbM67A-19Px2aVLgweC4Qxebg@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] rust: add arch_static_branch
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
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
Content-Type: multipart/mixed; boundary="000000000000dc2d130620353d5b"

--000000000000dc2d130620353d5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 7:08=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Have you try this with "make O=3D<dir>"? I hit the following issue, but I
> am rebasing on rust-dev, so I might miss something:
>
>         error: couldn't read ../rust/kernel/arch_static_branch_asm.rs: No=
 such file or directory (os error 2)
>           --> ../rust/kernel/jump_label.rs:39:17
>            |
>         39 | const _: &str =3D include!("arch_static_branch_asm.rs");
>            |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>            |
>            =3D note: this error originates in the macro `include` (in Nig=
htly builds, run with -Z macro-backtrace for more info)
>
>         error: aborting due to 1 previous error

Yeah, we should use a `*TREE` everywhere. In addition, we should not
use `SRCTREE` but `OBJTREE`. It is my fault, this comes from my
prototype I gave Alice.

Please see the attached diff.

Cheers,
Miguel

--000000000000dc2d130620353d5b
Content-Type: text/x-patch; charset="US-ASCII"; name="objtree.diff"
Content-Disposition: attachment; filename="objtree.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m045ljec0>
X-Attachment-Id: f_m045ljec0

ZGlmZiAtLWdpdCBhL3J1c3Qva2VybmVsL2p1bXBfbGFiZWwucnMgYi9ydXN0L2tlcm5lbC9qdW1w
X2xhYmVsLnJzCmluZGV4IDc3NTdlNGY4ZTg1ZS4uY2NmZDIwNTg5YzIxIDEwMDY0NAotLS0gYS9y
dXN0L2tlcm5lbC9qdW1wX2xhYmVsLnJzCisrKyBiL3J1c3Qva2VybmVsL2p1bXBfbGFiZWwucnMK
QEAgLTM2LDcgKzM2LDcgQEAgbWFjcm9fcnVsZXMhIHN0YXRpY19rZXlfZmFsc2UgewoKIC8vLyBB
c3NlcnQgdGhhdCB0aGUgYXNzZW1ibHkgYmxvY2sgZXZhbHVhdGVzIHRvIGEgc3RyaW5nIGxpdGVy
YWwuCiAjW2NmZyhDT05GSUdfSlVNUF9MQUJFTCldCi1jb25zdCBfOiAmc3RyID0gaW5jbHVkZSEo
ImFyY2hfc3RhdGljX2JyYW5jaF9hc20ucnMiKTsKK2NvbnN0IF86ICZzdHIgPSBpbmNsdWRlIShj
b25jYXQhKGVudiEoIk9CSlRSRUUiKSwgIi9ydXN0L2tlcm5lbC9hcmNoX3N0YXRpY19icmFuY2hf
YXNtLnJzIikpOwoKICNbbWFjcm9fZXhwb3J0XQogI1tkb2MoaGlkZGVuKV0KQEAgLTQ1LDcgKzQ1
LDcgQEAgbWFjcm9fcnVsZXMhIHN0YXRpY19rZXlfZmFsc2UgewogbWFjcm9fcnVsZXMhIGFyY2hf
c3RhdGljX2JyYW5jaCB7CiAgICAgKCRrZXk6cGF0aCwgJGtleXR5cDp0eSwgJGZpZWxkOmlkZW50
LCAkYnJhbmNoOmV4cHIpID0+IHsnbXlfbGFiZWw6IHsKICAgICAgICAgJGNyYXRlOjphc20hKAot
ICAgICAgICAgICAgaW5jbHVkZSEoY29uY2F0IShlbnYhKCJTUkNUUkVFIiksICIvcnVzdC9rZXJu
ZWwvYXJjaF9zdGF0aWNfYnJhbmNoX2FzbS5ycyIpKTsKKyAgICAgICAgICAgIGluY2x1ZGUhKGNv
bmNhdCEoZW52ISgiT0JKVFJFRSIpLCAiL3J1c3Qva2VybmVsL2FyY2hfc3RhdGljX2JyYW5jaF9h
c20ucnMiKSk7CiAgICAgICAgICAgICBsX3llcyA9IGxhYmVsIHsKICAgICAgICAgICAgICAgICBi
cmVhayAnbXlfbGFiZWwgdHJ1ZTsKICAgICAgICAgICAgIH0sCkBAIC02NSw3ICs2NSw3IEBAIG1h
Y3JvX3J1bGVzISBhcmNoX3N0YXRpY19icmFuY2ggewogbWFjcm9fcnVsZXMhIGFyY2hfc3RhdGlj
X2JyYW5jaCB7CiAgICAgKCRrZXk6cGF0aCwgJGtleXR5cDp0eSwgJGZpZWxkOmlkZW50LCAkYnJh
bmNoOmV4cHIpID0+IHsnbXlfbGFiZWw6IHsKICAgICAgICAgJGNyYXRlOjphc20hKAotICAgICAg
ICAgICAgaW5jbHVkZSEoY29uY2F0IShlbnYhKCJTUkNUUkVFIiksICIvcnVzdC9rZXJuZWwvYXJj
aF9zdGF0aWNfYnJhbmNoX2FzbS5ycyIpKTsKKyAgICAgICAgICAgIGluY2x1ZGUhKGNvbmNhdCEo
ZW52ISgiT0JKVFJFRSIpLCAiL3J1c3Qva2VybmVsL2FyY2hfc3RhdGljX2JyYW5jaF9hc20ucnMi
KSk7CiAgICAgICAgICAgICBsX3llcyA9IGxhYmVsIHsKICAgICAgICAgICAgICAgICBicmVhayAn
bXlfbGFiZWwgdHJ1ZTsKICAgICAgICAgICAgIH0sCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2Vm
aWxlLmJ1aWxkIGIvc2NyaXB0cy9NYWtlZmlsZS5idWlsZAppbmRleCA0ZjBmNmIxM2ViZDcuLjc0
NmNjZTgwNTQ1ZiAxMDA2NDQKLS0tIGEvc2NyaXB0cy9NYWtlZmlsZS5idWlsZAorKysgYi9zY3Jp
cHRzL01ha2VmaWxlLmJ1aWxkCkBAIC0yNjksNyArMjY5LDcgQEAgcnVzdF9hbGxvd2VkX2ZlYXR1
cmVzIDo9IGFzbV9jb25zdCxhc21fZ290byxuZXdfdW5pbml0CiAjIGN1cnJlbnQgd29ya2luZyBk
aXJlY3RvcnksIHdoaWNoIG1heSBiZSBub3QgYWNjZXNzaWJsZSBpbiB0aGUgb3V0LW9mLXRyZWUK
ICMgbW9kdWxlcyBjYXNlLgogcnVzdF9jb21tb25fY21kID0gXAotCVNSQ1RSRUU9JChhYnNwYXRo
ICQoc3JjdHJlZSkpIFwKKwlPQkpUUkVFPSQoYWJzcGF0aCAkKG9ianRyZWUpKSBcCiAJUlVTVF9N
T0RGSUxFPSQobW9kZmlsZSkgJChSVVNUQ19PUl9DTElQUFkpICQocnVzdF9mbGFncykgXAogCS1a
YWxsb3ctZmVhdHVyZXM9JChydXN0X2FsbG93ZWRfZmVhdHVyZXMpIFwKIAktWmNyYXRlLWF0dHI9
bm9fc3RkIFwK
--000000000000dc2d130620353d5b--

