Return-Path: <linux-arch+bounces-12721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8CB0351F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 06:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360D6177528
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 04:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A321DF252;
	Mon, 14 Jul 2025 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT5KAQ2l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E36FC3;
	Mon, 14 Jul 2025 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752466856; cv=none; b=YiNyUhoNx5XybRw4uh+t4hCuAgdWC7AI2B6ntWXfJj0UDjtPnoW6kpr5/nG6Urg8qzAdc7PV1ii5dvlKjt/g3bbJ3C7ionepNsHduKeToaCgcdiqKlbJt8mI4DcogVrj4KBHIex7xX602xEgxoBFHXfmhejUaYgKxL5PHS1CefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752466856; c=relaxed/simple;
	bh=SuP+qQVi/MxIQB/1CDIRKWnHRBYowFHJSKjU7kuP458=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9N8AT/iKTlwsPSigcYOaUCz6XPAG9Ld7vo0s5z36Go+tm7IDOoR0VnmNNFNqrNPToyhZRXB2qhXbvflfTUSE+8SkZrATc7VphA/ZM155MwZShw9AzMIu0O2dhuucpLmtycgETb5fp4N1sDmamjZYH3g/Q+zUx8FihBkr2zPqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT5KAQ2l; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so31957986d6.0;
        Sun, 13 Jul 2025 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752466853; x=1753071653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7KPUZRfwzKm6vhoXm+OjqDoe1jPCZoU1nC9eh6TlIU=;
        b=MT5KAQ2lNS6JEgsg4FJl3hGJIBjJqJ+pphzmP3wWObQ2B0IK+DTsYVs1IAkVoWBsQj
         5F/b++gy4da9cO5UT8g9UiWTyfEKorlZerk70VmTsDjS/yGBambmmY8vR2OpnNDrmBI3
         M0roNcv5Q5zWc4Y3gJmytcQf/99vuZCigsAKV59ON/0c5tuj3/BwYH79uCbcrsDjFTQQ
         laSzUuZz66v16YcHZPFVE53lo3p4Ndc0avXdk5ZEz5L3UGfa17JK7FOkiKC+AAWd2zLW
         tXqqUelIL/KGqU6qBAm16cWlwxyin8+SvzjPZ2BxgRSNrxf5yK+MfBnyhRbSbMEgo2UH
         bYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752466853; x=1753071653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7KPUZRfwzKm6vhoXm+OjqDoe1jPCZoU1nC9eh6TlIU=;
        b=MlTo00AjpbYnV3/qMgSdtxqeYce0YfFlijdDs5oqtSCatRa3SVZicz3/dQHmDzeNgJ
         +IAU0jt3rrjIyu+1uYJ3Hj3mIENZkPGa3xb2t/aiUbdEpgZo090b/duF93XSW/s1czyS
         nI90HU/4SQQOZNNTC1U/XgMlHfx7XlJvqm6ZJ2YjULP7fHtSd8THjCEIK6CQKW6ql9BA
         MXskd6cQt5YZ91GFktBM3xjKoZu1asgtWlovfeuHeJ1omOFZJxxGwhZTCJYQ68oVQsb7
         oUrMjidX+atdWoH9sKUruY443t+4G3KaPf8CFURkx1VWTFbIIO6pWZ5aVbt9kTzr57Px
         U8iw==
X-Forwarded-Encrypted: i=1; AJvYcCUl5VL4KP8YelIbnvsJdHh+Z4A3gu+CBUEQoWH76cPJlcE7T8AFfqmFPcV1eUFkeJEPMeemWK9rCcLf@vger.kernel.org, AJvYcCUoIRvG5tcZTcZ5jaPkzE9ikq8mgCrj76NjAcEhXspT2rYjb68cmLSL7GkOHA/jC3tf6RVfIpzfxzy/8wv6Ed0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn95Njcuyr14wZZNxRDToEvTHsXfUqJojsIAf2b1huA8fjJgm9
	LgTB6ziIhrWhDw0IeW0pzG5pyFsiQJ5tTu6od6/d+4O9JUT3xYI2HSpg
X-Gm-Gg: ASbGncvFr4kGVeoMxlHc2IjZ7SoKqQ0rKTo0g+SeqEId9PqPCpU5QkyGKdweZvcV3Kx
	v9HEXdEavqdnO8MgbBom9i8TZ5wzo/QeWef+OjpdXeGhYf2my1iimLUxVJC/2pdDk8CoRrMJRUT
	g0T9SqOXPJLWtlTZ3Lvm5xXtUO/MxMJxrNAFwtn58IFp63T2sNHpebdzsWz3pama5fNhyOt/fuj
	aOwvR27LGf1OIdZRwpz7KoGmjVS0BlT9koDqY4HlQ2rW9mjsvmOf5WvD2eFOKY0CxePiVWiRkBI
	1RvJ/s5csSUpACHQNRo5k2cIhAll0xeF+ArNTlJ+dWPOzDG6ioOn6K0yVQVflmOpMJog94VWeZ7
	IOLw0Pg1DwLlLP7EQba/KsOzFyaCbiX4S7UmT/B+vRcA0X5OLQJqWkALj9X8MWXypTx+WeDMcBg
	/wS3sDd85ee71i
X-Google-Smtp-Source: AGHT+IHDDJtu8kjLF/zH3u5N6Plv3lcX73uCNtxm0f/WjVKubUEQQc4jhA6eH6Rs5519YEmB38XtbQ==
X-Received: by 2002:ad4:5945:0:b0:704:9618:51d with SMTP id 6a1803df08f44-704a7065aacmr172694506d6.39.1752466853319;
        Sun, 13 Jul 2025 21:20:53 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39450sm42915536d6.75.2025.07.13.21.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:20:52 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C2CE5F40068;
	Mon, 14 Jul 2025 00:20:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 00:20:51 -0400
X-ME-Sender: <xms:o4V0aKiB1Yw7Ddrs-kWGfndprpgdgr2L4ZwzQ1bpn3xOScxnW6O2kQ>
    <xme:o4V0aMiNFkqdufkeyTRzHerJ32MkF7t-qTIVUX8DLu3rg7sM6jRmbbBVMvhspcwOI
    VJwbZM5_uDHTD6gmg>
X-ME-Received: <xmr:o4V0aGptazfK8y3G3bHmO2t0DIBwc0Ognkz1pQIMmEt5dYQJaZYAULhgcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehtdelkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:o4V0aCx8tIrHfRplnrskijHUbnjmpbNmW6HQXSp3MqqCbl2dGVu6Sw>
    <xmx:o4V0aFy-744haymfbCRLccCE2OUtfmYIzSVyeymjGwgmyHIbByiZIg>
    <xmx:o4V0aKbLjg8NsprenSkNmhPeXiNXzO378ZXxij6O6bhpTn9N15w8jA>
    <xmx:o4V0aGnjfOsVAqLEaOGud3_0YQJQHJ1DbIekyMfBTdy0tpC1dB3OkA>
    <xmx:o4V0aPEK9yjyqaJ155JtUU2KwuH3hswo_x5ZsYn5jREZow-089i7qi-2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 00:20:51 -0400 (EDT)
Date: Sun, 13 Jul 2025 21:20:50 -0700
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
Message-ID: <aHSFosU8tS1Oqj4l@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>
 <aHEiE0OoA3w1FmCp@Mac.home>
 <DB9GDOR3AY9B.21YFXYHE4F0MP@kernel.org>
 <aHFrUa3VWaKTe0xr@tardis-2.local>
 <DB9J3GBDB2UK.2OHWT5AI5DXFD@kernel.org>
 <aHGAhbmgsb9f3ImR@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHGAhbmgsb9f3ImR@tardis-2.local>

On Fri, Jul 11, 2025 at 02:22:13PM -0700, Boqun Feng wrote:
[...]
> > >     pub unsafe trait AtomicAdd<Rhs>: AllowAtomic {
> > >         type Delta = Self::Repr;
> > >         fn rhs_into_delta(rhs: Rhs) -> Delta;
> > >     }
> > >
> > > Note that I have to provide a `Delta` (or better named as `ReprDelta`?)
> > > because of when pointer support is added, atomic addition is between
> > > a `*mut ()` and a `isize`, not two `*mut()`.
> > 
> > Makes sense, but we don't have default associated types yet :(
> > 
> 
> Oops, we are lucky enough to only have a few types to begin with ;-)
> Maybe we can use `#[derive(AtomicAdd)] to select the default delta type
> later.
> 

Turn out I could give `AtomcImpl` an associate type:

    pub trait AtomicImpl: Sealed {
    	type Delta;
    }

and then

    pub unsafe trait AllowAtomicAdd<Rhs = Self>: AllowAtomic {
        /// Converts `Rhs` into the `Delta` type of the atomic implementation.
        fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
    }

(Yeah, I named it `AllowAtomicAdd` ;-))

and I only need to provide `Delta` for three types (i32, i64 and *mut
()).

BTW, since atomic arithmetic is wrapping, do we want things like `impl
AllowAtomicAdd<u32> for i32`, similar to the concept of
`i32::wrapping_add_unsigned()` ;-)

Regards,
Boqun

> Regards,
> Boqun

