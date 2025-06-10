Return-Path: <linux-arch+bounces-12326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88758AD4248
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334BA189FCC9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E224EF8C;
	Tue, 10 Jun 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjQevYMj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047424E4A8;
	Tue, 10 Jun 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581602; cv=none; b=PJYSWA385pQxStD2rXboJQMjEmdHRx1jhhhfxo58EKbEGVo36nJfwOIFbftRb30LXqOTYLrwzrtK5kIy0dafEMb0kmzGbgdgQLfhUxgf+vamtcFbt//wYIFjUmowfOmzEJsMk0iJwve5a4NcDI5qDh8vIOEU2NareMibBamS/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581602; c=relaxed/simple;
	bh=2sYXZ0RhTfN6SLKrFXrz5MrrSIww26BY2I8L1m2I4bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD3pzm4KJfDdL5yF0wmlsmBZvYJxbaP9p9kPC0oXkzNaxN3bT2iy/UxPE09x1oD3d/1NRC9gB89Tn6SeUJCsO6TbrMP0XNzg1r9swbBJmnmoUMt9gqyiwFm5nJbHSHPaAK9759y5fH54qvEWk3ZjFXaSgrP9flKCw7pMYYZmRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjQevYMj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0ad744811so41436326d6.1;
        Tue, 10 Jun 2025 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749581599; x=1750186399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W4Rd5KefmDkCudiFgqafP7/SrHNUHS7n6T+k5okKnc=;
        b=gjQevYMjz3hgUSxx4VLnI9TIWwZNBxR5cWL67lGbUnDWwdeq/vJmXk5nlxpCIUyEu9
         b5gt7eif14rbho1zKsU3tA7kNoru3s+qoutPDUqGJhUykJbYp3vCTbRfY6eOccsM0fum
         I3bEwT4ZHQreibiLQN1SuT3BvBXQxlq1sMxfBf5KAlNlIYnDsMfKhRZqZtgdlWz2/kW6
         Isb5gNPaWuC7/+Sfreb/tR5DRYwyeFeKl2rajsa1wcD5zpQSdSttIHB/11iUyvX8gLNj
         2IXfjax9tsl22g7G0DCNY/pgNxQPBFK2WJDR2NI0cpfAkp9dCsNVAFjEDPCtzAZsilLn
         nrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749581599; x=1750186399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W4Rd5KefmDkCudiFgqafP7/SrHNUHS7n6T+k5okKnc=;
        b=xE3SeObNuALi3bhuOtO104anaxTaXm1KUrD/6OjYHmwdOL3UZx0//Y7CQUlnXi6N7C
         KkRw9iNypvj5frJ5GgSYxbtufxrVNfEcthpJ3C4xmbiwYcd0ulf/BAVjlZscs/FbXe+K
         gVcU9P4WPU0h0lHbNQd4IHR/SuwJhYHuH9OqvEvagdMgrhdhUKujmJDIyRCNedH2JR7E
         KRR9x83p5uXoo9H0y/mg2PQSENNGks+tmJc9oAcLLB9RGRjYRsy4Be8yqswMm2CBxqPk
         6jRHblcW/5gtG6oC8NOcTdABQYUYWfveLJFysYfFsm46qJv7zz+4lxDWdLEz2HoEZqEv
         h6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUTRNB2aDix055lDKvUxh23fkJQyNbJhlnZkvWcMGVpTFJV7WIJGWmgFjz7tjJ0VI939XFyNdxDGSwQ@vger.kernel.org, AJvYcCUy839pm9Dcl3piGbRU2ds22pteYGfcIlunFK2prUrgHzNTGcTHFPcyU/cceYHtA8XZlD6v2q/aWJNL4bOhV10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34Mz1nF/mGIae8JAT4AJaxYPm/a9A4tqu6Yf3IpPC+9l1E7j5
	rvi3xaVsHo0cEtHc6HpOjsjWESdwWbcpW0V3qYBAxpYa74A2mnUdemjF
X-Gm-Gg: ASbGncvwefy2Uw1R9My5dojZbd6sp6TkLpvylfQGDktkvEdCe4mygqmWw5v23oFnqWH
	lVqyfIlQ5qk1JeqHMy+EEr1tRbVm83UtPewtznU8/0oHpSNQZJLVfNUyqhMjW/6IA3r8Vg6E/Xm
	7jx8Uq+dO+7Cur1QKWCntLeGYLU8SCuNF5DPelfXaUuvyY7rUTipn3uD9AHwoLxFuu7XCOSYsDH
	MrhnJ1ZjkLAfoZ+uf5ddU21w3hFbkHxSYS7RTN4MQWWPZB9QEYIiDdeM+uomES5QOCa2CNAqK2M
	Ojka8B2eTulZY46eA6L4LxkCXwORdoiMNFSTiTJ6gWvJin+DkoMEQCBp7VIGZeIvvdvGfnjyyqj
	GDI/GdQKYUs+G+CA5wV9mJtN+FWclJ9MyZ1QA+fyv6jkh0nwbyi4s
X-Google-Smtp-Source: AGHT+IGsLUS3refGq1Aq3PCXL9ovqUJvkRe1R09gDL09foqsyUwG3LBkaN8kqM1V9gKlR8s3k/sTCQ==
X-Received: by 2002:a05:6214:b6c:b0:6fa:facf:7b7a with SMTP id 6a1803df08f44-6fb2c38f50fmr8109866d6.42.1749581599368;
        Tue, 10 Jun 2025 11:53:19 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1ce43sm70288386d6.76.2025.06.10.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:53:19 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 311CC1200043;
	Tue, 10 Jun 2025 14:53:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 14:53:18 -0400
X-ME-Sender: <xms:Hn9IaMlf85k4pFlo_VYlAY_4sw5ROkg9KoPHN32aNpVWj1ZUIQNe6Q>
    <xme:Hn9IaL168BcNnsJ_72SBD7QyVzApEbicmYXCQwaIbn6L5ShSgwn4PTY-s-8qZ8V1v
    AUnNQP3X99op7N-3A>
X-ME-Received: <xmr:Hn9IaKpoRkM7YXAXR6o43uIZRd1eSl6CA6QjV2EmN1Xk3mHkB5W7tTOMMfvFDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgr
    hihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhord
    hnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Hn9IaIm4nhS9sZ5zcKYViVozQGHMpMBk6D14nRjPuARb8VIxeBHZcQ>
    <xmx:Hn9IaK1s74nE5ZxtjnS-LdtmtEacS4sL2a42_40WZNdR8HH6yUXx8w>
    <xmx:Hn9IaPtP94zItOp6ajpj3ELDTm-2mp8ODzHEaRwW6zyNU2joKFXjGQ>
    <xmx:Hn9IaGUhKg87272SdHQxfN8wIOgUpPXx_JwSvOuZMljYXHGa3M3wmQ>
    <xmx:Hn9IaN3CvbaGFAy9h2firCIOZAr4WeWhwcdqesmQ3h3p5tJoeH3aiwrB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 14:53:17 -0400 (EDT)
Date: Tue, 10 Jun 2025 11:53:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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
Subject: Re: [PATCH v4 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aEh_HEwSh2w0Ajkq@tardis.local>
References: <20250609224615.27061-1-boqun.feng@gmail.com>
 <20250609224615.27061-4-boqun.feng@gmail.com>
 <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org>
 <aEhrzxltkdnub_bR@tardis.local>
 <aEhyRhb71dIXzqSu@tardis.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhyRhb71dIXzqSu@tardis.local>

On Tue, Jun 10, 2025 at 10:58:30AM -0700, Boqun Feng wrote:
> On Tue, Jun 10, 2025 at 10:30:55AM -0700, Boqun Feng wrote:
> [...]
> > > > +/// Describes the exact memory ordering of an `impl` [`All`].
> > > > +pub enum OrderingDesc {
> > > 
> > > Why not name this `Ordering`?
> > > 
> > 
> > I was trying to avoid having an `Ordering` enum in a `ordering` mod.
> > Also I want to save the name "Ordering" for the generic type parameter
> > of an atomic operation, e.g.
> > 
> >     pub fn xchg<Ordering: ALL>(..)
> > 
> > this enum is more of an internal implementation detail, and users should
> > not use this enum directly, so I would like to avoid potential
> > confusion.
> > 
> > I have played a few sealed trait tricks on my end, but seems I cannot
> > achieve:
> > 
> > 1) `OrderingDesc` is only accessible in the atomic mod.
> > 2) `All` is only impl-able in the atomic mod, while it can be used as a
> > trait bound outside kernel crate.
> > 
> > Maybe there is a trick I'm missing?
> > 
> 
> Something like this seems to work:
> 
>     pub(super) mod private {
>         /// Describes the exact memory ordering of an `impl` [`All`].
>         pub enum Ordering {
>             /// Relaxed ordering.
>             Relaxed,
>             /// Acquire ordering.
>             Acquire,
>             /// Release ordering.
>             Release,
>             /// Fully-ordered.
>             Full,
>         }
>     
>         pub trait HasOrderingDesc {
>             /// Describes the exact memory ordering.
>             const ORDERING: Ordering;
>         }
>     }
> 
>     /// The trait bound for annotating operations that should support all orderings.
>     pub trait All: private::HasOrderingDesc { }
> 
>     impl private::HasOrderingDesc for Relaxed {
>         const ORDERING: private::Ordering = private::Ordering::Relaxed;
>     }
> 
> the trick is to seal the enum and the trait together.
> 
> Regards,
> Boqun
> 
> > > > +    /// Relaxed ordering.
> > > > +    Relaxed,
> > > > +    /// Acquire ordering.
> > > > +    Acquire,
> > > > +    /// Release ordering.
> > > > +    Release,
> > > > +    /// Fully-ordered.
> > > > +    Full,
> > > > +}
> > > > +
> > > > +/// The trait bound for annotating operations that should support all orderings.
> > > > +pub trait All {
> > > > +    /// Describes the exact memory ordering.
> > > > +    const ORDER: OrderingDesc;
> > > 
> > > And then here: `ORDERING`.
> > 

After a second thought, the following is probably what I will go for:

    /// The annotation type for relaxed memory ordering.
    pub struct Relaxed;
    
    /// The annotation type for acquire memory ordering.
    pub struct Acquire;
    
    /// The annotation type for release memory ordering.
    pub struct Release;
    
    /// The annotation type for fully-order memory ordering.
    pub struct Full;

    /// Describes the exact memory ordering.
    pub enum OrderingType {
        /// Relaxed ordering.
        Relaxed,
        /// Acquire ordering.
        Acquire,
        /// Release ordering.
        Release,
        /// Fully-ordered.
        Full,
    }
    
    mod internal {
        /// Unit types for ordering annotation.
        ///
        /// Sealed trait, can be only implemented inside atomic mod.
        pub trait OrderingUnit {
            /// Describes the exact memory ordering.
            const TYPE: super::OrderingType;
        }
    }
    
    impl internal::OrderingUnit for Relaxed {
        const TYPE: OrderingType = OrderingType::Relaxed;
    }
    
    impl internal::OrderingUnit for Acquire {
        const TYPE: OrderingType = OrderingType::Acquire;
    }
    
    impl internal::OrderingUnit for Release {
        const TYPE: OrderingType = OrderingType::Release;
    }
    
    impl internal::OrderingUnit for Full {
        const TYPE: OrderingType = OrderingType::Full;
    }

That is:

1) Rename "OrderingDesc" into "OrderingType", and make it public.
2) Provide a sealed trait (`OrderingUnit`) for all the unit types
   that describe ordering.
3) Instead of "ORDER" or "ORDERING", name the enum constant "TYPE".


An example shows why is probably an xchg() implementation, if I was to
follow the previous naming suggestion, it will be:

    match Ordering::ORDERING {
        <some mode path>::Ordering::Relaxed => atomic_xchg_relaxed(...),
	...
    }

with the current one, it will be:

    match Ordering::TYPE {
        // assume we "use ordering::OrderingType"
        OrderingType::Relaxed => atomic_xchg_relaxed(...),
	...
    }

I think this version is much better.

Regards,
Boqun

> [..]

