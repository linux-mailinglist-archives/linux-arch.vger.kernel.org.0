Return-Path: <linux-arch+bounces-7119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189C96F9DB
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 19:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17161F256B3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF31D31B8;
	Fri,  6 Sep 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GUTFNgtQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9R9wPK1"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EA1D2F43;
	Fri,  6 Sep 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643211; cv=none; b=YoqJjUDJcIzSIuCIb3baHpN95zExjAsw6TsEQkXoNkLffW+EwVp+aEXdaLD7EQqvgOsBkHExD8IO2zo4zniBcPB3nnNPvMJNwSdWiSqZ6cTnwOcT8+X8FGroK+W3kygJNbp/k5CXrVZQ/iD/iD92WwRREruclm5pfngMOL1IXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643211; c=relaxed/simple;
	bh=hFsVCuWFovzKfydtu/2HfnueKRA8iG/FfmTYP+cgV60=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n4pgNb35Ltt5qIrM8nSkrb6SYstEoEHr0gBZdwifNkYqZeKpwZ2K1Q523ZgLwLu+y7Ux2Dw851v0V2kovhOvG4nFnfcDQY6INI9xOnDg+2YozZnJ2kNIVjRSoHO6XBqYEr+Wi0LvTWJCEFlmviIH3wx6OcRzr0pFhNWaMCrKSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GUTFNgtQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9R9wPK1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FB57114017E;
	Fri,  6 Sep 2024 13:20:08 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Sep 2024 13:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725643208;
	 x=1725729608; bh=pGqQNxsj9qfH9QsO5+3KB74ZxiKlh96u9meajutmSw8=; b=
	GUTFNgtQFspoqY52oTwNT8LGQnoU4H5uEN9RCeE6gsv3bwEHDlnVhLP50Pdu9Fu2
	2kdGuRC787ra70SOi0UHXcegX3AHoLHukGeHXAxg56kIS58HVYC7w0+P/Sm2cSLN
	DlbIi+sdAUcRaOLVdAU1qUpy/WCbNDNwKiSA6lU8WR8S55y1WdO/oJyoHm07EssY
	osYOgAcVNnf8/sawYqWKezWV/nLNODEen6w+s2P8IiLxkOjLiI4YkBD/VLV0Q/Nl
	6LgaZTm7eHbRfQmgYIxXLKmyMpGoLDZRf0mr70S4kMDxBizzrN9ysSeLtNhthK//
	LeElrKukKR3n4/4pKHbsYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725643208; x=
	1725729608; bh=pGqQNxsj9qfH9QsO5+3KB74ZxiKlh96u9meajutmSw8=; b=U
	9R9wPK1G+49xOApyDsYUf3Fu3yQ5Vpd576/nOMIoIbwoax7odlvHHdYUQdZREVmx
	QM0CI//E+Bd1YBnjFtXWJqWAI/+gS2W6Br6mrc9hWBYIotQZp/LIjc1yeih9r2RK
	YSX5FTqLJ28Y/ekzoUfrJHsdpTQx1lH9uBInGAazEeAImpPc248R57rdLjcJKh7b
	FC0zG3bUZ7bgUI1Ypp1mUO+ZpoF4QLx2p8qce88pDSkAhmKPZFCRg7cpuojXe9Zb
	uwIPs45uyLTqZzS06qMWOb1tRyHBPRe70+6F2cKBNHPLL0PizwmXMCaEqWbgDz02
	WNjstbFo++LL9oHYolAiw==
X-ME-Sender: <xms:xznbZoRc9TVjrwLKZD3SHzdddDiP96tjjtxv7zYuQTxohyzpwwcKxw>
    <xme:xznbZlwYPXSDx2sdJuDKdfHHY_kloBKx7LdIHrJznJ6NTYm47RJugPzFXBqtpiGba
    y7hkWlc55lr9ypGJ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgt
    phhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtg
    hpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
    pdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnh
    hpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohho
    ughmihhsrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xznbZl1fFpbhEQaSulOr5Sb5zVIVPk3MWod4f0_odz-P4kBqh0pBWw>
    <xmx:xznbZsCU09WoXMvmnkvlxoT-lKYi7xxe8W1lB0yGdF4oSnkanfmeGg>
    <xmx:xznbZhia_v-Pv1knXsHTdr-LSugEdm-qUUfO4wftFXFqKrccp8gEiQ>
    <xmx:xznbZorI3xx_yg1Bao5_pENYkT_hqfWhD2oxzzfDc1KcZTunJ0-Gsw>
    <xmx:yDnbZm2SOmPpRxhr_WCBYx6zAC4fjvxBPkGmXhlUQA-4a4PbbOdxdC8n>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F9C7222006F; Fri,  6 Sep 2024 13:20:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Sep 2024 19:19:46 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <11527a80-7453-4624-b406-e88c5692b015@app.fastmail.com>
In-Reply-To: <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
 <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2024, at 11:20, Vincenzo Frascino wrote:
> On 04/09/2024 15:52, Arnd Bergmann wrote:
>> On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:
> Looking at the definition of PAGE_SIZE and PAGE_MASK for each architecture they
> all depend on CONFIG_PAGE_SHIFT but they are slightly different, e.g.:
>
> x86:
> #define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)
>
> powerpc:
> #define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)
>
> hence I left to the architecture the responsibility of redefining the constants
> for the VSDO.

ASM_CONST() is a powerpc-specific macro that is defined the
same way as _AC(). We could probably just replace all ASM_CONST()
as a cleanup, but for this purpose, just remove the custom PAGE_SIZE
and PAGE_SHIFT macros. This can be a single patch fro all
architectures.

    Arnd

