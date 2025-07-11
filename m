Return-Path: <linux-arch+bounces-12663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC1B01DA3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70670B472B4
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF02D3EE6;
	Fri, 11 Jul 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3R55vTP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8C299AA4;
	Fri, 11 Jul 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240746; cv=none; b=JvXcGT7TobstqLBCIbrBp43iOV6P/SluTYj76AGufJ1j47XLtlPC7Moom6zCIakeZzwQfyxi5TpF4MnNIQeAC969h6A5ttCSslx3ryYUlbwsOgFZR/XcEXmKGyeMEjwGv6ruqH+LwHZ/e0je0lAKqaXOUIT1rLRk8CGmhlMd0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240746; c=relaxed/simple;
	bh=Wxw5H24VaaibQ/B1AnzVCIGcsYhH0gAd7I69PKtsYos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idqdKp5qJTJUfsL6pGvtPJCa23OmzUDIqjyd7vC3JJrBBL6Z/ukHvJ8wSJs0WwqSaHg/nQtkRe2iDXtfLfaANXwM1ixMhIv8qQr7kiErUlZCAoIfVTlRKqpqP/DNO3zqWFS82lHUJlX2ngHGmJ7SdtSbCxLq+7GQ1n1nR1AeTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3R55vTP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58ba6c945so30122791cf.2;
        Fri, 11 Jul 2025 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240743; x=1752845543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSfG9eLyOi/7bNvNHBFehmopuc+sjkuQSYmr2u2++04=;
        b=N3R55vTPyI6/nePHiMl1QMs4OxfQgxrExTHeo96H/Lg4ZdCS16D4DdgH3XyQFRJQW6
         L0D/rjjJNyMYfQ0QaBBgK65fTZH4d+juLsentuhWpUGph4APQX5dowoFBXujHqmq05ww
         qVVfAtDg8eyA+goSDHMp8vdefTK/Tjl/AqYfZHBaHQQADG1T2Bqzv98Vb1+NlYX5Mkxj
         3+HC6rJW/Ue/64tcbo2Xoe5zyRrVuOUzZtck0xFn59TPg/YVzzT0QwHrrRaqxsjXNARK
         f23RRjGV+ggsHNU3zaNoxWTwM+IC7aRacs1RxHaQ4//1ulSw7jXdr6QegKvgctZXV4DB
         OhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240743; x=1752845543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSfG9eLyOi/7bNvNHBFehmopuc+sjkuQSYmr2u2++04=;
        b=kzziEllWJausnwiay4vI3PYBL0LCs265bxRmlNTcHNa32Zi+ugb1OD6HS2/h7x4oDS
         6OTAxpVhPAnk4hYJCnJKIzusrmHtf04a8o6r9qYsPHFPjQ13un0vhKs4Kz9GP5dY1Lw8
         rz1F5EEbkTGVwBV2ggoZh0MiMYqLUw7oUBSasgI1xBJhj7A+ldOiaEeOONmFk44IBs+v
         G34WUmVVF/TrEjEYb5bxjA8BUfyHs+u8k3H0H/w+mdeQvtTCK3aLdAVFfL3YLsLuYXRl
         wLyX/U+ruoCKNhScuyjY34sJJuxhbihk3AJOnz37X2pKTfUjs5C/tCXUvCSQKQwCU8/F
         ax1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4XdBcAW9bn6DYZ5y+UKESA1cR21OaY2D06v2b/vCRVamD19rgwIki+gd9GgwX2qfDa3aVKnyv2mjJ64F8BxU=@vger.kernel.org, AJvYcCVa9mIkaYzk8uhOW+UtzFdj29IGHSyTZfDjVlY2QToUy0M7d1y515LaJZpx1KLYU/rIGohjkMZN9Ksi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+zrk9A/wOoTfga/brdD6nglDOK0IM14FxBc2sLT8H4pBwMx2
	uKeLM4WZCL+qPCfpDLeAVyvWf7iPZ+7ngQYVpjz9goM8tuTUCwiNyLZ1
X-Gm-Gg: ASbGncsVfdlKDX02jlZe6umcuGofS0jLfCV2uxvzr59VRuhj64je7g/Nj5Gsgz5dzXq
	dt2KyitMgah1mD+URywMZTXZq6aS57JMhJfa59jrzzgXFsDl23yvklZb4O2hMhmU0uhdVYaXDYY
	j1nn8U+eXak2qz1fqyv9cFf0Fv9ReRgUOtCKwoVCS1fXdRsD2I/zydNOnX7/cJZIF3URKmWGqbx
	6xuuu/miNeTyU5x2ttn7MFQFMP1Mi8qR15m2QMro3BBk/0RB1tbLMiC+2ZXInUq+rqHJ33qK3yY
	ZUC2xsZPpoUC+y8AorKKQWLARKvcE+EzCzM9YslG+ijHBQ+ogAJ/zgljd32m8XHP8CiL5W1ZX1q
	ZFGvi2GL1jwfYscHX7K8+DFKv504SrwtA/nq2HbsOWD1AuaqsIBXXkASE7+vTYDC2F4tneC0754
	ntiYVnqtnxPU3g
X-Google-Smtp-Source: AGHT+IE8g/Wz22Mbl5u7b1Isnoz5jC3U3lWrtV2cFcRVjV+feIy/MaQqLmfKYsYi5oWJEoDkn3WEEQ==
X-Received: by 2002:a05:622a:429b:b0:4a9:8852:7b95 with SMTP id d75a77b69052e-4a9fb94759emr49988901cf.26.1752240742758;
        Fri, 11 Jul 2025 06:32:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc13e3dsm21020411cf.16.2025.07.11.06.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:32:22 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6870DF40066;
	Fri, 11 Jul 2025 09:32:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Jul 2025 09:32:21 -0400
X-ME-Sender: <xms:ZRJxaBt2QCH_vkKfoK1orHXvvFocrb86BTkxOiAUUAwMlJ7jJculSg>
    <xme:ZRJxaL_0Q6e8-Wc9HmtpvoiVA_8jIdXb8uJQPT9UbIkXRsYWYB5oqsgd61wPYi_gJ
    WlPCXX_PaR5ixjldg>
X-ME-Received: <xmr:ZRJxaJUu9su4P7gcU70Qyuf-_e6OnKPkYODbQNMn63CYJXZSEhMwL3hAAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedtvdetvedv
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
X-ME-Proxy: <xmx:ZRJxaHtd-dDi8Ww2nZ2iwkrXpbyiF1zaKmDoP2PBJeDFJi9q7JyOvg>
    <xmx:ZRJxaP-mhJNz75WZ-Q0HNoNKmJli4gBRCrFwgMJJDvkdcXEPXcw-Ng>
    <xmx:ZRJxaA1LPJyHiy-MfO91kd0zI0Sn7jDX52wnjUCnlnzELrfqkgWwDg>
    <xmx:ZRJxaESsxnZ9Gf-KUY10cUZ3XWSAfX_rlA6RT0JIzRLrSfX7eC6Wew>
    <xmx:ZRJxaDBSutXyP-lXRrWqEM5Lzd9WiujFqe5GkjylWj7rkiqrB0F-3VP3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 09:32:20 -0400 (EDT)
Date: Fri, 11 Jul 2025 06:32:19 -0700
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
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
Message-ID: <aHESYzVOTCwADqpP@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>

On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
[...]
> > +}
> > +
> > +/// A full memory barrier.
> > +///
> > +/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
> > +pub fn smp_mb() {
> > +    if cfg!(CONFIG_SMP) {
> > +        // SAFETY: `smp_mb()` is safe to call.
> > +        unsafe {
> > +            bindings::smp_mb();
> 
> Does this really work? How does the Rust compiler know this is a memory
> barrier?
> 

- Without INLINE_HELPER, this is an FFI call, it's safe to assume that
  Rust compiler would treat it as a compiler barrier and in smp_mb() a
  real memory barrier instruction will be executed. 

- With INLINE_HELPER, this will be inlined as an asm block with "memory"
  as clobber, and LLVM will know it's a compiler memory barrier, and the
  real memory barrier instruction guarantees it's a memory barrier at
  CPU reordering level as well.

Think about this, SpinLock and Mutex need memory barriers for critical
section, if this doesn't work, then SpinLock and Mutex don't work
either, then we have a bigger problem ;-)

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > +        }
> > +    } else {
> > +        barrier();
> > +    }
> > +}

