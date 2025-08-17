Return-Path: <linux-arch+bounces-13176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294BB29142
	for <lists+linux-arch@lfdr.de>; Sun, 17 Aug 2025 05:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7BB1B244A6
	for <lists+linux-arch@lfdr.de>; Sun, 17 Aug 2025 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C61A2381;
	Sun, 17 Aug 2025 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ2nK4Hi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C316CD33;
	Sun, 17 Aug 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755399869; cv=none; b=hMfcJmasOkCPnEPy6A6tq8RFsxDtseuz+I8lKRpou4i0wCuZuNWbnsb7Vj8IMRfzxX2b0cJNG0vlLhfHIyxw6m7emAbVeZZi+JCbmpdmbOq/A9uHSxG7LpGpR33Cn9TVkdn4YicbjCugB3sXPDcdokErotffD/GwZs1dI76d/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755399869; c=relaxed/simple;
	bh=bwzZ0EHT9CLOPYhrp9QBXtnFojq0Dx5Sqmor4zirmvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8TPNT2tMRyaK+vFCgB58DPaz0uSwi70zUQnNDhKjJaEnBF5jX09R0aD/AI1dt8cHJ7/+lE7YyG0bbsA6ctJagMyoA2LntOJMNHEM7xQc+8rqHdARGbwf3dGh0FJE+FbRSdWQXXWUJR4jwVFo6MLx4ZSxGLauhLTGKANHS35I3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ2nK4Hi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8704cdc76so347753185a.1;
        Sat, 16 Aug 2025 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755399867; x=1756004667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZs6He76FpZcbIW1aa62IVHXHMVIhxGtWlvMIkdGXCc=;
        b=lQ2nK4HiTXDbvHIm0IRwqsdSsyqHX6EQgUH1W4BN5f4asdYHSCqfhth4/qolL0HIOK
         G6cJdufJ7NB4M6xspQJZYrmY9BIfInPliwdkEY27tPZm5qy/u6y03S1TM8+lOuo6qGih
         1JrIxo9Er6NuXveGtK/eEqivsOFa8CvTcxcbngRDz1jFe8IKwM0wzWJSqxVB3UjwBG1S
         vpfVCJdVPyf65NKZIHHSR8pNuecfNolZNENJr/Rv1VALlySBu/ZPQTeHMeZ4BfKhzrdo
         5mCQC0YrjdfOa0L627uSR+oPwuNZehyQR9sw50wJAdhmw1YA+0OaxWVWMmRe8xKKtWb9
         b30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755399867; x=1756004667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZs6He76FpZcbIW1aa62IVHXHMVIhxGtWlvMIkdGXCc=;
        b=cV2fE4mkb5wxPhmp+3V4rTIqMZcwlt5dDgU6tB4S7oVZ+mY42aRZvEb46IJfwkjwDk
         hBOG5k7b0YJbczaUlX5i2ZTRVYpcu2J9LrtV1KTFtjAj8NVn61lUDF36XfJnHQtZW8/D
         yD/HIWWdT8vy21nVHhYjc1RlzrWCNE/zItpa4fYlrjOPgJ246l2zWGd2QH12c/cdfQLU
         X1Al1iL2jGY8UCa1Lt7dpek8pwZG4ZUCuCLD6l+9EDSBFowlSJGoLJq1P0iYic0WYGaw
         WASLDyE2uBe7DvWNyF3lEdHDausr7NugNUKtZAq2MHxTwXWyZYuIGKUDRLSDY9vXQnfn
         nnhw==
X-Forwarded-Encrypted: i=1; AJvYcCW4sMzAkDXknetn74gjHCKaOwZi3E3x8rH9opKHP2LzrdLnaBjFxQYuqGqiLFrzq2TDD00EclP7HA4PD1kEEJY=@vger.kernel.org, AJvYcCWHHziG+McE2eVvKx4uJVh1495ZIUbs2fz79hYuUCgb9EiNB8tgAfy9WG5PTIfYNM3ix9yoAVuQUbag@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVNyjQIPqgytQkhL3Dq3oBwjvg/Y0MkjAWpYEFRvtRnXPtflt
	SnZBteKQ2zZ17+F+gJcNYzFiARn9eNdp5am1LW+BU6eQek64Rh44J3pK
X-Gm-Gg: ASbGnct9ILMx0RPQECo/sKyuffOgkIiZ2iyzZ05KNAn2cdyt523CdYpBBy1weg4e7s8
	uDkbQI9rPllevexzTNyd/+SFBHzSa7eplvJkYumfpj/JtzpRWKTjFZXxqoSZw/ik7kru2PZCr7x
	B1oUGrkyakNxNa6JiQ3iLPbOJvGzfsBW2HuzJRhwaQZJF+uChA/jvN1D1I10Cc9T94Ju9YsrNr1
	27nBYb969ETtn0bB28kIUsEYGkudNauHXxMAEAsZZUuenwQl86vuvkpwVRR5Yx07vS3tTdaL3pb
	qsOU89OiGytLBbV8LdUg8/Bv0yRckHmRky/WnCkm09mkbhKn7CTS0gejBTBCXlXrKLmeh/8hfga
	0JdCEakObFxTOqhsfgsy1pumvJFEg2VAV/wFtWPM6RE6FThff6eyQebSDnCJMZz98mbFdNylrRK
	zH65H9WhEUcHHRscLugfw+M/0=
X-Google-Smtp-Source: AGHT+IEcGyW6Wy1k4I4mrqmEJrNmhDO/3ICtkA1wv9HqXpE1GA4A8FOzSyKlvNXQZJn5H+9FCilqUQ==
X-Received: by 2002:a05:620a:29c5:b0:7e3:4aec:2888 with SMTP id af79cd13be357-7e8867ca173mr523543285a.35.1755399866644;
        Sat, 16 Aug 2025 20:04:26 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e06a913sm369430285a.26.2025.08.16.20.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 20:04:26 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 605B3F40066;
	Sat, 16 Aug 2025 23:04:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 16 Aug 2025 23:04:25 -0400
X-ME-Sender: <xms:uUahaLscPFBD_WSTneNGPp2tkdvcy1WgzXTblU8HYKZr-l7ZnjEo7Q>
    <xme:uUahaN-mnRssVlF_QUvBa9wNziqfXgIHq2pum7Vx6GebVrIArRiQKujn67vvmfeA1
    ugYnJCG2XvAieERqQ>
X-ME-Received: <xmr:uUahaDXGr-F5oHvn5Ad65Y7j-xA89I7gnGhvZfEHlSaPWRGkL4MxP8oK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhkeelhedtvdehhfdtvdekgffhkeefveffledvuedtffffveeiveegjedujedv
    udenucffohhmrghinhepohhpvghrrghtihhonhhsrdhsrghfvghthienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgs
    pghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhssh
    hinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:uUahaJusuFa-0t7Lw_LEL_9ELnKkA_q5UYdmYxy3Fk38xEm7-uWEmw>
    <xmx:uUahaJ8XkBhmWiod53qs32Uqv3mGw6F_d7yNCbJLqtNmUpLUlCvNFA>
    <xmx:uUahaC3_yhzmifJR9-qcusOPVtKDZLbqakA19xqCgKMAIr04CkG4pQ>
    <xmx:uUahaOQd3jaWfajZEboVoaO3emueN1D2NIBbuPtDwHdSgrBBPy4fmQ>
    <xmx:uUahaFBzSy_XpD15mAcb78ytkOv237PQkQqfHA-su0-RobZgt-Gj2hGh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 23:04:24 -0400 (EDT)
Date: Sat, 16 Aug 2025 20:04:23 -0700
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
Subject: Re: [PATCH v8 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aKFGtzQnUdH4zUGD@tardis-2.local>
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-7-boqun.feng@gmail.com>
 <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org>
 <aKCtbSDuJNrtdLNp@tardis-2.local>
 <DC43RPUDBY6M.1TGSQKJV9BKSF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC43RPUDBY6M.1TGSQKJV9BKSF@kernel.org>

On Sat, Aug 16, 2025 at 09:35:26PM +0200, Benno Lossin wrote:
> On Sat Aug 16, 2025 at 6:10 PM CEST, Boqun Feng wrote:
> > On Tue, Aug 12, 2025 at 10:04:12AM +0200, Benno Lossin wrote:
> >> On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
> >> > +/// Types that support atomic add operations.
> >> > +///
> >> > +/// # Safety
> >> > +///
> >> > +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> >> 
> >> Can you add a normal comment TODO here:
> >> 
> >>     // TODO: properly define `wrapping_add` in this context.
> >
> > Yeah, this sounds good to me. How do you propose we arrange the normal
> > comment with the doc comment, somthing like:
> >
> >     // TODO: properly define `wrapping_add` in this context.
> >     
> >     /// Types that support atomic add operations.
> >     ///
> >     /// # Safety
> >     ///
> >     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> >     ...
> >     pub unsafe trait AtomicAdd<...> {
> >         ...
> >     }
> 
> 
> Inline maybe?
> 
>     /// Types that support atomic add operations.
>     ///
>     /// # Safety
>     ///
>     // TODO: properly define `wrapping_add` in this context:

The colon looks a bit weird to me. I would replace that with a period,
i.e.

     // TODO: properly define `wrapping_add` in the following comment.
     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to

Thoughts?

Regards,
Boqun

>     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
>     /// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
>     /// yield a value with a bit pattern also valid for `Self`.
> 
> ---
> Cheers,
> Benno
> 

