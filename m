Return-Path: <linux-arch+bounces-4566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDFE8D22E4
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD51C22EC7
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4E4596E;
	Tue, 28 May 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJpxeOwJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58644C7E;
	Tue, 28 May 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919215; cv=none; b=AZRnTU0Rv6JoHo2aMHEfonGmBhCjLnEBk5y29vafojJFBoBaFCHpjMuZL4zA4uzk/GHqOus40lIn5bulLmYqYb67yLWlrpzbAIvCkpx7RdQSkpPBHFnMg2D0TkNgxkD5l+uWbsiEfJwVYgcrs2jLrZch+WqGL6iR3A83Mzm6IKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919215; c=relaxed/simple;
	bh=+SMLwVcqLRSmG8T75XqR3w6eFstMjRzAAFgHYK+96eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHtYRtFQKYhbPHo8cscMC844T0olwsyQmVLbGhghWW/juKE+bj01ZdRApBd0cc9SSDhzm3qECwXczLzJ8f1TyXVwmMvEpSfvIs/0ZHTNpae634ET+qKvQNRQ64wnjgFsmYsyzZ+mxRK0TFbejrqItBwp0kEHzb/pdYwHgLXt9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJpxeOwJ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8cd25ebd5so498948a34.1;
        Tue, 28 May 2024 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716919213; x=1717524013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9CcbgCubAJ73RNKrfh6CLd9MLYV3LALBDGHRnXyNZ4=;
        b=VJpxeOwJlcZGL2zDUNi/6MPcL7e2Dc6QbTQjV1vp51FqbJDvEx0PgERyGFzl+KI17z
         zCCY8oiumNd672vT6dSZtzBdtu/aLXrL7Py3oRJDU4oh9by440EwUs0PaRhZJ85N/fyk
         LlJKEDlPV40/wFxUqx0On4zivZUJzKI3e5DrgKrQq9Cm67c0WrSNClXRz/tRipdlR8Io
         bSlKjz02iF5S8lGt8XOHDBl4x1YpASoMRBk+F3E7CmKi8yi4o6vFUN85pawvxalUm9a/
         srIb0BGISS1DSZcPi6tILjLh0hpp5CJMa8i2DMwaa4HQipEUS7YakYihLlJvWJupTPMq
         hBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919213; x=1717524013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9CcbgCubAJ73RNKrfh6CLd9MLYV3LALBDGHRnXyNZ4=;
        b=j8DQYFL1xhYJDD3q1VHF+G2feGXFweEgT5mumw96B8F77W8Ri2TZmEoRIzyqV4z67i
         r0DHYSDDAKiYLSsYCfcpcMESsFEkwo93zhxoQcjeMSCYyYlzfZB+a2zX54C/XHrNaTK2
         fVWgwpSAnbuQVf67r+AGx1IMOJGM7fP8tFEkIyOC9tNEsO6jgvyEAfDVHFCy0T2fc71e
         NFY3XTzWREhGT06oWzscFlWtw+nGZjyIz5ZjDA8UCLo5GTJWEyZSWS42kaQ8Bx+QImqB
         JJu9TxkQUj/5nns9UHs32VFAurOQJ17TBCUceFPzgBRzQVD67uCNdlLjZ5Wu2eWIbC7v
         EirQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ1jsMzJllmOLKc366dIiDAxAO+glP6NFk9x+mbQlC2357rBbF4JwEzSPQ1CHq0dZgB0q89ouVN5QqSU2He6d15pOd0Ku0Pew22dyJE3kVSZzuAzzR2Os/pcXEUUv9M2X1xIP/CZsew==
X-Gm-Message-State: AOJu0YyAjkeRI5QUo1KKeiCX8m3Tj5kxbSEC2syIYA8uSE8euSFjH/3+
	loBtcCbHolgqOS2jADSYtbRIfvDCLlmnlsp8rV4lN/AP8Tyak/1s
X-Google-Smtp-Source: AGHT+IElcgIpXkhyT9tgu74eBbiQ1jW3vTOU3j/+QTY2x6SznREkmM8cyy1VNsmpwJvsuHcEn1WGsA==
X-Received: by 2002:a05:6870:218d:b0:24e:6d33:9e1a with SMTP id 586e51a60fabf-24e6d33a0c5mr11547793fac.12.1716919212597;
        Tue, 28 May 2024 11:00:12 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca7f80sm402204585a.21.2024.05.28.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:59:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7C4721200032;
	Tue, 28 May 2024 13:59:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 May 2024 13:59:33 -0400
X-ME-Sender: <xms:hRtWZldR5lnMpqIwidbYtObOpcMDPFGLEhscKUPKEpZP0e15khsT3A>
    <xme:hRtWZjPoTuqtPJi8jGN-OJfJbG6kwg1djyq3h-KHcu_KAop94w6NqAp1v6eCDZQLy
    WX08o-DEEc_6kmBkw>
X-ME-Received: <xmr:hRtWZugHm-gyAHOGoJpPgVVfasIDSwjAqq5d6tbX89uXBypc3eJaSWTY-nI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hRtWZu854BEC9bqPofNG1gLeTo_MKcOJGPIggOURrmrLwjaZdCD-fA>
    <xmx:hRtWZhspHfdDsB-YzWEE_-130Y46nNWnRtG85it3vasVdIK-uoiQkA>
    <xmx:hRtWZtFeIzqp4QnNEZCjSuEQ68GPzdHeSfXHQlpVOvd7_JKQiQOJ5A>
    <xmx:hRtWZoO2iKHK3slOhWt9C_bley7S6ba8UofqDtvzk0LbsmhcmpwUeA>
    <xmx:hRtWZqM0pH6XfoRohovq0N0Bb1uHByrDxd1WAst9iOTjyLmZD8Z5bZIz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 13:59:32 -0400 (EDT)
Date: Tue, 28 May 2024 10:58:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZlYbXZSLPmjTKtaE@boqun-archlinux>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>

On Mon, May 27, 2024 at 03:40:13PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/27/2024 um 3:28 PM schrieb Andrea Parri:
> > > > +    |                smp_store_mb | W[once] ->po F[mb]                        |
> > > 
> > > I expect this one to be hard-coded in herd7 source code, but I cannot find
> > > it. Can you give me a pointer?
> > 
> > smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
> > the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".
> 
> By the way, I experimented a little with these kind of mappings to see if we
> can just explicitly encode the mapping there. E.g., I had an idea to use
>     { __fence{mb-successful-rmw}; __cmpxchg{once}...;
> __fence{mb-successful-rmw}; }
> 
> for defining (almost) the current mapping of cmpxchg explicitly.
> 
> But none of the changes I made were accepted by herd7.
> 
> Do you know how the syntax works?
> 

This may not be trivial. Note that cmpxchg() is an expression (it has a
value), so in .def, we want to define it as an expression. However, the
C-like multiple-statement expression is not supported by herd parser, in
other words we want:

	{
		__fence{mb-successful-rmw};
		int tmp = __cmpxchg{once}(...);
		__fence{mb-successful-rmw};
		tmp;
	}

but herd parser doesn't support this as a valid expression.

Regards,
Boqun

>     jonas
> 

