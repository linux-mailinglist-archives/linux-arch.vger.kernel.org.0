Return-Path: <linux-arch+bounces-12487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39DAEB9FE
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF393AD946
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5462E2647;
	Fri, 27 Jun 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNIuzAcV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644752676D9;
	Fri, 27 Jun 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034891; cv=none; b=hhBu5HZb5vFwe6awkc92ucR4W/9ODq0F5OFqfKCycWf8xrmBFELY77KWhIRvafPMQ84L3QJL0dYQdmVrK3BWksJqgQo1z1pWvETMnZEp4qdemKGNoDXIcJPpH8HH+R9xqf+PWwOwFuw+TC/KWIKL/0FvKvt2tthnWGQ/VFxBlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034891; c=relaxed/simple;
	bh=8SWOTq/6aB3hD/Rp3uSJjKSKkSx47GHiVeHf2/b9/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHYl/zAVNb17gLUXLrkTHj49kBCTOK6SSxTq85pl6ZRR1U180CjZHUxRnyACJFRSlGEAJnJ2XAdBPq12dHfzkSyObkyzT47p6LZrKOlN6G/W2cBaN17WFxnX/XCo4YfIbmEGHIFcEPfxbkxQtIkLb/NXoWHR5pa7tpEFHTVioOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNIuzAcV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d094ef02e5so366804185a.1;
        Fri, 27 Jun 2025 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751034889; x=1751639689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3XPUo2k/JzlWPJidlVVJlbfbcPmIjqtbYrSomwduhg=;
        b=GNIuzAcVyU2FUvm0kq0ocvJmZHj8bs3gUQ0NhKOtHnLUrqvaRJlzrj9x9Uz777lYIR
         UmNbQ9mbtcf+hWjjsDwns7VFKdr20u6N4FQvTHVehrY21iKDG/ZpW6Ds6V2fbcc6lnRz
         9mt7kCIYaAhsvyXrvIzaSpOS6YHrETGkhuomrXngrxDnRJjG9TxsaCRBZYWeElkvYvvL
         SwpZsNKchXnYZFvoHdHf0gqeq12li1gOuAMKXzvZ3AApr3bGn2/s9FiRoPzcqTUruYKu
         eqy6bMfLUi+/dCIBS7gp1WUhb8bYZvqGMR+/O4X4u7m5i0O8UrdRTCFp65ZpV+ToDMCm
         5APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034889; x=1751639689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3XPUo2k/JzlWPJidlVVJlbfbcPmIjqtbYrSomwduhg=;
        b=Q05efCb5RVWKXOIHlICQoztTIoDtAesk4/tnDy6s8xBpV4aUXcD1f/nYpz2YmB6uZk
         GJLzC++9XZmRY3LapMCxnClnaYzJk6SJSHm9Cm1S8fIQrDo4Kvxy3wsxflZm3ftPN7v4
         V+6YHq6cbRnMk2j4RWcaRxe9AOEJCzMaE4c9yd8qGGA/IwMygaa44G3V1BQMUI765b2B
         rWFACgHgkMS6Fcse7ryjMOXTA1qx5j8vmwFu5yhzhNFIbnB46/o+g6Ahs8Dp8UWDG5pc
         18NhwxXQtITOJEZZ3yZ0H8Hj9h27jeR0GL7J/PknXi2HV0tEZfjop/MbP8stDxdkB6gV
         QoxA==
X-Forwarded-Encrypted: i=1; AJvYcCWveqpNMdFkxrgE/35vyCKzbmgv7OFTYySWJnQmOk5aj/H0HtARfZ4ysy6BQ/YXQUsS+9tzeWUeuvs9XT6zHpk=@vger.kernel.org, AJvYcCXWptJ8ipWDPHp7qvT7VT7+ghbI/YbqswDqVHkkQhGy92qL7g0e7WablYlIcv/NR6YOnvw8OfbtoyvD@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCPsH2MKRX8rgG7K+tEyGUL93Yag4EHRm0FCyzG9TKM3++rnh
	q+cN9q9xlEMU3yONAAZZqdGUOmMBqJWCCKHgBRp6qJAiPFbaYNpKLvbo
X-Gm-Gg: ASbGncsWWIHsTIe8KTO5UjfvWgknmmpPBflXE6qCNRjPudu+KjVn/yEMTdHuNkgmjwa
	g6MkLFhfL+IjzzS6Dz/w3zr9tZjrOXbCUPJs0acKhZq40AUku20hJGRy+p0d6HYrdJiDhXRfE20
	tFkc4E589VV635gvtgNFGkQKQrZzKAb3/7RmgLNxxgUCzEMA7rZeK0X8+VKF2M+Y8yP+H2szcsR
	rvF+z98x3MWxXwz996tF9FUbtBXUAwbS9XIKGtcccijEU9ytVi7DrSb5dXDjeQcvpTt2S1gIl+F
	yuBvEGnnCBIkSqwDwR3KabOie2rXtTMOqCjGB4Rf05C77vC2bhl+Je496rOBND0Gr/edOQlpRrz
	vNHU6AkeP7n7/jsVGAt3jzmf3u9VztgGURlk3SeHoZhP5LsitAoSu
X-Google-Smtp-Source: AGHT+IGZyikryt8hPM9yrcWgWte1x7Olev818FRgeYkv+CxOxSOR68P97cWwvd11To4d5OzNHPBEOg==
X-Received: by 2002:a05:620a:8012:b0:7d4:4b12:a39c with SMTP id af79cd13be357-7d44b12a3abmr10636085a.16.1751034889181;
        Fri, 27 Jun 2025 07:34:49 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44320430dsm138449485a.63.2025.06.27.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:34:48 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25AD4F40066;
	Fri, 27 Jun 2025 10:34:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 27 Jun 2025 10:34:48 -0400
X-ME-Sender: <xms:CKxeaHaGyM6A187x3J_oJOBRqNZFvS84rgUIYDGEEfE1qEU0QKAl8w>
    <xme:CKxeaGZg7cT7mM1bxbQdO0-zLsya3lTSL_WDS1f6w1-qoTSOV-Vguhvxx8NpP51rj
    xM8PyRajhN7ylRlfw>
X-ME-Received: <xmr:CKxeaJ8HFmc8YjgC1rlq7M2UYU4tuBisAk0eyUzEaIc0iPdwB7Nbm22O_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:CKxeaNqEsdx2qMS26nGFaB16zCFaIwIEsqAvNInzeGK8V4aS_GcyLw>
    <xmx:CKxeaCoxLTbTjFCEGNQpc-dx0iS78-gkAPWlrPq120uyxlT8BTPKRw>
    <xmx:CKxeaDRHCOucVbG7up72PP_fDwcbf_eyrSijv8dRGX8v_epSy75Bvw>
    <xmx:CKxeaKqaDLEXezJL2BTQsrEDxGLz24pGHsCG-ufMlhOBMwKKZMYz_g>
    <xmx:CKxeaD5ju76A5mTWN9uDvGOOeyiryUFpsIKIv3HkxEI1Da2qNKMajHM9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 10:34:47 -0400 (EDT)
Date: Fri, 27 Jun 2025 07:34:46 -0700
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
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aF6sBmgTmdM5ZoB3@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <W3facY85E7FjV5y6_67OMqPUz1-Vubr8TpYgFCgXNl8GMh1oM6_bF9V94Kl_oZsdyCQSrxm5WExUmztE3pJ_BQ==@protonmail.internalid>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <87wm8yznkt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm8yznkt.fsf@kernel.org>

On Thu, Jun 26, 2025 at 02:36:50PM +0200, Andreas Hindborg wrote:
[...]
> > +/// The trait bound for annotating operations that should support all orderings.
> > +pub trait All: internal::OrderingUnit {}
> 
> I think I would prefer `Any` rather than `All` here. Because it is "any
> of", not "all of them at once".
> 

Good idea! Changed. Thanks!

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

