Return-Path: <linux-arch+bounces-10976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EEA69AA9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EDF4245DA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151A213232;
	Wed, 19 Mar 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QKele5xq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwFZoY+S"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C61CAA92;
	Wed, 19 Mar 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418793; cv=none; b=NKhIWAiIlIOp8hI1CYLACoixH/y6/SWEu0g9rNPRTELIIfIwj6piF2fCTTReI0MNti2HEvevmiJA9ZqMUQHT3AX913cMiNuVtMWEiN3pOr1DFziPEny+zVrcJbfaRVVgPYAzyDOgKqP0b9gM2cWWluHPc6eJmQPXTixXeKhkGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418793; c=relaxed/simple;
	bh=07unsPIOouW9iMQnJQZ3z7ee2X38QzQkiB5NzIUJeGk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jTVl7em9pYV3m3gyfD6y1BxvTrOJo71ElbPfyCOUYIhBBC5LwZd8McdOko3GA3P6p4u1Ji9CpnhVA7l9OAOe2Ez6tAcsVCeHdrjZEaCkEBlQvquudtA0Pvt4qhkZfmjCY/tsIiQocnjV1M9GYjw+tn2oxPU/Fii7Ai4Zigh5R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QKele5xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwFZoY+S; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 82FFD11400F4;
	Wed, 19 Mar 2025 17:13:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 19 Mar 2025 17:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742418790;
	 x=1742505190; bh=wbTxLXQnu+kcK3t8kl8CXS0pPVmrRRSr8Z/ui3T8w/Q=; b=
	QKele5xqO4BrDkt0JCu/CoVTcfndJfQcP1FmrBYtnkmZ9IzRnwfK+upG4AZSp/8T
	Ou9tIwrmOCrdXT1fe7ncs+LypJ/K/3YdswntnPVVkAmMFmFZNX9/Z+TGjfyah3Ef
	wy88ul0T4nOvX/5tZy1H66DICw/z1HrZW3/NoruaHkHg3BPRE8uS8t0EP/q2Cfm3
	1uAwsE0qIZ47xsbNNm0xNmoUkD+v2oPS4PK2NIapZm+cqeDeCZiWqpV+YSvARLaZ
	RU5wgwnrJ7C8SnwEqZ35+ftVye3YNNDTrFcnQZQ3QQkrrPeuBCVtrqzwZH4TtbBX
	dV129o6uzGpoRzVBdcYDyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742418790; x=
	1742505190; bh=wbTxLXQnu+kcK3t8kl8CXS0pPVmrRRSr8Z/ui3T8w/Q=; b=K
	wFZoY+SDp8jprSdHOnL3YpXU19VM00FQhrpqsIprWtUR9Huo0ZY5wFJ7vD5Ygc0I
	D1rGZnkASLDmW45NrQz5hBvWJdpvI3B3ph09b/tIPy5wzvqxG/FbvppGsIqna97L
	4cqm53DRyHTp/1AvaKjRHEYzbs+8QnN8wk/49D8iuPRFthmxWAiz9wVhqjNyLAUG
	b202ocFCpyNYD4Y3wBRn6VHqi1f8nrwn6Lntr6g/G+/xgexENmosLuuLp2Ds33tF
	zqJyYpDaachvZsS/piWD/byVeNkYWkjXG9nXMG3r3Uu/uvyBIS3OX5vrf6G4PiXC
	4C8X16rDpijgwiBeRnMxQ==
X-ME-Sender: <xms:ZTPbZxdbGEHt7ySgeZOXilxoVwiz8rNlYHsWzzBvMxtBwsBwUKG3xA>
    <xme:ZTPbZ_OOX8yrSUB6e5RqQrYhw2OrBKBU2h1-tbSmEtb9GyU3vJQvifZ7P0xRZlNlz
    l0QjymCwjImRExU8I4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghlmhgvrhesuggrsggsvg
    hlthdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohep
    iihhihhhrghnghdrshhhrghordhishgtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtohepsghjohhrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:ZTPbZ6iHglh7TxpQHaCmmXceUI9lhAXa2jJhUg6UVS9RvRH14mvizg>
    <xmx:ZTPbZ68eOPnm4xU3DVr68vusYHjDD7e4Ab7kmiYK6x7WKDncUNs3mg>
    <xmx:ZTPbZ9sODtDIjiy9ssWBJAy-YFteQupEJfVry1UHVMaoHQ91SBVpgQ>
    <xmx:ZTPbZ5GxH1Sr_bWMuas7HPprZcsbQ0VMAbgIKRLx57EaLQ_I-5SD5w>
    <xmx:ZjPbZ5FKua9k0hYXiGccoQ2TWnsmKH-WNhTetSGDQUBidUiwZmE-a_jo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87EE42220072; Wed, 19 Mar 2025 17:13:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T04d17f90b906d792
Date: Wed, 19 Mar 2025 22:12:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ignacio Encinas" <ignacio@iencinas.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Eric Biggers" <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Zhihang Shao" <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
In-Reply-To: <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
Subject: Re: [PATCH v2 1/2] include/uapi/linux/swab.h: move default implementation for
 swab macros into asm-generic
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 19, 2025, at 22:09, Ignacio Encinas wrote:
> Move the default byteswap implementation into asm-generic so that it can
> be included from arch code.
>
> This is required by RISC-V in order to have a fallback implementation
> without duplicating it.
>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
>  include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/swab.h       | 33 +--------------------------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
>

I think we should just remove these entirely in favor of the
compiler-povided built-ins.

    Arnd

