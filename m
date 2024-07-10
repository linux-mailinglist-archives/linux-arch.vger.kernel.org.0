Return-Path: <linux-arch+bounces-5347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852692D1DE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FEB1F24C92
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA218FDA7;
	Wed, 10 Jul 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W/YNqMl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crGDQrNc"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5681723;
	Wed, 10 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615568; cv=none; b=OLH03W0nmuAvrnDkBN5rxY6qAdo7HAgAUrWZl4bQF7fPW1dByZzC+U6fqmhban4gpqFTdgZH215/VA/DQVYtK0+VaGlc7t3Z+GH43n2vmzzW0PlOkwrp+723BuhfFDbQSLdjRRYeWVb6V92bfDd4/C6HtqRf+M0xrM+RizN2zUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615568; c=relaxed/simple;
	bh=ENCye+tN6ZTv1qBEWwY9zTaG+Gvl9QpdG298D8ehGvs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WEsQnOOYHCMMj9lN4AuzjCcRAQgnzl9ttP/f3jhgNjM1DCZ+IfYbPpA+NsVchiioJKwrYCylCpdEmzXuI00jabRRcLyr73mjV1iuNjBuu6ACrf4edOX//lzrejLeTsRDdzI4WmfbMSlw5FTl6UhecdmZKrRtIhfXqfibgsCUNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W/YNqMl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crGDQrNc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 326441381D67;
	Wed, 10 Jul 2024 08:46:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 08:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720615561; x=1720701961; bh=iHV40EwQ89
	jWy0gmmC2olWSBS48TkU1OBQ1jmtxb560=; b=W/YNqMl+VwtHXRTXRaIaTOqRcu
	mDP8QLj6Y/2fx3oKUqBRqm+/EvlkDGK6INDctqhYqZ3P0KT7vl/+ONvvpDWHtav/
	INrtSGgAZfvTy2FfPZ9e5U/ctGW3UJ0bG2lUD2zECL27IMknS02KkO4xYtFqLPBj
	L2f/0q2NsPYTnRD+eEcgUbmSqhyTxFukCCVcNLQJmYEKrojVaRMMcet0mseQivoc
	o7zT9j6+vj6iRy4t3eL0G13u5IlzeRdY/5n5BJkOi+qzJS8IfesV2TO0CO28SgZd
	FbG20NrFr2uvqVaRPkcxe+3M8kDz2yTGMUkIvfFov1HyYDVOaUnyF26xK+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720615561; x=1720701961; bh=iHV40EwQ89jWy0gmmC2olWSBS48T
	kU1OBQ1jmtxb560=; b=crGDQrNcTJb5MTItzXl+jd9CXkgr1tJQYNoL1x3el+K9
	/M/IZo69NXq64HMZcDPOkuB+uJRF93MnUp9dD5hscD5u4VIFCqFsOhRkmjQm3ZAQ
	2puyHiKtAn15LB0ldiIjH75pikyvlrLSOO72dQM9RQiLsXqHCKfm9CiykJ66sOpC
	WAOmASa4SsEoMLBvP05Rk1dBUX4o8y8XSZ4hmZEchCGS9IirIHo68LpiVHkS/zWC
	ZcDUm8RW2r696ghojf8F6LWcW07ZlGqrh9efhJEe3palyNaWXzgIOgwk/VguCm0o
	WJaG/ijrOVzrKDAntP9FIW1kOdvTCK/q6FDTlxZLBg==
X-ME-Sender: <xms:iIKOZuwRgj1GBkAB4crhdq046iBrTrYf_VQFUqmQo92yzGACZaFmYw>
    <xme:iIKOZqTFAYKPr3m7m3IjGxxTUEes8tCXK0qurabiwEZG_6DwxZXwYu-xhCBUGffGX
    t_UcNSWA38BHsgdlh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:iIKOZgXX4lS7AhfaBALO2NgUi_Q_hqGvfqsThQRcdzSW8AxNOcU2UQ>
    <xmx:iIKOZkh3Q8Uv568BncsOYYwSy5NZqYdQ5vsYnP2OEyZUWVUErABkvQ>
    <xmx:iIKOZgA-iD0SinnbnWicFgosiMfgcgfGqE6pQCD26vQq1I_TbrpU3w>
    <xmx:iIKOZlICnUNdS2ZWXCfC8mojYGl6A5g57_lKFS3g1u2HUiNpWXxoZA>
    <xmx:iYKOZjML3T9OUaj4EJch1lH_wzFpD2tpbfalNhCZaWdmfLSSIwJp8wc9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EB4A7B6008D; Wed, 10 Jul 2024 08:45:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <461243b3-4f80-4745-8169-c5dcee32ed63@app.fastmail.com>
In-Reply-To: <5fc31a39-2068-4fff-b9bf-27feb4ca3bbe@arm.com>
References: <20240612160038.522924-1-steven.price@arm.com>
 <7f258a4c-6048-4718-851d-4768789bc5e1@app.fastmail.com>
 <5fc31a39-2068-4fff-b9bf-27feb4ca3bbe@arm.com>
Date: Wed, 10 Jul 2024 14:45:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Price" <steven.price@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixmap: Remove unused set_fixmap_offset_io()
Content-Type: text/plain

On Thu, Jun 27, 2024, at 15:58, Steven Price wrote:
> On 12/06/2024 21:02, Arnd Bergmann wrote:
> Actually for now it looks[1] like we're going to drop the overriding of 
> set_fixmap_io() so if you want to apply this change separately please 
> do!

Applied now.

    Arnd

