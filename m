Return-Path: <linux-arch+bounces-12740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98EAB04085
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35596188B8B5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F733253954;
	Mon, 14 Jul 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRuGEXCH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D79246BB9;
	Mon, 14 Jul 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500849; cv=none; b=LxajiXPtMRLO0F/+bHv7Iaxebkv6sbXWkTeFQTu5YDUd8bcPcYux/VBmDT5NdZYsp6G0PQAIH+aAQjzWrr0fCdKXjOEe47Bufn8Unq1nIeN5G0Xhk0rIHo9syK1RMJhZnff9SfTT3uEhkddvwsGJgPSjz4AwDcmWa2lCfSx3V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500849; c=relaxed/simple;
	bh=Olq+q1hlsZvSCxl6oX0NqRMgS/hv5fLjRTZshMpP0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCH2TMeo3fhb26LcmsZk6tdaIV2+FIuB4qDDsG7HsH+0enYRol1fdRsd2EBr8VIan/vUuDqeNvNmBoX6iI/QDFKpp0Mf88bsM3aN5AXib/WwhLBuVZYibo3jRJU2gDcYYE+0btcgPp0M5U+BLTrsgqmK3IILOCfaFAmlqZjCWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRuGEXCH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fafdd322d3so37343496d6.3;
        Mon, 14 Jul 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752500847; x=1753105647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3j4m+MGxK9NH+sARTNaIEHxLP5Gbuav9zslDuXdpPU=;
        b=YRuGEXCHSVY0cN1zRpuodE5iDs13FEHwL0UVv6KTtKJVxbY9OgggOwxEbD1NnLtg2c
         beJP5NEElugcffC+40z0ctiNLyQpRwYVjbIfiYz5h+C+EyOJLGK9u4s2hO9T3ojFWWqR
         C20G/8W4toiC09C5aDNQk+QGu/i/Zcz2+R5jUvxE9WRPgCtJbcWROS0jeXa3k6WG48DI
         Pt5M69BEPQgZd/TusrF+GN8A94LpmtT+dCwzyKk0gxuaP7vjM0krEkuOfxwRa9Lhv6ce
         zEvgfptZ0n8RPCfSUsb48jtu8HKHCcisn6it9ZPrjFxki3Yw40nMt1us6jHLWdG60Ohf
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500847; x=1753105647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3j4m+MGxK9NH+sARTNaIEHxLP5Gbuav9zslDuXdpPU=;
        b=f1J2Hr+ETok8gugIHDvXkitnogoFeNElWJBXmvc3sVi+MRLck7/3VYiZTIyhaNIN5o
         zwJYNL5wEzMlouUwu7GD9V1nXFc/dgnTzrAt+SQGkQwnsiwUl9tQbJGJ3QpYPsakedGA
         s4jx0W8bLhlBADr7L56IlaBAR6TvevZSZweWssbuyCYjLV7tiUoGr/G7CHepXejnPK5D
         EmNWXlEmpDl9mW/Gq4qn37vbmBGSzVvkrssImIi3fAE2musjU/GjUM2ULzOBcK7IXNVa
         BrHZUq4jFwPI+kkGerWFCOV/7QzrUtklD6Vwsp8EnDQmtR6bxQpyONynadLigiMBZbtc
         AEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4w6lKQ0vKvE0+Fh+bgChOjj10N8g9J68jw/SDK4+TMXhKakaSacC5Qz5WEu1S3NRdSBgacgMmMwss@vger.kernel.org, AJvYcCXQ8jgtqFpoekiKZMXOJnPjodstp2cACvhz6jMBnYr0v+iFj6R7JQgmjjuPcwKlcGuQlOvG77xSBNTmXE5eCLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMS9gNxf354FFh/eaZb4gUgBOsCEkv0QQ+PvVHKrJDlzuCWaXq
	eMb0AvHjgFbOejGO7/tvW0E8xgfSR0QnHH7/uxLVxTJZWEm+KDzBvBCd
X-Gm-Gg: ASbGncuw3fhuH91weJ5qtbDpJR8rbOLXb1sSOzdPwlgu+GznivWbZYNUpoEF1EHYLYU
	p53koWvsrkiX5S7t4+fWFOi7ueuednAKjGysUNRnUDT/ljJGbVOi2daZ/HxvSSWYXDzRiay6V/a
	iGvNkYzcVNOsRNYVoTizHULaBhVU+zpMhabbpvDzTpTk/2zMBFpOhYNWwoPrflXN5kjKn/ZMBGo
	TOqXYxxenLCDk1auPQCedW5WIlL+X4fF3dajmADeP9jBphEFlkbTZawfb7Ai53VlFV7/96zaNth
	4Ao+aqUOgfu7CHtFEwu1CcmnIx1gTWOqO/Iu18LLU7MD4K5mKk/eaYxkSupehwXbtAUdSCus+/7
	XMzFy8atrFkwO5POkTOs54KjtWkLGZpBW9zeK+pGDRa7K7WpON+/RyF0KX055SxXJHhz3BsCceR
	yHX0G2uEyvumbq
X-Google-Smtp-Source: AGHT+IHo28sU146jMqRyWUoeKa8Yk5IwPxZWxFAwdDfLIIABL6lkMYs53Nt2rNNPIXEDcgl9CfZFhQ==
X-Received: by 2002:a05:6214:2263:b0:704:846b:5f53 with SMTP id 6a1803df08f44-704a42b14f8mr240353746d6.25.1752500846500;
        Mon, 14 Jul 2025 06:47:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704b394b6f5sm23848676d6.12.2025.07.14.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:47:25 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 32369F40066;
	Mon, 14 Jul 2025 09:47:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 09:47:25 -0400
X-ME-Sender: <xms:bQp1aBiDBYppdzCwS6cNCIufgkY6XF5ZrSFeFMqkWYygHKGoVKCM4w>
    <xme:bQp1aHjKEazCF_cFWoU4WNX9XmH8iMYfsr5GHR4xLYVdVIC_gvrjnQlLz40Cwo1UO
    JbnNR8Vceoq0wtqJw>
X-ME-Received: <xmr:bQp1aFpkKjojUIvRAKhztRMi5OAhdVj1LxYuHALuhTFm4SoaRHAE9TUh-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:bQp1aFxAHw3eOmeq7mO212W6QCGo8bgCQsCyXOg0vlLt3kHpdYHfPA>
    <xmx:bQp1aMxm6H5LUvqSBBMl7MMw2__QVBaFB6sMV039M9EDTCctRaTE1w>
    <xmx:bQp1aFYjAwtvYTvtc0HfkJ7Q_626o--RfyzgfqRtmLRPJgQ3FyR55w>
    <xmx:bQp1aFlZDvmi2K_VOJE-ZZkU6MoUzpd5frDNYzY8plmd4FfxQR0OCA>
    <xmx:bQp1aCHiG3nnjcqPTSBcGxzV-K6dOBX6NP0ZYop2ujIZDueJ7R0vW1j1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 09:47:24 -0400 (EDT)
Date: Mon, 14 Jul 2025 06:47:23 -0700
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
Subject: Re: [PATCH v7 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
Message-ID: <aHUKayPmRrAOd9JM@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-10-boqun.feng@gmail.com>
 <DBBQ9SLMWA2K.33BWRE1ME65MG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBQ9SLMWA2K.33BWRE1ME65MG@kernel.org>

On Mon, Jul 14, 2025 at 01:06:08PM +0200, Benno Lossin wrote:
> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> > +// Defines an internal type that always maps to the integer type which has the same size alignment
> > +// as `isize` and `usize`, and `isize` and `usize` are always bi-directional transmutable to
> > +// `isize_atomic_repr`, which also always implements `AtomicImpl`.
> > +#[allow(non_camel_case_types)]
> > +#[cfg(not(CONFIG_64BIT))]
> > +type isize_atomic_repr = i32;
> > +#[allow(non_camel_case_types)]
> > +#[cfg(CONFIG_64BIT)]
> > +type isize_atomic_repr = i64;
> > +
> > +// Ensure size and alignment requirements are checked.
> > +crate::static_assert!(core::mem::size_of::<isize>() == core::mem::size_of::<isize_atomic_repr>());
> > +crate::static_assert!(core::mem::align_of::<isize>() == core::mem::align_of::<isize_atomic_repr>());
> > +crate::static_assert!(core::mem::size_of::<usize>() == core::mem::size_of::<isize_atomic_repr>());
> > +crate::static_assert!(core::mem::align_of::<usize>() == core::mem::align_of::<isize_atomic_repr>());
> 
> This is fine for now, but I would prefer for this to go into an
> `assumptions` module like Miguel proposed some time ago.
> 

Well, sure. Also if `assumptions` or other core kernel mod can provide
a definition similar to `isize_atomic_repr`, I'm happy to use it.

Regards,
Boqun

> ---
> Cheers,
> Benno

