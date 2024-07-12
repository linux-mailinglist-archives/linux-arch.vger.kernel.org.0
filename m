Return-Path: <linux-arch+bounces-5379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFC92F7B3
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8049A285274
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF69146D79;
	Fri, 12 Jul 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cMt4P0Gr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgYDcZka"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18EA143C51;
	Fri, 12 Jul 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775624; cv=none; b=sREGNOE7h9TRKFngngaqtT9d7++x0MCd2QBk0Z0vMd+ZzpMpVqguIgnNMmNXYNbAYFlFaGuoNSSCt+CheiQQrklG3P9SR7wtyU3pf4o7yOW4nHD98yiodwZu9blp7Uo+DJ7UqCHMu8v4Qq5qPiP8hBrYzeVE6B5OQNMEABVtb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775624; c=relaxed/simple;
	bh=iFK37U2f70CC36s76QKCED26mTV/SsdiHM+sATzIl90=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YzhWkSRwq7chtU5rIVWxdJf8fuW5LBNf4pATrNTEx7bNxII55ULwROLVHCAGH2Sel/QbQR73awyHS3XOKUrWJ3PRpsfLK8yn/wwj3DXQDCc1U6+eKaTRFESU7dDsy/7+gponcCz2nFp8xa4lI5Ix3N4HEEp66C9E4Oeb1tihmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cMt4P0Gr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgYDcZka; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 093B913886AE;
	Fri, 12 Jul 2024 05:13:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 05:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720775622;
	 x=1720862022; bh=+8/B7nnlva+5zNPi7sf2bUE6DcSx2Ml3WIXcjT3v0KM=; b=
	cMt4P0GrPCayVfGKqZ04Oldr7Mq6E4vJI+T0BQYmDKIDYEHrhuOriDb2sn8s1KAi
	LzNn1/Ct3iNJHUj/9LKX/q5T+aPnWSU7HdJcQpfMzPrfFAubBhErxvUuy1P+kRh3
	Kj28fPCP/bx/RANmMJOBlO81H2asQTcOtXF+xF5ATeo4o3qkokNXPtv3pTzE9sn9
	2xy+j/kytN8CnYTQKueMwZdbAwZATfI+ZVxRd/0W7AmjdWmO9PW3UAbQyXY6/IYp
	eraDlJ3tZEnbEj9QY4mUUhTOv9r5NABuy+DSOu58NXQVjkNkOs93daRnA4NzJ+i6
	p3J3ei0lSuRTNcfUct143A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720775622; x=
	1720862022; bh=+8/B7nnlva+5zNPi7sf2bUE6DcSx2Ml3WIXcjT3v0KM=; b=M
	gYDcZkamVp0txdHnMyaS7XkhFzNUlFoQzSTIyWZAj9H0avUirl9gdX5gYdz6XQ7Z
	qC1CVsA2OHkEHJ5dPG3Y9/IlJBydnLypw2NP0jTgRp0vVGxMNT/F+GYe71li4sAw
	KkXYBrpStP+OLQ6Igrv6lXWSxxyFj3Mfi8HvKhOVu7aDHGzfMwpWP8aPphGLveY1
	0yxvR57ylk+qoUnc9ngMgO6svFMtGH8TEr+JdIp+XB2GuLJApzLN8ocObuI3RPjm
	8oAW99cy5eFWAiK2kDQhrWzhogGOXGFnqfVrBW6dTz5CFt7kRPqZpUz/03sruZVI
	06s5Pn7JCEWojOtFmbaMQ==
X-ME-Sender: <xms:xPOQZt-gkPmGrHIkjqeUNvcRdLZEQU_Jz8dQ0G-CNop-bWBhKDU2Gw>
    <xme:xPOQZhv1pioHUTjgPWVTQkPz0BGoB_PmdRozC5XLrsMXXBQWtRdymnz4I_DdIiusV
    snjitaKeOOyhNgD2wY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xPOQZrD2kH8otN3RHA4viULvGsXy6rh7LGueObOJ9FDelSl8S_oLUQ>
    <xmx:xPOQZheVft2_07Rj9pEC1MUxQxSs1cKPU-CmR23h62f6VdXf7xLXeA>
    <xmx:xPOQZiPpT6jkGVO7I3U5rxli4mDgimMarQvFMF6WpzzJDuvXO4Xqcg>
    <xmx:xPOQZjlSpjww5SK-qGAGKRrkYnivx7JEazxU2Eq_z1bUBgXoi4Q2Xw>
    <xmx:xvOQZosARBHlClwP4SI8f_7F32uxnt7h-kjJ5tyGMWjYdClF6iIiL_9w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 62E5BB6008D; Fri, 12 Jul 2024 05:13:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d998e37-926c-473f-a58a-1d47b96f882a@app.fastmail.com>
In-Reply-To: 
 <CAK7LNAS=h6dML-06ox1dje_bxF2+R-Gq7Yw-s73Vi-FW39L9eg@mail.gmail.com>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-4-arnd@kernel.org>
 <CAK7LNAS=h6dML-06ox1dje_bxF2+R-Gq7Yw-s73Vi-FW39L9eg@mail.gmail.com>
Date: Fri, 12 Jul 2024 11:13:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
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
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/17] um: don't generate asm/bpf_perf_event.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024, at 10:37, Masahiro Yamada wrote:
> On Thu, Jul 4, 2024 at 11:37=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>> --- a/arch/um/include/asm/Kbuild
>> +++ b/arch/um/include/asm/Kbuild
>> @@ -1,5 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -generic-y +=3D bpf_perf_event.h
>>  generic-y +=3D bug.h
>>  generic-y +=3D compat.h
>>  generic-y +=3D current.h
>> diff --git a/arch/um/include/asm/bpf_perf_event.h b/arch/um/include/a=
sm/bpf_perf_event.h
>> new file mode 100644
>> index 000000000000..0a30420c83de
>> --- /dev/null
>> +++ b/arch/um/include/asm/bpf_perf_event.h
>> @@ -0,0 +1,3 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <asm-generic/bpf_perf_event.h>
>
> I guess this is a step backward.
>
> Technically, kernel-space asm/*.h files are allowed to
> wrap UAPI <asm-generic/*.h>.
> There is no reason why we ban generic-y for doing this,
> whereas check-in source is allowed.

I think in this case, the simplicity is the more important
argument: this is the only case we have of wrapping a
uapi header from a non-uapi header, and no other architecture
would need to do this.

The way the syscall-y rule works relies on enforcing some
checking for existing asm-generic headers, and I could extend
it to allow this special case, but that would make the
Makefile rule less readable  in exchange for avoiding
effectively a one-line file.

    Arnd

