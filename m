Return-Path: <linux-arch+bounces-13613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B51B574ED
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E249F3A370B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A622EFDBD;
	Mon, 15 Sep 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JcGw6eYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsCkvdLb"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448391FC0EA;
	Mon, 15 Sep 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928578; cv=none; b=QutxpVQEWCTHmMlaes1/ZtD2EXDb9bQm+5DfLKvksIX5DUp8EHKQr72WZ4MQFjw3x989KcujjJ6gCo3tFIcTJDQbGk8W1xrpwANQBD2HUNvMl3WHOO8O50285kzZkgVpFUrqrFEIELyrbgMr6ExOi2tmWzRvL93kNcuLmPKVp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928578; c=relaxed/simple;
	bh=w+AOnPDqZdINjhZr0XEnxl7jwYDeFZy59UUMQYl77HY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pBgpRAJkePqGf5XZ96QHTB2doX/zLhlfqjq+1iUQHeeC8Axpx5eOCh7FMKRfMvK/gilemxQWKhyi0AHmvL+5ygr+WHDhkBLaG8F4UKFWwpcwEDp+ErSTECulgSlgm6cbLUb1LW6bsZlNCivgezO2yIIQrTqMnKO0YKE9aErNLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JcGw6eYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsCkvdLb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40E48140019B;
	Mon, 15 Sep 2025 05:29:35 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 05:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757928575;
	 x=1758014975; bh=nKLER6V7zUEC4x624A5YTVLE+4Pgd1sT0irB5GYVHZg=; b=
	JcGw6eYEgUWOe/fxn9oJLYkd2jZ2DHsaugWzcx6lfdijGXrw5NMElWvkhPknjNuO
	sHQxFdIgYPXP9/QPu5VObPEAAUxZfW1e+yR9PyUEMNC+76X2YTPImX2bzxp+O6h1
	rHpp9PaN1ywFyRrjL7zjefDNI32RJXw/GC66Nix+NGSEquhn98Y27F2pOPAssGjh
	CV5vF8a+c+djtI+4rUaVGFrrCjF8KcRzGVHGr+ksMLvgGs0dUF1pzfKMBRdS0lWJ
	bSqdpZ25VeBJwyqjpOI9mroL6zfodrTltxyZ9roKHfPVNo/Ltav/3IaV2XzXCX8N
	6H2JqUl6OXuCicNCn5cY3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757928575; x=
	1758014975; bh=nKLER6V7zUEC4x624A5YTVLE+4Pgd1sT0irB5GYVHZg=; b=T
	sCkvdLbaUyhT4+Cnpbq0E0PDQ2ozmarQFgrH0WUZJqBvUlnnU6Kp3E5HqU/lVvrz
	4KySQKhOqIoR9l9oEokPsY8UxOSjAVe27PHeudT8RmKzqSt6Ngp0v9hceV2xHXQI
	ggQZo43z9GMAP6g40Vy5oUT76kb5Qn9L8+6q7EXWI40/T1SMG9IdmM1OtzeAX4Qq
	wKlsG0awHfYZJaOCOpUtLER2rjBtY2yZpM26Cp8SIMGzRvUY/DFtEnH0W5QIkpNf
	hn2cIDDb5Nmw7VApmbmLYYmcXegEAxIN+Ngk+BLP6/4vf5cMG1dpmdUQA5U0BSXU
	N98NQzu+RKH0Kiyalgb+w==
X-ME-Sender: <xms:f9zHaBA3PnAS3ZEGiMviQdb5khui0bmyPi0O0_3Whot6ObayLaR2-A>
    <xme:f9zHaPjtq5rgEon0uC1_U-quSrSr8EgGbNoWmXCueHe53z4pBuk995DwvtR3LhGxh
    BA1L7v1ZN4ZZe019jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:f9zHaFxrSSUbs45wxHJOEnDg7qyBSbJY5-MiKbslq1nL87kur1MpcQ>
    <xmx:f9zHaLN_dxTKaeYf8VpADHHRs8HS9FgaVV2IyrwoflayV3EXwUMGTg>
    <xmx:f9zHaMfQDWz4QYMvoBIl1I5ODkRz8KDvACezbY7IIwmshSQQEuZzfg>
    <xmx:f9zHaIS50g0ntb3JfzGjXIFAxVK3aeTipNhXCb4gJGm3g7etWS6mMg>
    <xmx:f9zHaP6QFuhQp-GLlJZwvtIyKJHHEhHqrYw4VhlSt8Z8gsOXGT2R7pNO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6C77700065; Mon, 15 Sep 2025 05:29:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Mon, 15 Sep 2025 11:29:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <fb06c629-6a57-4d14-a5db-b7790b84ce13@app.fastmail.com>
In-Reply-To: <c130a0bd-f581-a1da-cc10-0c09c782dfca@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>
 <c130a0bd-f581-a1da-cc10-0c09c782dfca@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 15, 2025, at 11:26, Finn Thain wrote:
> On Mon, 15 Sep 2025, Arnd Bergmann wrote:
>> Why is this not aligned to 8 bytes? I checked all supported 
>> architectures and found that arc, csky, m68k, microblaze, openrisc, sh 
>> and x86-32 use a smaller alignment by default, but arc and x86-32 
>> override it to 8 bytes already. x86 changed it back in 2009 with commit 
>> bbf2a330d92c ("x86: atomic64: The atomic64_t data type should be 8 bytes 
>> aligned on 32-bit too"), and arc uses the same one.
>> 
>
> Right, I forgot to check includes in arch/x86/include. (I had assumed this 
> definition was relevant to that architecture, hence the sizeof(long), in 
> order to stick to native alignment on x86-32.)

Ok

>> Changing csky, m68k, microblaze, openrisc and sh to use the same 
>> alignment as all others is probably less risky in the long run in case 
>> anything relies on that the same way that code expects native alignment 
>> on atomic_t.
>> 
>
> By "native alignment", do you mean "natural alignment" here?

Yes, that's what I meant.

    Arnd

