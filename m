Return-Path: <linux-arch+bounces-3151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085988AFAC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 20:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606D8B39068
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114F13C819;
	Mon, 25 Mar 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTC8vqQC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33513C816
	for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375026; cv=none; b=s8mff/0Mo38qm2Lwt7MOXMLJ89/W58YLy9AqoSr2UU1y21qu5yBMor7q0F9wpFBX/6VlpLIj7AqE/IvLgyYOX13n5bQLCxSUM761qA/YHomxv19zsffqOraCd1ThwKjCvCw39aW++09rNduaTf2lvFsI74lZgclFNXSixt9c+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375026; c=relaxed/simple;
	bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EctW7nzMVdkMx/BmlrP5qZmt5AIVuKlkXXeDdjN6VsyKF2CC+KNcDpeP1IJ9Jkno9PzIqih8iv6L1upawEP/FlIkusJOEP1ZyxEE1CRdU3gU1puu8ZlyRhN+/sO46tQ+dq8hnn38ROkKu2A5d5wpnEM6KSh89N2n4Hqws6afR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTC8vqQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711375024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
	b=YTC8vqQCaNQSIfmGxmaRo+XhG8hbqvkA1bRpoON52j6bDZd5yhMfuVs4MNxtDN3TBcNf1n
	NQeNkeDCI0L75PsZ8upu+Yo6AKT7hF3Wokh8e0+uZ36fDGEM84bQJkoySzWEw5BPLnO4N2
	JACjb1RDN+B0qI34sVFz1XXM5UIi26Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Jdo2b569M5uDebBVvd0xug-1; Mon, 25 Mar 2024 09:57:02 -0400
X-MC-Unique: Jdo2b569M5uDebBVvd0xug-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c5548f93so5085991fa.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 06:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375021; x=1711979821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
        b=j4s2GNn5mq7JYpFsIAwtYEk+Ahklo85Eo6bKlig2KWQSWS0l6jf73f1E294jrrXj9J
         bodAkMAMbfpnFbE58d6OWR2xvrzJj0A4wvZ9p9kD1KZMQ7FftbzW57YEo70dkVWkTfp8
         PvVh4zGHLKdjlwJisjg5/w1gn4ILW2i86GHX/chsku9iC/QervZJRK/8Zx3xZeg0k5mr
         uStMQiPGbR1+6iySn8Zu68K68YtbbgOqcQIbUlPwYE295SFP9jZoxvKmPkKfYPWbn/Tz
         bqGyyIHXZ0eDnHho6xdIKPUic9JupNGf+zbNY8XzBXgo4FMK4aI/mnwI5ZeKnolCPWV/
         yqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7PmbYxfES06xZHoxOXhmxQPtAf/1T4TesNegF/VpU/4yt8ZaLvdPEbZ0ikwnT4HHp9/3ETw8XvgyigYuVBR44aHyk11I34v2jQ==
X-Gm-Message-State: AOJu0Yx0SGOarBPHK1ugQA02SRr/FT0If47Lo6xO62W71ycWMlpc56as
	3+blaYnKrvnmv3SfrH7DPcSZhShoD8Oa4Nn3SnXSgYlSODHCVwlZAXFrk+DXUfr50NWsW/InVT7
	q5OIkzQxEYYRX4Ln/JIZBukjn6gUCSUcoHYHWka4q39je3KkqRQc3f1OAxE4=
X-Received: by 2002:a2e:88d0:0:b0:2d4:78b4:e568 with SMTP id a16-20020a2e88d0000000b002d478b4e568mr4341993ljk.1.1711375021348;
        Mon, 25 Mar 2024 06:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsEsxChr4oIHfPIiuFPvTM+72aemZNo0G3gI+fLGhTYtrb+QS9VpjMdi/YbUXjC7EP1XZSIg==
X-Received: by 2002:a2e:88d0:0:b0:2d4:78b4:e568 with SMTP id a16-20020a2e88d0000000b002d478b4e568mr4341961ljk.1.1711375020848;
        Mon, 25 Mar 2024 06:57:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b00414887d9329sm4600055wmq.46.2024.03.25.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:57:00 -0700 (PDT)
Message-ID: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
From: Philipp Stanner <pstanner@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
	 <kent.overstreet@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,  Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan
 Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes
 <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Mon, 25 Mar 2024 14:56:58 +0100
In-Reply-To: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
	 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
	 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
	 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
	 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 17:21, Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >=20
> > Besides that there's cross arch support to think about - it's hard
> > to
> > imagine us ever ditching our own atomics.
>=20
> > [... SNIP ...]
> >=20
> > I was thinking about something more incremental - just an optional
> > mode
> > where our atomics were C atomics underneath. It'd probably give the
> > compiler people a much more effective way to test their stuff than
> > anything they have now.
>=20
> I suspect it might be painful, and some compiler people would throw
> their hands up in horror, because the C++ atomics model is based
> fairly solidly on atomic types, and the kernel memory model is much
> more fluid.
>=20
> Boqun already mentioned the "mixing access sizes", which is actually
> quite fundamental in the kernel, where we play lots of games with
> that
> (typically around locking, where you find patterns line unlock
> writing
> a zero to a single byte, even though the whole lock data structure is
> a word). And sometimes the access size games are very explicit (eg
> lib/lockref.c).
>=20
> But it actually goes deeper than that. While we do have "atomic_t"
> etc
> for arithmetic atomics, and that probably would map fairly well to
> C++
> atomics, in other cases we simply base our atomics not on _types_,
> but
> on code.
>=20
> IOW, we do things like "cmpxchg()", and the target of that atomic
> access is just a regular data structure field.
>=20
> It's kind of like our "volatile" usage. If you read the C (and C++)
> standards, you'll find that you should use "volatile" on data types.
> That's almost *never* what the kernel does. The kernel uses
> "volatile"
> in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
>=20
> Compiler people don't tend to really like those kinds of things.

Just for my understanding: Why don't they like it?

I guess since compiler people have to support volatile pointers
anyways, temporarily casting something to such a volatile pointer
shouldn't be a problem either =E2=80=93 so they don't dislike it because it=
's
more difficult to implement, but because it's more difficult to verify
for correctness?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linus
>=20


