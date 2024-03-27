Return-Path: <linux-arch+bounces-3257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6888F250
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D7BB2418F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187015442B;
	Wed, 27 Mar 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dx4WhPaq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D315383B
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580254; cv=none; b=VHP03gDFk6uVbfBB+S6Ny0i129aEsFAYTPtlX9Py0jZ+trxm5BUUV++qr8EHSYE1aUA0NMvFMUfEi5iTmc4eoIdWpM9P4UNWRN7x2VC0Tu5vZF8dKHwqqjTN125Oz8elYfAcDLlDsUsUqeVX4RtztkWiMMULBw+NYOfQ3Jfxd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580254; c=relaxed/simple;
	bh=VO6BQZp9XbSQ+WsnBdem/mcXj4kD5L/TqZKDrqpZiSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoQ2Hy1W5cIZ0FswFJREbNtvZDae1qpSjtL2vNgqrvwWfI9zoEvw0N8Ih/dDtTy7b149XtIZHnag47OYCH9Bh4Qx2jqWM5UScLCVOiTt76Xjvl9bKrfsKpSbvLftDs/+dC1QmSWCDZmEv1vky2DE/PzNOo+YGFJhnoEN/2PviSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dx4WhPaq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso48597766b.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711580250; x=1712185050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=dx4WhPaq/8KHox5vx6vtgraL0uFTOcJGXHVFY4mbdUjrnlw9wWqllPKi+Re7uMRutI
         86wGDNcd8PI+bMVRRJIFzTGtKHxzKzi4YpsFEtqHBwKAZXQ2+lNdTzxK6svMqd5s/QjE
         1+Yr1pQ3Ban4xJENJj1OgwBxjgGPizPSfSR3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580250; x=1712185050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=wTXISosaP1qQ1+S2CprhCCZh00hnHAvYP0DCYrXeoU5E+VDhodUX4RVEygZvIXQHA3
         WvoT5CmpwXh7UW9gO/Dkpf3d+WJSXjqFb1ofcnEIYdXJmNDRiZqMKQqun/52Xru2wr0P
         LehuRta+sNSfh3NTuhD942SGmrTdCiDTNTDG0yYnF7yL2+nVnEa05ZGG1+iSb4WaFb3b
         WSzsu/Jn2xR8NbkxR6hTbd7CMcLh4QgDt5FQbbD/hNEAMbFh9w0VKv3icLo3hS+6SBZX
         qCKXX1kEqr98dpCZ3CVHvS/vLMy07wrfndkgnSJo9gQqi2xeza0SnTOwQLv6BVe9a4Y4
         lqGw==
X-Forwarded-Encrypted: i=1; AJvYcCX53htFY1kauHmqjSPKUf07rPSUmwuIbY1O/E18wQZzP/vvU+iFdpRdqMNUjU/ExspNqF73v1TEBZfLrGzyet2fbAvdxpNmvPu8WQ==
X-Gm-Message-State: AOJu0Yxf2frQth904lHTDMTEq8Cs7iwhUhaqf6sFYas/H0sngNG0Mcez
	bL7wnQWneuiP4C0dUVl386U7PJ8ZfFcQOTYpBJGYi21c/hEZ38lyo9tzCC2ez1nHvAgke7/gJMi
	mamvBGQ==
X-Google-Smtp-Source: AGHT+IFIlIUOJ/Mh0e/f9Fo4X3gaTMWqMYSEknWqKIEAWOSzCHgRM9aZdtNk7Na72LbjxY2MhpIpEA==
X-Received: by 2002:a17:906:a254:b0:a47:2f8c:7614 with SMTP id bi20-20020a170906a25400b00a472f8c7614mr545857ejb.43.1711580250495;
        Wed, 27 Mar 2024 15:57:30 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906044d00b00a474df4cda5sm40222eja.167.2024.03.27.15.57.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 15:57:29 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a450bedffdfso34794466b.3
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 15:57:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCFe/bgifn/KfPSMf3I8ZboVAcLcL2n/tuieUD2jmX+hIx4G7TjSqJcpOklZ84Zsl57ovMBhAoPgznXnbpzjhmCAqltGrtQrHerQ==
X-Received: by 2002:a17:906:1352:b0:a47:3887:db68 with SMTP id
 x18-20020a170906135200b00a473887db68mr468280ejb.38.1711580249028; Wed, 27 Mar
 2024 15:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com> <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
In-Reply-To: <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 15:57:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 14:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>
> On the hardware end, the Mill guys were pointing out years ago that
> register renaming is a big power bottleneck in modern processors;

LOL.

The Mill guys took the arguments from the Itanium people, and turned
the crazy up to 11, with "the belt" and seemingly trying to do a
dataflow machine but not worrying over-much about memory accesses etc.

The whole "we'll deal with it in the compiler" is crazy talk.

In other words, I'll believe it when I see it. And I doubt we'll ever see it.

               Linus

