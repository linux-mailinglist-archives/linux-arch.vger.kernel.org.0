Return-Path: <linux-arch+bounces-1903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E62843CA4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663AD1C29CE1
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2696997B;
	Wed, 31 Jan 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="r1w+SIgG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prxagr4L"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BE679E1;
	Wed, 31 Jan 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696963; cv=none; b=dk3hHH+GlH8o99PbocNQafNofQh1ibF+bPQETRAgeK2lgfefbWwmn8tHeWNEz+8D4bTRr20YyEOTAmuSRt6F47OIJw/y/Vcu0rzlOPNnTUd3hgfZi5BfEW10GZJ4bKHJ/dR6XEuNSSkKmuKHJkiLwX8SlwEThU1xTlRdcfVQtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696963; c=relaxed/simple;
	bh=FmRhJrNN5tdkYj1oEn1WGlN9crcXpNJmsF89y7Q5CxM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UX/nDSKraDQnzX4DfkiJmamYy6ac8pdhCvUfEm+3Ik9dDReOUBXvGK2kS5g2MqDE3xP1TWPv9I0Bqg+lPl0Wrn3SclVfd9tctB6DlSRaVATa4VRTsQZFKDap5N+Zsk1M/XGivNyADib9/NA7skAIa29IuwrIhXinS/U4GeKguT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=r1w+SIgG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prxagr4L; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 677D15C00BF;
	Wed, 31 Jan 2024 05:29:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706696960;
	 x=1706783360; bh=iKsNv795W6E/GbLdxQpU+VkSSklR3RfYg2NP17KrEuU=; b=
	r1w+SIgGWw7dJyt3GzIZOgqo2n/eeg1SXNYzBJKIHR6M+ZtY9LOh/WzC8xl5ZyiX
	KGiDo4w+ZuwSEQ1vuvGYQvBLaMADawKJeAQY6vMvLojc2nTufc2dwLrdoan28w8L
	NX4TquETi11QgoauczLec/BpoD1TxBXJ0E5lzJwPQP1Z6V2oWv+o+FEyeeyPYpVn
	gT8ibuoLeRJlzl96Gs9TKtcIl7CcSgc/LXeZUQCWW8n7s5lOftNa2Mert2BDm2GP
	YaaVIomhQwxG6eFGNlsVVWMLtp8Y5UtRyG+22deQB/OrbIIMR0mNY97d5YsDwNXi
	l/a/oPZxoUjFG27YrK7sgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706696960; x=
	1706783360; bh=iKsNv795W6E/GbLdxQpU+VkSSklR3RfYg2NP17KrEuU=; b=p
	rxagr4LAAt5LDBTk5TLUgiJy31iihbvdHZuht6v/ZdhedjYllhFfqCe81x2f95Zo
	7c6qF6Vqn0Ct+PWPC0LPmC2q3oxm8PJ+97vM2ReNQS4BnfuikN8+tFzLSVwAiLnB
	XCwpMLMC/apTM5pOXQjPBmynVDClv9VC0FVmqluRrpBax54ys6yQVKOB8+JxDgx7
	CeJBEi5CJKu+A2PM+6A9QnmPb1gRmwAS45hIUBOcJLxv4NTuzCD+RmnYS8OKNWo/
	J/L2JLLQS3iQN6M066Waa64UWuCrsmuVL2LkuV7ucDjl3KDA2RKS79l+cG3uXD9h
	80+Nmub29smTdXwFwugbg==
X-ME-Sender: <xms:_iC6ZWx41lQGmTgxNQPv033inelQFUqqgqhGoRB1Yy_Suw3I8Xelgg>
    <xme:_iC6ZSRqCMMRGR4dsf2AkWDbTf6DTYgj0B5L_el4qpBjc-H_WY24kzGjuScisGao2
    yzSLAe8OaA_rRy8Tlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_iC6ZYXhgaK38oMGNaGPwVUfqTjpiERjPnsH4firn_SwhCPxrErYHA>
    <xmx:_iC6ZcjvaWNtDsNaKMs_RAFWnK9ju6FdUo2vEcbE8gjZqfayeaG8bg>
    <xmx:_iC6ZYCMLDoeolGZs_ufJ7ezycNWlbfwu69_HSZoxwUOXAZXBSQ_Mw>
    <xmx:ACG6ZY2U-kSIMTC4srsLhXKXwUwJquPF-ApdBE0B8lL06BOUgQl9CQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 44453B6008D; Wed, 31 Jan 2024 05:29:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1036060c-25dd-439b-b081-893d0cb000f6@app.fastmail.com>
In-Reply-To: <269edff0-d989-4ac8-b0c3-bce31283806b@kalrayinc.com>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-32-ysionneau@kalray.eu>
 <995eb624-3efe-10fc-a6ed-883d52d591bb@linaro.org>
 <269edff0-d989-4ac8-b0c3-bce31283806b@kalrayinc.com>
Date: Wed, 31 Jan 2024 11:28:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Yann Sionneau" <ysionneau@kalray.eu>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Marc Zyngier" <maz@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kees Cook" <keescook@chromium.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Waiman Long" <longman@redhat.com>,
 "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Paul Moore" <paul@paul-moore.com>, "Eric Paris" <eparis@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Jules Maselbas" <jmaselbas@kalray.eu>,
 "Guillaume Thouvenin" <gthouvenin@kalray.eu>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Vincent Chardon" <vincent.chardon@elsys-design.com>,
 =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
 "Julian Vetter" <jvetter@kalray.eu>, "Samuel Jones" <sjones@kalray.eu>,
 "Ashley Lesdalons" <alesdalons@kalray.eu>,
 "Thomas Costis" <tcostis@kalray.eu>, "Marius Gligor" <mgligor@kalray.eu>,
 "Jonathan Borne" <jborne@kalray.eu>,
 "Julien Villette" <jvillette@kalray.eu>,
 "Luc Michel" <lmichel@kalray.eu>, "Louis Morhet" <lmorhet@kalray.eu>,
 "Julien Hascoet" <jhascoet@kalray.eu>,
 "Jean-Christophe Pince" <jcpince@gmail.com>,
 "Guillaume Missonnier" <gmissonnier@kalray.eu>,
 "Alex Michon" <amichon@kalray.eu>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <git@xen0n.name>,
 "Shaokun Zhang" <zhangshaokun@hisilicon.com>,
 "John Garry" <john.garry@huawei.com>,
 "Guangbin Huang" <huangguangbin2@huawei.com>,
 "Bharat Bhushan" <bbhushan2@marvell.com>,
 "Bibo Mao" <maobibo@loongson.cn>, "Atish Patra" <atishp@atishpatra.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, "Qi Liu" <liuqi115@huawei.com>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Brown" <broonie@kernel.org>,
 "Janosch Frank" <frankja@linux.ibm.com>,
 "Alexey Dobriyan" <adobriyan@gmail.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>, jmaselbas@zdiv.net
Cc: "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 31/31] kvx: Add IPI driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024, at 10:52, Yann Sionneau wrote:
> On 22/01/2023 12:54, Krzysztof Kozlowski wrote:
>> On 20/01/2023 15:10, Yann Sionneau wrote:
>>> +
>>> +int __init kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, v=
oid *))
>>> +{
>>> +	struct device_node *np;
>>> +	int ret;
>>> +	unsigned int ipi_irq;
>>> +	void __iomem *ipi_base;
>>> +
>>> +	np =3D of_find_compatible_node(NULL, NULL, "kalray,kvx-ipi-ctrl");
>> Nope, big no.
>>
>> Drivers go to drivers, not to arch code. Use proper driver infrastruc=
ture.
> Thank you for your review.
>
> It raises questions on our side about how to handle this change.
>
> First let me describe the hardware:
>
> The coolidge ipi controller device handles IPI communication between c=
pus
> inside a cluster.
>
> Each cpu has 8 of its dedicated irq lines (24 to 31) hard-wired to the=
 ipi.
> The ipi controller has 8 sets of 2 registers:
> - a 17-bit "interrupt" register
> - a 17-bit "mask" register
>
> Each couple of register is dedicated to 1 of the 8 irqlines.
> Each of the 17 bits of interrupt/mask register
> identifies a cpu (cores 0 to 15 + secure_core).
> Writing bit i in interrupt register sends an irq to cpu i, according t=
o the mask
> in mask register.
> Writing in interrupt/mask register couple N targets irq line N of the =
core.
>
> - Ipi generates an interrupt to the cpu when message is ready.
> - Messages are delivered via Axi.
> - Ipi does not have any interrupt input lines.
>
>
> =C2=A0 +---------------+=C2=A0=C2=A0 irq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 axi_w
> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 i=C2=A0=
 |<--/--- ipi <------
> =C2=A0 | CPU=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 n=C2=A0 |=C2=A0 x8
> =C2=A0 |=C2=A0 core0=C2=A0 |=C2=A0 t=C2=A0 |
> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 c=C2=A0=
 |=C2=A0 irq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi
> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 t=C2=A0=
 |<--/--- apic <----- mbox <-------
> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 l=C2=A0=
 |=C2=A0 x4
> =C2=A0 +---------------+
> =C2=A0 with intctl =3D core-irq controller
>=C2=A0=C2=A0 =C2=A0
>
> We analyzed how other Linux ports are handling this situation (IPI) an=
d=20
> here are several possible solutions:
>
> 1/ put everything in smp.c like what longarch is doing.
> =C2=A0 * Except that IPI in longarch seems to involve writing to a spe=
cial=20
> purpose CPU register and not doing a memory mapped write like kvx.
>
> 2/ write a device driver in drivers/xxx/ with the content from ipi.c
> =C2=A0 * the probe would just ioremap the reg from DT and register the=
 irq=20
> using request_percpu_irq()
> =C2=A0 * it would export a function "kvx_ipi_send()" that would direct=
ly be=20
> called by smp.c
> =C2=A0 * Question : where would this driver be placed in drivers/ ?=20
> drivers/irqchip/ ? Even if this is not per-se an interrupt-controller=20
> driver?

This looks like it's close enough to the irqchip driver
that you can just have it in the same file as the 'intctl'
portion.

Top-level irqchip implementations tend to be rather architecture
specific, as does the IPI mechanism. Depending on the register
layout, I think you can have a single devicetree node for
the combination of the core-irq (for managing your
own interrupts) and the ipi (for receiving interrupts from
others), and then have a driver in drivers/irqchip to
deal with both. For the ipi mechanism, trying to abstract
it too much generally makes it too slow, so I would not
go through a nested irqchip or a mailbox driver etc.

I don't know what the 'apic' in your diagram is, so that
would be either a nested irqchip or could be part of
the same driver as well.

     Arnd

