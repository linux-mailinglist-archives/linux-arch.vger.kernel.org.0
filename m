Return-Path: <linux-arch+bounces-8542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83119B043E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B5C2839F1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19518E76C;
	Fri, 25 Oct 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nTq77u+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYd+CaNQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8B1632D5;
	Fri, 25 Oct 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863461; cv=none; b=hKnmYldDJ3SBTW80ZEuX7EhMIYOD5vlPVYJNUN/a9q5Mp1BXcZ3W0OpKyOr2fslE/RZXqpHKUrHE0cd7cQ5Zjm/BfElMLVjeYOKtl9XJVXGHnzxxBCF2uSDbdjiB7r0Gx38pW7dAqk64Nu9x65tVFcPOWXPqJW3bQ/7VWqjAdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863461; c=relaxed/simple;
	bh=IO5JRAi5QVuzB3nZMKM6uhv+seJAQIBK2VjWW9MTLG0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pO/WSeOhnV4TRJ57ZlTrvjstVsnX9Aew079uu6wd3sLpHpyTJLIZxB3UkYYmGJIn/i6s3jm7kvHwgkwQ31C9mflou6MPdSBoQM4mBTH7c95fOztk9qBw6uC+eSiYfr0crWrVSBKG4giA9AQv6SSy9nPFSx4objkSXvh8maNrWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nTq77u+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYd+CaNQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54D1325400C4;
	Fri, 25 Oct 2024 09:37:37 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 25 Oct 2024 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729863457;
	 x=1729949857; bh=mTD/E8mUSNoNp+vtjeW8NYfb5u7ndnKHIytXzDhahwE=; b=
	nTq77u+YbjEK1oOGqWOEMss4pavBeea5xmfNB5v8n1RQ22NxJIlmfp2TzT4IKpOx
	caApVTp1/TP1+2AFsH+6DaC7B1jXPpi59lVd0QmK1g4cyigLCbwCjjCU5UZejO28
	8c3d8AGT1CdV1FpUSe8Ohc2JPaB0EAv7X1aw4eGMMqsDN9QNF4MBCkY7XT7NWXhL
	O/OEAgSYzhCEctYt3/dxus3LsMgxjvtStf4TUCEi3KDe+iRqYuAwvWG/ws/9TCTb
	91Febe33d87M4u4RsAc2PSDoS2l7TEXW3ZHH0N9mqk4H/wIO2sYqmM++nNVpXfOu
	l8mVjbE2Y3ckzB0U2VTGjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729863457; x=
	1729949857; bh=mTD/E8mUSNoNp+vtjeW8NYfb5u7ndnKHIytXzDhahwE=; b=Y
	Yd+CaNQUnHw9YsFM/xsr4EEUnyKUrgtD2vti8QGZood/Hu9648OKjYo4bH7A6Neg
	jnJDKNvwBYkFvlybTuqF2bH/KaZKDCsMPx9nvXzHCWTKjsCUnllyUHCbFyKAeDhX
	YNkya00Lwsz0+acBTk9P7pZOFNJx3BvJUubdQClXQQcfFmAJOHzcSMDEsFGYeUz+
	Jg9HE+6A7ymczxjo7UpkNZEyk9ue5mso6y8MDn4M5ldn8ZNSI/lsZrOwKW2qGN95
	SK1C5a5uk//QbB1mqxfMZZhPvCEMy7uIU9Opdu0mHCbXfdkyJRO6uRsr50PfJcTO
	dO3S1hvvUj92Ys457iJAw==
X-ME-Sender: <xms:IJ8bZxsuj29dJ1vr5lHn5cEFvY6c8AEcCMtZGM1az7Jp64ZRgbF05Q>
    <xme:IJ8bZ6f_PFYR1VPWQ6NunpU9GXYmb8uTFHK2WzhvwLuyhGpOciB1CBT9pvUeu8GH4
    UYBuOr6HJ-I4-vOr1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnh
    gvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshhnphhsqdgrrhgtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtoheplhhinhhugidquhhmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdr
    ohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdr
    ohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqd
    grlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IJ8bZ0w8_fyzDu0Dhxg43egcOQd9fPmeL9IF1HbPQzAPODUmdkywqg>
    <xmx:IJ8bZ4Ng8v61LIOz9Z6hcNW7TrkYDvZ9-QsNLZ7fNM7Okgrh7sPTiA>
    <xmx:IJ8bZx-O8B7MlF4JofybzIynmnGJvvLwnq8RLzH_1fknLv9ZsqMu1w>
    <xmx:IJ8bZ4X5lrN7iDkKbGm85k7BOBq5kmsTovQZ6V9cVszatdT146tmOA>
    <xmx:IZ8bZ02QO2wzbQXTtXh5NJPoq2r5QyMwBKYu4QPUoTFRk_k35DiZGUWq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B9352220071; Fri, 25 Oct 2024 09:37:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 13:37:15 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <c9f10ee9-697f-4f45-8c82-a6dc61e5a74e@app.fastmail.com>
In-Reply-To: <20241023053644.311692-1-hch@lst.de>
References: <20241023053644.311692-1-hch@lst.de>
Subject: Re: provide generic page_to_phys and phys_to_page implementations v3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 23, 2024, at 05:36, Christoph Hellwig wrote:
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.  
>
> phys_to_page is only provided by a few architectures despite having a lot 
> of open coded users.
>
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
>

I've applied this to the asm-generic tree now.

Thanks for the cleanup!

     Arnd

