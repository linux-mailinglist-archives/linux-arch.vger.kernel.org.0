Return-Path: <linux-arch+bounces-12356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B83ADCF88
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5233BD1CE
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876422EBDDE;
	Tue, 17 Jun 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsXpbUsT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88182EF655;
	Tue, 17 Jun 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169410; cv=none; b=b3tbUYpzKg0OLQ6ENVPmoE/qCGcjbg/xF09gZq6GM4HXE6AmEFnC1Ia7URhrCmv8j8RzuPsOTjSSM7GsvpjFK7dha4dgnQQGUUIVaIIeCIyF+Kr1FibPDQcEPQBIZ7kut4sKzqm4rM6twz6gf39+LvwGIefmnqGqc7ZUQ/Q4yeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169410; c=relaxed/simple;
	bh=iyMKWm3mSC0FkjcF0R3622r5I8u9Cp5VpdkuiRTVNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQHG+4X0A78y/BGHAEiH2MoNY4cWzSMp7ZM54ejlvtAE+TALjffpMzXeK0eIdLm5p7vqAk//0xYCfapEu1yQgtZnuwVQ1ny1m2aK1+j0ZvJ35w7Rd8r7qk3gW/r5x/j9L94uEKTyPf4DqL2nT8R3NrPcGcFuavKemKlT1E9RRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsXpbUsT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54836cb7fso4013762f8f.2;
        Tue, 17 Jun 2025 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169407; x=1750774207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yIBACmWgX7l966LbMVSZorYkOqXPTghDqN6AWOfmEo=;
        b=XsXpbUsTDddmGAqedEmbTnx/o+neePRmjVujiRvNSf+MVnjsaBDrjWEkGaJnYNLIXK
         1E85tXEOncucEtLZ792tMUeqZRTihz6URxB3TPmAQQxmiZYpQKcexXCW7ouzvw4AM98a
         EfMqH0OJJ6JvrUnpcEQPP85g+OXIi7R/cCZrKzCCrYPSDCyZrDKLMxLH//j2fZxOgH5x
         yki9hWN3gvb0aHy9NYuhBM0a+zSH4pnbSsYK5Pu2zMSQrV1HMOhKjmj0tkK5h7K1HkQR
         GyKqvjjp3GQlI6Om6Zr/UIWgDg5Hf1LRx969/8DQZl5HLJpjBNAdx3csu7ob8KMI6sDY
         zy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169407; x=1750774207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yIBACmWgX7l966LbMVSZorYkOqXPTghDqN6AWOfmEo=;
        b=RtmtHtZez5NSHp7PLK5OB7DnLaLy6KstSc/yl9dNdoD95q/CxB3N6gADkWQnHm/Dp9
         N5b4c6AxivPGDQw+aids9tiBuMRumRSldQNLg2ymXFNfNxehrkHSZ2hpuJU8nAO0bEYe
         JmeUxeAGFdbtfANfFE3POLIeKH1+8RlRF+WXkzPdH8GMmhCJpfT0QV2DblSWoFuHODTu
         01DEJFuF+AQZB4sqV4iQgi/8giNsgcrWYZNtjNoan3YSyQ85TQYVxDnwYOD31oj8GCZw
         Yf983x294r8a1Wmsj+oky7nnNLWwN/rKkhMWHiBqbhxTfkADWkKkVGZL9V5GYwPc2V0B
         2nxw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Lq+5/86MQJMdjIu1we7vZtH6JIkJFP66fhhIsEsOuU2vWLXuOwO6DAakpSWuhJrjS63jxXc8ShkC@vger.kernel.org, AJvYcCUp8eQ2hUGfU4v4nCohHR5mCm2/ZJvh29aHE4QJovr8qIeEj9AICuxC4wPil46YhQIvD2aI2OdMzOxVR7C3@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLAsVElBfbT65a6VmN80dDq6de5Nhg8l3x21nOsp/MO/hrhfC
	EjFlMqiTPEFgyQ9m3gtauaIPHY1A5fMJa4uPl3/Ngrb9NqOMpxaRG2xd
X-Gm-Gg: ASbGnct6t2xrrYKZAcU+pXehMonuHg6fN0wJhzsULnGM5wb6nMe0O/6IRonvBa6kMfi
	irD505v2LvxoN6qiHc3GXasPRfYhwSsxQLJO+1pJ7ozL3sUNIymapqNIYraPeD5XOQyE6uanVsv
	r/w0kiQ5CEPDnGpOzqJqE95grQdeVT+8PX2SNzJcpXQuSg7TfEY1utH5ijQ6mHe+OWURa7lEQQt
	meEZP7LBgF4muZBuxCNmz4+jpnXdJGeU06H8PYZOiF/JBdB+fMUnGKZ537a6D6RmW3CchJ9l0b7
	KO0n5yvJCIz42EugtxvA5x9/w26duwWT9wRcVCD76/2x2D53tDVy0+AyeZXd
X-Google-Smtp-Source: AGHT+IHhV6aPwQ3z4bGt2UdYrL2Uo5IQ2qap/P3r5HVqRrVdq5gQPZ8PvS+O0eqHB3HO/uSvbblRDA==
X-Received: by 2002:a05:6000:4024:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3a572e586f1mr11172093f8f.57.1750169406549;
        Tue, 17 Jun 2025 07:10:06 -0700 (PDT)
Received: from andrea ([217.201.252.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a577e928f7sm10557923f8f.64.2025.06.17.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:10:05 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:09:57 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Haas <t.haas@tu-bs.de>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aFF3NSJD6PBMAYGY@andrea>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea>
 <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
 <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>

> My question is: Do we have enough general knowledge at this point about 
> how the various types of hardware handle mixed-size accesses to come up 
> with a memory model everyone can agree one?

You know, I can imagine a conversation along the following line if I
were to turn this question to certain "hardware people":

  [Me/LKMM] People, how do you order such and those MSAs?
   [RTL/DV] What are Linux's uses and requirements?

that is to say that the work mentioned is probably more "interactive"
and more dynamic than how your question may suggest.  ;)

Said this, I do like to think that we (LKMM supporters and followers)
have enough knowledge to approach that effort.  It would require some
changes to herd7 (and klitmus7), starting from teaching the tools the
new MSAs syntax and how to generate rf, co and other basic relations
(while monitoring potential non-MSA regressions).  Non-trivial maybe,
but seems doable.  Suffice it to say that herd7 can't currently parse
the following C test, but it can run its "lowerings"/assembly against
a bunch of hardware models and implementations, including arm64, x86,
powerpc and riscv!  Any volunteers with ocaml expertise interested in
contributing to the LKMM?  ;)

C C-thomas-haas

{
u32 x;
u16 *x_lh = x; // herd7 dialect for "... = &x;"
}

P0(u32 *x)
{
	WRITE_ONCE(*x, 0x10001);
}

P1(u16 **x_lh, u32 *x)
{
	u16 r0;
	u32 r1;

	r0 = xchg_relaxed(*x_lh, 0x2);
	r1 = smp_load_acquire(x);
}

exists (1:r0=0x1 /\ 1:r1=0x2)

