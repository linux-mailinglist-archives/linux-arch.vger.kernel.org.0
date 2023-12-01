Return-Path: <linux-arch+bounces-611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE71801630
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE7AB211BA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762E619A1;
	Fri,  1 Dec 2023 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OhVX1ual";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhHpiTeZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE31128;
	Fri,  1 Dec 2023 14:18:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 132F22B00496;
	Fri,  1 Dec 2023 17:18:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 17:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701469088; x=1701476288; bh=Yf0DCq6uHReIEXb4I8GDi+xTuGOMnvQzeuV
	fuSfiqD0=; b=OhVX1ualRwWUKIOdDP1Op+eyMmNsNY9/yG+CBhNxoiyi7ol5pyD
	ZP0tE9z3n608DUxFND6NXf/km6NYlvp1sobl4u54CJphz9E66Bw3JuGV5aSKjba3
	ACmPKAbPl0NwNmEny2JAvegVKeVNCdC/qb3dgCKSljwYDm1PjMgRi+Ds7Pt4BCen
	Wdf4F9Sm6GaZy52w5enOae2FQw9jzFuJVkBKobEKA4aymWs1ZiduXTo6AX1z8Dwk
	IuOVzZ0pLxrdHT2RLWM51B+kejHC0ef/GOuUnFtAnoeu1JWiqn0BSOeBRWOnL95d
	iQk1EChGVa5c1xjuuVjEzeyklZIn0Te7GNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701469088; x=1701476288; bh=Yf0DCq6uHReIEXb4I8GDi+xTuGOMnvQzeuV
	fuSfiqD0=; b=EhHpiTeZg4ikcKwMOfBQBIpa8CV1aHi/eisJy/so0UOP1EidwOc
	t948VO7F2q5Ql8nngYB6dYNWo9xDciiqel4nILJquaFLjIRxMQbDyYZ/3gcQKk9Y
	fpAA/81LDdIrIcVIWvIrLyNhy9p0VcwlFuQRezW4koG1jEBgEzD8pGlQDoFT20+Z
	isymSy2n5jU81yhDmOIuW3fBSXnr3nN6kBq6s8CMSMIXLXZ3AJ+XYYL9nNOJc2+g
	shYs3U8UnYzA0oNpAJRtYr4lTsjZHSCvCThLX9TiTSrEPJfykyExLCHGSRKZZWTh
	hT2lCdLH0Rl/xqw2rW6iqI7UhUhE5MQECPA==
X-ME-Sender: <xms:n1tqZSkPx1vAS_oYaJDBsOWOpoDMbV1GxW-dugE3oo9FSPuY3YUrpg>
    <xme:n1tqZZ1mIrtwcTViPbknlsJi26XiGhB44jOBJFSkoFnjBoOeAGNRMroDzhgs-5hDo
    HG_9nH-GzgbjQK_VGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:n1tqZQoX80uebtPwscZwklt3NPqkS_K90aKHAiBkpQnVGY6-dR7FYw>
    <xmx:n1tqZWk3T-vWG1KJOodbcQbfLeAWZzoXJoU5dWmAhWtdxY88BxO31Q>
    <xmx:n1tqZQ2ykrtSEQX6H738J-MM5luZNuBoD3EZ4mkVIJqHYz7R_0d8VA>
    <xmx:oFtqZb-g8xRJTB_H8wtnwVZedEPoPoPaNXJnVCCpx2FVYsHG-PC14XuNKNY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B4070B60089; Fri,  1 Dec 2023 17:18:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ed157c7-e0be-43d9-afb1-2bd53b934f56@app.fastmail.com>
In-Reply-To: <4bf46893a583551c71bdfbf91df9ccc4b51556b1.camel@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-2-pstanner@redhat.com>
 <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
 <4bf46893a583551c71bdfbf91df9ccc4b51556b1.camel@redhat.com>
Date: Fri, 01 Dec 2023 23:17:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>, "Neil Brown" <neilb@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "John Sanpe" <sanpeqf@gmail.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023, at 19:56, Philipp Stanner wrote:
> On Fri, 2023-12-01 at 15:43 +0100, Arnd Bergmann wrote:
>> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
>> >=20
>> > -#ifdef CONFIG_PCI
>> > =C2=A0/**
>>=20
>> You should not remove the #ifdef here, it probably results in
>> a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
>> GENERIC_PCI is not.
>
> CONFIG_PCI you mean.
> Yes, that results in a build failure. That's what the Intel bots have
> reminded me of subtly before, which is why I:
>
>>=20
>> Alternatively you could use Kconfig or Makefile logic to
>> prevent the file from being built without CONFIG_PCI.
>
> did exactly that in this very patch:
>
> @@ -14,6 +14,7 @@ ifdef CONFIG_PCI             <------------
>  obj-$(CONFIG_PROC_FS)		+=3D proc.o
>  obj-$(CONFIG_SYSFS)		+=3D slot.o
>  obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
> +obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o     <-----------
>  endif

Ok, got it, looks good then.

      Arnd

