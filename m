Return-Path: <linux-arch+bounces-12339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DDAD8A2B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CAC3BA7F8
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996192D5408;
	Fri, 13 Jun 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eja4ss5/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F0272817;
	Fri, 13 Jun 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813466; cv=none; b=Dch40iKSuJKcCbpeE4kVVZs/Hk1SSIgzu6VMRHYd7RZBBN0+gDcEehht2Zn3LwrmnjJt0klSpWhVWtZbNjFwa5FPUUqSwoPVDa7IPGQTVG4nF725wQWCPihQa87kicj+REehGUdcrTTa0r+oZjI/CgCqSb96YTy0hHEFGeApquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813466; c=relaxed/simple;
	bh=mtF/JE5cceh49XAD8mCMcwIGfvyvIyabnWCIV7upGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHU+aQEoma0dkg5Tv+E3Kil3BZla8xD8lYVGgL9aFgKGO4wLpNp5JyBjV/g/79F8m1t+iPZV8xtfOcobcifFh1YKJgp4k3CV2ZbpY+YAL8g2JnBNx5QmS3qL/E2W+XV9i/KWVG840/+p83258BaAhc0kG3ZvohzbWeN5Xk7oxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eja4ss5/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso301944666b.2;
        Fri, 13 Jun 2025 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749813463; x=1750418263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+fb9d5SQqy9oK1PPSlfO90PRYcA6JQsTLMYgiTjNj0=;
        b=Eja4ss5/KjIu/DuT8D+XztbjFi/46v3G9669IQEaVGfr9nYGYVjjXKLvV3C9HGHDEa
         YH7OYe3gVxQc9LP5rtRcoy6P2mYIg6MlmrliHt7oX2VQqz6Q4G1bpwzLIeN8jMaiZtj0
         YqQDYywOntsLiEH/XlHUlnn8fqokYtLCH1w+5+xFYmT5ud6+zlpWjyAIL4xVHbb8pwjA
         lGETSsu8UYLM/bZ74kc2jEAPQV3szUC3KBzdlWwoWrZI76T3z0AiQAXmEazi3bB/fgAy
         Cq9+MDAdVlpaNGL+5D0Z0RPMh3KnHfKsHzsq56cslnuKUGpXgBbL8njU6M3wtAC00wrJ
         kj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749813463; x=1750418263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+fb9d5SQqy9oK1PPSlfO90PRYcA6JQsTLMYgiTjNj0=;
        b=nQOnB1gAo1MNbM5yse66S9tEaiiUx68JG5tyn/o4QrEWYee8AEg9W2gxFKK31fKMuv
         C9guSZ52F1Z+kd3FuP/srFg3IbwFjZF2z602doP4hkjOwyZEvnhrdPZNz19dFSwNfQlU
         9e9TwM/3Jl0Gk2LTFHYCn0GbpmeaueJEtD45oPZjbSk8HPjzzscSd54CUJzbVaROBwHA
         VHpKPd6HGAzv7j+cUg0jkMs1jBuvPtCpFmGedpGjYDFf4RAtkctVKcItvWlJx9M8D1Xt
         CU8I2ZaQoUKe0Q4JwFhKaOzl2OVBGTTYdZVrnSJhkfk8T9va+bfTykNBiQPl5TyoIcgl
         n5qg==
X-Forwarded-Encrypted: i=1; AJvYcCUNFRrM0O8TMoWez7QvImJRdlo+7X8JB30cMk0T4hCc1dgqpkLJ7IiefPPy3bUtF8HWGDW1PrCtGIbF@vger.kernel.org, AJvYcCWyxkbLg/jJ4bPv7P02MfTSH0N09q42FXaFlNUSh4s/M7/meD3Rlnii1wSnIDEUFIsahzx3QLgtZuJvmgeK@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKg8tX0I8ox9Xnp5uaJWCSnfRycAFy7ZudpF8P/AhbDO5NM/z
	6LrLdFJMF0KnHqee8f416zp/MN2GgzVjqOUxB3kHi6BJrFHTAKWbCpBc
X-Gm-Gg: ASbGncuAKeyvHfXk+CLrfjNm5rJ5DbPJ6yOa8Sf1F55QBVATZHtPPoHSRwCQowPwx96
	hVqpcdZEqhlTBQPw/UAA5OU5EDqHdjMNG4A1W67HimSvedvoQzXeG6ykcOsfzGd/nE4rrIIjqJW
	UGKorzNj4Me7WFL5MvPdTtvkH4c4yix31dwqHDhpUSaDPHEVGly3mak8vSVgYcmLaQDo0ssB/OX
	tfHJVCTXyEJi+3XLar/Nh314mCHsbUU7xA2L9Wr79DmYeP82FKEhCLpVTa78pp8M3lC5ILX4LO4
	hJBVv91irImyXK6iBDKX5s9dQf1Hcade+uMDp9k76UnLLwmidRzpIxltzUYKbk04u9M=
X-Google-Smtp-Source: AGHT+IHD9r74C7xCLAz3JGGdVxDJf0xcuJg/kr2xZ/X1ScLL8ZDs5GnXZ/FyZz4Me7DM9dGuAUcPBQ==
X-Received: by 2002:a17:907:9496:b0:ad2:5499:7599 with SMTP id a640c23a62f3a-adec55030damr273383466b.18.1749813462723;
        Fri, 13 Jun 2025 04:17:42 -0700 (PDT)
Received: from andrea ([31.189.73.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8979563sm110704866b.158.2025.06.13.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:17:42 -0700 (PDT)
Date: Fri, 13 Jun 2025 13:17:37 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Haas <t.haas@tu-bs.de>, Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <aEwHufdehlQnBX7g@andrea>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613075501.GI2273038@noisy.programming.kicks-ass.net>

> (snip the excellent details)

Indeed, joining in praising this report -  Great work, Thomas!


> > ### Solutions
> > 
> > The problematic executions rely on the fact that T2 can move half of its
> > load operation (1) to before the xchg_tail (3).
> > Preventing this reordering solves all issues. Possible solutions are:
> >     - make the xchg_tail full-sized (i.e, also touch lock/pending bits).
> >       Note that if the kernel is configured with >= 16k cpus, then the tail
> > becomes larger than 16 bits and needs to be encoded in parts of the pending
> > byte as well.
> >       In this case, the kernel makes a full-sized (32-bit) access for the
> > xchg. So the above bugs are only present in the < 16k cpus setting.
> 
> Right, but that is the more expensive option for some.
> 
> >     - make the xchg_tail an acquire operation.
> >     - make the xchg_tail a release operation (this is an odd solution by
> > itself but works for aarch64 because it preserves REL->ACQ ordering). In
> > this case, maybe the preceding "smp_wmb()" can be removed.
> 
> I think I prefer this one, it move a barrier, not really adding
> additional overhead. Will?
> 
> >     - put some other read-read barrier between the xchg_tail and the load.
> > 
> > 
> > ### Implications for qspinlock executed on non-ARM architectures.
> > 
> > Unfortunately, there are no MSA extensions for other hardware memory models,
> > so we have to speculate based on whether the problematic reordering is
> > permitted if the problematic load was treated as two individual
> > instructions.
> > It seems Power and RISCV would have no problem reordering the instructions,
> > so qspinlock might also break on those architectures.
> 
> Power (and RiscV without ZABHA) 'emulate' the short XCHG using a full
> word LL/SC and should be good.
> 
> But yes, ZABHA might be equally broken.

RISC-V forbids store-forwarding from AMOs or SCs, certain (non-normative)
commentary in the spec clarifies that the same ordering rule applies when
the memory accesses in question only overlap partially.

I am not aware of any "RISC-V implementation" manifesting the load-load
re-ordering in question.  IAC, notice that making xchg_tail() a release
operation might not suffice to fix such an implementation given that the
arch has no plain load-acquire instruction yet and relies on the generic
(fence-based) code for atomic_cond_read_acquire().

  Andrea

