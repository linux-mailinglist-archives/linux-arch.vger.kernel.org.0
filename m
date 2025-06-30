Return-Path: <linux-arch+bounces-12512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1426AEE15F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C91A1881AC7
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CE28CF64;
	Mon, 30 Jun 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="TE605Ovg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C528C873
	for <linux-arch@vger.kernel.org>; Mon, 30 Jun 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294687; cv=none; b=Cj56zfH5y7z7fWA+pEjUsVXnS/lbzQ7gStzwiIAEFCkOJYgyAKCRvTA5ph4XE2VC+u83qYl2shxDUZBSD2tfvD08nVPQFbS+1jiaZSosGFjjv1DvJ+ZHdPyKkX4ftqupIQeXhxye8Gx2rRxWeN9uGKKmY4o7kqWXmTgSDFhW+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294687; c=relaxed/simple;
	bh=ap/Vm0hYAdUXiirW96C0YiEeTbMgX/cr/ya8hhJoDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQhRLvi/6KI5URXKQv4fEdIGF+jxuECLgmLjpMKoOWbMhI4h/bk+X8tynL5+bcFilg5p8P3RaZcxEhfx1dQ0D4AweA1ZYEU9KiWtIfdMwBHNVWW2pGYDMjutHeLUHbogiVtKtJkj8OYb5tbYIA5ya1INwbyPPuSUiGoCsZoFdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=TE605Ovg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fae04a3795so50135936d6.3
        for <linux-arch@vger.kernel.org>; Mon, 30 Jun 2025 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1751294685; x=1751899485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ2IOsiMdP1IuJhsvJEX3s5TfXtkiU/6UeXHloIPvLw=;
        b=TE605OvgjiX6814tNxQ1aZBX29+GZ/aT+DBXM63NhSJoXieyywFsEKMLVEdGFPLijv
         x2oWp/t179lVtTdqfqWKrmng0tmIrW179A7To63cWIjnwCvPY7j8ylrpIKLMl7KVoes6
         QIbdn6noCMkT/8DCLFVXilb/ecw20x5eGAvekLfciEbG5CCH+0NuIQqT3hfVdQXZAR6l
         EzNkRBevGXzCjfrU7b1w6hUPsWUAQayn2VqY1fhML7RGidM/ZM1pKKwIwCL3LCM2Weei
         XDuA3mejweOAUgRjHVA+MOG0ciJK+esy+TPlsEFyLYQbt/HDUUq6XR5Be+j049pADMlM
         lHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294685; x=1751899485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ2IOsiMdP1IuJhsvJEX3s5TfXtkiU/6UeXHloIPvLw=;
        b=iqIQLfJEG/NjSQdDDq7FDvKYeeUNOXaZeE43mrc5eEg9iwtUqPRkXS2JP/vV7MlugC
         sFyVF5v1ueDl5YUKiJ/CbvGMT//u+iWDykaLllQzvrc/ANuCgCzsfHdsM71dU3ed9XAB
         FKPnD0+EmQJDkZmBNLsV/YSXDBSqdZIGqNGhohdobautDFRgAnXbEcEn9BjfbpK5ZTfG
         jVBeWppCGpeEvH2DSyrlzxdqCPDLTjOuLzqcw3iieHVT+2Bv3JHpHPsXo2VJWUIznoZF
         U7q8I867D1sAgzLVfFR1SVVN0+8bed8O2tZF61GEsF1CxIO8NZprjYHyrfjhrWWnUn8f
         0Asg==
X-Forwarded-Encrypted: i=1; AJvYcCWrG5SmYc6bSXagR1efgxhxfs3EfEIQyi1rG/eHiM7DxpUZ2ZSWXhXFnpUPEa6jGoBrRI54H3RVzuJT@vger.kernel.org
X-Gm-Message-State: AOJu0YxETVML/+RpBFx0KM1H+0h7i2BrAmP+Q2wCiiJEYCu9m6HxnJJt
	idpY8uwvhuXM+RMy6SNXPLQF7s1zRh/c0wBwnGqqZ9ixWY8GNl6ZipPu/BmnPTV44w==
X-Gm-Gg: ASbGncs1zrCYEY3TpEE71NHzZPAv9oVXJkcy9SUOq23CQFGXJKcaFuK0mYCsyUf9S3S
	J42CvD+MHi6yselxvgAeXo4znnymFwDzJ/0rTdtXZpHl1RiCscocRwmnvp47q57Bos67ZGNfybv
	C7ClIvaJWR00QlcueQsWTZjoDzCjGzqhZlmM4X8i1RnwbmDsf/09ZjNNY6sIc2NpqHlcpt5tPk+
	Ml5hYp9MvT2RsblgjxK4QZedBcgjQ0Da38QcJJ3ScYMDJTGH8riEvIqUEetDXE6eLtSicKiQaB+
	Vq+/fKAD/XmVQuH9r/R5WRkKYTR1jB38YLc2HFDjG9Pf6KvfC8suoRhOr5O3z8zoc+Z0kBORj4r
	PYRC0
X-Google-Smtp-Source: AGHT+IHF16aEg/qn8BZbxpWd2q+vfCazqVYFFAdUoh25jEnDHU8nkqKpn5FdbuttMK7eAlC+ciyVMA==
X-Received: by 2002:a05:6214:caf:b0:6fd:7508:9c04 with SMTP id 6a1803df08f44-70002ee7e20mr190732136d6.20.1751294684428;
        Mon, 30 Jun 2025 07:44:44 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d327sm68783646d6.22.2025.06.30.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:44:43 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:44:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <7eea6ee3-4a9e-4eb5-b412-2ece02b33c6c@rowland.harvard.edu>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <8734bm1yxk.fsf@kernel.org>
 <jJqJwkURyr0NjkFdJaF6oYbPGY4LEzZs_sfY9jlmqoK1B9iE8VjqbfINHilEHxKfmpc9co7DmsS142ZWsBQ8tw==@protonmail.internalid>
 <aF6yRIixTPx5YZbA@Mac.home>
 <87jz4tzhcs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz4tzhcs.fsf@kernel.org>

On Mon, Jun 30, 2025 at 11:52:35AM +0200, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> > Well, a non-atomic read vs an atomic read is not a data race (for both
> > Rust memory model and LKMM), so your proposal is overly restricted.
> 
> OK, my mistake then. I thought mixing marked and plain accesses would be
> considered a race. I got hat from
> `tools/memory-model/Documentation/explanation.txt`:
> 
>     A "data race"
>     occurs when there are two memory accesses such that:
> 
>     1.	they access the same location,
> 
>     2.	at least one of them is a store,
> 
>     3.	at least one of them is plain,
> 
>     4.	they occur on different CPUs (or in different threads on the
>       same CPU), and
> 
>     5.	they execute concurrently.
> 
> I did not study all that documentation, so I might be missing a point or
> two.

You missed point 2 above: at least one of the accesses has to be a 
store.  When you're looking at a non-atomic read vs. an atomic read, 
both of them are loads and so it isn't a data race.

Alan

