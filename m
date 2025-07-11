Return-Path: <linux-arch+bounces-12715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F9B02655
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1071C26148
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9CB22B8B0;
	Fri, 11 Jul 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3AY/heD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48621A453;
	Fri, 11 Jul 2025 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268938; cv=none; b=UcVVzZyuCScIAjpJwt1AEStRd9WnxLujJg9Z8hHLuFvq60GNJyM6oPPJm4SuYw9cTTMlDqFOZ5fHIYGX+RC0dpptxaKPqf+5fxBtYjONIeS6WD2HBhqdgonTV2RBiNMz1xf+seTMqQ9I9Eb7AzxjtTiTfWLUPzA3xLBHoF+CPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268938; c=relaxed/simple;
	bh=/6jx1eXNGaD49/dIGd6+A9ItUXIEm9RDVUUAuS7ycJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAWhGiuQrvfc5dkWaEEsN7h7ydCiEfzzsklvKpnLJU4pKWL+tpKr0l9hgKIwvPITB2/lj/fFOg6FCgsAsSR5pRhiV2IZJ8ZYgCZ0uqmg4j2IWp0ZDXUvP/x0XNX3uv9yomnnz/IAICeZyRTfwgJW6wBl1iBBL51vwQhWRNK5+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3AY/heD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e0bb4a2c04so14159085a.3;
        Fri, 11 Jul 2025 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752268936; x=1752873736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f18fbZZRbveSqbmKFgVw+VUk1+2XWjIRNb+rjsHPdcE=;
        b=U3AY/heDDungblp7oKXB19J/idiuNwHICm15+Cq8YZh74FH6ymT7vduJYoOl6MS54a
         vJ4hwdWPkMb5QGKQrM+Xuw2B9s0SSrWrMIj9ThaxzRAQiSMJwj7Pa6AQtfBRs6SEHQEg
         hFhJRvSjFTBMh1P8/+HwO2SdTFIuWLCmgQrmxOCJ6P0XMvi/ZvyKSsxiSF67LVYTNn+F
         XlV09dnSLwmCfSsyJvd6dDA2J7uvBm4lOXfGxknDKwnNlFbZc84I2jO2zEEfttw4wgYd
         NHv2NgTdjGAPaJvueaId/RBpqj9RzV8sBljYjpW+N+zWVHwZ2xBFshxQAIxM24KNeVZ+
         S0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752268936; x=1752873736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f18fbZZRbveSqbmKFgVw+VUk1+2XWjIRNb+rjsHPdcE=;
        b=o3w5hd0hT928FugNXtkL0dCw4fQ5yB/qpqzlxPgr+rZ8u+dstMtmSyjopWxHgN+lGU
         YvjFxyZNR8qLU/JoVZSSNamYJ+FB94xLf8ODuO51xqvdJqYmm/m8TM7FlE5saa9nXwSM
         39m/FdMo0jOhUjGqd0ab9AUqury7/h6Ks5kOb0gjT9BP4DEyw+N9oi5TqPCfLNgo5IGC
         76Cg4x5BWA+mg2IfLRkeQLB/LLLFtdamM/1zIaHtk6tBaBMNuUjiBFMfg4QMfndJBtYQ
         TLYj4HYfSNdZeJja+mk1Pp6xHQ0JyBgvutykh7JfGo2EVk08nhApfilv9cXHEw6HrO9T
         MbTg==
X-Forwarded-Encrypted: i=1; AJvYcCWU1nCGOLjrv91KBU1vL3FUloNwrkdCjQ2HXIUfHfZ3WexRXm6+R8eTSITSWrNaYaZ45opaU7/p+y7MBUyrU5A=@vger.kernel.org, AJvYcCXXWM0sNMnOl0aTsIjUGswpghnWMlclUAaiXLSVc71t5QeUHGwjbk8cRIY2DVeSMcexk/fFldDBA8d7@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbMWWR9Gq+tU6AuIH3f9lLu/Af4V8jKX4cMwXxI2nB9TLkcTy
	YDJ8RaQwBUa345DgWc70oLBXgzLlaats8ReLtjutLNfc9nZJr8KWuK1YHrzHTw==
X-Gm-Gg: ASbGncu5Dg8QXlh7u+W/c1lzKisMK1bWVabnIEAZ17l29C1aKb7oktxlAZMr5zkKv0o
	eck5F0+1kyLZE48T1VJyL0/ttaeRjVioUEvoRt+DfrYnI9Ov/AvfJR5YRdeMX9Y1kdD0aKeodBS
	jTnU46ldqWoCwzmyN4mddmU7EmgHCPaVyxHzU8jD/6SBys2PK+TzWLd9wsQqjO7i1cKuKqr6hA1
	NRvUD8qqScXBOb0uE8BViOQ3Kyc0Mk6zkhnbx7wWM/etA4NwQ3nPo/hSrcCddfdQD06a6GpS1+e
	l+JQTLMpPPvNbQlTxxUb5R1hgi51MsGiEL1PdgVAK0ejL0RDT1gKUp3gG/Xw0zYXR0kixsUo+oW
	qMXvMmtU5gynWr0tiF/FX4P+KFv8QzWaAAn5kDJWfg6vO4ptGeFjRqHXfa7R/xJXWNXdwTxTdfB
	635auh3N9aI5K+
X-Google-Smtp-Source: AGHT+IEqiXYnHFo15mF1CWRFRUjm7j6mS/lEw9LW+x1CmanecObRrjvEinHOKHkL5F155PLbdXNuIQ==
X-Received: by 2002:a05:620a:4087:b0:7d3:9109:4472 with SMTP id af79cd13be357-7deca0fe414mr577569985a.37.1752268935832;
        Fri, 11 Jul 2025 14:22:15 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e01651b7c1sm67783385a.63.2025.07.11.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:22:15 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6519F40066;
	Fri, 11 Jul 2025 17:22:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 17:22:14 -0400
X-ME-Sender: <xms:hoBxaCuv2RxoItsIXSENQAUoYCg8RZPC_0GNXlaTwwhsPcx3NHKjlw>
    <xme:hoBxaI-ghevSxo47y41EM_LPbfyaA1aR6zm68g8jdd3ND9hGSvrQaudgYXA0U9STF
    7Ef72j7b0FyBhPWKw>
X-ME-Received: <xmr:hoBxaCU2CaBZZ-srnDGYgp3ux68T1mJ4S-0yUlQ2sra7ysA96yOeIBU4befF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedtieeghedv
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:hoBxaMv1ng42MYmS_42etUc8Qjt6vxXeFHJS9Tp1savv3DDkT8qnww>
    <xmx:hoBxaA9hnmP4ylJu6vNVBLUkCzF7shwXuBke_IRNagXwa7SxcP-W-g>
    <xmx:hoBxaN3jGrtARlalYaDlvc58Jm-yfQeUcRl_O7AC-rQIJTzgXKAIdA>
    <xmx:hoBxaNScmNipFMsmIdip6JU4gn4XVctPuCgh7gcIocqV_yQt6eTEag>
    <xmx:hoBxaIAf_77wnn7oXrAoUQpVjjBfSOXSbg6i77-iLPjxE_AION9Wj_wx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:22:14 -0400 (EDT)
Date: Fri, 11 Jul 2025 14:22:13 -0700
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
Subject: Re: [PATCH v6 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aHGAhbmgsb9f3ImR@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>
 <aHEiE0OoA3w1FmCp@Mac.home>
 <DB9GDOR3AY9B.21YFXYHE4F0MP@kernel.org>
 <aHFrUa3VWaKTe0xr@tardis-2.local>
 <DB9J3GBDB2UK.2OHWT5AI5DXFD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9J3GBDB2UK.2OHWT5AI5DXFD@kernel.org>

On Fri, Jul 11, 2025 at 11:03:24PM +0200, Benno Lossin wrote:
[...]
> > Actually at the beginning, I missed the round-trip transmutablity
> > (thanks to you and Gary for bring that up), that's only safe requirement
> > I thought I needed ;-)
> 
> So technically we only need round-trip transmutablity & same alignment
> (as size is implied as shown above), but I think it's much more
> understandable if we keep it.
> 

Agreed.

[...]
> >
> > Me too! Let's use it then. Combining with your `AtomicAdd<Rhs>`
> > proposal:
> >
> >     /// # Safety
> >     ///
> >     /// Adding any:
> >     /// - one being the value of [`Self::Repr`] obtained through transmuting value of type `Self`,
> >     /// - the other being the value of [`Self::Delta`] obtained through conversion of `rhs_into_delta()`,
> >     /// must yield a value with a bit pattern also valid for `Self`.
> 
> I think this will render wrongly in markdown & we shouldn't use a list,
> so how about:
> 
>     /// Adding any value of type [`Self::Delta`] obtained by [`Self::rhs_into_delta`] to any value of
>     /// type [`Self::Repr`] obtained through transmuting a value of type `Self` to must yield a value
>     /// with a bit pattern also valid for `Self`.
> 

Looks good to me.

> My only gripe with this is that "Adding" isn't really well-defined...
> 

I think it's good enough, and I created a GitHub tracking a few things
we decide to postpone:

	https://github.com/Rust-for-Linux/linux/issues/1180

> >     pub unsafe trait AtomicAdd<Rhs>: AllowAtomic {
> >         type Delta = Self::Repr;
> >         fn rhs_into_delta(rhs: Rhs) -> Delta;
> >     }
> >
> > Note that I have to provide a `Delta` (or better named as `ReprDelta`?)
> > because of when pointer support is added, atomic addition is between
> > a `*mut ()` and a `isize`, not two `*mut()`.
> 
> Makes sense, but we don't have default associated types yet :(
> 

Oops, we are lucky enough to only have a few types to begin with ;-)
Maybe we can use `#[derive(AtomicAdd)] to select the default delta type
later.

Regards,
Boqun

