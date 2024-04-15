Return-Path: <linux-arch+bounces-3694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87B8A566A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE891F2110D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D278C7B;
	Mon, 15 Apr 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TsZXhxB0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpiQFj7B"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACE60EF9;
	Mon, 15 Apr 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195056; cv=none; b=LQcWKaQKgVWeigwLyhA+9vHcP3+ijh5lreTIvmDz5j3BqEb8xQnpP+pLv7mYTG2OAKvcah3U4T3R5YRW6o444oWAYe6Bskl/euUWq2i/VY+NH75whMo4dCdsN43JM49kri+HEktMCrqIPfPAJiBuzaHZ1MnuIY9rjno4MLFS9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195056; c=relaxed/simple;
	bh=ysPz6mY/TRewOJKQOKl7aqCeiD9oIAf/7WjUQ5bJ3KM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qGW/8IDj0B8v5mchzvLatRzj/6tcS19AsR5oOcrELeihN8FhWzbmlW3FseiViwGpi2tgl8McO4TUqlDcdSijordSnzuTQfzdwe5T5+jZlrBW5lS5ARDnTT90Le7jjUAPdAmQ39efuXyKNWxbfwy7zBVxj2/hO5riyNFk6iBS72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TsZXhxB0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpiQFj7B; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 502EF1140133;
	Mon, 15 Apr 2024 11:30:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 11:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713195053; x=1713281453; bh=uejkFuVJ7S
	+uU6TPaZslbYYiwuH4wYboz0/NG64qH38=; b=TsZXhxB0sdEZtHCFU2Yk5LG6Z8
	uPF+TwzaqPoUtKbWauOxtH4+C7Akzgsx5QnzHO/kv0LKj/qSf8bih/c+pcQNFDjw
	wYSMWkh72PrhmvqCilDplOB9y/696LFvk3cp+KwxEEgGWcn9qCuVJDhDcfnzP2yz
	q14czIgEWk0oTA4zx5+9zLTYqcF0sjID3GFHuYhAkuF4h2GHgK+MPTKxir/85HEn
	WHEG5bFm9/lH+PJjJk1fI8XDea3tgoTFjjzKVwZVKXNsMipQEzvBh5+oXs8vk6Mt
	KpSEKav49DHZqvbTztdSQwJSWU7ycEMRmkyQSkhdlfGzvD2kU2RHFTRsBjRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713195053; x=1713281453; bh=uejkFuVJ7S+uU6TPaZslbYYiwuH4
	wYboz0/NG64qH38=; b=cpiQFj7BzVcn52N5NdGS8x9v4da+p4jMDv0g89gle0uu
	lLhcb20aCQDPV044IkxkklRJHovV3p0CUwOo0vRYTvf9b9qgxYIAGKWKYCLpBzWL
	PHMTmxA7TJa4kEdePJeLSKYAE34f6ROAIRh/R3fMeLpTS8peztpPOhNqgdPG4RG8
	nExko+KcbxV1Vz/B1x7L4ODsWTyeOgRxcyDOv4ynZXdRILc+nmt5GCHB1PyRzD/d
	+/IUBY+tm+0xlewekvLJKCNgZTFSKW1Qf4gaZtCaUzGK7Cia0c66WgXg50615dw5
	U9wm3yoNYhZIqLnCD5Ip5yLn07zrQK4UiBErvEMzRQ==
X-ME-Sender: <xms:K0gdZoXdDfe7FtOc-J9lmS_LYkQ4r-C8SBziw6hl9KI9pam2T0M2Ow>
    <xme:K0gdZsnrfnpW5pDGNS-bt1Ov5khh39DOCFPnhWFQjmc7m2R2Yj_k0zu7NRyXFsXT5
    f_MStLFYVHtgVY61eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K0gdZsZSjdLnThvcTEskcGolfQuQX_wm1oeDCLaHNnpFHD9Hy-TuUw>
    <xmx:K0gdZnWO9eUGc5oDmLHQ4JErDP-uraTCveZiZPibXQ3jd5gQoGxGEQ>
    <xmx:K0gdZimKqo26KcLeMT0lD25R6DvGRJwGTSYEQh-zwpVZ1SHiFCyruQ>
    <xmx:K0gdZsdFcPYBvz_fOCox8EtZYvqpm11OBs7yV-lfOkaKSB64pUJ8_w>
    <xmx:LUgdZhrptGBapc2P9s8b5mxNbcnHlMom_sSBuQFVaWQri9ajjMFzUk0u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B461EB6008D; Mon, 15 Apr 2024 11:30:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61d0584f-dfe4-4d8c-a178-78f000d477d4@app.fastmail.com>
In-Reply-To: <c20b433f-97ef-7faa-5122-9949af41f2fb@kalrayinc.com>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-31-ysionneau@kalray.eu>
 <f69adaf2-6582-c134-5671-4d6fd100fcf1@linaro.org>
 <c20b433f-97ef-7faa-5122-9949af41f2fb@kalrayinc.com>
Date: Mon, 15 Apr 2024 17:30:31 +0200
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
 "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 30/31] kvx: Add power controller driver
Content-Type: text/plain

On Mon, Apr 15, 2024, at 16:08, Yann Sionneau wrote:
> On 1/22/23 12:54, Krzysztof Kozlowski wrote:
>> On 20/01/2023 15:10, Yann Sionneau wrote:
>>> From: Jules Maselbas <jmaselbas@kalray.eu>
>>>
>>> The Power Controller (pwr-ctrl) control cores reset and wake-up
>>> procedure.
>>> +
>>> +int __init kvx_pwr_ctrl_probe(void)
>>> +{
>>> +	struct device_node *ctrl;
>>> +
>>> +	ctrl = get_pwr_ctrl_node();
>>> +	if (!ctrl) {
>>> +		pr_err("Failed to get power controller node\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
>>> +		pr_err("Failed to get power controller node\n");
>> No. Drivers go to drivers, not to arch directory. This should be a
>> proper driver instead of some fake stub doing its own driver matching.
>> You need to rework this.
>
> I am working on a v3 patchset, therefore I am working on a solution for 
> this "pwr-ctrl" driver that needs to go somewhere else than arch/kvx/.
>
> The purpose of this "driver" is just to expose a void 
> kvx_pwr_ctrl_cpu_poweron(unsigned int cpu) function, used by 
> kernel/smpboot.c function __cpu_up() in order to start secondary CPUs in 
> SMP config.
>
> Doing this, on our SoC, requires writing 3 registers in a memory-mapped 
> device named "power controller".
>
> I made some researches in drivers/ but I am not sure yet what's a good 
> place that fits what our device is doing (booting secondary CPUs).
>
> * drivers/power/reset seems to be for resetting the entire SoC
>
> * drivers/power/supply seems to be to control power supplies ICs/periph.
>
> * drivers/reset seems to be for device reset
>
> * drivers/pmdomain maybe ?

Right, I don't think any of the above are appropriate

> * drivers/soc ?
>
> * drivers/platform ?
>
> * drivers/misc ?

Not drivers/misc, that is mainly for things with a user-space
interface.

drivers/soc is mainly for drivers used by other drivers, but
this would work, especially if you expect to have multiple
SoC variants that all use the same architecture code but
incompatible register layouts

drivers/platform is really for things outside of the SoC
that are used for managing the system, especially across
architectures, so I don't think that is a good fit.

Traditionally we had this code in arch/{arm,mips,powerpc,sh,x86}
and we never created a drier subsystem for it since newer
targets (arm64, riscv, newer arm, most x86) all use a method
that is specified as part of the ISA or firmware interface.

The question what you expect to see with future hardware
iterations: if you think all arch/kvx/ hardware will use the
same code for maybe at least the next five years, I would
suggest you keep it in arch/kvx/kernel/smp.c, but if you
know or expect other implementations to be needed, I can
merge it as a driver through drivers/soc/.

     Arnd

