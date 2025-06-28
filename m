Return-Path: <linux-arch+bounces-12491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17388AEC460
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBED1C240FE
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F421B905;
	Sat, 28 Jun 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj7Bj6K5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E981A2C0B;
	Sat, 28 Jun 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751079880; cv=none; b=Mklv4Yq1vpuuBOqSfMVrqQxLN/mkxwXgxJu1XNDUyXfOUVk/Aq5dSoSvjS31EKpxa1uF44eCYi5OEjSjGQ+gxR2sGJqXO0O9tPDiQQ5MSiN6fPX9S0V4+qVbXZ4iK3N2s3fm/khQl+jlxpsNe290gDiHOKDS4BLtb6QHbsui8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751079880; c=relaxed/simple;
	bh=A199jhFR5Qy6+t8wqS3MkSs28EyiOM5Yrdp6FjD86/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKC4CyG+pdTbRunAQNBF5Ka0a6zUO5wFqH0pDezcoAGWsyvaTxnura0Zdz8a+KVAwKCH6MgzPVEZJJusOodRmP0k7cMSKeoT/yP4WG0IBb5ZYkTXh45uLe2i80Qd8STJHM7ZUmOFWW01NwOC5JsMjAr5FLGq4CV7vGhTGadjC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj7Bj6K5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d09a17d2f7so41401185a.1;
        Fri, 27 Jun 2025 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751079878; x=1751684678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBxGWmQb5nk/fyFqkHAC3KnBOgRqr/pEMtIFxkLYnss=;
        b=mj7Bj6K5eMnBJD674Fagq1loUx8ZX5OthA1JS7rk8ZQgppn5Sb8bT0C9Lu6KJXeYsO
         jARX5d2xmb28JzZFVbwYyxE1nTOWJuLK+QNHstXHDm/6njBPFe4eIQAxBtzubHFFau0Q
         iiuuL/I2k1D9IjsZBXT4KOl6LUm1fhuKrCPHtH83T39sl3aZpdlRFiDXpwnNmEpinm9F
         +rn0ReVpfHTGmxJD4hw/rwduwU2RkwLo+Y2At1EuucHb3vci4k9iJ/NtXYwawrv6z+AQ
         GmQ/ZLfCV5yjdsR/iWXrQ31horjIH0IUdHN8PFf0T8s6EBXAA8cgo9YLgzM04oVGZGZI
         lGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751079878; x=1751684678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBxGWmQb5nk/fyFqkHAC3KnBOgRqr/pEMtIFxkLYnss=;
        b=ma6i0ZkB5kigxDwJWYiHJmnrUnXUHxUfyCouzjrQ0RG0ZzOuOItaQBf83KZVicVSdp
         UJBqcNpbK6HhQu56alrYaic8QyJ6vbB2+E37Cqb09+KwHlL2JJ4KHQaGgZwdTIt+VyMD
         9tJEyJtQO2bMhpv52iWbhadAH36s9On5HyuVwBk2JhhzdxmAdIb70mnFukjL7RRqI5Xd
         5KOzpJScQDzuHmTQQrcgxQts5+rfXe/8rnz6HaaxBHkVCPrMkrBZ5+aGQgJG+ncMiMvA
         77qzdPuVx2huxFQkqFyUx/s7JIuXmyea1Y/UlC5XpA63U1Q8JQ/vG1C9F9NUTv4q6Na3
         LBSA==
X-Forwarded-Encrypted: i=1; AJvYcCUCSs8Nqa18e5do/1+Y7EOPrr/sC45k+S/B2O5HPacFDldci3nbtRPe5gCsxbDnbBkhERlY6b2CaRDC@vger.kernel.org, AJvYcCVsFDhYxGW0cDljTEBZGq/Y2av6tKd2rgtLYjEJbm/B9jjwhR+t28P8C080odQji1ZblZ5ef9dETHyvY0DYTYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYnaAD8HV0WRU9CxTwph4Fi/VQcp8ZRNvSOx+/Kam9wqnPs1Z
	c4gb7XBZiUZPg/5k+raMCP5ZJtG0inquztYzwuzphD5VEIKJn+FdSyiv
X-Gm-Gg: ASbGncvDRDl7K97CzAIxXQuy0+dlh0AvwCBX08V6A59tHrmRn6U4EFNSo3AeTOE+JJ2
	IuJM2T6P1sOqBTDtoNUSj217C4vB7dmArAQd/ySBnVl15/kj2q9kRu/4sBQyUtYRAMIc1CedXmQ
	E9nPvzh5XkjjVHFio5qQ/B0TayqQJ8yMDVBVI7xheqA4gIkz7hKJud4JIQb4bkNICIQEHlFgQ7q
	NvUjVdj5N5HoMmiXziogqeQUcpwWWorFB6xVAM3G607i7pWb4VoU7QriUw/y/oHpvqZOkgenqIy
	O2C+0RLl1ueOjbFi9vtZb4mgfhc6Q43LVjSvLzR+zeisSu3rebWmcTrVI3V29qzl6pFAAqipm1r
	G+QRhzL68/v08fnNTJG9LibGAfsckkjSZ28WhEp/n7aU4Ol0hMcTe
X-Google-Smtp-Source: AGHT+IEMhz5iYk21dCtC1J+T5Da9qhJbwioVtNp4BihLPHEjAmfyFJF8r20P/5zPbWgHh60hUN51mQ==
X-Received: by 2002:a05:620a:1904:b0:7d0:9ebd:821d with SMTP id af79cd13be357-7d44390ec5dmr925757385a.23.1751079877775;
        Fri, 27 Jun 2025 20:04:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44321993bsm232088285a.77.2025.06.27.20.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:04:37 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78802F40066;
	Fri, 27 Jun 2025 23:04:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 23:04:36 -0400
X-ME-Sender: <xms:xFtfaNQ5HDN4uzShRCrOpL0yntYmtrJHJMfN0km4FAysrKe-4-jfOg>
    <xme:xFtfaGwzX47PfuTePuNnee15Rc4oHguC-lrWx5G91OSk0AW6czQ2dEBxbOhbHG9u-
    FhwClcCBzulDJ2KMQ>
X-ME-Received: <xmr:xFtfaC1FrC3Ti1npqEvJhqfBKuhQcaklP2GQsJ1gzch1GoEzh2AsJV_0hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
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
X-ME-Proxy: <xmx:xFtfaFBO30jdjyu0Er-WsXTCfahfeACGgAZ2tYNg03Har2wDKexw8A>
    <xmx:xFtfaGj8c3VgOFPRFef3vwwYG6VulR9udcCOaJg0mbPEIj2tzrInZg>
    <xmx:xFtfaJqE7pdQP9xBO0B5xi1SHErzH9GcpDm61CQLB5IEJKLf2vsF1Q>
    <xmx:xFtfaBhjRjh5SuIWojKP05EypYk5bNR2gQCk0s5-iKV69RCmpM16Qg>
    <xmx:xFtfaBSO0GVaF8v-4vci8h7gfry4xURzJJtMyJGojysyt4cuWYed70K3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 23:04:35 -0400 (EDT)
Date: Fri, 27 Jun 2025 20:04:35 -0700
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
Subject: Re: [PATCH v5 06/10] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aF9bw_FcuSTvK9IS@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <ZpemRgknqWbwYAShU6PA8VNVPU7cQv8WMNwyb9hlZzfkfXKJ_fyN8xfM2Ca75tXcE6Cv6pGHcNJgrp-p8fm6hQ==@protonmail.internalid>
 <20250618164934.19817-7-boqun.feng@gmail.com>
 <87qzz6znfu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzz6znfu.fsf@kernel.org>

On Thu, Jun 26, 2025 at 02:39:49PM +0200, Andreas Hindborg wrote:
[...]
> > +        // - For calling the atomic_add() function:
> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> 
> Typo, should be `AllowAtomic`.
> 
[...]
> > +        // SAFETY:
> > +        // - For calling the atomic_fetch_add*() function:
> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> 
> Typo, should be `AllowAtomic`.
> 

Both fixed.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

