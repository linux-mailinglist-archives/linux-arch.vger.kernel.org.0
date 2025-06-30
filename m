Return-Path: <linux-arch+bounces-12516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E936BAEE263
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFF81890055
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C628C87F;
	Mon, 30 Jun 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiKBLHy8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1128C870;
	Mon, 30 Jun 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297285; cv=none; b=j75Yeo0cxIwLJcL3os9KPBRbm2pCuZcQKa/M2x6/bJmKkzetD6sl1dKhurjBulJmyBa/Si65k38bJN9SvajWdrQWOXO6bMe84nPE7a4dZ075oy1M5u0ByezLfXbwsaDTR7gNNdaCunHEaYcBudccxP0qgUcQs/YuoHdoCy+R1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297285; c=relaxed/simple;
	bh=R4ZKd5Izt9SSWjSSLD/vaRFa31ZYb9nuV07HQ1qG4yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg/eQEV/3dtVrAy7CtGqQ5ftn7GxkdyGlUoLrt5mp17OrY/458AmDL0V2NqdwqShFOgNWCgT8UMxUM7xZwRZY1rRlE0cEoG197jskZVzzzuej+/evm4c397ETsit7+maGnHPzGTGwvcNNwlTdGUrK9RHYZlgoVQltDRAU9slqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiKBLHy8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fad3400ea3so41819836d6.0;
        Mon, 30 Jun 2025 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297282; x=1751902082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRWe4SgiDv0tsg7Z/Uvyrshrg1+1baaByE8+3IYg1qQ=;
        b=XiKBLHy8E936CXxiBkQ3O4RU1pXmo8zUi9JwMKRURjbkE1vo3e2CXJu8Pa+xSMjfrk
         YBLxavhTLLw5qFKn/AaljEWSDUf2LG68t1Ay7DUsn6l8VtZLfubRi8Fs0QcJ5Kx874pe
         /MRTFOZvo7vEB5EgdSN4i6VvPcw+9HmxTcDIb5G/vNusKRVb0xff/4ya8b1S1WtUtOfq
         T7oy7NM8ubb9Jjk0CCNF9nJscVUzMUu+fnnsWAmmewTkM6AvlRVaiBt+/BXY9D2/XaKx
         IyOjSoTkTl2I8pfbSctvg7QwPd1V3DiY136eoZwiDwRmOl3rAV2oBb68nSib2zB9Ap2k
         XY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297282; x=1751902082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRWe4SgiDv0tsg7Z/Uvyrshrg1+1baaByE8+3IYg1qQ=;
        b=dNjJ1VcKYDRqvY55LOqgYPNhUTVOFe8JRUd+5oJnaWlBaK1ERBsZsKgUHn7A3HYRW8
         iBJHhR+WvBRUAMTyzZskV6gLKGy/lUUgeBuKjQaHYjFI/8f1LWPIakbkVTTqBLZ0AyZF
         +PS+nNMd/rKfNHBlnTD3A/QIIl9TvDd9WQob24ZLqo5LG0gigjInvNK9U1iu710Ls9Nm
         /Z7+8rsluT5/xFMJEG6087lHaJsMaIG6u4zVN1h9BYvi0kH0kPbxA1INt7CDpj5iNBgD
         slf8sTZmC6ctr4euMxa4qMyClw5LSbs1PjZjH8/bULJz5+VTC4+p+7GsfprrtP7r3BqV
         yy7A==
X-Forwarded-Encrypted: i=1; AJvYcCV4oXI/d6xmN4gVOYKitinvbuTB82Ltbk0FSC9A3XVjZChobBeUB3dB6isvFOlpiU+nw6IGuqIqlkBx@vger.kernel.org, AJvYcCXPI6rC6syG3BOvTmknha/epROqFVIwBwsPLaXQNExt4BKh9TUpSvqNzOGkM/im/B6ow/01ODUAE5rzmf4BUVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcwx7CXal+CoDEfh83vMDVInVhlNDiB6NamQDPSifqxY+2P/T
	B+BNHnUio7KVjN6vhKnLlEL9VIPZGEs0vxFtppdJilhAl+ClrLcDtQxX
X-Gm-Gg: ASbGncte3RV6TkBfyECdzw5IQSfg5MrEVQixMSc0S+Rv+PjyGVDCmTrgllDk8fXJI27
	yHfxtBMSY6sTjqh3ueqFq/5twYB7+Qzz9eYvHsr5iiFzKEBvNZw7KcP31/B1ls0suSs718bzXsN
	KeeouyVNBfqMhmEDHwacbMW6bOz7+pqakUGxeri3eoaWQ+MGHGBQKjzfI1mgJFdWtz3GHjMc5i9
	ZJUPhG9m+cGj5l1XNUU5ETNsv2iwZKo2MeT9FnKxMsQVnLPP03/Dci1P7M3QcB4bWaYuGkk1AMi
	ZT1Z8CXL3k2fVoTKzTfoSkQFQmcs9pGP+BXckEyQG0is1cjp2/2IrwoZ1KXm8W+X3olsaFXYlby
	3LZjZ6p5JLtOzUMYBAnxY366GaktOW2wjLGh4dnw5EXqGtphdZl+s
X-Google-Smtp-Source: AGHT+IHBoKvVU4bpVWy26A88umlSdYg7xDFOn/6WBb9a3Unoq7wnWyZHIkO35I8WAP6pzd32QS3AzQ==
X-Received: by 2002:a05:6214:2345:b0:6fb:619c:98ac with SMTP id 6a1803df08f44-7000841ca3cmr224617726d6.39.1751297282157;
        Mon, 30 Jun 2025 08:28:02 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b5027sm68355766d6.33.2025.06.30.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:28:01 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id AC81DF4006D;
	Mon, 30 Jun 2025 11:28:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Jun 2025 11:28:00 -0400
X-ME-Sender: <xms:AK1iaBDkzTk8wXkRcRCl0ZTQaamobcNFNn2lthfQZAaBqYl-rvBptw>
    <xme:AK1iaPiWRv5GW2N2xd_TSxK11S4xArae6LLB3mTudbzSy98B2ENiOkAy04ETpJubY
    dj3boj5xv_pjVM_HQ>
X-ME-Received: <xmr:AK1iaMlvsePwJadZVdYTYO32qtVdofMVsHMQumkgvmvR8SHoQiqe7o_PMPCy9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AK1iaLyaKv3kaC8pF1jREu432UFhp9rOe2NMpIMUqK0kb7Dp5dFABA>
    <xmx:AK1iaGSOvPvFxO7IawSH5fP1OvTeoOjQL8T6Hq-IcY7XeTXcgMzesw>
    <xmx:AK1iaOYUTRQh-zeZJ4piKuc_bVkOZuDUcVUFMwjrdbQfWLnFm0FxNA>
    <xmx:AK1iaHQbPhBvh5QjX3knerCzXuzVJrYCFEVQAyasK8azsx1TzieD8Q>
    <xmx:AK1iaEC1vKaFzsxfrU6HFdoOerQvp30nvKAebfMON3CWlBwXZfESzDaO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 11:28:00 -0400 (EDT)
Date: Mon, 30 Jun 2025 08:27:59 -0700
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
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aGKs_21dK7y50fxh@tardis-2.local>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>
 <aF6iXB6wiHcpAKIU@Mac.home>
 <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org>
 <aF-aS5FLX7QIiiPa@Mac.home>
 <DAY0AZXDTCD3.OAWZ91IQJT2Q@kernel.org>
 <aGKsHZ0saC-XkQlA@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKsHZ0saC-XkQlA@tardis-2.local>

On Mon, Jun 30, 2025 at 08:24:13AM -0700, Boqun Feng wrote:
[...]
> 
> Make senses, so added:
> 
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -310,7 +310,7 @@ impl<T: AllowAtomic> Atomic<T>
>      /// assert_eq!(42, x.xchg(52, Acquire));
>      /// assert_eq!(52, x.load(Relaxed));
>      /// ```
> -    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> +    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
>      #[inline(always)]
>      pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
>          let v = T::into_repr(v);
> @@ -382,6 +382,7 @@ pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
>          "atomic64_cmpxchg",
>          "atomic_try_cmpxchg",
>          "atomic64_try_cmpxchg"

Missing a comma here, fixed locally.

Regards,
Boqun

> +        "compare_exchange"
>      ))]
>      #[inline(always)]
>      pub fn cmpxchg<Ordering: Any>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
> 
> Seems good?
> 
> Regards,
> Boqun

