Return-Path: <linux-arch+bounces-3473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4E89A35A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC73CB266D2
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28737171E58;
	Fri,  5 Apr 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu9rbMiM"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4817166E
	for <linux-arch@vger.kernel.org>; Fri,  5 Apr 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337239; cv=none; b=AIhtyqI+43eLYKV40XziK7hKMLYz9E157q0AfsArta1Bzyr4aTrGpD0MzSERXskX+FRvoOv8KggjskPXzTODS+Ao1XhODwGDJGz25jpaVLTfeqJpKJJyShL9VaeNoFhkKz+f/t3jySNRh8eJQdED9S48l3c0DwP38VnaYPj4Mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337239; c=relaxed/simple;
	bh=lPpM0wT4yWeklYwKPrb4XynteXC/5k41kP/uRm4NnA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YU5Jo/d7o+8PC3dmn4QFVX8CyAW4p9z+VKJevyqu7EmCJH2WBdb0iMoaIiNFZ6LfOihv2lFb67/eeJUprMyZrLqn8ItIOytffRUFRkx5sifoQWMb4C4t1WHosXHO//9u3UsiDGSZ+CvXrkOdo71oqyfj/a8LGc+K94mxT3oWCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yu9rbMiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712337236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPpM0wT4yWeklYwKPrb4XynteXC/5k41kP/uRm4NnA0=;
	b=Yu9rbMiM0fWU9xVZy35gWslsTjc3tjangIirICsYE0INIuDFftVA85oE1M4Y8OUE3VFULz
	9NFfTBURvaKPRv3yaUcPxWVmAb1IF0kcPlD/TbfdgPxpvG095gMeV1Sdln1gnk1WcfKNjD
	b1AMjCsSMmwYDft0cVIGWcCsFAEZoOU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-_Gfe2kXpO5qw7CRKu59QFw-1; Fri, 05 Apr 2024 13:13:49 -0400
X-MC-Unique: _Gfe2kXpO5qw7CRKu59QFw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d851a4d958so4441531fa.1
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2024 10:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337228; x=1712942028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPpM0wT4yWeklYwKPrb4XynteXC/5k41kP/uRm4NnA0=;
        b=CTb0IpNIGaVFotTREru1v/ENB04KznxYZW31KnEsWsJAV4s8q4TEN19wZt6NJNVXMl
         1WxJvf4fGBkx3D50EmRIJi0jVJi+c1nnlIvfmh6aSxFyM8hBgQidNjDaavjwAWi/S3jp
         ZaD0iB10+pGR/up+FzSRQaPwkFUdD9K43vBZUsFKOiSpBlpxOfzxwnm+wzjaQ/amSW1i
         bQcsvDabyx+SOilSNUxZuL4MIpxjdgQrbsOTkSkamGLWKCtxPyLrtso/CFBC42NDeSdh
         AWb2Sdod2BM5qKOCqIS9pQu26xLHKXykHAoEad4I1Ut3GT1FgaBJqq4Z+8kP455JkNw7
         sXWg==
X-Forwarded-Encrypted: i=1; AJvYcCUN4mWW0FsB/GLO/0/N5a+qLuLoIm8cldZgGPfpvWamwt5RnDkyRN4LHqTcOrB5+JemupsI6xAx+AQyntmefOhLNCI49yVfkywm0A==
X-Gm-Message-State: AOJu0YwdL9GDd7CR3qNCGaUQguluJv8S39T5BfN6dlbsxUqPWCl9VcQ+
	1oGGa4PRasTlLxYwkdbnD9/AYG4+IuveQvUEXLVg1ipqGLOzd6r7xITLzdPkAYhymTEkJnYcb6n
	vfz+1c0wp2GXZyq0WD9tYFeuxjawAFe42wm1omIMsAwFP1aEH+vnhDZ/0jyo=
X-Received: by 2002:a2e:8095:0:b0:2d6:c59e:37bd with SMTP id i21-20020a2e8095000000b002d6c59e37bdmr1535956ljg.3.1712337228330;
        Fri, 05 Apr 2024 10:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7mr/0zQsW+7ufXN8Cy1V8GjLrwfuTgftu9UYTsupPGSbHO+hK+Reby8puICIcwXAsNILmAA==
X-Received: by 2002:a2e:8095:0:b0:2d6:c59e:37bd with SMTP id i21-20020a2e8095000000b002d6c59e37bdmr1535935ljg.3.1712337227885;
        Fri, 05 Apr 2024 10:13:47 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:c00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b00343e085fb89sm2317448wrr.2.2024.04.05.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:13:47 -0700 (PDT)
Message-ID: <2aaca204c110d33025c3b4fd7e6f67b78d72ab59.camel@redhat.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
From: Philipp Stanner <pstanner@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
	 <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Boqun Feng <boqun.feng@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>,  linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev,  Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea
 Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David
 Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc
 Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel
 Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver
 <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,  Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Date: Fri, 05 Apr 2024 19:13:45 +0200
In-Reply-To: <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
References: 
	<CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
	 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
	 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
	 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
	 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
	 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
	 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
	 <ZgIRXL5YM2AwBD0Y@gallifrey>
	 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
	 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
	 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
	 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 12:07 -0700, Linus Torvalds wrote:
> On Wed, 27 Mar 2024 at 11:51, Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >=20
> > On Wed, Mar 27, 2024 at 09:16:09AM -0700, comex wrote:
> > > Meanwhile, Rust intentionally lacks strict aliasing.
> >=20
> > I wasn't aware of this. Given that unrestricted pointers are a real
> > impediment to compiler optimization, I thought that with Rust we
> > were
> > finally starting to nail down a concrete enough memory model to
> > tackle
> > this safely. But I guess not?
>=20
> Strict aliasing is a *horrible* mistake.
>=20
> It's not even *remotely* "tackle this safely". It's the exact
> opposite. It's completely broken.
>=20
> Anybody who thinks strict aliasing is a good idea either
>=20
> =C2=A0(a) doesn't understand what it means
>=20
> =C2=A0(b) has been brainwashed by incompetent compiler people.
>=20
> it's a horrendous crock that was introduced by people who thought it
> was too complicated to write out "restrict" keywords, and that
> thought
> that "let's break old working programs and make it harder to write
> new
> programs" was a good idea.
>=20
> Nobody should ever do it. The fact that Rust doesn't do the C strict
> aliasing is a good thing. Really.

Btw, for the interested, that's a nice article on strict aliasing:
https://blog.regehr.org/archives/1307

Dennis Ritchie, the Man Himself, back in the 1980s pushed back quite
strongly on (different?) aliasing experiments:
https://www.yodaiken.com/2021/03/19/dennis-ritchie-on-alias-analysis-in-the=
-c-programming-language-1988/


No idea why they can't just leave C alone... It's not without reason
that new languages like Zig and Hare want to freeze the language
(standard) once they are released.

P.

>=20
> I suspect you have been fooled by the name. Because "strict aliasing"
> sounds like a good thing. It sounds like "I know these strictly can't
> alias". But despite that name, it's the complete opposite of that,
> and
> means "I will ignore actual real aliasing even if it exists, because
> I
> will make aliasing decisions on entirely made-up grounds".
>=20
> Just say no to strict aliasing. Thankfully, there's an actual
> compiler
> flag for that: -fno-strict-aliasing. It should absolutely have been
> the default.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Linus
>=20


