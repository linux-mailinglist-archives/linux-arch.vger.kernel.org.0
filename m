Return-Path: <linux-arch+bounces-12732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C72B0378F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DE13B923C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D822F772;
	Mon, 14 Jul 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O26Gplp8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B422F74B;
	Mon, 14 Jul 2025 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476943; cv=none; b=ZE99s5xEvW9sNQXOG+wiW9zw2QRhZgUERuXvcQQRMMbQrp1EgkjdmwLxDK2Gc2aT8hakcvm2NIcSl7gcx4frWNZhQBSoCuILe6U46TPOJzh95/AIyo3Qo38Lusvlpo0XOdMUy/uaCC9hmn7eBTSgyHKo1RIpb1mImbsx+jfc1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476943; c=relaxed/simple;
	bh=x//8q92R3nOcCNECS4nY8PWQLzPPAa1uQNquSm3Vvmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL+RVJFRnmxx491W61DMbJFd/z6WcSzvy4+4qBUL/DdoWk6lbkUlaciaxtF0K9ZEWSfMxYDS+PPuHsxmSk9GQQQRE9PKeBEfyn7PhvuMsdIGa2HSYXo1wFBorL/oqq1BckaorSNMw79dpHcKQPEvFZHOVyajl36Y1nCm0IwDiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O26Gplp8; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faf66905baso52001796d6.2;
        Mon, 14 Jul 2025 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752476941; x=1753081741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkJDkHbnoquXDlGKTmb4rIJk6It3tSzSiHWA/GDYj/Y=;
        b=O26Gplp882r+Mge5FHjOUJXLLIq9f8LI/YQjTWNEkhs+5er2QJzJZEGSAn01+lfiIB
         RqgHU6d8qnDMBQj3EF8Lcpl01Y5YbeubQPk4P1oKweprkEZw+5ihlk67372hoTRW3Qr7
         jZR1rH8oT/rUWr1ef2DO8BYgCZpaSGLxevF+i9VdA3ZwdyN68pAhcSC1iS4IXXL5afgO
         P36TlFoENZKfiC8Gtm2iJbl52q3HGRDhndQQrTTG7Jiz0XbcglOvVfj0hGMUzC83ciPt
         tVtfNaZEzIcsMYIFXj+geVzsYeuq77+BYGymKhuBIjF11j39ANVFLv/gIXM1QknEJauz
         Z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476941; x=1753081741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkJDkHbnoquXDlGKTmb4rIJk6It3tSzSiHWA/GDYj/Y=;
        b=JZw3j9mDwUPNjYegqK3QmFPtUXLmsK8ewAZ+6lLRgo2pUN1c71ShMSpuk2FXm4Xhh2
         ygb38GYi4Ay5hea15V60F0sFkB++TrWAQjytEHe1zKMrAESVmiFTF6UjA2JksrwHCQj8
         86cGzd0YFsYbi6JTibVT68Ab1LPa74QKMIyxc5xzezW09B+s5SWRF0AU5K63FYUb+708
         jyGfVMw78a2a3GA3xSA+GzaFKT/3KOq9uQSLvPV1qdgmAdMnj6l+sFxNTRAbwlgCcF1Z
         Uj0YH6FkNvHRgUVCU/V7XLnQfbi2+0eHbWdsFnaP9m500lahD8lc6o+AHJt9TJ/D8Zdm
         HdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEeMVS3gX7LfZDtizOmD07EK6zbY0209jBUIOi/NTYZhlb3DMLq0sTyrKotgTuth1crduvw/HUKypo@vger.kernel.org, AJvYcCWLbByCsqI63gW4/4vP/0HN4XLxwv4ZEFP/a6JqkQM8GUE1S8QjhbsFFsOP3xIyD0XBZqZkZ1wzA3M32hlxhiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZaYSMpqb6ipuaIAUmHzyPMR8GLqhST9vvd392QrurBiFYPSP
	Vkq3vpbFeuFkUSyocvwH9lMsTJXevrwsbbZ1efseJhKYzv1dFwToYp20
X-Gm-Gg: ASbGncs19w+27Glicu911h3PgVtMk6QH9goV6LBUtQptKbX96Se0or7VJcp/I6Z8Kib
	OYW6mH/bbh1e4DrygBal442UjFExkucQEtYYLdvZlckr0uQQX/8Pz1zQ3vPJySQtTXZmmTkO4n0
	SuxkeeNNr+l3BIb7oU33ZIaNClo/QCpV7FFrVVyV5mv3fy++GsP+hmCj2fv36kWtJVeuFbNNBLJ
	EIyvNiJpsa+l0rcgAKB8GFB8oFFRwRIItyr/ZY8kDRTFMy+/nxAOl5AcW8Vuv9tK3knf9cpDBBP
	vtOwqTOxo9jsFXlEI1CCEgCDduyv63ABqpohZKdKbspo8tsrmyTWS2VubRSy9npPm1xEaEAIUl0
	0jZN8mrpygT6SA1QVZeC7LOfjr88tFEHROV1ivjh6kDHEdQ8kaarsQnKXB0E1nutXq6/VEV6nx1
	iHb52fPwb72nBoED0sTjasjeg=
X-Google-Smtp-Source: AGHT+IGGt9c3g5ocSLs6ER6i4TSNQnR8605ekObL+FAV6dt9sSig0LCnZAjmkbZHXYQxcEO+mDqvhA==
X-Received: by 2002:a05:6214:230c:b0:702:da0c:61d with SMTP id 6a1803df08f44-704a421dab2mr226258786d6.25.1752476940718;
        Mon, 14 Jul 2025 00:09:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e459csm44240566d6.49.2025.07.14.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:09:00 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 957D0F40068;
	Mon, 14 Jul 2025 03:08:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 03:08:59 -0400
X-ME-Sender: <xms:C610aNvXitwiN8QyoM5oDmoifC0DBJ_FU4jl7zzEELX4Fc59Ekce6g>
    <xme:C610aH8TwtYcUtsRYeUiQniPa7ypuMd1ALJqxA_saUFwCcCwpUoF2wE-4-npSmdRd
    Y7ViYpF1eGRQz_Mkg>
X-ME-Received: <xmr:C610aFXGSS3mMQ7oSh3AKxX74A7HlDLtCjK7bm4paEphKDEVP5zUFiLhww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:C610aDt658Cbv0cR0jGgDKcoZRdZw95fvS-PaXJw7hb4S80IYIKLfA>
    <xmx:C610aL9ku6p9ppgesOwtUD7NUtTsu2zTp7uR6PaZvz39VT-kncR_AA>
    <xmx:C610aM2VBRrSJswqPKRyjqMk4GbH9lfWKJta7065cscYxhDtF6MebQ>
    <xmx:C610aAQApEeuoftoqhPSQGNL1Xc4aXhXbhGCyGBCyKuW28mhnKBkQA>
    <xmx:C610aPB6NVJN0R6x5AujjMKg0bw9cAsLXrTvSHmhfbuNCaCjC6bpscYl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 03:08:58 -0400 (EDT)
Date: Mon, 14 Jul 2025 00:08:57 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHStCX_pxoGog8RF@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
 <aHEYkg5K7koUohRo@Mac.home>
 <DB9FY5IYEKIH.3KRD160QZ8C54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9FY5IYEKIH.3KRD160QZ8C54@kernel.org>

On Fri, Jul 11, 2025 at 08:35:25PM +0200, Benno Lossin wrote:
[..]
> >> > +///
> >> > +/// # Guarantees
> >> > +///
> >> > +/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race,
> >> > +/// this is guaranteed by the safety requirement of [`Self::from_ptr()`] and the extra safety
> >> > +/// requirement of the usage on pointers returned by [`Self::as_ptr()`].
> >> 
> >> I'd rather think we turn this into an invariant that says any operations
> >> on `self.0` through a shared reference is atomic.
> >> 
[...]
> > [...]
> >> > +        let a = self.as_ptr().cast::<T::Repr>();
> >> > +
> >> > +        // SAFETY:
> >> > +        // - For calling the atomic_read*() function:
> >> > +        //   - `a` is a valid pointer for the function per the CAST justification above.
> >> > +        //   - Per the type guarantees, the following atomic operation won't cause data races.
> >> 
> >> Which type guarantees? `Self`?
> >> 
> >
> > The above "# Guarantees" of `Atomic<T>`, but yeah I think it should be
> > "# Invariants".
> 
> Yeah and if we use invariants/guarantees always mention the type that
> they are of and don't assume the reader will "know" :)
> 

Just FYI, I ended dropping the "# Invariants" (or Guarantees) of
`Atomic<T>` because I don't need them any more. Instead I add a
guarantee for Atoimc::as_ptr(): always returns a properly aligned
pointer, which I actually need for calling C functions.

Regards,
Boqun

> ---
> Cheers,
> Benno

