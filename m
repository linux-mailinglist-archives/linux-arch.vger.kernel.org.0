Return-Path: <linux-arch+bounces-12682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6BB0248F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C877B6C86
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314941E0E08;
	Fri, 11 Jul 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6oeQFzb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD991DE4E0;
	Fri, 11 Jul 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261969; cv=none; b=eHmBsdU9S4dY6/kFnEZKi+xPMpY6ZFe6I+FBiztsmt2CTemw/2uD0o+h3bBdIoQSCK/vPLxueLsarKv289X78jtpKSmWQTF3/5ZQ/sG+mKeLBh4jAtnaKglCYKeV344fWQL0w4ooK1TMME0gLAqeDV9B0I2c+zHPAQU+h6KkU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261969; c=relaxed/simple;
	bh=Nj2/9SXax7e+BLCGe4rwQQy+Qk8F42MdceTDjpf/rDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6U5WeMIcRtYwTZZRrGqBrSG1vFdqActbJGWpJsnz3eyueEButMJpX0VK280b6B/LKWZ1iTd7Njk5WedyLnu+Z3Bf2qS0LLPUtLLOzS2PNYgLYmu0/QsQpPuadtc5ru5auP1k8uZ+EFOX/HZHwZMwnroaoAnSfX1SjkWpvKnSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6oeQFzb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3dd14a7edso354326685a.2;
        Fri, 11 Jul 2025 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752261966; x=1752866766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwfSF5Ou0Fh5wm9fluMBnRsZ0sojeKWafBTdf2xAt2w=;
        b=U6oeQFzbsMgNq7HeP+qR/wy519sUTIPnlM5tEAOMs0Q0luJwrD4EnCT5OQ5V6Cym/9
         GekWAJqMI6THL13QGF9TFo7o9Glo63do9avjjBgORS+zmA/Oj9Cf0xMVklkQ0krXHd7j
         llgZmV6Pjq3BinsZtozzRk4oFYbVkzxV83hPG/Qm/Hdxw8btretAJSGfDdCrW0168Uo9
         KD0aWXTjBGv0reeqaidgtNKhZJUArpW68dj4Yg0jMmJm+Kaq3evhkz/SCmiHFVg0CE84
         zdap8iCgTaOpIEVMoXiYIvtqGIFvk7PLd9ckiQRPD3OBvMWABb3vBCzKdnx0HmCyYWJn
         qZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261966; x=1752866766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwfSF5Ou0Fh5wm9fluMBnRsZ0sojeKWafBTdf2xAt2w=;
        b=iU9Yjbsohk6m+5BJQ4SrhNidodUh4oKsBgnTbXnTfxBEBkqTNhtS1YhPDrjaksMysY
         NYp3BF4fmkBYygG0k+0aqMTrxZWykC8qRpXlw82wx2cIfh5UD3teh83h27/qC+UPenJk
         Ojy6aTPxkm1oQnya4hZDrRWjhRcPbmbhbEEfZB3pQzcpHFsfgDMjbOrvkBo3gMOrzcpF
         75922HxqDNzYfoum5meZtGk+mHb6LrkaHZmLLdANpx2UVwvjLhWW9GhTyqxWkUeHCVdj
         t2VDeW96V/D0hNIzDXasekVaIvHxfOEJYljIHl0E/pYihr1rWUmBVsAhX06u/3L7cPIe
         2SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUKj2wIE+2NKx8ZHueLIvv5jaWV/hv2aTBbXCzxQ8ZhgoeQ7aOuPxuteYK68WC8arZ0ogiz3MXkOZWV@vger.kernel.org, AJvYcCWMeq0oR6khyH5I799zG18Ge8nNj2nDVd8/Fu5igkJCO8oLC2niCI1GKKcJiTuiiTq8oNEG1+wUgQ5LhiH7oCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHIR9O5Ej8ppVoX/5H2NrcJikppQZo1Vybq6eMhPi26UJKo7y
	eXYK2iB6EkkiqLn5M3iQLz+A8UgLU4WvFG6eYStc1dViGOoC2o3VxrHx
X-Gm-Gg: ASbGncvbvRWFs7EtfNp9c/2rr9lcBm7nz2vGibAJbnRQL7Yyuk3/4y6NY/srYnHrWv8
	QO5apHG7GuCqTMhIYctmx4IayML/WAdAH5FmYV9ZsUSMdJuH0kH39UcR/np3hndM092gf3RW4pE
	CMJH2vvTVMscrm85bcMuqkm3SLu8RwknO8HOuQrbWSZaQm74xD2XHzZbPNkETlpN6oEyTwlFe0c
	gAWyWD/UMDXsJhcKdaI23Qslq1gWpipa5awZc1IZ8EqGC/Eb6fsgPwfRBjqewYj9T7tvTJX+Lx0
	YahNyPutcF8bR1QZJATqyWUhnGB1tdFAiQozfqOYbBJCQttkSz50UOuokp2fUeRsmNtEqHYsxHN
	YIHZkCOdehP6mxrL5ArCAKsji5Ckf5VqrTgOrkOfuyQ52k51nfc+YFKvWI19yc3qy1DnQn2BQ/V
	8Bnpd6RtmwMNNK
X-Google-Smtp-Source: AGHT+IEe54GCWKEIEGuTF82+GhJW28o7mntY39+AcMUpIh0AY0EaceOmMdD3EnQvJES3Xw4UwW2hfg==
X-Received: by 2002:a05:620a:1a2a:b0:7cd:ca60:7bdc with SMTP id af79cd13be357-7ddec83adfdmr874233285a.48.1752261966090;
        Fri, 11 Jul 2025 12:26:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b48bdsm23045806d6.28.2025.07.11.12.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:26:05 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CAABEF40066;
	Fri, 11 Jul 2025 15:26:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 11 Jul 2025 15:26:04 -0400
X-ME-Sender: <xms:TGVxaEr3t-y0z3XbQJS5uzsszc86CQxpphas6KuDseyXVuXOyGTPGQ>
    <xme:TGVxaMIvioDaOOA2igtomooNDMlwuGV8q2LGQbo8SHxVB1Bmuyp_vqXBVq4U20Ec4
    GQMpfZsBLY5iiwdcw>
X-ME-Received: <xmr:TGVxaNwApmjLEjY-H2oQhTCl8aZ9BiXyygvgn9IY9m0TB9uIbV34KgN6CyvLhFPnoChCzFwX7SUzXtgHBxvO99D7h3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeduhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:TGVxaLavNepknuDm-QvASV8tWdMIZsevdvKaRVxnaEcKLJFeR0BX2Q>
    <xmx:TGVxaB6seHyJc022EtIc6Y1isic1FIUjMOdneqUcH56R8LiXkz6F-g>
    <xmx:TGVxaEBTUKPM-iqLtc-n_fBKjSj91raYcofBFUmbu4mD9Sv2JweqNQ>
    <xmx:TGVxaPv7r0ITUwP3NzMR5WT11V0J5EREL9VJwknJ_eeTgIsSx18KsA>
    <xmx:TGVxaButY3S48qkXy9UX3a6JPI8IckyslmdVOOwu-jkXHFz6nzGBVeUd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:26:04 -0400 (EDT)
Date: Fri, 11 Jul 2025 12:26:03 -0700
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
Message-ID: <aHFlS96FTRgS0dH_@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>
 <aHESYzVOTCwADqpP@Mac.home>
 <DB9GF0U3JJWL.3FQFMRTBO52C1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9GF0U3JJWL.3FQFMRTBO52C1@kernel.org>

On Fri, Jul 11, 2025 at 08:57:27PM +0200, Benno Lossin wrote:
> On Fri Jul 11, 2025 at 3:32 PM CEST, Boqun Feng wrote:
> > On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
> > [...]
> >> > +}
> >> > +
> >> > +/// A full memory barrier.
> >> > +///
> >> > +/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
> >> > +pub fn smp_mb() {
> >> > +    if cfg!(CONFIG_SMP) {
> >> > +        // SAFETY: `smp_mb()` is safe to call.
> >> > +        unsafe {
> >> > +            bindings::smp_mb();
> >> 
> >> Does this really work? How does the Rust compiler know this is a memory
> >> barrier?
> >> 
> >
> > - Without INLINE_HELPER, this is an FFI call, it's safe to assume that
> >   Rust compiler would treat it as a compiler barrier and in smp_mb() a
> >   real memory barrier instruction will be executed. 
> >
> > - With INLINE_HELPER, this will be inlined as an asm block with "memory"
> >   as clobber, and LLVM will know it's a compiler memory barrier, and the
> >   real memory barrier instruction guarantees it's a memory barrier at
> >   CPU reordering level as well.
> >
> > Think about this, SpinLock and Mutex need memory barriers for critical
> > section, if this doesn't work, then SpinLock and Mutex don't work
> > either, then we have a bigger problem ;-)
> 
> By "this not working" I meant that he barrier would be too strong :)
> 
> So essentially without INLINE_HELPER, all barriers in this file are the
> same, but with it, we get less strict ones?

Not the same, each barrier function may generate a different hardware
instruction ;-)

I would say for a Rust function (e.g. smp_mb()), the difference between
with and without INLINE_HELPER is:

- with INLINE_HELPER enabled, they behave exactly like a C function
  calling a C smp_mb().

- without INLINE_HELPER enabled, they behave like a C function calling 
  a function that never inlined:

  void outofline_smp_mb(void)
  {
    smp_mb();
  }

  It might be stronger than the "with INLINE_HELPER" case but both are
  correct regarding memory ordering.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

