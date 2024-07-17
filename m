Return-Path: <linux-arch+bounces-5459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D6933D20
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A77B1F24655
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7717F506;
	Wed, 17 Jul 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qiqOQV/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYhGR3c6"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C81173F;
	Wed, 17 Jul 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220379; cv=none; b=EyTJLVrmIMqLAUvS/uvMJ1Rfwt0EJE2X5M4Aa26DbD62LxvaBYVhrXkhX7mMd3yq384OevrjQQ/hpuazIBorAASUKjbRpS+BOpmIXoGG0IDeT3O8c9N5/bQ4Di6T8A25z68+pGPIDbWSVq/5YwgzmyMK/z/MKl2SbiJATA5zY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220379; c=relaxed/simple;
	bh=GuFkuwgqT80GRWXZvm7LRcX0ZMXSO6k1+urf/KtMogI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EoH5999evv2KLFfT2BwDudy0psR8KUx1fEvvwI/J1I94k3lkpEppGo88OQcTzZO/q4CDZf16tvRyFbg2fvWQgwpA/qY91yf5UTB6o583Zw2B3apxcCCtc189bpE6ly3+SAqWTYXnCJSept8AXpnqBd+qFSIq4cB7eCtrCMCAiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qiqOQV/Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYhGR3c6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute9.internal (compute9.nyi.internal [10.202.2.228])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D13FC1140186;
	Wed, 17 Jul 2024 08:46:16 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute9.internal (MEProxy); Wed, 17 Jul 2024 08:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721220376; x=1721306776; bh=/CApYD6wKY
	nJBVN4NbL8zaH4ZDUgadgUBuZp5+ecVs4=; b=qiqOQV/ZBHOGp+WRExDp4NzLdj
	ziUl9xIHaUXYnBshQBoAxGk/gVS9rKLhRK3WBuRgdNEnDrwmn0Lz+anGbh4newhE
	qiATIwmRv/uj2g97g8OM9RmpergkSLw+X7W4kUIR3qD0+Sl3oiyBhFE7eqVdaNTI
	hC5+8KqqGeDfYXzIGk8dMxUi5mEwdWN2Hc6IAtoq5iGyL4pQpuMcTcRNKOKP2de3
	6zNHPaNDFteBrktsnqiWXnXbafZ0NsOCqMvmUv1OmeMZMyfrbORXxOjHXJeMxP2+
	4q3LewaZnF+cG+ZYcI2RbDUOX+kfrd+vAJCTLl/90fgj2rZLmCRi4UlvyZMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721220376; x=1721306776; bh=/CApYD6wKYnJBVN4NbL8zaH4ZDUg
	adgUBuZp5+ecVs4=; b=lYhGR3c6zUvtgFpfRszwIHAm42Q0BxFUb415+QYJFeWc
	xgsRAJPATdNRpoNNiS9aXLKn0WxLdP682FIdPO46JBZmfMGQhly4a8i6oFGthfZz
	MhFlY26GuQSbriMBkK+V96uPCGjdex4OQ1xbetOET4QNa3VNWCeBc5hNFUyTNl+L
	rHmQwOmCnsr3GcrnNgqz27e439an53N8EqFLy9tRPFumSP+Sq2OIEBy1i91XrbA1
	KPpacdbigM/viaWRTAxU/POrsaT3X1zfv7DLwIDNeU0MIYbgtFpSqjy6mpU5h2Cg
	3FlnIjvjSEGDizXvce20/14W1hOI1EbikHnEsxZt6Q==
X-ME-Sender: <xms:FL2XZgu54zRo188ytbgokKLG-eM4_oct46qUF3zL2lA9v_10Y08z2A>
    <xme:FL2XZtfHT4Wi8X98SWGHqJjKULUVb3Lv8BrlqYk6a31KbWqIe6kozNUkhdKJoFqki
    AP5eR3FC6wazrKMIKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FL2XZryYFxReCHxYg1QjiiH7dcsKpiwNjFrFgvo9GdtpbStBQBAuag>
    <xmx:Fb2XZjNceNt8fkAK1H8grmE9yW5ioXtEGgCiD38SIQUspwW20NYIWQ>
    <xmx:Fb2XZg_YXApV0zJUjelNBs_wv_CkV8Vm_zjLElkOJ-FFFFFcNOuA0g>
    <xmx:Fb2XZrUUYISPVoAHWqmqGi54AAfe6u4d7cGemq7uUnXOcqRDtpbcow>
    <xmx:GL2XZh2MdXKDq-J1IfFLVUWchvHx5FvMcBTDJmK2Ej4vcoG0Bdlci1mt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A54C19C0062; Wed, 17 Jul 2024 08:46:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f92d9393-779d-408a-b3f0-906658fef3cd@app.fastmail.com>
In-Reply-To: <91b10591-1554-4860-8843-01c6cfd7de13@app.fastmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
 <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
 <ZpdnhhaQum_epcGp@hovoldconsulting.com>
 <be80d8f6-2a1b-4f63-a43e-652fa5328d11@app.fastmail.com>
 <Zpd-Bx3VwrYWVeTs@hovoldconsulting.com>
 <4d471a38-f86f-429d-a1a3-b882439ef7ba@app.fastmail.com>
 <91b10591-1554-4860-8843-01c6cfd7de13@app.fastmail.com>
Date: Wed, 17 Jul 2024 14:45:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Johan Hovold" <johan@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 12:54, Arnd Bergmann wrote:
> 
> -$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl) FORCE
> +$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl)
>         $(call if_changed,systbl)
> 
>  # Create output directory. Skip it if at least one old header exists
>
> Masahiro, does that make sense to you? I assume you can
> explain this properly, but I'll already send a patch with
> this version.

This was not quite right either, but I sent a patch now
that works with both old and new versions of make and
has appears to have the intended behavior for incremental
builds with or without changes to syscall.tbl:

https://lore.kernel.org/lkml/20240717124253.2275084-1-arnd@kernel.org/T/

    Arnd

