Return-Path: <linux-arch+bounces-12750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A74B0442A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6691622FA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893561FF1A0;
	Mon, 14 Jul 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFBnIkdd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFD258CED;
	Mon, 14 Jul 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507175; cv=none; b=A27ND1uw5lBjDNR/fZLnWAu4Um4x/pyl+0eGoSss2+2HEFw/p/zHfp9Ws8ECQV381X28MEWs6zvosYN8OaSTQ8K19c6dHiZPrnvz1iobmeGow1cciCHCL7SukZuOz2pY/UJ6HhM7oZ2LQpbtg+VWowllXpEJxSiQHlaWSv7PZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507175; c=relaxed/simple;
	bh=/koeKlB/k0Uouo8pgg2T7oltVBCEzdoq4Vld2kRYayM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbFLbJzK4hetUPYct+m0UV+zzON/aa5CDJappt8MjwqzmlSi+fszdzVoo+P1dGKgxvmmnjSwk1GcT9iE4CRhQaQqSXN+LcmdlN4aF6ujQHVz5pFK70dgBlNR65YrRUrRPsrH9j5CDvzSuMVxfrQmQWloiAv1jw2QNTUOSo3n4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFBnIkdd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so10524181cf.1;
        Mon, 14 Jul 2025 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752507173; x=1753111973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MfFqiSzZREdMyVsNgIAfk4F76Kub2bUvM9+BkEQL8A=;
        b=MFBnIkddb+9KXceKX83Z4A3uM2Zqpi+mNWM750Gi/BQAODJU/YMflNSs/y0Q1p5Fdb
         FAsPa4Aiw+wUFtAA98RG1M6/yuexlUtbK2cLU2m3CVGYWC+fldUG+NNG9jICv5DCv3U0
         4ONuBSVQ9wsXmbDxSGx77WNy79HQxzL8z29s9b5WL+l0wnBa6I9MvasZg2XTAZpU2sV7
         4dYj0vaVKlRboYMgShpIfXzlArlaCo/+jik5jJWXlHofKtXLPSOtICpvz7MFrqYj+w4c
         +2SebQQLyTl0OltrOEzOspxUWFa8GB190PXOS3OD9fNQd428WnIM2wj8zjmNkNelPd4Z
         x4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507173; x=1753111973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MfFqiSzZREdMyVsNgIAfk4F76Kub2bUvM9+BkEQL8A=;
        b=jiJzG8GtI5b9Uq7nQyp8/M9EIv5rRhwXjFT/56uCZx2PGAp85LfRvvXtAWFj7O8rsC
         gscL8zJ0U+cAv7ICSZZs06Q0GXEXmHWhHYwvieqf4t/j7LJ8WEX/hoAjP+6QI82oN+8b
         d9xp9B8T6zOwVEbes0LeVfK6Q+60D25mfqsGi9dhOdVv+lufI5y6Lmrw1aw8QzJMZJUU
         4dfTdMR+pxdDh3fvCeSYVgMFRP0W6ZF+hilZNhJPl+KnZdjNXTQOfGJmifLfS6wrBs2x
         VeREKeBlq5bOA/qUC5zPNk8CMVEDokBSItoqVcaJWItMVmb4VYw7tRzvkQk6VQ5MCz84
         6g2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW1VO+7qd1rImRyLsJ8oaLfZpCGl6WZoV7/L9AswTEnR2OfMABzz6MCEPz7XhAFCEu8KU0IcikDRNp@vger.kernel.org, AJvYcCWmD1YsX5lqjs6sysOFU9uYXG1Ca1v+D0MwNCLPOBgZa6c9Mv/2J7qRCwyBsvoXHh53/Il0fmOTgJVTbIRtOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFDMMXGRGNweeY2ItG00BlfBwasQpokn4cUPTr6a5s7dG8kn/
	SPuankIOzgWMNgpYonKiflSGZQfhe9meBNzPtg0gCeZ1Cx9EvIknjzOp
X-Gm-Gg: ASbGncsJMh7i/EtFZhrS79oKBP9JIj/cBAMzlPulDBcMpEPTf1UWCNKWwYZL6RH6GDD
	4SkXwPt28LmwGMuP6mmK2JAVeJoGZAmwB1p3StetGDO2tJJYLyRYRwWZe/7t7a31TXA2Ze+LZWL
	02ceDXrdn9m/WDkHipEa2zoriwJRFNp1q+H42Qj678+626sw0rDW6rnVLd1UxcFZeEWEHTrCsrP
	D+dpgmoVVt/QRkIlf1AYVbCsZT6ERR90exB707GUQrd0GdkQw6ZU1UrD+zBEiErY1hE/nAjjiO1
	ARXEX6L0nzGuYeu/SrYktHyc5kPVHLIVJT61ieF56QlpIEJWsbRaumDH3Av/0thjCDWbN8hJDPi
	3F8WZrG4b6umM8pKynbVZ3G1NB2tyPkOwnsgAfNHze3KXN2vJE9AePb/KacTq2Jla8s0z/OQdYt
	TcA5Sxe+2ZOePe
X-Google-Smtp-Source: AGHT+IEiE/KhsLnwDtozknIyhsymCObeRf1LTZcI6ldZd1GqTFKQ2x8AfKPsdKBm3mDZ2dcM+KQJ6A==
X-Received: by 2002:a05:622a:838c:b0:4ab:38c1:f9a9 with SMTP id d75a77b69052e-4ab38c1fc7emr172803891cf.19.1752507172595;
        Mon, 14 Jul 2025 08:32:52 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3f1c9a2csm30869951cf.67.2025.07.14.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:32:52 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83594F40066;
	Mon, 14 Jul 2025 11:32:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 14 Jul 2025 11:32:51 -0400
X-ME-Sender: <xms:IyN1aNZhQdTXlEwdUFRK6ixe11IsrGl9xQrPhCYt2MdciWQg-2N87A>
    <xme:IyN1aF5V1ixT0MErGGOpS8ZDHhBAE-ASyclvhtA7ANSPsYQFZaeFm_Fo_jKMk6mpv
    TW-gZDXrO6Ol2FAcw>
X-ME-Received: <xmr:IyN1aEgsrCJ6UmyqHs1It-LK9ZJdmCqOQl4JHFw0IhhkfW6kCIniW78zqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IyN1aLI0aVk-31eig95s5X5IAwTfkC5opzO7TVO4o63Dxltb7RQpig>
    <xmx:IyN1aGqzMj-aS-jBspJ99eptAKv-u_tP7EK0_blC3OdjvfW1sdhgUA>
    <xmx:IyN1aJy2I1GGOeidWxfmC4_5la-hcr47Jg_T8wBKUXoDfP8TVg_o6w>
    <xmx:IyN1aCfyxZHOaUh4scxy2MoqYe5CypGeJlzZFysocpLyN3her6pRcg>
    <xmx:IyN1aNcFefTTQUTDjPW2XSJEq3GHvRHfEVHYBNt7FwOijMbUp8n62MlX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 11:32:50 -0400 (EDT)
Date: Mon, 14 Jul 2025 08:32:49 -0700
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
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHUjIQlqphtgVP2g@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>
 <aHUSgXW9A6LzjBIS@Mac.home>
 <DBBVD70MASPW.2LUTJ51Y6SGMI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBVD70MASPW.2LUTJ51Y6SGMI@kernel.org>

On Mon, Jul 14, 2025 at 05:05:40PM +0200, Benno Lossin wrote:
[...]
> >> >  //!
> >> >  //! [`LKMM`]: srctree/tools/memory-model/
> >> >  
> >> > +pub mod generic;
> >> 
> >> Hmm, maybe just re-export the stuff? I don't think there's an advantage
> >> to having the generic module be public.
> >> 
> >
> > If `generic` is not public, then in the kernel::sync::atomic page, it
> > won't should up, and there is no mentioning of struct `Atomic` either.
> >
> > If I made it public and also re-export the `Atomic`, there would be a
> > "Re-export" section mentioning all the re-exports, so I will keep
> > `generic` unless you have some tricks that I don't know.
> 
> Just use `#[doc(inline)]` :)
> 
>     https://doc.rust-lang.org/rustdoc/write-documentation/the-doc-attribute.html#inline-and-no_inline
> 
> > Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomicAdd`
> > stay under `generic` (instead of re-export them at `atomic` mod level)
> > because they are about the generic part of `Atomic`, right?
> 
> Why is that more natural? It only adds an extra path layer in any import
> for atomics.
> 

Exactly, users need to go through extra steps if they want to use the
"generic" part of the atomic, and I think that makes user more aware of
what they are essentially doing:

- If you want to use the predefined types for atomic, just

  use kernel::sync::atomic::Atomic;

  and just operate on an `Atomic<_>`.

- If you want to bring your own type for atomic operations, you need to

  use kernel::sync::atomic::generic::AllowAtomic;

  (essentially you go into the "generic" part of the atomic)

  and provide your own implementation for `AllowAtomic` and then you
  could use it for your own type.

I feel it's natural because for extra features you fetch more modules
in.

Regards,
Boqun

> Unless you at some point want to add `concrete::Atomic<T>` etc, I would
> just re-export them.
> 
[...]

