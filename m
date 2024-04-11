Return-Path: <linux-arch+bounces-3609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4018A2021
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 22:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8978D28BF4B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3F1947D;
	Thu, 11 Apr 2024 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cPj9/fmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHqB2bof"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA411863F;
	Thu, 11 Apr 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867083; cv=none; b=kuYOd1zY0ZgA/1BQ86cLnPKRfjc+5emVdyQbYCwY+W3wfFtI/QAs8ENQYQzD7vZUGo79hngYoE3UjuMfTVldOSHWZz7xaJIyafn2OYIOW44cYvu4T+mJ9QAHxrNzyM0yf4B1BEB1VL3tVMkZmJ7hM1d9Kpc/36Iu4vmVfODY+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867083; c=relaxed/simple;
	bh=N+rD5QfdxBQ/+DoxhEwOJBWLJNrXs7YfVLacUCjziJg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g97wpLHAG/wxhdH93bCaU0DlxzMLVWdyWQZcTOJt7UDRJY62zwnMYiyZQt4Z96EEGyBogkcTa0pd0xIHDNy7g/jGi2hdWt6aZGkwvfSz/rdXcwBT9zZ+EsCHdQH9cJF1vZW93yLYtJhlzoCEF4BnvKGOd0abR3mNc0r2JByJglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cPj9/fmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHqB2bof; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 51A3618000F3;
	Thu, 11 Apr 2024 16:24:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 16:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712867076; x=1712953476; bh=ZXeIVotYWY
	tiu1d2XO6gj9pTb41qrbKlByzdKKRm9q0=; b=cPj9/fmJ5ICh3OIX4HYXzZjM6n
	cLQiW4Cz21H6OpfvtrZuajQKQhfVwrCtAKvhmNhLttcnVk+BNacSSrhvH2eoA4Jb
	YA7ADp36lgYsoe8ZlE1IwK65U2ovNeC+NM3RZqmzX5KbJbVv+MbvmIJISIrncxpA
	nP9LvVPza1DgjGMq5ufcQ5/epM3fh7JhGOooRe7YM/58PKTmJJHY8uIttlD7XHpF
	n8L+VnT+Za2CYcrcZpmhXdqxVfqrRqJ9mffsEWZPmV7i7LTS2hhnaf7nEEz/gbGS
	q2Z3cYd+YHriIMSPqNPm1krDVAqXXcfEs/RyTbq4YjbxVBfsZc7KhldP9Ozw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712867076; x=1712953476; bh=ZXeIVotYWYtiu1d2XO6gj9pTb41q
	rbKlByzdKKRm9q0=; b=qHqB2bofPTTin25e4aiJKGl5dqQAnld3Fg7cvAp/9+KS
	ELfm4Jw1r+Jl+HFzb4gt0Wlc7p/jT2L7gzrhBYxITEFZs7upd0f5708VfsrfRgz4
	X3aeO6DqbAQIwROGE2QSuJBfXkqFUhhN5Ltrn//VyJ2i/TPTltK4kw+grYkliWzg
	78RmddP4ArbDecPpHgQ3dV1tOmnRqZKsTIX3dDCtkmoGxm0Rr9Uw6WLScZyF4nc4
	kkuKC0gFQxbps7hOK4OpwiZGBFV9aPgl0ZALkLZrFjuOO9i4mA/YsIAMvL2u80mq
	QrecgtpIZgCiMY0ZWunP7c9wWs5BflbhcVM7acshZA==
X-ME-Sender: <xms:BEcYZpAZwpPAmBxOlYDASCzFc-JYQXMnIOxfElOpC1NGI-C06qCjlQ>
    <xme:BEcYZnheUgW-Q35kxjTjNuqIJPO-Jm724Zb9c9BAyFKDmDa2MHbTElW_ezoNNv_nG
    l_UNZdtj9ZsB8oyJx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BEcYZklh8mIT3WyAnL0CXsulvEanTdkreoWtmohNPyKbX67YUgk6vA>
    <xmx:BEcYZjxuyibftC51S33hv9nL8jnnYrwxGqBL77KuCKZf_31PYxnkzg>
    <xmx:BEcYZuSbzkYjtBSFYH50QqT-S_HXRIap8ighca1--qWVlOtrBca6xw>
    <xmx:BEcYZmbUHbWP6gDWtrjpzxKF3oMnIrQ0BFKDzvFz1UOvZ4XgXiPy0w>
    <xmx:BEcYZhYAjiqvMqacjd-jdPFz3yG5e4uH3_E8k3rwP_Z4ENK4taN6e-b7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0D8BAB6008F; Thu, 11 Apr 2024 16:24:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d499b754-4b0a-4cde-9ca8-cfe0fc9bf2c9@app.fastmail.com>
In-Reply-To: <1-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References: <1-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Date: Thu, 11 Apr 2024 22:24:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Leon Romanovsky" <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev, "Ingo Molnar" <mingo@redhat.com>,
 "Bill Wendling" <morbo@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 Netdev <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, x86@kernel.org,
 "Yisen Zhuang" <yisen.zhuang@huawei.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Leon Romanovsky" <leonro@mellanox.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Guralnik" <michaelgur@mellanox.com>, patches@lists.linux.dev,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Jijie Shao" <shaojijie@huawei.com>, "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v3 1/6] x86: Stop using weak symbols for __iowrite32_copy()
Content-Type: text/plain

On Thu, Apr 11, 2024, at 18:46, Jason Gunthorpe wrote:
>  arch/x86/include/asm/io.h    | 17 +++++++++++++++++
>  arch/x86/lib/Makefile        |  1 -
>  arch/x86/lib/iomap_copy_64.S | 15 ---------------
>  include/linux/io.h           |  5 ++++-
>  lib/iomap_copy.c             |  6 +++---
>  5 files changed, 24 insertions(+), 20 deletions(-)
>  delete mode 100644 arch/x86/lib/iomap_copy_64.S

Acked-by: Arnd Bergmann <arnd@arndb.de>

