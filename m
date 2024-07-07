Return-Path: <linux-arch+bounces-5301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F745929963
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 21:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1677D281497
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAA44C89;
	Sun,  7 Jul 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HHTghpaG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdnMr+ke"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18C8BEF;
	Sun,  7 Jul 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720378874; cv=none; b=NZtvhtewl+AuV+ZVaw4nv3D5wQo4CL7sNNIH/GJ+TXXap+diINwLyYHO1Kw/9l+dMF6c6ZyYpY/J66ru8ykC640w5MkR0UWaIfgmNXTdJVyeAKZ1WDfv+lYLEwe4maEFYoS1kaLCfj3CNbg0M1Jhyu8rB0mVUFLKivk4b6vWtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720378874; c=relaxed/simple;
	bh=DiH0q2lmQfMpabjnUIZcmGEpU6B0TqByxAqfNRIw/fU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pHcny5Pna8eAEsZuZkOenE4a8bAM9AUJ/jHwmxSdLzchUNktDR8LFVIWAwmBC2Jgcgq14HGfVAmF71EeTL2jeU8OjieAF1zmi8WfRJAvgImHT4fWK9JahxOwpxxQA8c0GDT7aFaEZnnK4N8tZmUAg5s02atAjbs+j8YwbkNw3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HHTghpaG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdnMr+ke; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71E371140299;
	Sun,  7 Jul 2024 15:01:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 07 Jul 2024 15:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720378870; x=1720465270; bh=fnPGPD9rRT
	Nh/NwSH09iJcHZYTTZZQWsnaDWsGvqyLg=; b=HHTghpaGP/JjoOdMDMQxLTrjB9
	0kv0clIUUiGG7R5+LhHcHbweBlbL0e+ztylTz4+kNtf2foqtgFduj/s4EDt5k/qC
	G5lvqE+MaRgsVhOKtOIuHR0jYWLAndpUj+Oe7vwghlDLRcLGWhRfdrjZU6msK9Nc
	39+I6n8sbF300XpkmWWWOg0o9d/I9SeAgOFvxoJvEUVN7ddpK5CdGFfYMBH0IviJ
	G+Sfzn/64KRqZHDEg+JtSGoGTiES5TNLNavlreQKHPLJgxDbtUMofnl+Jpoo2opK
	olWF9vVyik1Gl34BjX1ZMZdYncxHvrq+DTS8KlttcM5701CCEGTvaTwfME4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720378870; x=1720465270; bh=fnPGPD9rRTNh/NwSH09iJcHZYTTZ
	ZQWsnaDWsGvqyLg=; b=XdnMr+ke7rPcVaKICM/4MTAscO8S4n2POUvc+srkQSxu
	PgKC1STml/ic3NIJD/DllgAn0fJ3GjsnRd9/t/RRIlaQXSizic7gjMrOj6ZrN7Jf
	GjuGvdG7y2fJL9QE+JgK267/9xGU5BBAf7OEXpyJkkssec9F0X6CKvrHY6cWby9G
	6ORmkQAxJaKLqUcR/kly+dc0lHmch96+3t6X04xfPLLb0IWZW0a/b1FKtqiLrLZy
	ymTggkI5H4ULHzNC+s0NyMoWeCTy4zSDfkxU20Ms2+AWRiEQrrC8VIy3m3Zrs3iP
	h8icHLQxtM0Rr2uuCGOIHIVxunk05zYOqUUOiYQlkQ==
X-ME-Sender: <xms:9eWKZsbNzHZyq7QjOvDSiTmrwPW8YkRlGW9ViOokCnxsy8XWS1wRPQ>
    <xme:9eWKZnadkURuThWfyvJ8KZ7g2M5fZKL4oA4vkDcfgNUO8yUq4k_rr1cMZ4N5fbsse
    481-AxkkTltPXR92kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9eWKZm9noHmhVE14zh8Y2v1bgLu2GOJucLG4LfBhnJ5Hid1D0b7FeQ>
    <xmx:9eWKZmowcccumd_rGZMPmbrZNxlNRl6megKIGrDLmGHWwFdJ8PMIcg>
    <xmx:9eWKZnqdrGYzg33PeCcYvaQr5eyenQBr_CAKAjnZlsEmDWqN_KdckQ>
    <xmx:9eWKZkRFWUaojh5VxSf-6rO1b2J6SQ7a4UdPDYuIpjHDzCl84eGnpA>
    <xmx:9uWKZolrCFzeCkC80lMP5Ge2YhY0GId4LiRgAQIxgAqIsTI5Mwwbc2za>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D891BB6008D; Sun,  7 Jul 2024 15:01:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com>
In-Reply-To: <20240707171919.1951895-5-nico@fluxnic.net>
References: <20240707171919.1951895-1-nico@fluxnic.net>
 <20240707171919.1951895-5-nico@fluxnic.net>
Date: Sun, 07 Jul 2024 20:59:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>, "Russell King" <linux@armlinux.org.uk>
Cc: "Nicolas Pitre" <npitre@baylibre.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when optimizing for
 performance
Content-Type: text/plain

On Sun, Jul 7, 2024, at 19:17, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
>
> Recent gcc versions started not systematically inline __arch_xprod64()
> and that has performance implications. Give the compiler the freedom to
> decide only when optimizing for size.
>
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Seems reasonable. Just to make sure: do you know if the non-inline
version of xprod_64 ends up producing a more effecient division
result than the __do_div64() code path on arch/arm?

     Arnd

