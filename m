Return-Path: <linux-arch+bounces-3524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF289DE22
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD0C1C22A02
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FF13BADA;
	Tue,  9 Apr 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SfFQjHod";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef0PFokv"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460B13BACD;
	Tue,  9 Apr 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675131; cv=none; b=mBwIIohLRX4+Svs98vqcqmbMOgmoj34YDa5LXpcs//D8B3gUu0Tq2HP0nK9sofPoP3w2PLX8BXQ/4ZoR2pMFMUcD34WZIJI1O5uFl7am/tXiCfrS6s2hFuh3WccGXuqAh+3wR5m6BtDU5ir5NkAPIJKalJ74RrmchnR6S+7L7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675131; c=relaxed/simple;
	bh=BRuB4UKpiBNByIq5UG25bS2+dgxfikOk79EzTalBWB0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=c7GsqqKvU/yBnQnlMPdnLu2rtIXBLg08oh7Rlp0CNKitSUmhJIJW1aiEJnPTRNCEn98fMoISWT8JzS/2FIkbt2aRauRFNZv3851g++9FeNlsE1mvx+XKCsCYSA6Bbj/OeXJLO8AqCBPtydT/kBg7diSNIqqjhOCGytxuEQLKNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SfFQjHod; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef0PFokv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 06B801140193;
	Tue,  9 Apr 2024 11:05:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Tue, 09 Apr 2024 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712675129; x=1712761529; bh=BRuB4UKpiB
	NByIq5UG25bS2+dgxfikOk79EzTalBWB0=; b=SfFQjHodMy4wHc/7Hwneo7e6ym
	E8E50/C3wm/DXFR2krf3ZaIFAuJp8dq3KeP/bmTag5bqJ2qgznRgzUmHdZpvPzYF
	HiNN6uqsTLlUcHVbhGaCE61tQTR1G7PATqfFLZyT6Z/SqfFS9QoQkMFUJ/aaa1vL
	Bff0NW6osSw1a3SOCQ0hpZSuLMMYyfbj/ZEad8PgsiuiA0dk9p65Vqkyuw1VngmP
	RKhqrp0bV03yTWp7CntUJtBFGm0hV/hVyunkEjHrF4DS4Ze/v12vJGC9Jh7y9KEy
	aQ6fvM3zqsMvWehZUUchBdx9GFtoszvedaoz6k+Kqo4YJJ8/QAQ2RAQdFxtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712675129; x=1712761529; bh=BRuB4UKpiBNByIq5UG25bS2+dgxf
	ikOk79EzTalBWB0=; b=Ef0PFokvTD6zcZNbpgYWGwiG5tb0z3tH4RKUwV1BcnOA
	LU55sK6DHPcIixL7d+ocbFjLyuKgyjk6t8WSkbHyAmB6Fk/Yhdq1iBcbG5ktwK1W
	Vdp2tkSlqPIGaPpjs+hf8Y47V1agAFjUezogUnWV7MC/8tt3xE4MVXUldis12au+
	5wO5e8APojGNViA7hoHehOQB/RGvPY3MPsU1ezN0Uay5fos05hCdbkmL8gJKuHvq
	j1jRgVIOj94mFUuaYi8QgnRtdO4KE7XfYpmZ06MXTPlnxqOhDVGlAauKNzWg/LjQ
	YmOOcfFW8fUeGF05V0O/XHG8Jp5iLt73t0/uiFIrUQ==
X-ME-Sender: <xms:OFkVZu0Rsk9E-4wgeolKdkfyRkZkktAQ_nwi90wpywPJECrcnp-xRQ>
    <xme:OFkVZtZ8E7n0QrrrKCWDTBwFI11uOolA1CyI3MTRjtaaXbZmB_3MSqCt6Am9uCAv5
    RPFkWA46jtfV2z5aW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OFkVZpp0uweMVBe4mmv9NW5UTNyoys7sI81g1sZ10cCG-ZxWmhaSQQ>
    <xmx:OFkVZhqhHpgYAZzObLm-mMSA97VqEN7nUWTJHqv2EnUtO8uMV8Nm0g>
    <xmx:OFkVZj3qCI5_0Z9qhwv8FivbGBSHkYtJLI47daNJFbOu9tZ3r_WR-A>
    <xmx:OFkVZgDTVHrnffOvSW3qUIcqx_TBrTFj8dIpvFFmofUrTguf6f5txA>
    <xmx:OFkVZlw730G3knSjl4M9c5cTKK3CRiFbZBBn-zYvW7qImYlwh_S02HmI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 67E1AB6008D; Tue,  9 Apr 2024 11:05:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe75de1c-f500-42f3-bef0-8830d9f45ea1@app.fastmail.com>
In-Reply-To: <20240409150132.4097042-8-ardb+git@google.com>
References: <20240409150132.4097042-5-ardb+git@google.com>
 <20240409150132.4097042-8-ardb+git@google.com>
Date: Tue, 09 Apr 2024 17:05:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v2 3/3] btf: Avoid weak external references
Content-Type: text/plain

On Tue, Apr 9, 2024, at 17:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> If the BTF code is enabled in the build configuration, the start/stop
> BTF markers are guaranteed to exist in the final link but not during the
> first linker pass.
>
> Avoid GOT based relocations to these markers in the final executable by
> providing preliminary definitions that will be used by the first linker
> pass, and superseded by the actual definitions in the subsequent ones.
>
> Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
> that inadvertent references to this section will trigger a link failure
> if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
>
> Note that Clang will notice that taking the address of__start_BTF cannot
> yield NULL any longer, so testing for that condition is no longer
> needed.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

