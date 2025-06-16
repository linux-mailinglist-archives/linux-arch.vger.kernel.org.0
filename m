Return-Path: <linux-arch+bounces-12351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7FADB32C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03540167E38
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A01D6193;
	Mon, 16 Jun 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="i6yGYI5m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C852BF007
	for <linux-arch@vger.kernel.org>; Mon, 16 Jun 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083076; cv=none; b=Tye2oYuc5AzqP3Kh60FQd9E4q9Mp007dlxUcRIlKPYaIwQ7ww250U27mnom4lX34g+3hj4h1bDoTLiFEtE/N1YwXp0ABOi3iGwRXRFGQJXBvUI0iayr4zMc9q3khE8mzcCwWGom6UOoNOHt97eG0QvSFOiXpBIQ6nMCWVKOlLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083076; c=relaxed/simple;
	bh=zoPlTkoZZmJtHvxgje6uQdW9GgwchQlmybNP8yjwaN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWYZZ83qmnWWnaYRdNy7dIVKAEbDj7a1dJNneCxYTtn3SWZ8SNgA2QDUSdCtPtRggZgmIjf9Tjr2F2S9INEs4J2Hq4YZpnUElGagThtdJqTmx8YKZffS6GUL1sFmZhocD4H7KGfeWwcOdps74qO/gfr1EoGrMnPVpifpwsYBiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=i6yGYI5m; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d09a17d2f7so421605085a.1
        for <linux-arch@vger.kernel.org>; Mon, 16 Jun 2025 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750083073; x=1750687873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOggq/KPowkbkENDJnGOHpXXvgQx4F56FAixym3bp2M=;
        b=i6yGYI5mS8tlXa57baShPSH1cg7VlSZA/FnWjgWXRGRVWm1L2qVZxRNeMHEv9TafUr
         h6WqqYDQXfXcLvzvvScx3JA9m9yQlwDFa5rUdSR2eJxlFGV+mZmJ2nrZpUxcEFQa6WZ8
         P+MhRH3J4Di0h0uAwi4BZP4+ekovjxaHDEcSqLOUswi1rnJLWbadESAmUjYOz1HcI4ed
         JfnSzqDk+WmtX3iCcfk+rUtXTpJOMxpMarD53llGdlCaIJ54AtL/GjIQdBV3MLitglW5
         zGAwbNhf/U20Ca1ck/GrRJTzN5j4Stf3n+pasQT7ackjJYXk9mGzdOopT5sVLFT6CSDm
         H1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750083073; x=1750687873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOggq/KPowkbkENDJnGOHpXXvgQx4F56FAixym3bp2M=;
        b=cjkPdtLRx3hx8WfBkBSDitnTiRAtPYf8bylnIuxRuHPouJlop43p4NtD6OzOIR7rXj
         S0sSGwrPWywD8zm+rsrf/V8B4vm4XsGo65hsxltWmIsaCeIrItPX0etTn8Q4xwZUXNAQ
         suVfHkx2i+t5fH+LIth+GR+szjpuSaG582B4xLffb4EaAKZIMrN383Dlx7MBUIqDP67V
         wDYLUmD6t3vEDewMjLq+8VtflXUHXJkft3s+ymBXuSYu8LIL71d9x53stuyyuv4g0+y4
         5o5YSII9uHJpJtClxH2xi7l6Rq7ThjPRxr9MyUeu8isj/zKZSTkkJ/w2eCwOCrJqcGlg
         e+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAoZE54KYWRu1oEko9LbKNaR3Q6eK4ueRLNwyHQJUqJgaNhNRFVD0s4m4reGOd0g/a6dWJKmeDZKb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nETeF2uFaLQMCc2C4MtmxdTgm5e1ByMZJWKpzBhmNmb5kInj
	vn5pKEqKJjs2NammCDKxJpBn4NGAkYj6uPJcyy+AlnVl1VnaMHCUPKIcQwtQqD6t1Z13AW5+FZg
	kHX4=
X-Gm-Gg: ASbGncvzqUhuH463BlxfbguuswKsL/6FtBwy/xyyll4ZXEDkUiPKziV2xrSsnFx3AWF
	/Jc77Aj9LBA4blGB1bsCiN/2rz4LS4s6s77dhvQa6PM9GMNw67waDa/KI8kLEKm/EjC68BntNcg
	nUXQxzg7Bsc+ORAXqQYHFQffm69wW/h+ERauZCE269170ae4ggcxGgKVXvrz3eMUpVSbMmGAzCq
	0C2f3+/VS4s9SnNJiQ/EckiYjCBqUwL7xYZymZ/m1SRWF78+Ce9DMeov93JE9pouX7H2t0m43EE
	VyZfS5euRwNsG0Hc+/+uCzGzrFGSgcuDjzvgxN+tD9udIjRSaCB3zA2fqE65zq3+hx2yUF6kjht
	XKOg6
X-Google-Smtp-Source: AGHT+IG/Q8oqK3NAs6JYHlzNOnNjSakbP4l5bRaZECFc8nTtdEfQzpzqsQ4tpcjcD5JM5xcRL5wrXQ==
X-Received: by 2002:a05:620a:390a:b0:7d2:2822:3f79 with SMTP id af79cd13be357-7d3c6c18fcdmr1653377685a.13.1750083073152;
        Mon, 16 Jun 2025 07:11:13 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dfe347sm530784885a.36.2025.06.16.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:11:12 -0700 (PDT)
Date: Mon, 16 Jun 2025 10:11:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
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
Message-ID: <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea>
 <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aE-3_mJPjea62anv@andrea>

On Mon, Jun 16, 2025 at 08:21:50AM +0200, Andrea Parri wrote:
> > Thanks for the praise. I expected more questioning/discussion and less
> > immediate acceptance :)
> 
> Well, the discussion isn't closed yet.  ;-)
> 
> 
> > Maybe one should also take into consideration a hypothetical extension of
> > LKMM to MSA.
> > I think LKMM (and also C11) do not preserve REL->ACQ ordering because this
> > would disallow their implementation as simple stores/loads on TSO.
> > That being said, maybe preserving  "rmw;[REL];po;[ACQ]" on the
> > language-level would be fine and sufficient for qspinlock.
> 
> On PPC say, the expression can translate to a sequence "lwsync ; lwarx ;
> stwcx. ; ... ; lwz ; lwsync", in which the order of the two loads is not
> necessarily preserved.
> 
> MSAs have been on the LKMM TODO list for quite some time.  I'm confident
> this thread will help to make some progress or at least to reinforce the
> interest in the topic.

Indeed.  I was surprised to learn that CPUs can sometimes change a 
32-bit load into two 16-bit loads.

My question is: Do we have enough general knowledge at this point about 
how the various types of hardware handle mixed-size accesses to come up 
with a memory model everyone can agree one?

Alan

