Return-Path: <linux-arch+bounces-15602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABFCE8668
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 01:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F23D3010ABD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF91DFF0;
	Tue, 30 Dec 2025 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCI3Hsgw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54F3D76
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053841; cv=none; b=LbZCJX3+HMEbLnQYY9/tn2wb+2ibIvPzoRSXHJJwvDCt0x+UOM2ivQONMkc131Wu+QZyZDXIvB6Sxk0czDrjntF8md7yi3Je0CLU9eVrD+6OJfZf44E4ceQ+wzWCRfuD75+2EmKguH6pg+fAB2IKsLeU2NwX8WH2D0fITHLtlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053841; c=relaxed/simple;
	bh=/4DDN/3gIQCM0o5cnOfsf59pP8c4OuQrBPqNlv11YC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSS7/FpMKvXcCpT4DwAXl5Y/FcMuwPzQfUgY63Lhg3+P18sXA/ndX52Hpi5F7s/MkLaSCb7/8N2QzT8pZClPi2O37Myd+hbAUoaOEIXwEYkFjGF/SPb4RpYeMuWU/GeuZBc0McOya2EnAJZB8skhthW5YLWVax92351UB7wYLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCI3Hsgw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso108242721cf.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767053839; x=1767658639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3W+y9lqoOSloOorX1TW32/410l7bPpqKG/R2mp51Mg=;
        b=HCI3HsgwL28Aovk81lPv8g9iN3ToSS2bZIwHQcISLclU1BcJViC+/Iv1tf/Airkxhf
         lqxsPHheKX5+OyNll7EhfTE4NHLTNfJ+h+bnUTmIzRdhRLYwaTXcXAoUwwQDoFr1MfrK
         lGvgSZGkxS4Fi5J06eNU8GqTejhSy+01sF41Jmg4XCgsiJWaAtniNsiFIlMMXqb+nUs+
         MOYqbZejE+c3LYDoj8XTBa9ARBbvb1g6CYfUIcDouyqqh9tKGcC3Aty9CY1PXomrwBg4
         V1NIOO3t0PJkL9uXkIz2DtKpnnrFGbuxSy/xc8WNdeyvavpUUSfUWJuW5whVsp18pFa9
         KBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767053839; x=1767658639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3W+y9lqoOSloOorX1TW32/410l7bPpqKG/R2mp51Mg=;
        b=B+oeuiQLBSeuZW0IJhdUqQns/6N0tQ/Gwd0JkdwPih5adhJTdQZqUY/48Vnl+1qQ5c
         Bgo32I/Dvt/lOBJdfbfUwDgR5tiuYymAwP48ffW+Sd4UrUSc9b85v6ldCMSK9ye8byOS
         RXv7w7/QLfNdOwQpbgajBx8qg+nNsf0e5xeHh4t8FvNlcNQZXhw362s129AJ7elOYE6X
         0/sWGUbKb8Apf3lgAQcTZVYAzl/5vHIEWkpCbVMBaV5r366ecs/cY1ynX5I3ud0GiC7Y
         8l1gj0COYWNQsVisJiJRqjrox3CCIco5ormKMuZhKK8CUurXQxqU9C/QkMVwR6z7pJuR
         F6hw==
X-Forwarded-Encrypted: i=1; AJvYcCVDGjy5RB4gPUswipK+cBLx/GpkRmIq3SKuwlr/Au4MAI4U/oe5JN+pLluiK0lvqG0DwOpjiwZ3PrE9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/2YtaUDUa1vRyNF/LIyf44NIYh07Upf5l28e+6lHobCNhyUM
	glL0QdBWQDeg2CQcVZUY0d9EHYO45LrXYJfYJLQgw1c4s0i3CP9AT73k
X-Gm-Gg: AY/fxX4JSezUJDgSeJUxV3SjOZDoND+lqfDIA1RcRIRM4zK5Y+qnO60nEoCqQLMuZ6q
	9mYgiTfhuxkFseY08aVCHL+qCCjKIm8zyMuvM5NCw2nwIdpiJ06G3R2BnNYXJaZKI22Md2q6BbR
	v1yvpw8WlXBHKqOUPoDU7PF09dgxcA3QIdtOagdNuOXnTNxBaox9RKKXwbKg47G1wUy2YGdYr3D
	EWmx3OLE61uy5otaWbm9+7RDC8DsM+Br3gDlf4+KbOuJSBaOXqSzm0aILA/L+1efygb77SeIGu/
	dfJf0TFhTHiNsaACnECOBPgGreD0UNg2ZI9RSgFelbYZIBQ6doMvLOhieETn1DUFg9RXB2bCTM6
	jJzyJYX8l8DD7R48hIznQtIB7gHI4N4Mt4V19Izv9sDOHyBuVlWPu4g1HVK54g1mYxODIYqoikq
	dqDTd//nhBOAQZC+BqXRQQrutGoTyoAx6mPWWWwiy89XZsxyjf88LakMKGxyxwEtLEwLVMIaAW3
	PQcBp7VaD9zuAqhXcQjVRjnYA==
X-Google-Smtp-Source: AGHT+IGMhISQN0aQ5+CVm+O84FCUsvrfO0PjPvKQRNTJQjKuH52aETix+mqiToBhhZBeLE6evVYvUw==
X-Received: by 2002:a05:622a:588c:b0:4f3:4c48:8899 with SMTP id d75a77b69052e-4f4abd8c8damr594549821cf.46.1767053838917;
        Mon, 29 Dec 2025 16:17:18 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62e1e7sm230890441cf.21.2025.12.29.16.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 16:17:18 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B5F5CF40068;
	Mon, 29 Dec 2025 19:17:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 29 Dec 2025 19:17:17 -0500
X-ME-Sender: <xms:DRpTaTnQ761mN5xwzJrL8489UjsF9HpV4DmCtA-Ci9y3E2lhQzRwNQ>
    <xme:DRpTadV9KEz6rM8l8fJwHuWbdB9GqfEmctwG3Omud98YfwlIsmTy3mV9BPQlD1tAi
    zsWdpkbJ_-VBDsW_qx4ZRboeLKwaqdhs-VjIIxuJbXOTbZAX5_R>
X-ME-Received: <xmr:DRpTaXr8kB3qNFb2o5BKtuEJsQuTVSKltjm2KRcdtwr7MmbaWprKD2pMb6X->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepfhhujhhithgrrd
    htohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepug
    grkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:DRpTaeVns3OQ73Nz_y8_yQg9aN-xSbqKrkC4qejvX4fY5uM1e2pU8Q>
    <xmx:DRpTaYHdxEnJjX3QCncUtxy0rWhW-RkoAQMuBNVMv8522sdndVnokQ>
    <xmx:DRpTaVAphvbcwSZvHF_9VtCY9lvHO8m61P5wDZjfjPH8BQxWHaeRlQ>
    <xmx:DRpTaazEdL2lupbLvEGak9BkmFajKU0vB3IxTRuu-xz0HLKV6DhZcg>
    <xmx:DRpTabeMejqKaYx16bshlGrfNpLjDUZh0yehbCoWaGyKDvVgjhx8jav7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 19:17:16 -0500 (EST)
Date: Tue, 30 Dec 2025 08:17:13 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, ojeda@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, lossin@kernel.org,
	tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: sync: atomic: Prepare AtomicOps macros for
 i8/i16 support
Message-ID: <aVMaCTO1zOAHU6fR@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
 <20251228120546.1602275-2-fujita.tomonori@gmail.com>
 <aVJiR72gcz_uonoS@tardis-2.local>
 <20251229163616.732caffb.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229163616.732caffb.gary@garyguo.net>

On Mon, Dec 29, 2025 at 04:36:16PM +0000, Gary Guo wrote:
> On Mon, 29 Dec 2025 19:13:11 +0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sun, Dec 28, 2025 at 09:05:44PM +0900, FUJITA Tomonori wrote:
> > > Rework the internal AtomicOps macro plumbing to generate per-type
> > > implementations from a mapping list.
> > > 
> > > Capture the trait definition once and reuse it for both declaration
> > > and per-type impl expansion to reduce duplication and keep future
> > > extensions simple.
> > > 
> > > This is a preparatory refactor for enabling i8/i16 atomics cleanly.
> > > 
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>  
> > 
> > Thanks! I have an idea that uses proc-macro to generate the Atomic*Ops
> > impls, e.g.
> > 
> >     #[atomic_ops(i8, i16, i32, i64)]
> >     pub trait AtomicBasicOps {
> >         #[variant(acquire)]
> >         fn read(a: &AtomicRepr<Self>) -> Self {
> > 	    unsafe { binding_call!(a.as_ptr().cast()) }
> > 	}
> >     }
> 
> Unless the proc macro is generally applicable to a wide range of subsystem
> abstractions, I would still prefer to use declarative macros.
> 

But the tt-muncher style is quite challenging for a boarder audience to
understand and change (if necessary) the declarative macros. IMO, if we
can have mod-specific proc macros (i.e. macros that are only usable in
atomic mod) then it should be fine. Thoughts?

Regards,
Boqun

> Best,
> Gary
> 
> > 
> > But I think the current solution in your patch suffices as a temporary
> > solution at least.
> > 
> > Regards,
> > Boqun

