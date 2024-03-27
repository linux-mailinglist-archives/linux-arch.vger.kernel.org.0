Return-Path: <linux-arch+bounces-3226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5188EEDB
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02211F2E705
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395615216D;
	Wed, 27 Mar 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gvtKHWYM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16496152162
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566468; cv=none; b=V06OOPrApu+2WASbjkjp9us2iiTscOJSSAZ+O52sz7rjzQSKDZ85ouAXbMSCCfqaMghV2Xc37HNDYR/DU1s/lxnBj6jbZd78ijM7Pv1gt8eDIxakFd5RsOLG3Z6tFyZ1p3IjL+q1TAOGG59MCI++EZ0mGGaooAWjOzVvORHq3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566468; c=relaxed/simple;
	bh=jMoBfFRvYMHbxV9SVPKA1xW7pPTPIbFhe56hTJM1VbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntIKSixzhhHjVeHbcXgHcaBJDDpQh3ybFyEr9nXgR5wLHNV3Rn58Ao0Y6EcWVj1gvtzOw/PbK4uwfPQKM3/gcgTJ5eSMBxw3+PT92JikhR5z707wszo7tNX35jSeEcIlbahM3SMNG37I5bsqbDUAfSW736ihaX3roTVJnu8cx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gvtKHWYM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so186877a12.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711566465; x=1712171265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WdyHGSi984C+8z92+nQdjQTGDoXLLzpQZD6STeLATA0=;
        b=gvtKHWYMlYjqblR3bFTlrIy1WNW13rAyH524zsOXYlPyhELTWBOxG+KTSrQPMo01lz
         rYvFP9ENb7BEf+E9fI4CCat3PU79Ef6QrA8Qh8jU9Hkc6+TmJfgcK6KbyO4/EDFucM+u
         S0p5hHldtV3SlQeKm0S2ccOePV1Cn98q1lEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566465; x=1712171265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdyHGSi984C+8z92+nQdjQTGDoXLLzpQZD6STeLATA0=;
        b=pFJU9bCdmRAga6nm7Gr6l78PoVjiBH+9CEUXFhYDDtJJOoLVhAgtdCrMV9hHGuKHZD
         VWjpry/bZjJATPjoBZmUzSpTmBW3LY1biqwAP4ZWmyCs4wwhoB9SrWz3DFAGn7zgvieQ
         yx2u8WDh5/DF7MDpV3DuvbZ5sWKSrNZZzzcBXXn7YCEHXAByuyJQXJBoGe9yqBDRHP6v
         u9sTM178/nK37iOg2I7Qe9tv8sx4XiHV8OenmIX6j4afQE6IpQP+xN2+hOOP1XoT94FG
         IuN9329tPxWkAZy5lqWLnEncKwApFbvnhlDBN2zfuvYK9FN5c7XgH9YHHMl6g98PZz8H
         nsdA==
X-Forwarded-Encrypted: i=1; AJvYcCWc7AzH0/w9YDIi67wfV58e6OaRZT2UOesKHOXrxSRuB9XsetF5bQQExn3KezN2MOaNuJBnwh7hc1IP8ddfr7PgxnEPTidJ2pcDsw==
X-Gm-Message-State: AOJu0YzJYUesD+djvyDodup6pKTOKtd59XCLYPAaJiuVBcNE3U2ctT6t
	B9DragsXohXHdKvsQEw3seGoa+gzS0mRnowvhGXbi10gOzhLu4vGijO23suefAK/S6wy0HBWjZU
	8Gf0=
X-Google-Smtp-Source: AGHT+IFo5hmOH3BpQ1OGAilMcKGn8135RECsf4if4V1uD+DMwXEXLwJ0q9PscWgQysItsy7VXiJFRw==
X-Received: by 2002:a17:906:b858:b0:a47:3900:7b2d with SMTP id ga24-20020a170906b85800b00a4739007b2dmr251312ejb.6.1711566465224;
        Wed, 27 Mar 2024 12:07:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709062ac600b00a4739b854cdsm5744745eje.33.2024.03.27.12.07.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:07:44 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso23276766b.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 12:07:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXheMdqqkqBEGQjGDWpk+O2kdY6jrw04s5MHMELjqAMJQ4jcl8zX3vAVgjk7ajVtlqqBZ+8P5EJ3TOjnzubFsKY0a6QKMZdEUmouQ==
X-Received: by 2002:a17:906:6d5:b0:a4e:14b3:e7e1 with SMTP id
 v21-20020a17090606d500b00a4e14b3e7e1mr172960ejb.42.1711566462952; Wed, 27 Mar
 2024 12:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
In-Reply-To: <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 12:07:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
Message-ID: <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
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

On Wed, 27 Mar 2024 at 11:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Wed, Mar 27, 2024 at 09:16:09AM -0700, comex wrote:
> > Meanwhile, Rust intentionally lacks strict aliasing.
>
> I wasn't aware of this. Given that unrestricted pointers are a real
> impediment to compiler optimization, I thought that with Rust we were
> finally starting to nail down a concrete enough memory model to tackle
> this safely. But I guess not?

Strict aliasing is a *horrible* mistake.

It's not even *remotely* "tackle this safely". It's the exact
opposite. It's completely broken.

Anybody who thinks strict aliasing is a good idea either

 (a) doesn't understand what it means

 (b) has been brainwashed by incompetent compiler people.

it's a horrendous crock that was introduced by people who thought it
was too complicated to write out "restrict" keywords, and that thought
that "let's break old working programs and make it harder to write new
programs" was a good idea.

Nobody should ever do it. The fact that Rust doesn't do the C strict
aliasing is a good thing. Really.

I suspect you have been fooled by the name. Because "strict aliasing"
sounds like a good thing. It sounds like "I know these strictly can't
alias". But despite that name, it's the complete opposite of that, and
means "I will ignore actual real aliasing even if it exists, because I
will make aliasing decisions on entirely made-up grounds".

Just say no to strict aliasing. Thankfully, there's an actual compiler
flag for that: -fno-strict-aliasing. It should absolutely have been
the default.

                 Linus

