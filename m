Return-Path: <linux-arch+bounces-12407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C467AE0C2F
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 19:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E03B757E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7928CF64;
	Thu, 19 Jun 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JaRduo96"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7319D8BE
	for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355825; cv=none; b=LCCTKHOdlJdd/2bQy/9bvx6HpMZL3pVouTGMIZdsNbJ34wRmp7uGoZ2E8U2eR8XfQimei9cfnE/SUBBgeNLgvMHqA9JcJLp+Txd4wwel/3HJ+cszS2FdbORQP7mgRwf53n6iSVHx1zsHvgDtXBuxpzNR+tBULeJ4ii/mRFQYm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355825; c=relaxed/simple;
	bh=eai0KmAEI/LXOe/M1noE2xH7znIEBHLB9tBGHx4OkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7wvR7dlhbqcxn6ZvntB9SIEugoRIkVa5capG8+NCv6/HHvmmYIlSyV20zp8FONlLu/Q0Ozmz8pNbKc+M5iSzb2/SISMIYb4JXUqDtortyhiMdUku0xGR/vHaMay1Sf2qua/OoYNqFQmL0VloEHqREs7zU6+ZHWVxOqLZBvvGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JaRduo96; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faf66905adso5824726d6.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750355822; x=1750960622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8d2ui7E+uX2eOaUMaNXo/P5F6Y0SfvCqCGd0JgYOPM=;
        b=JaRduo96YQ6iqnFjPO8CC98dm9mUwSs/BjQgN5vUvHBrlSgW9qoXLSTAhhfpzLqpTr
         ReoT29Udl/8KWrdG0fwp0oNpQrPgMMka35YLgFOXJlKEyJ0P/V0UWEAEN2JPTNQz1iG3
         9rGXhGvQdbb5aLcJaGMjekONyZGkd+gLzsqeI7CUj6AsW+OVAy25ta/MFCFOp1ZRvO4V
         juAtPDJHqK3YYFcDKJjvjv9YGtW3+P9db1jcyiaifMrQUx+sHNA5lKqjSzGq8khpOPbX
         Fg9KMv+3YkOgI/Jr73lL8nj9MmiLEElE1DQ1/4BaBIV2ZbB8+3vEM+PuLHDeofMMCkBj
         Ydcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355822; x=1750960622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8d2ui7E+uX2eOaUMaNXo/P5F6Y0SfvCqCGd0JgYOPM=;
        b=fR+bLgHz4dQKvzPWm4NRxAZFetBzDSS5j6iBCXZBAb1anpHVi0JQeMELd1poBnswTS
         j+wNbjOEDRld6qpILB0krPqy+Ymf/9pLan/nAoenGSy4p5EK/tBZEvc8Ua7uwWLdgE1b
         c9GyO1QvCIV8eDp+P3Rk1oMT0fWB96BZWqL0yZ4sfVtCb1bWp2cP3RLuEF41MWKnt+8M
         BIypp2qPxuaZVwWA02dbgxL3bA7b6mqq+hZsYTj2t8nkbJnu0bxQ2AaPLBvCrZPHlWYf
         5U2bfcOWxEAlYyAkl3xY/Rnsr0185/eD8fdG+nX/W/sGPuN013JYDe1PkPYyJdotCVMS
         dm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLy9Kw11/kL/9dWUYlZKF7f5vHtB/U4/ANESudMfcjQqz4DeH9z38UcPdCV6BWAEv9VCeBoxePLaoj@vger.kernel.org
X-Gm-Message-State: AOJu0YylOjFfL/URVOB81jpIda57o90pFZ069XEpHAvEEmKlG95xf2YI
	A0krraXA7Rm/8ndPeum0A6QEGpsUO4P9CaqROdKR7aQgxPDr4kZ43O9vit1pBsmLNg==
X-Gm-Gg: ASbGnct4CPgRNL+nLxP3IkT4Ijt4Fl1xoYyBaiHwABW4wdazN76ajoKQ3z0+eEd5nwa
	BXCGo4QU/bDjqvriuogbDUyQdtUjPUSYO8NIxhR0XFkiPSd9Q1M0Xksezgei7K0S7pSJbpi+prA
	Zfa47BW/bfqX9Rlnqwj1IjPiTO1qhGKq0DANgMB7A90XXLRW813DhhRIAMsB042D75I+F/DlmBF
	BkWlVF2toEU4qQpJXZeZlTiiPOC2KHwqlBJlzACJSaaDH0rxFgQfn/40V4709PBXC4gL3qoVk8U
	lAinlO7bqsHwjfyeLgYqmGoeS4+aCxbPcNfrxgnQCHj8SvV0Y9SDILKTVOBJX0E=
X-Google-Smtp-Source: AGHT+IFfAivhqC/12RhcVOhHTCkxtn7BPAMKJ8jBgCMvwPH79EHDEwzW7+X8dU3ooMKnx4PjKTOoZg==
X-Received: by 2002:a05:6214:2c0d:b0:6fa:c5be:daca with SMTP id 6a1803df08f44-6fd0a4694e4mr3308996d6.7.1750355822520;
        Thu, 19 Jun 2025 10:57:02 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9ca8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09593450sm2348556d6.98.2025.06.19.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 10:57:01 -0700 (PDT)
Date: Thu, 19 Jun 2025 13:56:58 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thomas Haas <t.haas@tu-bs.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <a0887a91-468c-43ff-872e-c4c4e23b26dd@rowland.harvard.edu>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea>
 <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
 <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
 <aFF3NSJD6PBMAYGY@andrea>
 <595209ed-2074-46da-8f57-be276c2e383b@tu-bs.de>
 <6ac81900-873e-415e-b5b2-96e9f7689468@rowland.harvard.edu>
 <c97665c6-2d8b-49ae-acc5-be5be04f0093@tu-bs.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97665c6-2d8b-49ae-acc5-be5be04f0093@tu-bs.de>

On Thu, Jun 19, 2025 at 04:59:38PM +0200, Thomas Haas wrote:
> 
> 
> On 19.06.25 16:32, Alan Stern wrote:
> > On Thu, Jun 19, 2025 at 04:27:56PM +0200, Thomas Haas wrote:
> > > I support this endeavor, but from the Dartagnan side :).
> > > We already support MSA in real C/Linux code and so extending our supported
> > > Litmus fragment to MSA does not sound too hard to me.
> > > We are just missing a LKMM cat model that supports MSA.
> > 
> > To me, it doesn't feel all that easy.  I'm not even sure where to start
> > changing the LKMM.\
> > 
> > Probably the best way to keep things organized would be to begin with
> > changes to the informal operational model and then figure out how to
> > formalize them.  But what changes are needed to the operational model?
> > 
> > Alan
> 
> Of course, the difficult part is to get the model right. Maybe I shouldn't
> have said that we are "just" missing the model :).
> I'm only saying that we already have some tooling to validate changes to the
> formal model.
> 
> I think it makes sense to first play around with the tooling and changes to
> the formal model to just get a feeling of what can go wrong and what needs
> to go right. Then it might become more clear on how the informal operational
> model needs to change.
> 
> A good starting point might be to lift the existing ARM8 MSA litmus tests to
> corresponding C/LKMM litmus tests and go from there.
> If the informal operational model fails to explain them, then it needs to
> change. This goes only one way though: if ARM permits a behavior then so
> should LKMM. If ARM does not, then it is not so clear if LKMM should or not.

Okay, that seems reasonable.

BTW, I don't want to disagree with what you wrote ... but doesn't your 
last paragraph contradict the paragraph before it?  Is starting with the 
various MSA litmus tests and seeing how the operational model fails to 
explain them not the opposite of first playing around with the tooling 
and changes to the formal model?

Alan

