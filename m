Return-Path: <linux-arch+bounces-13027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98AB19D2E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2691B161BD2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3523BD00;
	Mon,  4 Aug 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ccnfia0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAP95WYG"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C27DA6D;
	Mon,  4 Aug 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294461; cv=none; b=DhR0A91nys0WJpZIYElUdCKHZx6X0m7mv0LDF6pSlsnXZ8cq3okqsgvJykCFC7z1S4h/9ei/2KJHZGsGkilX9Fxb6a5eZeb4GMwSd3aFByPj9OK+C6IGu0cxcO6Qnh4XLIFgA8zk55t/XdKrcUBHsRypoal1yJup77yCGy3O8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294461; c=relaxed/simple;
	bh=+FfqmW+qjndmQCeIgGkX4MsEM80n6CsPysku9Nq/9Y4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GPyZBWo+kTl5D0Osl1WfMRO1r9HsIgOzqc+aeAeLCugATXLz9lS3EKiEes4xNdlyFDx9b4Xap0w9zM9x60iLR3bXOhQ2CcW9vNIUutJVWjXWIny7aZK+c4JNPreWYgsMehy+dLkekcmERLhnF90XB6Z1bc040Ruh4y4XnM1K+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ccnfia0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZAP95WYG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22AB07A00D1;
	Mon,  4 Aug 2025 04:00:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 04:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754294457;
	 x=1754380857; bh=fveizswO0sH0RFOzitjHAxAu9/EZqisbQYkgXpX+m1k=; b=
	Ccnfia0zv7FDTOlCsbMZ+0QsRaC9yrnXtc7wUK8AV0nEN6srStnQAab0TCQZmko7
	2YkzoUsMtnoHz0WMadxczKqkCcJ9/jJ5MIkkK6pPVk4XgAXc5kaBE4vA56eBKY67
	3+8S8xdcnithFHOTA6e3KwGZdq59GlxarOoGQbQQuzclK8eIgqIWYbp9zxEhHTET
	JG4UYaoLvR4fcURWSq/uNnl10zO3eh8D8Ex4wpc9B6DIZ+cf8QYKEZ5aO7QbW/+y
	dgjceUZH/GbkKbb2BpwJi1kYpK+TTd8hkY3RgWMdHfAh/3LJDX77fmzM1KcJSlLu
	deQAD3bFoAhUnVS/mWGGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754294457; x=
	1754380857; bh=fveizswO0sH0RFOzitjHAxAu9/EZqisbQYkgXpX+m1k=; b=Z
	AP95WYG/krxxLixZIwWbltM3IoE7uCBiDDQk1NqPLQjg0vol59IMjiVe/QW7rYtO
	wESCqetrJ1N4rIthGS1kI+gsn6jDeXGZNCTzFhSZK4JKzaITu5Oi5eLurlFEASpV
	G1M+wJIOnTTXhAZHzDTjWmXK+CJ1vgGCcN0xa/EvVmt08nhDOXT8natrn9LlZuwd
	yOuiOlbgk1/QxfiAThXUV0UsVn4B5sL3QLrCIi6oZmqI9jZdBS7bfc2lZYdBMBPd
	W078wXOsbrZ1KLm/1oor4Dg6EoUmw/+JN2u6a3IQ0k1TBYwchvN/CvoQZ9e5zYLM
	LGiwXBq1Qp7gd3oVDvSbQ==
X-ME-Sender: <xms:uWiQaFHh8XAqXDwC7NpXg9hyNvAu3d-e-Mp7DkB_5BQ12JMc0Iz8Dw>
    <xme:uWiQaKXRDaSZTxadiKJ1cz5q_aOPZc1SiASEMcEs-MzCof8a8K_PcTT5xSUi8SHle
    yJz6vLsH20I7rgCeak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    grnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepghhlrghusghithii
    sehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepthhhuhhthhesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhprghrtghlihhnuhigsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uWiQaMXzing_BnyAvY_T0WhWknOOg-4pNW4anKJbCdBggJucY0MRpg>
    <xmx:uWiQaFxXB-LlAb6NR9Yyg4tAR5K-cn5V_525XGUCJN39CH2jdmhw6Q>
    <xmx:uWiQaBTYJAexkQ16s5DyYhikMBhrWhgcCZz111AHFV5KG3WXHlWm8Q>
    <xmx:uWiQaBhJBTK7Y1f9CIcikH7eAUPpG_xPkBCTmbMruHQQDy9Vfn08eA>
    <xmx:uWiQaLnl_wFi2ijD3-N1-Exr41ehFiqKVNck9LbEOy0aSi2QMWeuqi_n>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E673700068; Mon,  4 Aug 2025 04:00:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T74f2f12fa7b53bdc
Date: Mon, 04 Aug 2025 10:00:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Huth" <thuth@redhat.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org
Message-Id: <579ca73e-3b55-4e05-88ae-d7bc192f0023@app.fastmail.com>
In-Reply-To: <810a8ec4-e416-42b6-97bf-8a56f41deea1@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-35-thuth@redhat.com>
 <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
 <810a8ec4-e416-42b6-97bf-8a56f41deea1@redhat.com>
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi
 headers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 4, 2025, at 08:01, Thomas Huth wrote:
> On 03/08/2025 15.33, John Paul Adrian Glaubitz wrote:

>
> So using -ansi in the kernel sources nowadays sounds wrong to me ... could 
> it be removed?

Probably: I see that sparc changed '-traditional' cpp flag to the '-ansi'
gcc flag in linux-2.1.88, while the others were still using
-traditional but just dropped it later.

Most likely the idea at the time was to just no longer use pre-ansi
preprocessing rather than to exclude gnu extensions.

     Arnd

