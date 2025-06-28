Return-Path: <linux-arch+bounces-12492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD73AEC4B2
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE87E7B23C5
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66421C165;
	Sat, 28 Jun 2025 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu0x4q8a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75737201004;
	Sat, 28 Jun 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751082162; cv=none; b=Sl2r2mLCDjn7ZyCE0h7Uz3QWNkKpcYC6VAg1eegJXlT9K8rxcKKxeqUuUOO3DCwsbTa2c6mDCSWiz87UAC0Pn7e4ZtpZ0oUQvf1N9UaA0KS0rKa7l/yga2JVKJurjNvD7CAITl529da7L5URwzj9MhVHwpd2ZYtzoh8ynJMY9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751082162; c=relaxed/simple;
	bh=nhER8ZfvdtY3YByIjG+YMSgQUrFdl2UkZ/cmvNb3MAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVQVE65ylZWSa4RMOEjLIMN8ell1SAGbm7p1nincm6jHSYzftKM/JXU86WgWq5lU5ysFkf9YBviChxy2M1LyyA75kwkESckfDrl2bAlWeKIOHx1LVbtRV4j/mTO8nWQjgJUkeMENHShifWuGlGopBbuh7VTPnN/Tb1xYCnbo1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu0x4q8a; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso30185686d6.1;
        Fri, 27 Jun 2025 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751082159; x=1751686959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VEbBp8YdQcFMU69IN4b0pwYAz5X1X8v0Kfm5rjL0u8=;
        b=Yu0x4q8aBbCkaI4WFHfShsoKOE6GWku1HYtoRZXb6efTOqksD/IH+5pH76Brsw9DRV
         Phiz+5XB1+aCgS4v9wAdQO9L3RiB36NnLueTIGr/hvFFmLBSfZNHpExl32X4ebapXHLh
         CA0LIUtD7rr9mtP6wDGLcFy1lNPv0Ij1Zztm9dHfBdwu8Qyu+WQ+Y82BDTbqtE3vUXOl
         M9Mxwr8fAh2ttfzfJZDua1xcxTctlJSyxV1BkPNBoXKnqY7/7BelJHUMU1AKyKLL40kJ
         O01XFj+N01LPFXcHy5J1PHpBzqqaE3gubwW/GEJg+ynTfQTWY8Z55bFENxx+xAXsDs0H
         ZC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751082159; x=1751686959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VEbBp8YdQcFMU69IN4b0pwYAz5X1X8v0Kfm5rjL0u8=;
        b=LrOYr5OfFytWEqyfVO/G+ZkJuSdEespcnhsgn5QVCsj11PneC6aymvjWFa08FhERNV
         6Yz98/08QaoMuU0u6/OCDyp+NwxWKHS2Kjv0Qb6O5D1736nhLffVZU27gy0IUxNU02+o
         JvnVnl5dS0zASQICJtjD4o/m8K62guRhXegwthXvUCwBe/GpFPGRLvPueSUspICJ2CvU
         b4A5hGOE7xLF9ossbRXfcXZ0SxXNegPHpN8QziDZ2ic9b2HvGgz2+kqD+mqxCgys0VL0
         53roIDHCuSMWSmaIUHm44awlVlyxVzMeYB1Zyp578+fd5ZQjc1z2KY086fELWbgFFwIs
         xXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVK6B4RCw3LL9Ftt9heyMoEP3yv6shngCagaQuQKuRjq5S7hur/351SvVZqOT/yF+ZubhtERZncQpUY5JoyjLo=@vger.kernel.org, AJvYcCXN+QL2Fif1eY5wxsjv77A9MKtiYMt9ws/h9CcOw1LLHC+2bN9goyLddvRCXT0F8FtcOF6Ox3NBGKum@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3k4K8Jd6chUU323kbwErIl/MCQskEsZTBhRhagpyzdx6fFfr
	iJF83SS26u4uvTTXBWmRU3Ao5b2tYvbYLQKnzsDB4FijV9Ysrc50b5Yf
X-Gm-Gg: ASbGnctoYYG4oi9i8OQaNdKEfuW20ZH2sPwSv87NPD+My5KFpLHThlsy0cXh1Lh7xmU
	ZYtnuVT1Z23DXraymGlEObXwmvHmRDqYxnm2iYTvyqwBekEGnen9AaqGIYBN7jLwkaGDyP88nPU
	OVay5/2NsPIlelVqwxRkqK8+qmb4aCfMCxzmXJSVNAUHGGsVlnLY566EvLqTGI2rx3n14gutoM4
	dUTKq4OJ+edsvBW7/run40j4vS6xeeL5T4WGQ5Iqznu875iYCtNe6OLspU3/71hJTIck7CZ9Ces
	x10D44t+zDz80FWTpazbW5K3A/HfAbfszGVIs2PNtnXYVRKBi1G6cv+Sbhv4DGC2hrh+WWzAEgE
	7df61XZSKSMbrdHoUXrQZVPvZalUZ5nc6fCb9y3AtefPaQVu9NjwG
X-Google-Smtp-Source: AGHT+IGedbmHDaqU9GUha1odWRJbVBRQf8bnjo4m+/kurV/RO3ST+RbsJJXnW2tWoSkKHZdD52LSbA==
X-Received: by 2002:a05:6214:224a:b0:6fa:ae40:3023 with SMTP id 6a1803df08f44-7009214990cmr83567916d6.7.1751082159322;
        Fri, 27 Jun 2025 20:42:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b50e1sm31074116d6.34.2025.06.27.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:42:38 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 22882F40068;
	Fri, 27 Jun 2025 23:42:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 23:42:38 -0400
X-ME-Sender: <xms:rmRfaGAnsA9ZcFPvQvGW7kVxBmDIVwhSAWAqJ5pCQacQTWq2iDaR6A>
    <xme:rmRfaAgg18U4xIY1DXpBc04zVu23doqBBddPj1S_y4FD-20PcSDUk764kysF3KO4e
    djHi9O0CohrthY9fw>
X-ME-Received: <xmr:rmRfaJkrIPIm2UoztFGciaxrH7RB0gyxoqpDdWHe1pi4a7p34aRp1tKOQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegkeekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:rmRfaExyzSKlE6o4bZZiZnfTo3QpT8W0UBqMrwFQdntBYBO21p76IQ>
    <xmx:rmRfaLS2fegfgQ9M_iBXC6iNBcDCoC2pEYqPlYWe155j7GZrKFz9zw>
    <xmx:rmRfaPYeg_auaZ-A-TzBsWTnKeF74UzdFxxkjGWPICI0CsFeY_LV0g>
    <xmx:rmRfaETEChVCo8tiClrKe5pygw-8sdQRhtMLRMPUjG34dyv8F7NdkA>
    <xmx:rmRfaNB1S5EfWisrzswXOrsWiG3ZtIGTj6u7398Uz9EOAloXHofjQSEQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 23:42:37 -0400 (EDT)
Date: Fri, 27 Jun 2025 20:42:36 -0700
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
Subject: Re: [PATCH v5 10/10] rust: sync: Add memory barriers
Message-ID: <aF9krO0nVjN0yoEC@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <A-SZkzm2EzwbPsG5Vm5qfT1BIGijzoQ7zQI6ExgXZbSXf8ZfIMw6fe-Z7xWgvKnr0BPylikGRuhEfiKfXx5xTw==@protonmail.internalid>
 <20250618164934.19817-11-boqun.feng@gmail.com>
 <874iw2zkti.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iw2zkti.fsf@kernel.org>

On Thu, Jun 26, 2025 at 03:36:25PM +0200, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
[...]
> > +//! [`LKMM`]: srctree/tools/memory-mode/
> 
> Typo in link target.
> 
> > +
> > +/// A compiler barrier.
> > +///
> > +/// An explicic compiler barrier function that prevents the compiler from moving the memory
> > +/// accesses either side of it to the other side.
> 
> Typo in "explicit".
> 

Fixed.

> How about:
> 
>   A compiler barrier. Prevents the compiler from reordering
>   memory access instructions across the barrier.
> 
> 
> > +pub(crate) fn barrier() {
> > +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
> > +    // it suffices as a compiler barrier.
> > +    //
> > +    // SAFETY: An empty asm block should be safe.
> > +    unsafe {
> > +        core::arch::asm!("");
> > +    }
> > +}
> > +
> > +/// A full memory barrier.
> > +///
> > +/// A barrier function that prevents both the compiler and the CPU from moving the memory accesses
> > +/// either side of it to the other side.
> 
> 
>   A barrier that prevents compiler and CPU from reordering memory access
>   instructions across the barrier.
> 
> > +pub fn smp_mb() {
> > +    if cfg!(CONFIG_SMP) {
> > +        // SAFETY: `smp_mb()` is safe to call.
> > +        unsafe {
> > +            bindings::smp_mb();
> > +        }
> > +    } else {
> > +        barrier();
> > +    }
> > +}
> > +
> > +/// A write-write memory barrier.
> > +///
> > +/// A barrier function that prevents both the compiler and the CPU from moving the memory write
> > +/// accesses either side of it to the other side.
> 
>   A barrier that prevents compiler and CPU from reordering memory write
>   instructions across the barrier.
> 
> > +pub fn smp_wmb() {
> > +    if cfg!(CONFIG_SMP) {
> > +        // SAFETY: `smp_wmb()` is safe to call.
> > +        unsafe {
> > +            bindings::smp_wmb();
> > +        }
> > +    } else {
> > +        barrier();
> > +    }
> > +}
> > +
> > +/// A read-read memory barrier.
> > +///
> > +/// A barrier function that prevents both the compiler and the CPU from moving the memory read
> > +/// accesses either side of it to the other side.
> 
>   A barrier that prevents compiler and CPU from reordering memory read
>   instructions across the barrier.
> 

These are good wording, except that I will use "memory (read/write)
accesses" instead of "memory (read/write) instructions" because:

1) "instructions" are at lower level than the language, and memory
   barriers function are provided as synchonization primitives, so I
   feel we should describe memory barrier effects at language level,
   i.e. mention how it would interact with objects and accesses to them.

2) There are instructions can do read and write in one instruction, it
   might be unclear when we say "prevents reordering an instruction"
   whether both parts are included, for example:

   r1 = atomic_add(x, 1); // <- this can be one instruction.
   smp_rmb();
   r2 = atomic_read(y);

   people may think because the smp_rmb() prevents read instructions
   reordering, and atomic_add() is one instruction in this case,
   smp_rmb() can prevents the write part of that instruction from
   reordering, but that's not the case.


So I will do:

   A barrier that prevents compiler and CPU from reordering memory read
   accesses across the barrier.

Regards,
Boqun

> > +pub fn smp_rmb() {
> > +    if cfg!(CONFIG_SMP) {
> > +        // SAFETY: `smp_rmb()` is safe to call.
> > +        unsafe {
> > +            bindings::smp_rmb();
> > +        }
> > +    } else {
> > +        barrier();
> > +    }
> > +}
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

