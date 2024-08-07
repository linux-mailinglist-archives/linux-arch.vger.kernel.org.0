Return-Path: <linux-arch+bounces-6103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D494B006
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74601F23B4B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168981420CC;
	Wed,  7 Aug 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="M+AgFKcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cbd0u4JX"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224113D61D;
	Wed,  7 Aug 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056809; cv=none; b=FAO6fv0IPE57hxrufn3OI3Le+HJcjRUPkZVcfc/JI8pChZ86NI4Xck8A9OTYxwhDv9av5177SPJPwN5GuV6iGS6c0S6jLugvpZddGh5inWieJi/ETVC5UYx2tF2LRwUZGABwImEp0cYW92cFS4++XcupEk/jSAf08J2TQawWkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056809; c=relaxed/simple;
	bh=Ae/yFOnscB0LM68KscBwrE7D7vNdMDnnAeb+RIaDy6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O7YNGngTs98rc4ibxaV3sKGFYUo3oqXix71OvHenG7ylTIXx0BYb8BiAy8RzsZ5nt4f8sHXB3xxtbayOBGdhCmd29mIpaqNlEf9GPJcvn37z8/8egsMM3wQzhWOkk+4US3MkrDndwKQWs19btoqT4rMIwhasK/HwdTMhULPIiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=M+AgFKcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cbd0u4JX; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id B9FE8200F9C;
	Wed,  7 Aug 2024 14:53:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 14:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723056806;
	 x=1723064006; bh=dN92Yy3XFjXTxBQ/NKAZMCYVQAegkihc+8DVkcaUGXw=; b=
	M+AgFKcnD/Nuugw9QWMdK0TNIorx7c9kz4u4kWeEtoBkeDVxq1i8AfEINi28F8pD
	mqxXrgNc0hd7DLIVn8ZdgKKw1WixvvvthvoPlB32dikpdRyZeayfzxol4TWH5zV/
	sctoPTqK+Gpjs6mQSC5g5LuM5+hqde8Awr3BiE9VBetstqH9G+Y73dGI251beJG0
	KD/S9aRYjMWru5ducc9JFCJqHqrV4tG/Fb2biX0pP/55/wPz4yqBj2Cwo3Jic+yq
	Ts4ZD1s3I/J9I7pooC8Z3JaExlDJaha/uLa/IoywBt1Fj2dxnikSyGwL/537oKvz
	3Ga11kSBaDC1us7TovA9WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723056806; x=
	1723064006; bh=dN92Yy3XFjXTxBQ/NKAZMCYVQAegkihc+8DVkcaUGXw=; b=C
	bd0u4JXHiwM85jQmCceR5thBnLlVROGCSHq6uqUQH7EES4yd9w+rGDAsQiWGz/KE
	Tx9ieCb+syV32NMwTs+deNuAAbSSJe2g2WC6Q1eWWQa6JXLDL+jX7+woQX4AVmls
	7LKrhVy6yJsezqFhMNl/XzM0DJIJdjB2cO6q+5fT/oDBlh0O4crlMEUa9nDaj5+w
	8Li1kDK8ZNJzdI09O84Vv3hC186LsTWkCUiEZ2/yFGg3ilPlXUGqR2TZ+rh7pN7b
	zrQN9qvczGLLR6LFQdfP+t0gWYdb1IFiN8QXdil4RtN7+rEubC/YANNF+1Cs12kw
	Bcw5FrUO4Qwt7abMjpS7w==
X-ME-Sender: <xms:pcKzZnopk042s10_adxzzpGQqjjj1zN1aqGfzwY9vdXxA-HcaMU7yw>
    <xme:pcKzZhphWvwWMwSmYbDYPH1KAUK7_qukQL58dPLkKZwJ6qZO-PD0mTILf37wC-VkJ
    yuGeXAZyjmZouRsKac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:pcKzZkMMEa1QCyx9DYya--xGnOf_SSr3_VdEDtu9hV8xSe9yXZqVCw>
    <xmx:pcKzZq7W7a2W3QiuibYT4n87PxFgIhVytpph5nF0kYnO4gUYERaGxQ>
    <xmx:pcKzZm6A0MWzdmDLhHIywLO77HSPGI_SIwlTXUWpWoknLUo6ctrjwg>
    <xmx:pcKzZigfeNcP1X2tQ3rm8J0r0mNkRKSh21gYx64IauzFFFTIOJUQRw>
    <xmx:psKzZuEqNacnXDRDYO1s0FZVTS1ct0wiplIuRye5vQU_o20dyn1ygN6I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ED628B6008D; Wed,  7 Aug 2024 14:53:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 20:53:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand" <david@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Davidlohr Bueso" <dave@stgolabs.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Will Deacon" <will@kernel.org>,
 "Zi Yan" <ziy@nvidia.com>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Message-Id: <19f7ccec-db2a-4176-b6d9-12abe0586d07@app.fastmail.com>
In-Reply-To: <ZrO6cExVz1He_yPn@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
 <20240807064110.1003856-25-rppt@kernel.org>
 <1befc540-8904-4c23-b0e6-e2c556fe22b9@app.fastmail.com>
 <ZrO6cExVz1He_yPn@kernel.org>
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 20:18, Mike Rapoport wrote:
> On Wed, Aug 07, 2024 at 08:58:37AM +0200, Arnd Bergmann wrote:
>> On Wed, Aug 7, 2024, at 08:41, Mike Rapoport wrote:
>> > 
>> >  void __init arch_numa_init(void);
>> >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
>> > -void __init numa_set_distance(int from, int to, int distance);
>> > -void __init numa_free_distance(void);
>> >  void __init early_map_cpu_to_node(unsigned int cpu, int nid);
>> >  int __init early_cpu_to_node(int cpu);
>> >  void numa_store_cpu_info(unsigned int cpu);
>> 
>> but is still declared as __init in the header, so it is
>> still put in that section and discarded after boot.
>
> I believe this should fix it

Yes, sorry I should have posted the patch as well, this is
what I tested with locally.

     Arnd

