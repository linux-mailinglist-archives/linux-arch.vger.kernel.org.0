Return-Path: <linux-arch+bounces-12514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46699AEE20C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E3C3A51B0
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA828DB71;
	Mon, 30 Jun 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVwxPjZ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C828DB5D;
	Mon, 30 Jun 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296368; cv=none; b=mxrIcfvEDQ1/zRUNAfvIh1l3q0UQ+cYRmRHL6h5cLQtSlr7DxTMk95z4sdUZJ5iBleUu/w/jsvP+1MXJ1RPDXKJSqBRAmP+Xuyl5TZCfvl7GM5cMNWB8ytfjvNjF7pz6A3pwBehPRAg7BV69CDV2M3Z2llwcedTVrUkmEzhQP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296368; c=relaxed/simple;
	bh=DRVwtCNqcIY5zcQdsRZsM0qpmQoaT3TR9n/N8B5xSRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eppKtk7nmBBABkd9woBjFQOwQXiC+BqtlcdNNZgP0Z/SZxqbQ2pb1ph6U4uO+26iAKUHI7QSy/l/1vRSsFIWpyyVYdaTjSOcMWwXLP1VtNLyW49VKIJM7RJ0yGEUW7lTJLR//TCawXDgQQorVN7m455/g5D04mSw9KK4E/Vz4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVwxPjZ9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a58ebece05so24288471cf.1;
        Mon, 30 Jun 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296365; x=1751901165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaOLegHrcn1eXx3UWYOL64GB4OGC7u3vLrNV/6rSYsM=;
        b=eVwxPjZ9/H3RfrVRRkJRfsT1BWq3gi3DqAxIGLzt8Z13zSOmIcinQ3CrkJz7V1z7LD
         ABbxccXKPm1juCVEhkmR6KsYBANFbFCh+9L5liaVSOibKM46BD9Km1TbUqDju6ohwKzX
         kkt+LhqiAjb8XgOWSp1iFUassBcHxvOGvluCsRPzq+xZEjE25XWXpiM2SGJoeqOm2emh
         z8Uwqu+ILWDknLdodvB0pQGXx/vMQ3dyl7626tUBhcdU7jnZUwsHAI6Oqub6IrPe+2m7
         EF8EkE1mirxkqdQ++dIyXWkwOCsMcXbB50IT9S5rca2r61aG4qna5ud4BaskAw3J5yNa
         YuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296365; x=1751901165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaOLegHrcn1eXx3UWYOL64GB4OGC7u3vLrNV/6rSYsM=;
        b=XLd+WmV8PyFMq4w0tl/k/7R+rpxtoaU+nlZEiUBt71YMDhsbLS2zAfxIhkckiurquo
         CcS7uTvAaucDGSYXDlL+XevmKnN9PuGPbehrZW5sYofHPzJPpn/Jpmaa9PBORBjEHoAa
         aNMk6GxPXLoDwkWXTSrmq3g49aqo3CufsmfBhyW8cbxiz/NW5TcQuos7jDnflGDWi27R
         nm7T34YQjKUszLICKaztJLUNcTrznB6I83hsBlc1Mqmv5dMV14eNC1Ha5hVatAGuj3y2
         wwyQgZ5o5dDGiOjV28ILx2mIZQZzww7TsmMv8g3fpw4re645RNpFttn3nhPJ0Ai6G59b
         MP/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+L1H3def5pd5e+L+rTolUytV7GPFmURd9CKSHbqdhsdDoNcp3ntK1VqZV8zjVZsQzqO+Njof7MHxBd78p+/Y=@vger.kernel.org, AJvYcCVs87Xr3rotEfLEL9+9SuFmJpa47dZ5XnRPshOuWVT09HDo7s5im795N6jKjknpOfTrYfjHgZwCZhJh@vger.kernel.org, AJvYcCXDVQikoy+YOHlSd3A6kl395Au04e4b98aMuOs5+9L+GytrZCaUiyJu13dUQR25Ny0TJVbyEHD2pKUzAGej@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5LBFhXfeAx8Ru0f/FlQtvet1iRtkE8qt5QGwSWz/iFvYFsnG
	UJaOzC10/+uJxmdw9LIlr3Lit3jfdhQdCLTMoeIqprsQKpObfYT+ZgiT
X-Gm-Gg: ASbGncu/VeghezMAPvo8pp+Jik0A4Jt8cHe0rWXrB95qIFGJd17ePuNmu6dUguzjghh
	m9V2u0Qgy5WvuOQKdHjDyipaNkfqsrrTvPl6T6gk2dPnbeJUx546bjsXmhiR+c0g4wKEGlZ2wRr
	6TPXlc9VcILTH+jn9CiJvcFlKzGSu2t2qnFQ+O3WJMz7adIsLgf/eWhK/9R99cbXArluW5C+ZEv
	7iVTLyLatsn1nc4N3ROzZrEz2173rfkWBF8ZBFfPL6wdRides/cw3pgEohu49Q7Px5YihiOJnMH
	dKnLFWP5zo0gcMFXpzz/+PHK6uDuVAqFin6/hjxRWQYJUb7GcNRqVSz+MCOaG2MwI+wGY2gdksC
	LKoMoQG/ojwNZmX5EK3hlC6zZA1bUaPtRP982HiAFOx2mYVopbqqR
X-Google-Smtp-Source: AGHT+IF4/b5ksWqDbDU0roRQ3BW5PvN7+2E2foS0GiY85GNlwFSrjehK8SMdetGdO5NFItvx9tP16g==
X-Received: by 2002:a05:622a:111:b0:4a4:3a4e:b77c with SMTP id d75a77b69052e-4a7fca0781emr217381661cf.17.1751296365175;
        Mon, 30 Jun 2025 08:12:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc5ad3c6sm59909241cf.78.2025.06.30.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:12:44 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C0151F4006A;
	Mon, 30 Jun 2025 11:12:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Jun 2025 11:12:43 -0400
X-ME-Sender: <xms:a6liaCOZK0Si2jNcqBsGnZs4J7g8DBX0ow6zTnK5qXW200lQPDNtyw>
    <xme:a6liaA_CXwBuK-Nug70W4vQUX8e8-uTfYYsPJbWIAW7hTVHdcwOrvB5B1iw12OeRU
    S5JM8eOgrgjN45Y0Q>
X-ME-Received: <xmr:a6liaJRyUxCTXh69iIvE08a1VbmysNaO6wW369ymQqmF4WM6W8TwbOm5segJAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtth
    hopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrg
    hrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:a6liaCstzCm5svvpiZfFQnFbON1YbLLhalgqr0R6u8I70KyUsXGyyg>
    <xmx:a6liaKeha2bPZbpRi-DoW4zn5bEeQScHW3BFeBDQFGAvvnMxVMWL2w>
    <xmx:a6liaG166qeo-ic7TvaQy-l2VY6GImnCXSeANjKNxxO-g7eCodqcWQ>
    <xmx:a6liaO-f7f0nkKNV8d6cyc9FDNIe8xjoosmrGuo2FRTej7O7Nr1LHg>
    <xmx:a6liaJ-f4la_XrC1RYPUt7iwkqVkpGecQhrcEAcOPLSLY-egrFsKZWHg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 11:12:42 -0400 (EDT)
Date: Mon, 30 Jun 2025 08:12:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aGKpaoZt5Ab2a7Zj@tardis.local>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <jBAtISwM9LKkR7KuCHEnym75NfGOM4z408pMuDfk4U8VzN8PQuk9JJfBc33Usre3YSjbgtFRj8c0ZNeeQMpZsA==@protonmail.internalid>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <87a55uzlxv.fsf@kernel.org>
 <_pLa3zqu-AHBOnxkEz7l13l9W-OsKBtuXIkjRsIJJy6EnYTrM99E8Yr24pzjqwCAj1_qs_PI-cVxRsBsbgiFdA==@protonmail.internalid>
 <aF9bmpX-i6HVMlaj@Mac.home>
 <878ql9zg90.fsf@kernel.org>
 <1cf36f94-7e70-48eb-a79f-ebde218cd716@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf36f94-7e70-48eb-a79f-ebde218cd716@rowland.harvard.edu>

On Mon, Jun 30, 2025 at 10:51:00AM -0400, Alan Stern wrote:
> On Mon, Jun 30, 2025 at 12:16:27PM +0200, Andreas Hindborg wrote:
> > "Boqun Feng" <boqun.feng@gmail.com> writes:
> > > in atomic/ordering.rs, I think I can extend it to:
> > >
> > > //! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
> > > //!   following memory accesses, and if there is a store part, it has Relaxed ordering.
> > > //! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
> > > //!   the annotated operation, and if there is load part, it has Relaxed ordering
> > >
> > > This aligns with what we usually describe things in tool/memory-model/.
> > 
> > Cool. When you start to go into details of ordering concepts, I feel

Well, avoiding going too much into the details is what I wanted for
those documentation comments ;-)

> > like something is missing though. For example for this sentence:
> > 
> >   [`Release`] provides ordering between all the preceding memory
> >   accesses and the store part of the annotated operation.
> > 
> > I guess this provided ordering is only guaranteed to be observable for
> > threads that read the same location with `Acquire` or stronger ordering?
> > 
> > If we start expanding on the orderings, rather than deferring to LKMM,
> > we should include this info.

I'm not sure I follow you on this one. I'm not trying to expand on
orderings, instead I'm trying to resolve your feedback that my previous
version didn't mention what ordering the unspecific part of a
read-modify-write has (like the store part of an Acquire and load part
of the Release). And to me, they are naturally just Relaxed, but I feel
that given the feedback I got from you, maybe I should explicitly
mention they are Relaxed.

It's simply just making things more explicit and I'm still deferring to
LKMM about the exact meaning of the ordering.

> 
> The problem with the word "ordering" is that it is too general, not 
> specific enough.  You need more context to know exactly what the 
> ordering means.
> 
> For example, ordering store A against store B (which comes later in the 
> code) could mean that the CPU executes A before it executes B.  Or it 
> could mean that a different CPU will see the data from A before it sees 
> the data from B.
> 
> A more explicit description would be helpful.
> 

Except that the explicit description should be in tools/memory-model/
instead of the comments of a function or the Rust atomic module. Like
Documentation/atomic_t.txt vs
tools/memory-model/Documentation/explanation.txt. Because one is for
people to get a quick idea about what these annotations/suffixes mean,
and the other is the more elaborate on their precise meaning. Most of
the cases, people won't need to get the subtilly of the memory model to
write correct code.

Regards,
Boqun

> Alan Stern

