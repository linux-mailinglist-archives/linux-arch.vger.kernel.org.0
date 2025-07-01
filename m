Return-Path: <linux-arch+bounces-12546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C123CAEFD12
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10C11888670
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7727780C;
	Tue,  1 Jul 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1AA+efQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAE2749DA;
	Tue,  1 Jul 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381424; cv=none; b=hC5RsmDAMSsC+l3MXdDsW8Mlhq6iPwQBD19WGObx6jaHyUWu3f08T6GGNZlfdfXJtP+wh0PfVqeGzK9fp3dek+4PePo6m/9M2rUM6Ax8oVcHuaDoitUErQWJ85WC+PvlqIPDAyGbaA4JGH6bY5pSOYdiuxG+VBuHsHV6fukYZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381424; c=relaxed/simple;
	bh=Pp4vcS03lDmrPdszYRwucchkYH6zncgLHopCa9qKIcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hifjwmGKxZ3Ezvr6rjXnutuDpzpRqeDTiLz5kxPgPjDLw7+EWXOcPbxORGwGKdCjM40CpwIz2Jyt/Pj6HkTXxY9Qu2ZIGzP7HSD2OCJPvHsHtFZDsbHsuqF6hsA2t92EDcCdqaO3NGDp9DITQDUoBHIr7AvKi0ZbLZIfFskQbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1AA+efQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6face367320so37949606d6.3;
        Tue, 01 Jul 2025 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381422; x=1751986222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xMPzI4BYFmtrcIaXCgikpxCSbMyY6dtY8BA23HqZsU=;
        b=X1AA+efQVofjVvJHm3GgMU+OFGltYRfRo6fycQbhHTK5BLi/opUW26UgHlvJNqr7jP
         AyOPHMJDYNRPFOhITSlpdEmmTUzDvuUFPYpAy9anwreQ5gtPgTlvFdLJx1JjzuKFtTUG
         BbDpIbjvVpIHTCf1r5q7g5mM0KAGTcFCEX2wTbe1rOQlL25JlyDtQsQtan1XsGGl+3ul
         5UA7WHhrkoePdaqV8nSKQRM8SwTQvqQfWN7a+KF/0Yx8hpTFxR8+6CqeZAOvmkkRSatv
         XyrTQsudFOQm1ZK0j7fDsk96pAH21fise1brizYq1e4KAk/pfowsCphckeu2FhOQVCj9
         33QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381422; x=1751986222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xMPzI4BYFmtrcIaXCgikpxCSbMyY6dtY8BA23HqZsU=;
        b=wxX2YB66s+StYhapf1nAPt+m6y+9w9yhwb9+KM/1vzkZAuoBLvlIEfEriUE9Zf4crV
         hLtwmHGmCbidxEIhXxo/JwmpP3x6HbfqXD6M5uESEOoSMsBBpzf8/ukpWst7I4cHH/SE
         1wLsMoYMgxmFNh80ehyCBoyWSmPkOKnf0ccQ4Tbnr70z6cJPint8Yuug4qLEqztc6uFH
         rprunniOD9sTc4Yy+mX0GZtNgIAmYjV58YqGRRRs5LNvqa2VhY+RFmrI+q0uLZa0LUu+
         6O/zodi8d6SuUUKrwRlfKtINYhIvWYcsz30E/yXeRg5/DbWaIyhWY5wcU7UnY8HmMKzT
         w4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4B0y7Vwht18+OzsEQWupjpj9nDBgJIjHmBQ1pKpSEvCjTYPUw1N4TVsXuXV3/n9rsT0c/hlwrHqUbca9Y+w=@vger.kernel.org, AJvYcCVOVTYa2vtPh4x9DcV01VbUURUdHEqEUjFAP0X3Ma1eK4IxvimZtpX2SGQJ9L7OqGZTMDx6A4nUhft2@vger.kernel.org, AJvYcCX1ZsXRJk2FWVffiMmi3DYFackMzKlAyZOUrE7dXOVT0VES2cXTPls7Ni0HcRJwP3jLNbkYI5kp0POTa8Xe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56nMYCwYDC4586Kth/sRK1s1V8gLye4ZZjOTmVYWGfu5X1Iz4
	C/lqzZPFp9Lc0varp8CvFbkSpsz47ZT0FuRvtaWNNN6Fnf/3yktXm7Wt
X-Gm-Gg: ASbGncuj7FAQqJR9oH3JlHhbS+9nXhp9iH/OmF9x8X9hivfcNDKd5lX+4iPFCYJKtR2
	HebkQ0kLFN0BxKtcBuVFOUPI2nCCYKEM0BIZsgCU+4NXC0MusTcUZtcg4jXNibJP6y2mv+iLZGT
	5wqNJAfxV0yyN2So5bZPzMT8D2GNXTsOTeGbCgwvwdtgKPbCqaEBz1SKB6vZB5mnnUeFgMG2Pjq
	U8PLV2JFNVogBKh+utGL0MUdcdxrs+7IS1IrlDlH/TUNLzv91EPUwobaDDkqbJ8u6OkIhQS06PY
	7BIFm36r+KnDvInq2jnt9/iSomADjEg4nbdIVZ6yoaT/bKl9G1vz25U5Cxe3oXdVsilcjLePp2k
	llOerjewEnnvZ80+VhIQiyplpO4+xh2CLVU9B0kzpO8o7ICT/dTRu
X-Google-Smtp-Source: AGHT+IHfI2aCrI4TIYMVgRKiuqjH+gb+mFLEAN3w4NLv9Fi8LElRo+IdtEtnYa5pG130yeXIgjMESQ==
X-Received: by 2002:a05:6214:5f04:b0:6fa:fcb0:b88d with SMTP id 6a1803df08f44-70003995071mr338769956d6.28.1751381421434;
        Tue, 01 Jul 2025 07:50:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771c0d3esm84971806d6.42.2025.07.01.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:50:20 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33A68F40067;
	Tue,  1 Jul 2025 10:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 01 Jul 2025 10:50:20 -0400
X-ME-Sender: <xms:rPVjaDmf6bppXXWuyv1FjC8_peq-09fIctn0u9XCKW8HJGaMoalaTg>
    <xme:rPVjaG0dCPk3Xfsd8Teyi8FhpDmDGrCuBbiXMqNclw-S1PlIFIsFeSBkjxucLCzOH
    -DCvC0FeYBs6CsX0g>
X-ME-Received: <xmr:rPVjaJrNwPDxboVIkUWqKBbELesfszbYKGDLqoh7RVSeV3iA5Yc2cxZd-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    gvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrg
    hrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:rPVjaLlSqxV867VYSVIxy4V0XyF2b04cvL7jofUibe7Ao8Wb0-vnKg>
    <xmx:rPVjaB0zFBPdu2v8fvtKv2UYeIMh2sGKriDGVyWI7S_okQbRHQ8g6g>
    <xmx:rPVjaKttKAur6FBBU7yTblwAgSCi4R-SX6kCCy6UgacTFOtUDLmi7Q>
    <xmx:rPVjaFXl_-j9uf18xtrqCUaFjFrPeK8idU9rx-cRoape6jeWe--tqQ>
    <xmx:rPVjaA3QC0YP7iRSJV12wavuytCNqclO0FL1w9C_7sO-BSGw0mnPKWxK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 10:50:19 -0400 (EDT)
Date: Tue, 1 Jul 2025 07:50:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <aGP1qoda9U0q2yss@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <8734bm1yxk.fsf@kernel.org>
 <jJqJwkURyr0NjkFdJaF6oYbPGY4LEzZs_sfY9jlmqoK1B9iE8VjqbfINHilEHxKfmpc9co7DmsS142ZWsBQ8tw==@protonmail.internalid>
 <aF6yRIixTPx5YZbA@Mac.home>
 <87jz4tzhcs.fsf@kernel.org>
 <Xfm2JGPb6LBj7GAjuEFddz5UvwY_vFr3r-253ujBCBa4galferuILoEDKNSQcfOL-lFi65L-rTnBWAxxCE4cyg==@protonmail.internalid>
 <7eea6ee3-4a9e-4eb5-b412-2ece02b33c6c@rowland.harvard.edu>
 <875xgcxpe6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xgcxpe6.fsf@kernel.org>

On Tue, Jul 01, 2025 at 10:54:09AM +0200, Andreas Hindborg wrote:
> "Alan Stern" <stern@rowland.harvard.edu> writes:
> 
> > On Mon, Jun 30, 2025 at 11:52:35AM +0200, Andreas Hindborg wrote:
> >> "Boqun Feng" <boqun.feng@gmail.com> writes:
> >> > Well, a non-atomic read vs an atomic read is not a data race (for both
> >> > Rust memory model and LKMM), so your proposal is overly restricted.
> >>
> >> OK, my mistake then. I thought mixing marked and plain accesses would be
> >> considered a race. I got hat from
> >> `tools/memory-model/Documentation/explanation.txt`:
> >>
> >>     A "data race"
> >>     occurs when there are two memory accesses such that:
> >>
> >>     1.	they access the same location,
> >>
> >>     2.	at least one of them is a store,
> >>
> >>     3.	at least one of them is plain,
> >>
> >>     4.	they occur on different CPUs (or in different threads on the
> >>       same CPU), and
> >>
> >>     5.	they execute concurrently.
> >>
> >> I did not study all that documentation, so I might be missing a point or
> >> two.
> >
> > You missed point 2 above: at least one of the accesses has to be a
> > store.  When you're looking at a non-atomic read vs. an atomic read,
> > both of them are loads and so it isn't a data race.
> 
> Ah, right. I was missing the entire point made by Boqun. Thanks for
> clarifying.
> 
> Since what constitutes a race might not be immediately clear to users
> (like me), can we include the section above in the safety comment,
> rather than deferring to LKMM docs?
> 

Still, I don't think it's a good idea. For a few reasons:

1) Maintaining multiple sources of truth is painful and risky, it's
   going to be further confusing if users feel LKMM and the function
   safety requirement conflict with each other.

2) Human language is not the best tool to describe memory model, that's
   why we use herd to describe and use memory model. Trying to describe
   the memory model in comments rather than referring to the formal
   model is a way backwards.

3) I believed the reason we got our discussion here is because you tried
   to improve the comment of `from_ptr()`, and I do appreciate that
   effort. And I think we should continue in that direction instead of
   pulling the whole "what are data race conditions" into picture. So
   how about we clearly call out that it'll be safe if other accesses
   are atomic, which should be the most cases:

   /// - For the duration of `'a`, other accesses to the object cannot cause data races
   ///   (defined by [`LKMM`]) against atomic operations on the returned reference. Note
   ///   that if all other accesses are atomic, then this safety requirement is trivially
   ///   fulfilled.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

