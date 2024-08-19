Return-Path: <linux-arch+bounces-6318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92819564F4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5561C2175A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480D15747D;
	Mon, 19 Aug 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rRGdC/61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqfopL3N"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC7182B3;
	Mon, 19 Aug 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053770; cv=none; b=AyzUaL66Ptq+p/nTSbtyOMWfGNiQhULUx/hJ0bjWNMX3PXDGtFIrVPLMCNUWkAVtBEslbIsZBoHZgBaj6OewAO7eYWdw3XAzNijWflzHGt9uAs7Kk5NzTwU3yBx683nlmqzeTgYO19mYsX5eesYpAUwPu5Yj7Nhq473y37gCQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053770; c=relaxed/simple;
	bh=Jc6StV0rBLL4w4KRqChFELfq5YYhIJeXdmN6Lv73xbI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t2L8Eas13mgBk+qJwOihXApp1prlz0VgSyK+0ykaZJNQ3Q+QKgG6IVhOpaoQ6sfOHhjfxH6EF4IZHvBbuIOK1AeC8ePVlcGj4XegaJdtfol+y1czLmF8svaK5TMwOJUnEOnmhMo8xqn542e3rIUPEy7Y8x8U731s0NjH4OJZA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rRGdC/61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqfopL3N; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8523A11518DD;
	Mon, 19 Aug 2024 03:49:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 03:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724053767;
	 x=1724140167; bh=lFQVYmYMNBA6Y8zAi5sckuXFeIU8lBmafp6xesMZWdg=; b=
	rRGdC/61vkpx4/g9n5wjR9TLJwVPAqAxvP1IkMgQy31GMeN3IwQgQy2HZMFrOqk6
	UK4LwSlLTEzL5rwbzJTtLtg0qMW4QRwm64N98vS0v7OeB9SF/Bwt9fuRd/askhz+
	JCtUkneXLDeSFx9Vl39xkubFOa6/BTuL7NSD2Sb6phU16dHZETwssYaPDel8gki1
	2jWLRA13NkelHfrMB8v1RbMJQxG2Piiqh22gde45hHkI30TDS1vj1p9IJ4gcvoRn
	enBTmSXAtw3DZuxiQd1wwh4v2Kz6H20G9NxgSfA/ZuLc9OLpSypW7J9mtzbKYp37
	/WjpQLODD2tggx4DGLKXjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724053767; x=
	1724140167; bh=lFQVYmYMNBA6Y8zAi5sckuXFeIU8lBmafp6xesMZWdg=; b=d
	qfopL3NfWSH+BiS3TMkZvBC5R0plQ+SQBiWdxR1Xn+t9sLim/j5Tj38Q2nkeb96o
	ycUPKfHKD5A/pPZoqSuMVUF0wW5xSNCnNcEywdJWjFBx+ycVbfOTI6qt4QqOOwzR
	zMuOThKzIaScaFNanjd2zRNMtGuCd/8T9/5imJ8ZgWCE7/8TLuS4XQH2UCJSMoNi
	8jOBK/l8mxhSEgqUn18xPA7/Bj8oHKCg7V/YCpREluKYE+eaM4o0dZQhsyy9mWt3
	dNMoubgyLR5IefASmxisidpY/6Zrl2szK7LJOWEgWt6Bhl4AZ5onI1PGAit9mdpg
	NR9JozK0EFt8lobnLHeog==
X-ME-Sender: <xms:B_nCZkTVxCfjoByi2nvkY_VS9Vq9kbzsugwBZDAwwqaUfgDZ1XM72w>
    <xme:B_nCZhwCEKH8kzEUU_C49ze9__wTs6ZJsW618OZWtF-4i63UOhNnifDF4x8jKJdxK
    gnfm3i5nDdyuggD-5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhorhhvrghlug
    hssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrghhorhgu
    vggvvheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegsohhrnhhtrhgrvghgvg
    hrsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:B_nCZh1m5ia70GnnE61lXo9ytp-nSoW5vIJ1ShpVzDNLkoEN1wcSwA>
    <xmx:B_nCZoD0dh3ycDk8kfmhSJW0qQcilVSdXlJ6by6CBYf53C_dESnG9w>
    <xmx:B_nCZtjelA2N82brvMGL2aRsRj_lmBUAwjpZnChlvKyc6qzi1htPuw>
    <xmx:B_nCZkqOn8j4Dhx1VKmcqFGSxFVLIgTIo1GOBww8-DCukwgkVbmgpg>
    <xmx:B_nCZmZHz8nUttmzFehecasjVXkUbrL5_LdGhAUuRvIz6pnYU9WP2nOP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E3A8D16005E; Mon, 19 Aug 2024 03:49:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 09:49:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Will Deacon" <will@kernel.org>, "Jann Horn" <jannh@google.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <befa0a09-369a-457c-900a-d350da6a40e9@app.fastmail.com>
In-Reply-To: <20240816104132.GB23304@willie-the-truck>
References: 
 <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
 <20240816104132.GB23304@willie-the-truck>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 16, 2024, at 12:41, Will Deacon wrote:
> On Tue, Jul 30, 2024 at 10:15:16PM +0200, Jann Horn wrote:
>> Refactor the list of constant variables into a macro.
>> This should make it easier to add more constants in the future.
>> 
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> I'm not sure whose tree this has to go through - I guess Arnd's?
>
> Acked-by: Will Deacon <will@kernel.org>
>
> I'm assuming Arnd will pick this up.

I'm back from vacation now and applied it to the asm-generic
tree for 6.12.

   Arnd

