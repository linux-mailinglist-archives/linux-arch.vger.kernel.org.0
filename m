Return-Path: <linux-arch+bounces-15581-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DDDCE6DC5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 041A73016CB6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB13315D5B;
	Mon, 29 Dec 2025 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C16f3DXH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2E315D24
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014385; cv=none; b=dKp2UM0UjyG2KL33ivwZG771kGRyqf4ZWA6WtxkhrJuxBSCtvFAGhLq7IAJHSobS4GjnhCxofNN9VWPRV01tbmXSbxBunC8EvtKf9AU3I1NfEKTzaAQptLAeyLl2h9uADlsA2gS45uKncjPx6y7Vt0c9bEfaGj2+PQUqoc43BkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014385; c=relaxed/simple;
	bh=vKyqIlDT9VgsO8CEEafhUWBQEgKSJNkWpZyYYR+wV3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRvdxywye3rpApyJw3+PH0N5z/1MB4DKs+zIgBToVisDWAEEy5lLwe7B19A6pnwyHmt10K/QWblDAzY2oh4Z/AASziMk7if4OmTIPidaBGAFBEKP4boHebwRXf2Ve11IBmqbIHh9aLtjjsZBaSBSIDIhph9HnFdEgihIQHAqnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C16f3DXH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b23b6d9f11so1012190585a.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 05:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767014382; x=1767619182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8dzyqZ5agFXiOLV8QgjZGpnf5TGn2pbb4cFubbUjmQ=;
        b=C16f3DXHHerHe4A15rfvRZyeZ0jPl3SHGMHOJ/wvhv+xEAZBMLGJd9sckMoPI3IIHK
         51R6RiHp1CA1NmUZ8nMIoGT98opUoPNLl8sA9uQjfEX1Hz+krJcyqKoAuMFAZXokPWEx
         ubo0c8W09+l9IfMD3i1YrCWCJUfmzEREJZdIf8bLurDrSPraT4qBJFjOJJZ6ZYooN6uc
         i7UBzVOd9o75I1JD8qRifSkQBewYiPhsIuFfjt8ceAUl0glYKZnPziIdLhsCMQOuR3nQ
         YdvmoaLJDyUebZPmHVSDm5E25JFH0TL2JnbYCavx6w8Q6Vfhkh54TQL7lJqHomejKNuK
         BvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767014382; x=1767619182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8dzyqZ5agFXiOLV8QgjZGpnf5TGn2pbb4cFubbUjmQ=;
        b=H5QSnlfmrh3dH/98tMkKGtoR3V4dw2IQOVzNP55VYCF0dxlIEEptPeF5t168r9j+X8
         sZgNRVcYoNJMZKII5na6XkMgpzLnTVvM5L0++BSgCTtQw6I6fTS1hQVa0JFz+89uoVl8
         qC281pUfjmrX8+8rcEPQhNW0aFDFjbW/a74LrPH7hM5JdRDDo/tW2AYSlI7tqZGpBq+C
         EIN5BZdfgdY94Okiu4fnGYLo6Zx62IyVuRGelIBSiVogRWGvxaEtkAKjP99keRyNLIsz
         Wk8ZdFppyx0M18LQt51q3B4r2S4ojDIypyWLbw3g6FstXmsQwnAzrX8VJ/wCoGbZ+9Uj
         83ww==
X-Forwarded-Encrypted: i=1; AJvYcCWCGTKqvRaBaEzwJFcNeVRDsNyEfrZWXl4nigNI5wf+Gki0przqhuK0LzzoF1zpl0DlB4a/sOfRa5AK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0bhrAFDPbn8nqgt2ghL6oyrKJ9tCu+tBROIu93Go4IGEvqDG
	XU9ib5BspphyzJQOFzuQc5D4/lpsE+XaLrd4dGmmSborVJAP8Ah9KGGw
X-Gm-Gg: AY/fxX5l5qCi2ffrm+2+4+VbRv7AyV1m3J0Xq0WI8eXE8VL5VaMtc8/WnjpG+7yAarO
	weCqLPsAnzpWdSaoVJxOEJtdvZSbSwOEDaLtzZ8WGEe3gwCirF9ENvwZm23OKW322BkYGKsLw42
	nco045hy620hiy4hkcdt8BJqqhDhDB6baIofya6G7Sg3Jcp0xwnPPTtXEUJqqdDswfQSc3+YXqc
	/iSecK3URU2T+5YDVenb4wRXkBnYbSL7ryoxmJthuFjs4zKHXCRfKtYvfNibAVzyFRNypakA78M
	lwK1YU43dHw8r1ZyWGU/0SyFz29MnFMvcCZTAtNzvrxkr9GBy8KncSJ9i5mTNzBuDRqfReg2+T0
	aFcaMPkg0vUIoUhVrvZXeBJJYKFYnflE5l6uk0UIJiv4ZIh6Gdf0uuiI0uqlvX3gvxp83/Bqq/H
	vpVkWVV+pArFVvWh5JSdKcUwdU+SjC5RRJh2OfClIZ/W0O0oIt1fxCiZsQmY4CV7ZCAg8yf9Tev
	Y73YYCXo9o9Yao=
X-Google-Smtp-Source: AGHT+IF4My1gAUQWEgRyDinLNsbN0UU0OdtVQrGTOgglm7kCC6zlBSGvkN3FsMMiG4G2CBfGnFkqug==
X-Received: by 2002:a05:6214:3118:b0:720:e4bd:d3e6 with SMTP id 6a1803df08f44-88d84a2559cmr386084546d6.15.1767014382101;
        Mon, 29 Dec 2025 05:19:42 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm227055386d6.57.2025.12.29.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 05:19:41 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 611A4F4006B;
	Mon, 29 Dec 2025 08:19:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Dec 2025 08:19:41 -0500
X-ME-Sender: <xms:7X9SacgwgjlumTGB--o2XPjsv06DiWTsdBl4gyomJiEAwY54vaoLFQ>
    <xme:7X9SabgUEELd3I0apRTv_4C-B7PceNwTxaprxLn8oqHEyScOxq2wfDPBCNcrw96Vt
    kzY3nniGY6lgfGpkCOZr7F1111PfDsAUk2y-2hGdz0GUvZIQUshDQ>
X-ME-Received: <xmr:7X9SaSEtANZNeW-UPrzMoqNmxF4mUUQ4pEbdE2elh5nzQtw2EUAoTfQozw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonh
    horhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrh
    hoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:7X9SaQAptYzuquXRTEvdxhWwwu513cpBwbeFVNqc4T-qTyl_DN_LeA>
    <xmx:7X9SaQBY5vHI56SfoYA6Z-rVSMs9lmpDT9wndTMjkPLTmDGqKWUYAQ>
    <xmx:7X9SaWNr6a9AMO2m29F0Yx5qP2KVb8kGlXlXZlwdJBAPBLbfzMyK-w>
    <xmx:7X9SacP4mD13bzYmwFmV7tO_wYjnMI8z-kekR3laaTbxzIL1_v4dCg>
    <xmx:7X9SaYJk5UeMMZpbH1Shdau_o9_ZPRJsBKcnVY02uyTAAFmdGyFWQwnM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 08:19:40 -0500 (EST)
Date: Mon, 29 Dec 2025 21:19:27 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 2/3] rust: sync: atomic: Remove workaround macro for
 i8/i16 BasicOps
Message-ID: <aVJ_35voSG8xnUk-@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
 <20251228120546.1602275-3-fujita.tomonori@gmail.com>
 <aVJs-D4V1IpfzR7z@tardis-2.local>
 <20251229.215558.697746619121630518.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229.215558.697746619121630518.fujita.tomonori@gmail.com>

On Mon, Dec 29, 2025 at 09:55:58PM +0900, FUJITA Tomonori wrote:
> On Mon, 29 Dec 2025 19:58:48 +0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sun, Dec 28, 2025 at 09:05:45PM +0900, FUJITA Tomonori wrote:
> >> Remove workaround impl_atomic_only_load_and_store_ops macro and use
> >> declare_and_impl_atomic_methods to add AtomicBasicOps support for
> >> i8/i16.
> >> 
> > 
> > I did the following so that we can drop this ;-)
> > 
> > 1. Change function names of [1] and [2] from *{load,store}* to
> >    *{read,set}*.
> > 
> > 2. Reorder [3] before [4] to avoid introduction of
> >    impl_atomic_only_load_and_store_ops!()
> > 
> > [1]: https://lore.kernel.org/all/20251211113826.1299077-3-fujita.tomonori@gmail.com/
> > [2]: https://lore.kernel.org/all/20251211113826.1299077-2-fujita.tomonori@gmail.com/
> > [3]: https://lore.kernel.org/all/20251228120546.1602275-2-fujita.tomonori@gmail.com/
> > [4]: https://lore.kernel.org/all/20251211113826.1299077-4-fujita.tomonori@gmail.com/
> > 
> > I also reorder a bit to make the introduction of helpers are grouped
> > together, please see at
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-sync.20251229
> > 
> > I feel this way we have a cleaner history of changes.
> 
> It looks much cleaner now, thanks!
> 
> Maybe, you could consider chan ging the following two points:
> 
> - change the first patch subject
> 
> rust: helpers: Add i8/i16 atomic_read_acquire/atomic_set_release helpers 
> 
> - drop the following comment in 12th patch:
> 
> +// It is still unclear whether i8/i16 atomics will eventually support
> +// the same set of operations as i32/i64, because some architectures
> +// do not provide hardware support for the required atomic primitives.
> +// Furthermore, supporting Atomic<bool> will require even more
> +// significant structural changes.
> +//
> +// To avoid premature refactoring, a separate macro for i8 and i16 is
> +// used for now, leaving the existing macros untouched until the overall
> +// design requirements are settled.
> 
Good eyes!

Done (along with other fixes):

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-sync.20251229b

Regards,
Boqun

