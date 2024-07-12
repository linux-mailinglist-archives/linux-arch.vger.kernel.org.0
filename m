Return-Path: <linux-arch+bounces-5378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EED92F796
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473D02819BE
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E719143C51;
	Fri, 12 Jul 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="M7SN+q9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrQeQaoA"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99014143747;
	Fri, 12 Jul 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775354; cv=none; b=B1XHoXHU/viJxbPN9p7GszhHcMMdEuBa1zQ8p7o868QHbUVvwowATZHEdsnwCudJoNMbl0ivEW/0UgITEK74eyLTbSyTzQHmv34U6xQuYGcMQT04w6Opz7GbioS/fS/HJ4IuxebKZtJwNPEx/0j2nqICyc23C3YxlS6tPh143yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775354; c=relaxed/simple;
	bh=Dkgox/IQTwaQ+eQxNPJVC2wknfvPEUKKuT06ZCrgfKk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rbLnVIMTjxvHHuoiNEfMAumYSywNFoNp7orEJKubLwAuTHsbxztwE/vTmaRV22G82jiH4UNcrSDwsgOFImy2m1jW1kd9MIXUX6ek6rmXwKxi6cLlMWnFULnwGLdupxpY+7eCb/dZK+P5PWt7O1t2DkD9NbpIwMP5aQ+Zzf+lRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=M7SN+q9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrQeQaoA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF4B4138221C;
	Fri, 12 Jul 2024 05:09:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 05:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720775351;
	 x=1720861751; bh=sZ7e4XevovcBdrC0s9li43TyJDtZzYkioK9A8LGqM/Y=; b=
	M7SN+q9i0T1/jB6rkxntX3fgDkaikboa5B4fEQ7f99816KkJDDm+CP8PZpT8ZezN
	GNUQGwX8pzFBddHKwfg2FfGNMroyt65wjVT3xmfuIHK9WbS9ETLz6G3Tl6PSN+/F
	Gfumz/LDeEJNUhs/uKhyYOFI8xO/2U2gYlzfwSI9iCp9A1u8FAaz3YdE96uOlsIy
	C3z1sY56kT3e9DuxQR+jFBJ1IFYSZVRPnixfa4p7PBQmFvT6dCgKuWiOYdwH2RC8
	FCkIWbjvRk0llcGrJ0HVxt8Kl4gGJsU5QivQRQPATjazMWPswZcZVynMUPFb/PJN
	uQk5pfumf9/XpeBnVjhcTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720775351; x=
	1720861751; bh=sZ7e4XevovcBdrC0s9li43TyJDtZzYkioK9A8LGqM/Y=; b=N
	rQeQaoAYrmIx4P9f1dJ204CLgUujqrXKFMFrNNLiFFla4i8EB7bhNuKzjgRj3DGO
	Eym3G3cXIPA9uQzYswhcEucP6Mvp9c5FLUD/cdWl6bl7XVW+IM2TekwG8A4C79S9
	RKniQ50ZGXAG+CDKWB/rNZdBZS4WCdmBTR/EUR3Rn55HgdUBgbbooTGJE781Y63f
	S6Uud8LVRJi2zAyBSMhQQqQAgB1U3UpaSfZgH22siiPk6Nybr5f46Z1EhpNLZ6n7
	L3D7R8EZOD7aNt3qY7lxRGjX9Jaluw6Js9KGMNAtvS0npAU0x/wzA6w3JvX3vwzq
	2Y/W0ngCQNcaYui6ZdOew==
X-ME-Sender: <xms:tPKQZsDR-wmYFg7MIczctzGLNXIg6jYekOWPBAT2oOYzOgmMIKfXtA>
    <xme:tPKQZujqoKOXxeixBmlq_wWrG20-7I5PX6o1IAasYCOnLRcrQWPaioJkPDCSXXEcY
    0tjiQB1LzzzPzvF32A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tPKQZvnM0POoj8h13xHmxb_HKBiaQZefN_oNtqRHbw4JDgxKnPxd9A>
    <xmx:tPKQZixofpA8v3Gue5nkhh60aW_mzdzZJE689uqiwWZsm0JkKizC7A>
    <xmx:tPKQZhSnPYREvuE2yvUVgs7XB7xgq8KM2oeEU38DYPogz8EKybqKvg>
    <xmx:tPKQZta3spHoTBC_qk6-TiezbpzzI7noO1wvjB0mBLDEKDwWuROD3A>
    <xmx:t_KQZhwIZzgBoFR5lfyh56NGNRguMKKXxXb63UdfFG80E_XGEKAnPekG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B788B6008F; Fri, 12 Jul 2024 05:09:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b8fa2389-e666-4631-a872-d0144fb7b3ac@app.fastmail.com>
In-Reply-To: 
 <CAK7LNARpWB6Pqa80KDmpdJ_Rf5FZc71_bX9eSy3fFVCAyg8CAg@mail.gmail.com>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-2-arnd@kernel.org>
 <CAK7LNARpWB6Pqa80KDmpdJ_Rf5FZc71_bX9eSy3fFVCAyg8CAg@mail.gmail.com>
Date: Fri, 12 Jul 2024 11:07:34 +0200
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
Subject: Re: [PATCH 01/17] syscalls: add generic scripts/syscall.tbl
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024, at 10:43, Masahiro Yamada wrote:
> On Thu, Jul 4, 2024 at 11:36=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
> I know this is already written in this way
> in include/uapi/asm-generic/unistd.h, but
> the native and compat have the same function name.
>
>
> Can we simplify it like this?
>
> 65     common  readv                           sys_readv
> 66     common  writev                          sys_writev

Good idea. It looks like this came from 5f764d624a89 ("fs:
remove the compat readv/writev syscalls"), and I'll fix it up
in my follow-up series, which has a lot of other cleanups
like this one across architectures.

Thanks,

     Arnd

