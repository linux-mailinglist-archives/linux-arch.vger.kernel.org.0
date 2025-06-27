Return-Path: <linux-arch+bounces-12488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3DAEBA32
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1565647E1
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43E2E8897;
	Fri, 27 Jun 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiPqq0Bg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167F2E7644;
	Fri, 27 Jun 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035497; cv=none; b=TaxpQ/4GKi4hOAjXDxWPqatfcrp82hDvm66BpqETxcWeUQe7UHDfOnov5SjfO1dFJ2WATBG5eZiWiHkx5C7uGe5lWeN5ZdKP3JSdIxqOJxsIw/gS+lxIbbsMX4UxKV05kRo7gAalRTQ4FpzleXujE0n+VdKIrZq78axtFrSMk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035497; c=relaxed/simple;
	bh=wB2dQL35c8imjz8aUYEkv+Kk0qxUmqHONiTsdy+0DVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anCiWA5x5/ogKkma1SWul/8W7iit5IXeLUUAaezuFoa2Gtycj+24qfeyyQpTJno4B6lTlm5yYpYLwhFDvRAtxvLdDaf3im3B7Dymboh2h/Q4ilgD3/M8Lzm24kCSeeuLubR6FKDm5f6C698v2djKwo5ncLBnM/2DWLD8XPu87Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiPqq0Bg; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso24144226d6.1;
        Fri, 27 Jun 2025 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035495; x=1751640295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuWs3j1x7+EnEWhudL7zxC8HxyHZbbIVHszRV1zTF6s=;
        b=CiPqq0Bg41fA+gtRBVNoy9OynHMKX6Kubeb77PzfJT+ITZ9v4YiLUpQ5zPvPFmDrzC
         Ulka3opPhn4Wo3/yvwtwr6Y6zrlBZQFNKXmcbaVbDCGRqll4PJsqvoDlmZQkajGIQhO0
         Gg1kVD+IiDDULzP5b55ZN3ZvphtxUn9HTWgxPk8xLvJ7CfllDjkgcO+W5aO2TgAUWK0/
         9z8wKQ+8wccLVPy2O0xOrNKCNnYSdJ4MX65wmU3sZwMTaAWKOMkl0IGBldgKhCD/rXW+
         0DTMrbXERcsUQKeqy5h9bvr9wlU2aXrfeEYhLKXmn0/TO3krY0nIJcEssc5ymtYCSCF2
         rDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035495; x=1751640295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuWs3j1x7+EnEWhudL7zxC8HxyHZbbIVHszRV1zTF6s=;
        b=Xem64bg2/Oj7xOkPkfHlL2VM1DpQHpaYH7fb+dKOsXSKniis5nTqGH2edxIOMaAwB3
         3p8uf64ZVpVfTFj/hg1SpHeOjwQtSwwiIHv2vjPqapM0o3Q+21F/EMXH/hNz28SYDMUV
         cvb1is1PX1EbUEE4C1DZTigaskenhFLk3dVu7MEnl4okLml2ihsH3dl7UTiNm+FwczGI
         V+HwP38AQn+xzbFR6c3HN2lw8elxzJbcy5SudTmwse3SxcXAZhwTOlDPIxeT9d/Ktlg3
         lDbvM0SgD98NC7bG95g/x86WGJJuAKiCBhArA892aiYjkp2gA1ZnyRprkwTyi1ceGSx1
         qzfw==
X-Forwarded-Encrypted: i=1; AJvYcCU7JUIseCILH1PLVeNamHo+7tnnYFJ3bNgUCgxrF89mywrhvrqb+XqhMEeVs9dzJP/WMtW/Vl2aJqrQLEuPl+g=@vger.kernel.org, AJvYcCXUIrsYtoGyz9SalRyWkRhPuXIjazCg3FF6OIh6ZehYLed5FQqsz2yUXQDB2blqS+yqUkJYu8uKnTsA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38MPC/m5vXjyTZ2MendQ/2l8TSbfR+ux4g15Rv/TBgnFFv6kx
	e2rJtwBjg22S7zeB88C39ynfqCRaeYtxjteb27g6KUtI3lXlv9+CT7Xh
X-Gm-Gg: ASbGncvE/6L9yDZRT5+uH9oJnASypStrSO9Oe58ceDCGgv/hx0PLjEMH8uGPHdiab7e
	7t9rmJNnl1vL4eVCoTaUvFJwNinXRzyCOQdgd1xHtQskPgAHbMRz5Fhh0XB849/pb/nLU7Q2xrG
	x0x5SeUOaiC83x5hZOFfKvkBGsVpN8qTFS8Z9kWR0Nmt/D4FYre4AltPJsSbeCS8D/peI36xvE5
	MyHc8wf+6s/6tCzT7HzX1TRrWh+ngXEb4DYHxdNTYshBbSandlJDLiUjc3Hu8zWBZUUTINuGIm5
	Am6NFo+IQX2DN7qhfusCko10Msv5EnWkuaGUtoHCIiHUFwsO9Wyf7qunbH1m/ofymwRjr3fagN1
	L7qovuvwqDgLg4eHZEQvcJrJILk3NuAE64y9/iZCAFsQ7JMWl8Jx3
X-Google-Smtp-Source: AGHT+IEUuwUXgo2OeUL457R+n35acysC8d/++BJCeB5mNVOencHsLALChCWLXr3tQwUpPpTD/emPDg==
X-Received: by 2002:ad4:576c:0:b0:6e8:f4d3:e8a5 with SMTP id 6a1803df08f44-6ffffd79be6mr64502026d6.15.1751035495022;
        Fri, 27 Jun 2025 07:44:55 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771acfe6sm21357226d6.31.2025.06.27.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:44:54 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C03ECF40066;
	Fri, 27 Jun 2025 10:44:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 10:44:53 -0400
X-ME-Sender: <xms:Za5eaAVF4SuboNZjcMJ9rdBGSPX_5cHdfbiSeicrA3wqcG_W8L2IAw>
    <xme:Za5eaEn9flFN2ZT8DQEQqF1C53qbDpuaABIgKYNSE5mgtcrnsB9vEeoZlEhW8cq8q
    eidtsjfn5p5_nX9ng>
X-ME-Received: <xmr:Za5eaEbGTY-KHkU-PX2sPFB734tKCambWcvaUzeYKrINnfuiTR94fG8Zwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhu
    shhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    rghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:Za5eaPW7q6Vm8vQlEADyJOfkpYnVLCxMpNksemrPxOzEGJE7uM8k9w>
    <xmx:Za5eaKnpHM2jAJxSluf5PfN1C7hDNUk8A5i_tdNqVLgC8JFW7gZ_Gg>
    <xmx:Za5eaEfv78VoW3DYO3PFYqvODKwkYh3DRXA0sLBdtlnUrlaFln7CKg>
    <xmx:Za5eaME8NHJKzekGkjLzGCIinLX4t9iLWofJN-_c_ZSS35kE1zIzmg>
    <xmx:Za5eaAkRcPceVK611x3G6DFFFJs7q4BQ7s4NZYWOlLOqe9Lg3JK1QeRH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 10:44:53 -0400 (EDT)
Date: Fri, 27 Jun 2025 07:44:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aF6uZLX1zr2MP6Ne@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <W3facY85E7FjV5y6_67OMqPUz1-Vubr8TpYgFCgXNl8GMh1oM6_bF9V94Kl_oZsdyCQSrxm5WExUmztE3pJ_BQ==@protonmail.internalid>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <87wm8yznkt.fsf@kernel.org>
 <aF6sBmgTmdM5ZoB3@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF6sBmgTmdM5ZoB3@Mac.home>

On Fri, Jun 27, 2025 at 07:34:46AM -0700, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 02:36:50PM +0200, Andreas Hindborg wrote:
> [...]
> > > +/// The trait bound for annotating operations that should support all orderings.
> > > +pub trait All: internal::OrderingUnit {}
> > 
> > I think I would prefer `Any` rather than `All` here. Because it is "any
> > of", not "all of them at once".
> > 
> 
> Good idea! Changed. Thanks!
> 

And I realized I can unify `Any` with `OrderingUnit`, here is the what I
have now:

mod internal {
    /// Sealed trait, can be only implemented inside atomic mod.
    pub trait Sealed {}

    impl Sealed for super::Relaxed {}
    impl Sealed for super::Acquire {}
    impl Sealed for super::Release {}
    impl Sealed for super::Full {}
}

/// The trait bound for annotating operations that support any ordering.
pub trait Any: internal::Sealed {
    /// Describes the exact memory ordering.
    const TYPE: OrderingType;
}

impl Any for Relaxed {
    const TYPE: OrderingType = OrderingType::Relaxed;
}

impl Any for Acquire {
    const TYPE: OrderingType = OrderingType::Acquire;
}

impl Any for Release {
    const TYPE: OrderingType = OrderingType::Release;
}

impl Any for Full {
    const TYPE: OrderingType = OrderingType::Full;
}

Better than what I had before, thanks!

Regards,
Boqun

