Return-Path: <linux-arch+bounces-637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3231803570
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4961F211C1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2AA25567;
	Mon,  4 Dec 2023 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lToYSd2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZiosFcs"
X-Original-To: linux-arch@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66948186;
	Mon,  4 Dec 2023 05:51:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id B0BE558099E;
	Mon,  4 Dec 2023 08:51:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 08:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701697866; x=1701705066; bh=jc2DdqDvPB3CHzS9V5UmYYkn+gfSkKSwGuZ
	ew0dKJM8=; b=lToYSd2H6fukkizrGV0SCXL4dTZvFLTwbzShvF4LKI/NowJD/l+
	VLAIeUncYheum1Ao5C3QBRx468+f4TzCMbDiN2kjNpi4IH1X/EAlO/1jXvJZ+L8C
	DdM1J0VewK/7+v78NoVJ+uySXkwOOJfIHCBsh9ixJxI1SPhC2AjpD6DXvY8b63H4
	9sKozcMJqM8r1+yA1K3UZmEmvuh1ArwKhWAt2RFsgbpsCHQ7oP1ZSduiw0H1TeMk
	hQtv+c63NSxKuuNyT5UVeyRUd3azM2Xp16U1iqD9A//igQ58Uymemu+RkDiaCHdf
	meWNNyq0bsLINex4Rg39ORWByJRSokbFY7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701697866; x=1701705066; bh=jc2DdqDvPB3CHzS9V5UmYYkn+gfSkKSwGuZ
	ew0dKJM8=; b=QZiosFcsXa1/hwJvlpyk11ghQFkXbXDaGRFnEdRkhwn1wBw0Nrs
	VEtwy/djz1+grGIjc2nUnfLCe2OVcHYtTWM4sduSGRztbsJYBS0/e7az5COPhXPS
	+wr9ORxAwob1jlroh0U9Ymp5Yd3BJhmVweZ5oc6fH5BTHbMrS3s+naoAtksWCQDn
	QxU29VsiBlKUDbSY0ETrPjC6/zRFtiElYp27Mp3Iuhhy9lx72CINCFH37+eh4OkA
	q5PIVZyp9nIJR7ij7mNpOHZ/9Ccvozb6YpBJAkMsK51YzpZVIFpBsMrmH6tud/H5
	BRFO3ELYZ5QMrVprmT5At58xOrTxdd3Ge1w==
X-ME-Sender: <xms:SdltZTJGy17ryWwA4qYPQv2qaQx09B_qq_PXUFhYm50FWpSH1CfjWQ>
    <xme:SdltZXLrq1dnkcwK2Dbf3sqnF6iEu1AZmwIGW9YIYJssD7xmhYfjlIa24gZHBRGnR
    SVz7xBUu56uBtfkegQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SdltZbsDNKpwLeAWHvD6fkQvnhsUVvPXdLvOuaj4pxQZuIfnZIAynQ>
    <xmx:SdltZcYExxIzrpJpkaRoKlCV9BkWN4PmMuaJzeOXN2zIrzDanLHFGg>
    <xmx:SdltZaaw0iM0xj_2ug-rKeDI4rTDkI4UoBtwFFnWPrBqyOUBGu_JAA>
    <xmx:StltZWp8VY01k7wJI-1YSqpFSCWncfXA1gGbVhgTkAVRKLX93Y-idA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97FEEB60089; Mon,  4 Dec 2023 08:51:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05173886-444c-4bae-b1a5-d2b068e9c4a5@app.fastmail.com>
In-Reply-To: <2648aef32cd5a2272cd3ce8cd7ed5b29b2d21cad.camel@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
 <20231204123834.29247-6-pstanner@redhat.com>
 <2648aef32cd5a2272cd3ce8cd7ed5b29b2d21cad.camel@redhat.com>
Date: Mon, 04 Dec 2023 14:50:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Hanjun Guo" <guohanjun@huawei.com>,
 "Neil Brown" <neilb@suse.de>, "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>,
 "John Sanpe" <sanpeqf@gmail.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, stable@vger.kernel.org,
 "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023, at 14:39, Philipp Stanner wrote:
> On Mon, 2023-12-04 at 13:38 +0100, Philipp Stanner wrote:

>> + */
>> +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
>> +bool iomem_is_ioport(void __iomem *addr)
>> =C2=A0{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IO_COND(addr, /* nothing *=
/, iounmap(addr));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (un=
signed long __force)addr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > PIO_OFFSET && p=
ort < PIO_RESERVED)
>
> by the way:
> Reading that again my instinctive feeling would be that it should be
> port >=3D PIO_OFFSET.
>
> This is, however, the exactly copied logic from the IO_COND macro in
> lib/iomap.c. Is it possible that this macro contains a bug here?

Right, I think that would make more sense, but there is no
practical difference as long as I/O port 0 is always unused,
which is at least true on x86 because of PCIBIOS_MIN_IO.
Commit bb356ddb78b2 ("RISC-V: PCI: Avoid handing out address
0 to devices") describes how setting PCIBIOS_MIN_IO to 0
caused other problems.

I would just leave the logic consistent with IO_COND here,
or maybe use IO_COND() directly, like

      IO_COND(addr, return true, /* nothing */);
      return false;

     Arnd

