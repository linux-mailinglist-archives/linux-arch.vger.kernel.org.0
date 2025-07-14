Return-Path: <linux-arch+bounces-12739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD47B04075
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DE416504A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE0255F22;
	Mon, 14 Jul 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dghZ12a6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4E1F462D;
	Mon, 14 Jul 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500584; cv=none; b=tQFYzT3o7TwytZgNtHcXAYCHtfwa3t/YpCXYKC7hQIpEKhx7uKlmxhnuh7ORRW/sekg3v6K6lcWOyQAh7oKYjd3cp+Ifjrx6FoYzNdX0XaPBgPJQMqVRwjkSoxy5wElEI7IPwULk3555Am3I2U204H8WUCv/AzFT+f5LmEWOuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500584; c=relaxed/simple;
	bh=WPxyElylVhF0iPQIfxiTW4zQCOTfAgY1wQytxJ2fMiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3KkAWgCzFD9whjt8NynJp/NAkoRr3qA67+AQyH3U6aiM1liJyC2IiGoEgASUaaE9hrFj/fpdkU/rB+E/CVlH4kAvAtUWy0KPtKNPK6zNXUpQZHoh5bcDGFYwKXtIFrRlOZbfz+nCfTGr4HVg5s2cCPepFt610boPzoUz/H2DA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dghZ12a6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e32cf22fdfso58177385a.0;
        Mon, 14 Jul 2025 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752500581; x=1753105381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjFmGdXaAaiu0Ffhi5wpwHapt3S54QcOxUCblcGZllY=;
        b=dghZ12a6LM9fwZ+vJnHurU3mrXpEo7LIhgHNhtj4yKNdER2bUtwnztR11xgfWImrD4
         FHe5uVttPY5bqoaY3NfKNQEV4MjgpnFrK9R5t17IIWCLAKcxTSn/IVGE96lqTGOchHJr
         E5ZYOGs7fyKxjG9aJtFNzMyt67kuPdwOBwXtGbkInoCHz0TThmGcQ11Ue2bDH1xW+sqP
         1+VF9qZJ57PaWuTsdUR3SHNeJk4W+OL686E7wKZCTgaR59ngU0PYpMCJI4jZgKyDnkXf
         RdNAzjAdruSOgxVJOCf+glNhsrRTckEfK3lEEz88Nsgin0nXLFrA2XMFURdKUhq5OrH2
         wvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500581; x=1753105381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjFmGdXaAaiu0Ffhi5wpwHapt3S54QcOxUCblcGZllY=;
        b=q7YG7EdmCTf3yBpe93r5jCTSZGCnG9+yKGmIxgqyCdcLi3S53cOMfncEWa9luBZ1Hb
         e9+hAL6Xzz03sUgrFFACGyESjQPh3a3eEVH4lUvqLvx/xe5l3sKVbRtb1LVb75cVUUIo
         hoUUojnlTS2eC9CfZIaf2BtzAbIE2LDZH26THQCi3Dlbfn5QSbWvcq1jsQKeR+2YwsB5
         mmlQHOg1b8SkDj0z2Zer/qzY8P9unLWDUHEY7sJTkjmBhKJbXCgP9Dwgas+dxeWUxV2E
         3eqRK5dWesR12BSp0hVcE/xr18MB1CrTj8fwQ7kGi7YYxBrl45OlpLTjAbE/VfFHNGAS
         CENQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdq7xKmoqd2oDg5Fbbxqo3guLnIU6vNE2iW0uOGscXPgCvMDyMa+P0QVsUvJvk6PcolHCwxfNKpkqT@vger.kernel.org, AJvYcCWt/8R066F+17eSPcttmBI0EZFr9R06egAq1ix9VK2xZrP3l1Gm0kqREv8mW8eFBn256vGDh7afIqRKUY9mNbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71yFlyOxP0cTCB1vfP84iemHDU2DyGwIrGZ+9XoXQsGRwvWt/
	Kcv3gMLL5GhjXiL5uwknk1sidra2HFEa5xrMvu8HIVOlghqH39Uedpdu
X-Gm-Gg: ASbGncsqpNSnWAJUJPlQ8DHZdwoFJdxHfxfpeNDRHtE0s7qwtx58nlqolBAGSZhi102
	wHUnklAUAd9GLCDMnoTOKDZFM8bQDXFbSnmK0Don2hYnRcsSYGuOAou4RNVmZ05L/UnWaYr40bo
	jf4fb62WRUfusVMRxCsz/got6OVGjpJSDViVVZF+QppYSy47o9qO+DitQSkAkH34k4W2u61WO05
	1jGp8YKmlfHjpKb1AfMvfUG+2kJaFucbnX062IHWZ1emcyLp9gVMX04QKHDPr34sQ3D0DoS9Kph
	bAUCMY3B4wDYKtBsCAEEeuplWqOjRffZ+COVIQ/Z+MwzsWVSD4PbD9IBiT70jZwsnqc83+6Q3R5
	Td5AciU9EAl48PoVaywU+btc3d+0DxHCkpqn0igd+YBqnQjESCyNUBxdHUlWittBJRKcg+Y70n1
	JISyl1e9yKTSIXw0Q2QjtZXOM=
X-Google-Smtp-Source: AGHT+IGweO7G/7uSENn+QjmTqlnddwl29V+sT1o5JO9dLO+3x1eM5WrtlkMDznQvp7BWQT0CzFOjIQ==
X-Received: by 2002:a05:620a:29d4:b0:7e3:3276:99f with SMTP id af79cd13be357-7e332760bdamr202722385a.53.1752500580777;
        Mon, 14 Jul 2025 06:43:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f7d1csm510687285a.39.2025.07.14.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:43:00 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78D0FF40066;
	Mon, 14 Jul 2025 09:42:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 09:42:59 -0400
X-ME-Sender: <xms:Ywl1aDg6ZR-Pt-egYF0cEU0wN5VrH3Wc8d2tBgrBdgNGnhIReYEK4A>
    <xme:Ywl1aBiD2dUlnpJoC8tg4CZjOCDUfwJZMU4VkEOc89Ww_fXgexZyx_II5sZy5RUz1
    oqJYTCw24cXszNALw>
X-ME-Received: <xmr:Ywl1aHrAk2faanmnCGwYF7v4EfNsJNWcFfiNE0RxBYPu047YGRLbl95oxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddutdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Ywl1aPw5QLkQ8h8wN2AGHXMiG97DGE0zF_b0nFyuFM2NDibE_pfKOg>
    <xmx:Ywl1aOxvuEi3bZcmwu4wxtg9u3KRto60ks8oM57Robcf1EHUb-71Pw>
    <xmx:Ywl1aPbFSQoykG1EAzIuyNZKY8gf5duiOR5uYRVx6qypdNKAS7aT9g>
    <xmx:Ywl1aHlXvctT_p98-Ps8pUe1bWN_092kyk3UjuKjXn8s64OkZnHskQ>
    <xmx:Ywl1aMHVbmuDUlU3-8uBw6DYzNXRCHFWgcqAIKh7Xh5SXujsZ_qu2Ycf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 09:42:58 -0400 (EDT)
Date: Mon, 14 Jul 2025 06:42:57 -0700
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
Subject: Re: [PATCH v7 2/9] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <aHUJYTv4_wsatAw5@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-3-boqun.feng@gmail.com>
 <DBBOXLF23VVA.2T3U6GBOZ3Y20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBOXLF23VVA.2T3U6GBOZ3Y20@kernel.org>

On Mon, Jul 14, 2025 at 12:03:11PM +0200, Benno Lossin wrote:
[...]
> > +declare_and_impl_atomic_methods!(
> > +    /// Basic atomic operations
> > +    pub trait AtomicHasBasicOps {
> 
> I think we should drop the `Has` from the names. So this one can just be
> `AtomicBasicOps`. Or how about `BasicAtomic`, or `AtomicBase`?
> 

Actually, given your feedback to `ordering::Any` vs `core::any::Any`,
I think it makes more sense to keep the current names ;-) These are only
trait names to describe what operations do an `AtomicImpl` has, and they
should be used only in atomic mod, so naming them a bit longer is not a
problem. And by doing so, we free the better names `BasicAtomic` or
`AtomicBase` for other future usages.

Best I could do is `AtomicBasicOps` or `HasAtomicBasicOps`.

> > +        /// Atomic read (load).
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> > +        /// - `ptr` is valid for reads.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn read[acquire](ptr: *mut Self) -> Self {
> > +            bindings::#call(ptr.cast())
> > +        }
> > +
> > +        /// Atomic set (store).
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> > +        /// - `ptr` is valid for writes.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn set[release](ptr: *mut Self, v: Self) {
> > +            bindings::#call(ptr.cast(), v)
> > +        }
> > +    }
> > +);
> > +
> > +declare_and_impl_atomic_methods!(
> > +    /// Exchange and compare-and-exchange atomic operations
> > +    pub trait AtomicHasXchgOps {
> 
> Same here `AtomicXchgOps` or `AtomicExchangeOps` or `AtomicExchange`?
> (I would prefer to not abbreviate it to `Xchg`)
> 

The "Xchg" -> "Exchange" part seems fine to me.

> > +        /// Atomic exchange.
> > +        ///
> > +        /// Atomically updates `*ptr` to `v` and returns the old value.
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> > +        /// - `ptr` is valid for reads and writes.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
> > +            bindings::#call(ptr.cast(), v)
> > +        }
> > +
> > +        /// Atomic compare and exchange.
> > +        ///
> > +        /// If `*ptr` == `*old`, atomically updates `*ptr` to `new`. Otherwise, `*ptr` is not
> > +        /// modified, `*old` is updated to the current value of `*ptr`.
> > +        ///
> > +        /// Return `true` if the update of `*ptr` occured, `false` otherwise.
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> > +        /// - `ptr` is valid for reads and writes.
> > +        /// - `old` is aligned to [`align_of::<Self>()`].
> > +        /// - `old` is valid for reads and writes.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut Self, new: Self) -> bool {
> > +            bindings::#call(ptr.cast(), old, new)
> > +        )}
> > +    }
> > +);
> > +
> > +declare_and_impl_atomic_methods!(
> > +    /// Atomic arithmetic operations
> > +    pub trait AtomicHasArithmeticOps {
> 
> Forgot to rename this one to `Add`? I think `AtomicAdd` sounds best for

No, because at the `AtomicImpl` level, it's easy to know whether a type
has all the arithmetic operations or none (also the `Delta` type should
be known). But I don't have opinions on renaming it to `AtomicAddOps` or
`HasAtomicAddOps`.

Regards,
Boqun

> this one.
> 
> ---
> Cheers,
> Benno
> 
> > +        /// Atomic add (wrapping).
> > +        ///
> > +        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`.
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to `align_of::<Self>()`.
> > +        /// - `ptr` is valid for reads and writes.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn add[](ptr: *mut Self, v: Self::Delta) {
> > +            bindings::#call(v, ptr.cast())
> > +        }
> > +
> > +        /// Atomic fetch and add (wrapping).
> > +        ///
> > +        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`, and returns the value of `*ptr`
> > +        /// before the update.
> > +        ///
> > +        /// # Safety
> > +        /// - `ptr` is aligned to `align_of::<Self>()`.
> > +        /// - `ptr` is valid for reads and writes.
> > +        ///
> > +        /// [`align_of::<Self>()`]: core::mem::align_of
> > +        unsafe fn fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self::Delta) -> Self {
> > +            bindings::#call(v, ptr.cast())
> > +        }
> > +    }
> > +);
> 

