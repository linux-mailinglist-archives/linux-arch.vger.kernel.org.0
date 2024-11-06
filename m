Return-Path: <linux-arch+bounces-8875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47499BE168
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 09:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F22844AE
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13971922EF;
	Wed,  6 Nov 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KYpNkjVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TctsgkwO"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EC1D7E43;
	Wed,  6 Nov 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883342; cv=none; b=XFu6+8jiPcHdF5NZ9K+w78bdCqsONNwvD4UggqfPbmQfv1rbKK7qdmahTwP8aRBfc3ii9cV70rSz4hjsFx0Q6br3dKfgW3BePiNgDEqvN4S0pG4lyBJg7reJ/8fb7oCRxj3Jf6lEwLs3LaGYkV4Bi7ZGmKD/eGjIDXhQm5pitg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883342; c=relaxed/simple;
	bh=uoc4Nta1Ok0mhsU7WW3fUW4xjpp+b/2K0X+NjHyC1oo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nhdB+JXxKo92WndlR+lbKbzhimwR2brRIDAsrdJZg30cJpBG5WJ7fr1+YGcTm0sP3ihliQmiYHi31SgpPYof9cyR4kwUHfzRWQIwkKOnW49fAjyNQZDAilFv2xRVdR46777OmDjvU6/f5vyciPjzxGCzXo1yR+rt+ovgxJ/CntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KYpNkjVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TctsgkwO; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B48421140175;
	Wed,  6 Nov 2024 03:55:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 06 Nov 2024 03:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730883337;
	 x=1730969737; bh=rmf9ivMSLIWqrguJz/3/wM9+xDOvZJ7XRQipjjgHJlQ=; b=
	KYpNkjVEU2Swxa0H/qawlYh9y51+gW/hxSAzXIMAnNlVtEMaGenFucQQpjq8X5dF
	MVIxEtVbWhZEMwBOXFcqm8mGYCeNE5nB/kYzi1F5bH4H7wNCymZU/FYu+cDB8N7y
	9ZGbEGzRJo2WWo8J4G4R89XLi/1kOLi962N0DIQGQqP5G12Rk+9hGtWkptJQ9Io7
	icIuk0qcsZCAwkILlUF5FKuVKs3M6ZHf+eU87GWEbSnfOMoYjUa9Q/56b/6W2fiK
	vrKegjNjp9/Ikp3EmGLJ5ohJzwpKx0xrszf7OFvqak/Y1qyqBjHsCTfkeiaOCNvF
	N1NxKCN66sBf+X42/ZGX7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730883337; x=
	1730969737; bh=rmf9ivMSLIWqrguJz/3/wM9+xDOvZJ7XRQipjjgHJlQ=; b=T
	ctsgkwOLwI5QHgW6IaRpJyzPuhUo9MdShTs5bx6d+S5gCSTknZgSkENDHBYKJSMQ
	MqbL1gDp0IE9cXvH2ap8vBeEziY98hgJh0So1QhDq3tmk1EeMYpbWjc90dRq6kOY
	r1oZ91P7VRNoriWvRrhrfzv3Uhn8Nas3sNBbe7c3ArvFYWfxq9qzUKIhh1hzdPol
	vs+kV/xYsp7QUxYAWd9/p6iKvZHXtE1nm9P36Q3ANAGeVfDgfXH/iSg5p3uu0zF2
	bEcHHqDyXOLT0t9A0e5XkQVXPL+lKyWhL+2Y9/Tq16hbnGPf9nwKLQ+RMkBDcT4s
	8x5yohCaextVjWyDlDWvA==
X-ME-Sender: <xms:CS8rZ4mBx3PlWvm82La7NX3d2-nkdMljv0FmuakDQWv6G1o27DZIgA>
    <xme:CS8rZ31ZlQrNOjsCvrZXjhGXNFLZ2SmWuaCXeJenuPRhX0yy0l3pW4D_4mzrFGsXT
    ERUh5R5QiD4ir5CIaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorh
    hgpdhrtghpthhtohepjhhonhdrghhrihhmmhesrghmugdrtghomhdprhgtphhtthhopehs
    rghnthhoshhhrdhshhhukhhlrgesrghmugdrtghomhdprhgtphhtthhopehsuhhrrghvvg
    gvrdhsuhhthhhikhhulhhprghnihhtsegrmhgurdgtohhmpdhrtghpthhtohepvhgrshgr
    nhhtrdhhvghguggvsegrmhgurdgtohhmpdhrtghpthhtoheprhhosghinhdrmhhurhhphh
    ihsegrrhhmrdgtohhmpdhrtghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkuhhmrghrrghnrghnugesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphgrnhguohhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:CS8rZ2rAmYyph3aphEBuoxopRl9o6CG8tQ6R_LhEsvibdYMp01gq8w>
    <xmx:CS8rZ0mV8ZKLtngf0fyH6dU68PQzinQk1onUaAvUOgvzVzNp8REgDw>
    <xmx:CS8rZ23qi8bUwU51EzFJD2z_g-JVy1SP8zaBK7m_M_qHzbnOavatOQ>
    <xmx:CS8rZ7tak2EL9fG-drc4A5meUzZyq2aVjh0iNSnALMxxyx1HedVkXg>
    <xmx:CS8rZ50ofKZjEBYcH_pa0x8kyjrYGoBtj4rjb8yxLpXxTK_lqYoCLv6f>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 243F22220071; Wed,  6 Nov 2024 03:55:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Nov 2024 09:55:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Joerg Roedel" <joro@8bytes.org>,
 "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 "Robin Murphy" <robin.murphy@arm.com>, vasant.hegde@amd.com,
 "Jason Gunthorpe" <jgg@nvidia.com>, "Kevin Tian" <kevin.tian@intel.com>,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com, "Uros Bizjak" <ubizjak@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
In-Reply-To: <ZyoP0IKVmxfesRU8@8bytes.org>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
 <ZyoP0IKVmxfesRU8@8bytes.org>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for
 __int128
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
> On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wrote:
>>  include/asm-generic/rwonce.h   | 2 +-
>>  include/linux/compiler_types.h | 8 +++++++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> This patch needs Cc:
>
> 	Arnd Bergmann <arnd@arndb.de>
> 	linux-arch@vger.kernel.org
>

It also needs an update to the comment about why this is safe:

>> +++ b/include/asm-generic/rwonce.h
>> @@ -33,7 +33,7 @@
>>   * (e.g. a virtual address) and a strong prevailing wind.
>>   */
>>  #define compiletime_assert_rwonce_type(t)					\
>> -	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
>> +	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(__dword_type), \
>>  		"Unsupported access size for {READ,WRITE}_ONCE().")

As far as I can tell, 128-but words don't get stored atomically on
any architecture, so this seems wrong, because it would remove
the assertion on someone incorrectly using WRITE_ONCE() on a
128-bit variable.

       Arnd

