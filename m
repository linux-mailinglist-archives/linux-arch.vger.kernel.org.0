Return-Path: <linux-arch+bounces-5630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E993C668
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45C2283A02
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2F19B5AA;
	Thu, 25 Jul 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AsoACoRh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u59KnImr"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E51993AE;
	Thu, 25 Jul 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921486; cv=none; b=COKjgp513xrY11/lAWfZfDjmRc2IBPUCXbvQc7WK/SiRu8kgFQTpNV7g0uTKhTBjshX08gM3oTuNGJSiLH7nl/h9mFUb+834uVvPMDGGhpbITU/3Y8yK6yCA2iBPQ+2H1MzjPqHfEcvHxtqvnI06mXPi0G+eSdtHh15aQC+Ae3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921486; c=relaxed/simple;
	bh=omFdD5+Pochc28zrvzQtrIQ/9Ek+FUKt1cKCBjxqXfI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZDM2WiyHclGgcd2hyzzrfEEXHdCUe4TwpFolPHGdY+LEHXzjoDRIufXu+6lb6/u403F2LSlhA00S57JZ5RsAT0EsGU40MtLALwiqYNabPt3mx94r/p9MaFOnS7wDFCm89vQi4GnCaGrfiziKKPtD4VkmsXY8M68gqo9H/70FVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AsoACoRh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u59KnImr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9A68811401F9;
	Thu, 25 Jul 2024 11:31:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Thu, 25 Jul 2024 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721921481;
	 x=1722007881; bh=SH2QsIwdxGEwvXnuqvyw/+HD9jOx3EvErodiIHyLnIE=; b=
	AsoACoRhcJpNk1G2Ie/w5Db0mrpEH7bVkMaqvotJq6aNTS72PDERWycZ6/9oxdUF
	T78xaWaFifaFbhnWKLDkBrwaCuuouLBY1ZMAI4sr4sGquAemJyGvIyoxkwIMzwB8
	IJADDWMULQ2e+Zf7v9pOCio3I7qGUMOdm6BL4cs8TI98qX5RhlWHR400ut+2HKL/
	ysxEijoHjVqcBBdsuNmGjvACmAsGvgZf2ePB1vvW5lXx73l9hmmTx0J4sWbF9nq5
	LYMp5S5GmSMOfgRrptXB8nxX/Kd8SFXol9skC8EQAjWi/egT5Cs6giZXIM+XRhbH
	VkDGOwEtG/FA4IHW8FcrTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721921481; x=
	1722007881; bh=SH2QsIwdxGEwvXnuqvyw/+HD9jOx3EvErodiIHyLnIE=; b=u
	59KnImr5u7plQjCm5IdkuXjwp7Yg5w5qU1lAeJC9rRpyBmQYvOnpyWptgl5C/BQI
	4fs7rQLpJ4lnlznMxXIqsaNCSw5khKJnxuuDIyPUELSlipT7N1wcAJX/8IG0SkFN
	5hCDrkxVBeoTJHoUTIbWVLqC1Vk5zbmy2auDAYrx74nEgdFOHhDSm1POUPg2onyi
	yaJ+/pGtiLieoFksCTekqnXlUGGgd6i00ZCqdUjJrB0XyQFecqG7DXLyeClrON9f
	cam0xe25g+Vq++2Nt0Xh2V99St2Td8aoNrEfsDIAeLFfwtnLt3YuZVPytZzMQDhf
	F9kg196C2Zk2/S4VS/EVg==
X-ME-Sender: <xms:yG-iZphKtVbvGeOra7bx7_P00WK7AJ1N69H7OkBzwxPLQkutlAqBAw>
    <xme:yG-iZuBuS6hA-oRNqknuvPN0fwDH2yAjvromFeTmHmqO3BzwylC7kDy80tLoKIaN8
    NcYDDeJe1sabbxUVxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:yG-iZpHNm9tchrmE9bJF1DcsnXEzL6Amsc7aFYo53az5BN5AVn_YXg>
    <xmx:yG-iZuQ4lgBYBlNmGyNXtRPCgk6MPlrAMIg8jNUEPRHm7yZH-VS-Kw>
    <xmx:yG-iZmzVhp2U5gM4RXhKAMfji2rXp3FRTVHsghjm4KoDHm2DuSEASA>
    <xmx:yG-iZk6Dnh53-LHldUTZ5cpmQKq7GFuUL5bLrHFFiHiIzPQjSszb3Q>
    <xmx:yW-iZrh4M8MuFBJArq-ve0DQb30ZD5adlHyKr7qa1nrEfOYdYv2J8WhV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 89CFFB60098; Thu, 25 Jul 2024 11:31:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
In-Reply-To: <ZqJjsg3s7H5cTWlT@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
Date: Thu, 25 Jul 2024 17:30:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Youling Tang" <youling.tang@linux.dev>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Chris Mason" <clm@fb.com>,
 "Josef Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>,
 "Theodore Ts'o" <tytso@mit.edu>, "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "Youling Tang" <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and module_subeixt helper
 macros
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024, at 16:39, Christoph Hellwig wrote:
> On Thu, Jul 25, 2024 at 11:01:33AM +0800, Youling Tang wrote:
>> - It doesn't feel good to have only one subinit/exit in a file.
>> =C2=A0 Assuming that there is only one file in each file, how do we
>> =C2=A0 ensure that the files are linked in order?(Is it sorted by *.o
>> =C2=A0 in the Makefile?)
>
> Yes, link order already matterns for initialization order for built-in
> code, so this is a well known concept.

Note: I removed the old way of entering a module a few
years ago, which allowed simply defining a function called
init_module(). The last one of these was a07d8ecf6b39
("ethernet: isa: convert to module_init/module_exit").

Now I think we could just make the module_init() macro
do the same thing as a built-in initcall() and put
an entry in a special section, to let you have multiple
entry points in a loadable module.

There are still at least two problems though:

- while link order is defined between files in a module,
  I don't think there is any guarantee for the order between
  two initcalls of the same level within a single file.

- For built-in code we don't have to worry about matching
  the order of the exit calls since they don't exist there.
  As I understand, the interesting part of this patch
  series is about making sure the order matches between
  init and exit, so there still needs to be a way to
  express a pair of such calls.

     Arnd

