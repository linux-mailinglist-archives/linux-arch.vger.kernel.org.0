Return-Path: <linux-arch+bounces-12666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CAAB01E4A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E871CA6D81
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059E2D9790;
	Fri, 11 Jul 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5P39ZtC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021912D97AF;
	Fri, 11 Jul 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241875; cv=none; b=epkB9e9ws0+ida4RkNf8HzJ/KotUXAZPGOMmeZ6HTjP0LwvafN24RlKieu6xaSQy37GV7p1iZtJgDf6NA6IixhRESu/FG8DqwjBu6U3NOlbxUBT+GjGX/Ffzx5UDLWBN4AQofaXxmdlEIaCu5AWEoFV7lqNm948ACkkOLmkqcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241875; c=relaxed/simple;
	bh=VhA4dbbRgYBOcUaTz+c7NrVJIROm/R3rHh4CcKNyzi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUWIibbTp2Hxv/14QpoPhB4UPY867K+jAUbdyQvfZmOF9AV5DQnXi+7J8Lcl5yuSNZDGnLT5hqikLRe1TBZn5wCRFq7gy4Sap8+SAMgT5cMFCIKHCmLSZY7rmz4P1DKEwTzqquYwLZWk+orirjKr0YVC3FTJFV+A4AgqHpJZ3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5P39ZtC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so25463801cf.0;
        Fri, 11 Jul 2025 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752241873; x=1752846673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsPSR2XmtkCGfmNXHOX1skWOOfQss8KuN6l1/rksPTs=;
        b=G5P39ZtC1O/ys6GKXj/HEIR4wpjCBJOWpBN9X7BKANTik6nHqUBIgdQqoS2sDz3+Iu
         zh364Pzah4swsRDJRTSlmwrCv2XPCYss+HmQkgoRGx9eVth/uYjWTfcEalUpm0EcEi+9
         S6aV6utbTenJDh2bUVfymhsmQDeB7rfWbx546tvKPBX8Pfyq5z9N4eiLiX9FBzU/sZVX
         SoVj0SJcYqCxjNJfsFbK3z1BsfBz3ZRmTZsYcQaoHzvzFWhm6+rRZAfoGuckwvTw6ghy
         M76KdmrhivM6gPVZmgNOeuGoO/t3HJlRlIfSzTIM9lQ+eHWg+lbrGAdEsz2xLZrDx6at
         Ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241873; x=1752846673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsPSR2XmtkCGfmNXHOX1skWOOfQss8KuN6l1/rksPTs=;
        b=wl1/iPrMtdZowYOP5je9Nk66WlZsMdrJW1mdALbe5g458qO+xpHoT4BlM+BVlv4Dxl
         HuZwd0xEUwdAdXEjKD8FmpIz7yq9Q0Cr5GssIezzj7E/M7goJ3XvbjXE5RnBouo0+/jq
         bGbN3jiZ8CC9HcRCwSkoOqfexm+ur/dO11ih9he460jtZrWVXvvD0Ur/L42wllTha3IL
         x7wFAwTh2PZQaDIIar7iWv3iU4pxk3/SMvALUvj0n/N9bYALPQKi44tBp+7OIp6HNo5m
         IBuxWmewWTu5Y9FUdLrVHWyCkl8uoxIPsjbe3Vl+9ARHu9n50UtPqxa3FBleyISTkRup
         DJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFep+LJ7vAICaFsjBfgOFg634GbGBya8WJGxJD1DxPPJ9DyBrKqi/3Nj0Bo4ewgLM4vEiduwhhuoZQjU0QLC4=@vger.kernel.org, AJvYcCWwlqT+6o+u+boVqPlENQw2in9K6Cx76OEvI4cx1sE4LSPzoTxy7xtHPVuZZwTLPCk3LniRPXxCqaMw@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwYjv5if0UipygSDtpQM8D4LzY0StmhguHbFIR8dLe9AYFkPa
	vCkXpgBeT83eHmWZBn09AFsFr3Q9yZrac94sgkjuAB0BbeKZZC3/H0wd
X-Gm-Gg: ASbGncu2NZDHE5ezlHFj+RuXDTBssyl6Bz81d5hQo+E43fN09cztSwwx4g967muYVHa
	CHCWnaXAdhy5iZbg5WtyrlumlKbuUv9Ehqqp+YZ04RQrgdGVNW6cXYyapVPyD7qa5okhRjHVpfE
	+6miTC9zzGYxQqYCNMNO3YVWd/sCwFW0NqdsLdEpqQN1wqfsx5hw+6BM4o1C3RkgYqjUjXK3M7e
	VEAwF1LrHh/h5uNHtJ/0fHAFvfng0KnmGZam0XIbagiis9owcfeEySg+S7ZlPaopLO6ILlVbt8Y
	RaYpz9SkMTnQqFwN+2jxVwu8HWXAtf9Vqlppxs957551doCo8XPEZFC9I8r8EZZDqr6BzZpWXW/
	rf1LaIKWhfLnmigJIW21ybzScE9GO9EJWZH2CU6Pv6Hc6zOoGXA84EtHAtdYWf1YilbW1l+dH1h
	VqqAmFG0EXwrRQ
X-Google-Smtp-Source: AGHT+IG3j/mYxUHwTH0mxjQzJmi5wM/B/2jJ7NoKNHSKvwfZfcpJKZZ0N//i1HDkgCQ/ZVvMkY8kaQ==
X-Received: by 2002:a05:622a:15d5:b0:4a7:f9ab:7895 with SMTP id d75a77b69052e-4a9fb85a364mr59155491cf.4.1752241872555;
        Fri, 11 Jul 2025 06:51:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab04d910desm6281831cf.9.2025.07.11.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:51:11 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E4103F40066;
	Fri, 11 Jul 2025 09:51:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Jul 2025 09:51:10 -0400
X-ME-Sender: <xms:zhZxaKTEY5U6c6-_3YyteOJniubYemra0aIgWHSprXHT3_pZzke0aw>
    <xme:zhZxaBR7JwdG7QGEZOBQI4QeI9TSQ3VKT4i9MVx9JGDDrq0MbjsFxfUgnOXTO8AcL
    5MNKyRYtqHSvDSqiA>
X-ME-Received: <xmr:zhZxaMa-4paHWzWkXrjNawC6kruDLPCCMKQJhprkgO3ptlwOjTdGkobVFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeglecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:zhZxaFjIaiy3xPKeX89dY2CnVso02CcRHAZ6H-bY4j5chU29C0n1Fg>
    <xmx:zhZxaBi1jZJ7WSKFHml3JNgnciAGNRFFk0_a2NGpKqyJNE1l5Pm_Vg>
    <xmx:zhZxaLLBzQItEUnD5qoXsWMEqjwIuNI7l76Sj1l9YNPFmYb_9ySjgg>
    <xmx:zhZxaIVuakmfosevnFBxyDrY9TH7fm6Jz4CqAjyqJ8JD62rYJZq2zg>
    <xmx:zhZxaN1t5hd4nS0wzZcm9R61A2WLCP-yZjx72mnuzcXa9yl5_uellnkB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 09:51:10 -0400 (EDT)
Date: Fri, 11 Jul 2025 06:51:09 -0700
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
Message-ID: <aHEWze8p40qeNBr_@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
 <aHEQKBT68xvqIIjW@Mac.home>
 <DB99JZ3XMHZS.3N0GLG94JJSA9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB99JZ3XMHZS.3N0GLG94JJSA9@kernel.org>

On Fri, Jul 11, 2025 at 03:34:47PM +0200, Benno Lossin wrote:
> On Fri Jul 11, 2025 at 3:22 PM CEST, Boqun Feng wrote:
> > On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
> > [...]
> >> > +
> >> > +    /// Returns a pointer to the underlying atomic variable.
> >> > +    ///
> >> > +    /// Extra safety requirement on using the return pointer: the operations done via the pointer
> >> > +    /// cannot cause data races defined by [`LKMM`].
> >> 
> >> I don't think this is correct. I could create an atomic and then share
> >> it with the C side via this function, since I have exclusive access, the
> >> writes to this pointer don't need to be atomic.
> >> 
> >
> > that's why it says "the operations done via the pointer cannot cause
> > data races .." instead of saying "it must be atomic".
> 
> Ah right I misread... But then the safety requirement is redundant? Data
> races are already UB...
> 
> >> We also don't document additional postconditions like this... If you
> >
> > Please see how Rust std document their `as_ptr()`:
> >
> > 	https://doc.rust-lang.org/std/sync/atomic/struct.AtomicI32.html#method.as_ptr
> >
> > It mentions that "Doing non-atomic reads and writes on the resulting
> > integer can be a data race." (although the document is a bit out of
> > date, since non-atomic read and atomic read are no longer data race now,
> > see [1])
> 
> That's very different from the comment you wrote though. It's not an
> additional safety requirement, but rather a note to users of the API
> that they should be careful with the returned pointer.
> 
> > I think we can use the similar document structure here: providing more
> > safety requirement on the returning pointers, and...
> >
> >> really would have to do it like this (which you shouldn't given the
> >> example above), you would have to make this function `unsafe`, otherwise
> >> there is no way to ensure that people adhere to it (since it isn't part
> >> of the safety docs).
> >> 
> >
> > ...since dereferencing pointers is always `unsafe`, users need to avoid
> > data races anyway, hence this is just additional information that helps
> > reasoning.
> 
> I disagree.
> 
> As mentioned above, data races are already forbidden for raw pointers.
> We should indeed add a note that says that non-atomic operations might
> result in data races. But that's very different from adding an
> additional safety requirement for using the pointer.
> 
> And I don't think that we can add additional safety requirements to
> dereferencing a raw pointer without an additional `unsafe` block.
> 

So all your disagreement is about the "extra safety requirement" part?
How about I drop that:

    /// Returns a pointer to the underlying atomic `T`.
    pub const fn as_ptr(&self) -> *mut T {
        self.0.get()
    }

? I tried to add something additional information:

/// Note that non-atomic reads and writes via the returned pointer may
/// cause data races if racing with atomic reads and writes per [LKMM].

but that seems redundant, because as you said, data races are UB anyway.

Thoughts?

Regards,
Boqun

> ---
> Cheers,
> Benno

