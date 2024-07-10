Return-Path: <linux-arch+bounces-5342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB6F92CDBF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AD31F25D8E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22A17623C;
	Wed, 10 Jul 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vElaDc5Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHNtdTc2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E217B43E;
	Wed, 10 Jul 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601871; cv=none; b=ka4Y2sfTAu6Zo2QTVNdFy8SknkgBP52FEKfBI/jIjEvlMitTN2Q/vxFYykYK2cbXNScuCr0oqe6RiaSLGuKFNzP6SwrwMimhwfBzYbx/8PEH5tYIBcjsUjCyOH2+OpxPfOo8QmP3WL2P2cdep7lUyGevzIFphBmRshXZj6l+Nxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601871; c=relaxed/simple;
	bh=mJvQPv8fXiG9w1+1+ALK0b1J7FKFQY0Ni4C3WfFzukA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=iuLxjpWKgF5+oqz8ZDcGzUrk30szzraXfTENtWGTCwYGwDZ30TA1Rdc2Ksk9nxGAJuE86rRiwyKDxnh+RS3HkLSMBjHDBslhfY1CaCPs6oVzOCddnSVhGlaHVd7ycBYT+xNpErp6rYQlMOn59uBwKOs7gBfKhbNvlxZP1ZBekHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vElaDc5Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHNtdTc2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC0751381C26;
	Wed, 10 Jul 2024 04:57:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 04:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720601868; x=1720688268; bh=lt/fTYVo1r
	XzmeyPprLYJqd44kchp17M6qZOeedxiX0=; b=vElaDc5Zc4T0Bucn0BpOSB6GZ0
	hjNAgO3T5KaLmjz60FKHB4Cc7LinLJmzsc6RD4gS509+0qqW9TiguqDbOe6n1QH7
	J11fG0VOjxBsEX+UDwCBaxZNZSsL/Eidk7IDp3EE5NZPbOaPPStHgOvzD3LeqXmu
	7UfdC+foZq6/5knFTUYNrVxWJ0JcPXPfpbRsMV1zT0nr8OmrhD6etqIYPSXdaSdk
	k7LEdU/zq8ZmkW7LIxAR0GRe4RievqOm3RsDQmiMGUN8u3f3HjBqcgWRKLhflT07
	jy8vU5NNqiCi6a1shhok0mcPRLwSNBoa2c71l99xz4WSW9z0xwuBina45+Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720601868; x=1720688268; bh=lt/fTYVo1rXzmeyPprLYJqd44kch
	p17M6qZOeedxiX0=; b=IHNtdTc2MwgAHu+xsleVLRgFnL8zU2pqZI8wFXBO4G+z
	w7duvlyY1ZInZUOFYw/zHAMZZ1iz6uKfGYfjjmAG+balX3StBpo5ycfaUxigvTR+
	Vq8azfJ9B+A44C1vVXZ0vhtvPpka7EeglroUGLl8yIiV+HwPbZGN8XrIkqmyFQEa
	a9PWgOU3o8GqsJiMNTX7qHWBAQuO/ZnZdVWpQLeP/bNxu3JE1i5jCfxsHMbsiMd9
	XdiMVReUHd9OXaUru1txg9lHxpikSz+1xtseAoEmdsHFcWwjBZUKfnd1bh2/F8bp
	uuLuJRjKjr6zR6IFvoCBkHzCkxkEdxYrx3c45QFaaA==
X-ME-Sender: <xms:CU2OZtUZS9duTLybtLEjKFdaMSRkCFbANioPF2RVtxMDgWW0WqVXbQ>
    <xme:CU2OZtl5gfIoLfrZ9z6Mba3YM7-UiIYfgWhjPEMQcbEzgWOyXG9AyqtMiPLqLUZ1m
    R0cNRxcl5Cbgdp3Hc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CU2OZpYvBg6NeqezJ_1Y3OV0VK_2AKn1UDwnzoDmmbITnlsj8aypPw>
    <xmx:CU2OZgVzjr4HBNlxUYnWoLnXwaV1g5GGCjgT9vsyzXWpdgEUXXap_A>
    <xmx:CU2OZnk73biMVuO72udsYhhDDSs9kRL0Ezf3bcNHGzrqQnwnT2sK2w>
    <xmx:CU2OZtekE7zuLdid4cWFK96thjCQjauEHD6khKqmzgiMDMNOQudQtQ>
    <xmx:DE2OZhvCsORzsRusPbb4ghNUKhzWWPHTcU6ETVqu8SjoqHNiXfuHvRLB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AB154B6008D; Wed, 10 Jul 2024 04:57:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93c84e97-b307-4486-8dfb-e966c96751a1@app.fastmail.com>
In-Reply-To: <c8c882ad-d508-40b7-9af5-b2a2ddf777c1@sirena.org.uk>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-11-arnd@kernel.org>
 <c8c882ad-d508-40b7-9af5-b2a2ddf777c1@sirena.org.uk>
Date: Wed, 10 Jul 2024 10:57:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Dinh Nguyen" <dinguyen@kernel.org>,
 "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-riscv@lists.infradead.org, "Aishwarya TCV" <Aishwarya.TCV@arm.com>,
 shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/17] arm64: generate 64-bit syscall.tbl
Content-Type: text/plain

On Tue, Jul 9, 2024, at 19:23, Mark Brown wrote:
> On Thu, Jul 04, 2024 at 04:36:04PM +0200, Arnd Bergmann wrote:
>
>>  #define __ARCH_WANT_SYS_CLONE
>> +#define __ARCH_WANT_NEW_STAT
>>  
>> -#ifndef __COMPAT_SYSCALL_NR
>> -#include <uapi/asm/unistd.h>
>> -#endif
>> +#include <asm/unistd_64.h>
>
> It looks like this is causing widespread build breakage in kselftest in
> -next for arm64, there are *many* errors in the form:
>
> In file included from test_signals_utils.c:14:
> /build/stage/build-work/usr/include/asm/unistd.h:2:10: fatal error: 
> unistd_64.h: No such file or directory
>     2 | #include <unistd_64.h>
>       |          ^~~~~~~~~~~~~
>
> which obviously looks like it's tied to the above but I've not fully
> understood the patch/series yet.  Build log at:
>

Thanks for the report! I just panicked a bit and thought I had
done something entirely wrong here, but after having a closer
look it turned out to be a silly typo:

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 038dddf8f554..df36f23876e8 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -1,2 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <unistd_64.h>
+#include <asm/unistd_64.h>

I'm folding the fix into the tree now, in addition to the Acks
I received and another small fixup.

I checked that arm64 is the only architecture that has this
particular bug, and I tried building kselftest now, which seems
to work better. There are still a few warnings and errors
I get doing that, but I suspect those are all preexisting
issues.

     Arnd

