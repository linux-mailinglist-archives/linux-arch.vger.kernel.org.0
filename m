Return-Path: <linux-arch+bounces-12324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5781AD415F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9403A1C9A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02424729A;
	Tue, 10 Jun 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLp5WiJV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9A244693;
	Tue, 10 Jun 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578317; cv=none; b=sSop+0WgtyjVar5YUBV4INfNsbkutfBG7X9onkr6C5ZFuSm12Hmfezhs84kxtFk6SCInpeYj+mZHq5xW3wKRx4C3GWovjgkcjlWbsWWw1OLS29HbOFyckM9NzozbQazT3W1Wwf/2wGHOF3YcAetzgTLzgNHBOiIKQOJrq5nNdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578317; c=relaxed/simple;
	bh=WFSJOtGCy5DLWDZOUk7n++u9oB7z1T3ZkJpFtiZCWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSxnT713gduBs/y7RerXG1TY/HoVnUaAfmvgh4228pPIg6+rYhemNhIx5mAYtfvzrSqIb0mKNQ3/aUhmqJPwgPOspTm2yzwT7LLE00moZxzcSgzQZMm/6Pd8yPpkKbzcnJDxrxd/kqyYvp9NECGt9jFmhryR4suAVMBNgPc76lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLp5WiJV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6facacf521eso61204516d6.3;
        Tue, 10 Jun 2025 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578314; x=1750183114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFKC/VZAsPOtc+J1pi0LsDxSLSLhC1cMgwlK+mG2rRo=;
        b=aLp5WiJVVZA4fAEhrJJTblPVRK3aAK/Gzv/V2Xo2XCLAr+wNVfaHxNFUuW+FRC621Q
         P+opv3ieolhaAEnLS8QQuutzV2Etz8i6pOnwMkjF3XyvJBZPJjSA3M4bKD4VSU9veP6r
         eNzMPGeWLpw+jLw16NHxAVLytTTFMRln+0c4Ub3rjrssPuU8/opI83QP/lKZjH4JpEM0
         kbOz0qmbCnH4CORTIexpwh0sHDw5tqqNLyEPqqqSnbp3cJpG8ABkkyLxdLfa5wfPQz0t
         fr8J5WBKBF1P9yAj/xtLA/x8j4t/PSK7w9pd+krFRhcxqV1+icIJkkuR5bGD2JXIl/Ro
         OluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578314; x=1750183114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFKC/VZAsPOtc+J1pi0LsDxSLSLhC1cMgwlK+mG2rRo=;
        b=ZNLFJNhC5UrV+vFNTUXDPo7zlnP3XPQcoN4CD/8yCghJiuoZhTLENiQ4XPPMT9k19L
         g2eQEtrCK4aKP1wOEcR4nAuL5HdgyDmvIeqqSMKgh/io+q0oRKedoKLa0SVb7cIGT3cB
         bpg8q8wMX048amXNhXTuNzILBXFy3RPZKC97OAjiu2eQHuIHpDxKKVSZRDt9dt5n2dPT
         10zbUmWiIFnaC3/pCO7iLcxtHyC07YbiB2zedcgcAYwn8xpg6uqUWxFCpKrJtq5O7QLN
         N4Oix2FHsMQKtSgk/9hVcfAOreYG/a8tv/BmtGUCWV3UjsOLDrULRazo6g/JSa9U+ml5
         nhkA==
X-Forwarded-Encrypted: i=1; AJvYcCUQg71USRtV7P0EK8cReWqyd3ZeVl4HgfIgv1GmCCzFM0+2RJNn/xunkVKBddSbxlXH31E2MYSQLOkC@vger.kernel.org, AJvYcCVLPpXKNIt4exQn7C//SwXbA80qJSxfi0PdUe3QlZUxaug4ZGYdjqrP1NhnAthhz6g7ffGmWyEGHPQV//yAuxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqciNXTIOSxUomKH7HznvxfY3PDA7nRBfuBmzhMn72ak7VLorF
	ufVW059K7eXjiU1tVfOznHi2vHlcHmkloV+577m4MbwfgLqRLIhsvoSk
X-Gm-Gg: ASbGncstxlxYdhBhnOTvXnfYELeBQry5YE84vlCZa3zqZk8gtzErWyxaUfTIqxMjGrn
	EAFzsuRewzLZsq1UB5VeT1L6H5h4Ow9P1zpPD9wayPNQpmEVP7f7KTxfsq7PojMrIdRZzw4+n66
	Fz1slaUvYiTtYKoFtBllMT6uCGL5RcB3HGUemxmGNn9YH/4badXriPvD62zjqIa8/zetMJE4ICK
	KzKPhhf8uvEIY2EMw4r1o4v/PJCbL7uxvUNkPCFI3y5iLzBLYcd7a/Qq2CjcpUAhKWeWt/1JAQD
	hIlJigVj/WI5YrddVPS4jyTTesx8+yNGkIIe+jDDWVCHcOQmOmaQbpmpTdPvBcoeTJZ98M+lVsp
	DVn81+cGpMiZinpfr+YPuB1nmAlZGwfBvwmHPDAIMAam55v33oedabG/xxq3jwSw=
X-Google-Smtp-Source: AGHT+IE1ZgmFQqI16FjmhRw0PUqrqN2GZWUt9lHT730+lp5RjXgeKiNOIijStPhoRxTKPLxmV0rguA==
X-Received: by 2002:a05:6214:da5:b0:6ed:df6:cdcd with SMTP id 6a1803df08f44-6fb2c36a381mr5736416d6.21.1749578314169;
        Tue, 10 Jun 2025 10:58:34 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d250f64bacsm732339885a.17.2025.06.10.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:58:33 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B85001200043;
	Tue, 10 Jun 2025 13:58:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 10 Jun 2025 13:58:32 -0400
X-ME-Sender: <xms:SHJIaPQQI9zvh93RJUdRYS_Vf2bTAbjq8qZNXTFDgJuRD98uJs_Z_g>
    <xme:SHJIaAyMD7098r8q6arLE7prWGPuyg3o8JwOsiZ-ldU3t1kHDonPDfY_cfVHoVFBn
    _fsDOzL1cs0jWFvKA>
X-ME-Received: <xmr:SHJIaE3B4fHOZePCc-g2Yrw7-QiDHFNbBGvv-I-bGQUCDsd6iQq0fMzCgTzkOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:SHJIaPDnqQ5S_PkjW9IUVx-6hgS8ecikaaPuOyyIVBlZI1yxDd31Uw>
    <xmx:SHJIaIglPRK0z-iPm-tuomEHtOTTYTAcu5T1BJgYD12YWeYHA8K60w>
    <xmx:SHJIaDrHB74s9SNhoHtO1eb10T6C-QceOugS7UP6HkfZVgW9vwkU9Q>
    <xmx:SHJIaDiBY046MUqKFF91MjbxinoZTrvFbF3VAKDI_0emvKgG4lR3gQ>
    <xmx:SHJIaLQhx354PsPkGJRoPwWfFegPMSQOF7CI-MfwHtBk8_OM1w94oe35>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 13:58:30 -0400 (EDT)
Date: Tue, 10 Jun 2025 10:58:30 -0700
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
Message-ID: <aEhyRhb71dIXzqSu@tardis.local>
References: <20250609224615.27061-1-boqun.feng@gmail.com>
 <20250609224615.27061-4-boqun.feng@gmail.com>
 <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org>
 <aEhrzxltkdnub_bR@tardis.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhrzxltkdnub_bR@tardis.local>

On Tue, Jun 10, 2025 at 10:30:55AM -0700, Boqun Feng wrote:
[...]
> > > +/// Describes the exact memory ordering of an `impl` [`All`].
> > > +pub enum OrderingDesc {
> > 
> > Why not name this `Ordering`?
> > 
> 
> I was trying to avoid having an `Ordering` enum in a `ordering` mod.
> Also I want to save the name "Ordering" for the generic type parameter
> of an atomic operation, e.g.
> 
>     pub fn xchg<Ordering: ALL>(..)
> 
> this enum is more of an internal implementation detail, and users should
> not use this enum directly, so I would like to avoid potential
> confusion.
> 
> I have played a few sealed trait tricks on my end, but seems I cannot
> achieve:
> 
> 1) `OrderingDesc` is only accessible in the atomic mod.
> 2) `All` is only impl-able in the atomic mod, while it can be used as a
> trait bound outside kernel crate.
> 
> Maybe there is a trick I'm missing?
> 

Something like this seems to work:

    pub(super) mod private {
        /// Describes the exact memory ordering of an `impl` [`All`].
        pub enum Ordering {
            /// Relaxed ordering.
            Relaxed,
            /// Acquire ordering.
            Acquire,
            /// Release ordering.
            Release,
            /// Fully-ordered.
            Full,
        }
    
        pub trait HasOrderingDesc {
            /// Describes the exact memory ordering.
            const ORDERING: Ordering;
        }
    }

    /// The trait bound for annotating operations that should support all orderings.
    pub trait All: private::HasOrderingDesc { }

    impl private::HasOrderingDesc for Relaxed {
        const ORDERING: private::Ordering = private::Ordering::Relaxed;
    }

the trick is to seal the enum and the trait together.

Regards,
Boqun

> > > +    /// Relaxed ordering.
> > > +    Relaxed,
> > > +    /// Acquire ordering.
> > > +    Acquire,
> > > +    /// Release ordering.
> > > +    Release,
> > > +    /// Fully-ordered.
> > > +    Full,
> > > +}
> > > +
> > > +/// The trait bound for annotating operations that should support all orderings.
> > > +pub trait All {
> > > +    /// Describes the exact memory ordering.
> > > +    const ORDER: OrderingDesc;
> > 
> > And then here: `ORDERING`.
> 
[..]

