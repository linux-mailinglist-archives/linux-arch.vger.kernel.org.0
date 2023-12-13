Return-Path: <linux-arch+bounces-967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7A810BDC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5037DB20A06
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2AE1A5AC;
	Wed, 13 Dec 2023 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MJqz6FRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9/6Zjsh"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CC6101;
	Tue, 12 Dec 2023 23:52:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1DAFD3200A01;
	Wed, 13 Dec 2023 02:52:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 02:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702453942; x=1702540342; bh=IikDPD6jbT
	PCIfjTpK6kFvZMdeXgof5FgKKPsLRI3mQ=; b=MJqz6FRPuL878xfJjDRkXLDQ6A
	94LXNYwawjYG5kT3WifJJ8HgE5s3MDfAFL7Ezbmdu0bgQvY+GljnznmbQ7jbnP8l
	aIHAIbjsmHXJhKQBuLQHeh3nEARv48QIsxBMCa8Ooa4G3cbPF8xsiRbIT5Yuyl1z
	Y/RYdxdzJkIETVdRIlZappNAuK7eibT0zRSw12+2HRVnNsUuouL1Zs9R4trzGU2d
	C8VJCq5lCOlyHOBCHLQOQKgPcRLyrpj49FUH1GVYv0h3sCqHg9rnoxBNkaJ8yI/V
	yIvvZBF7MimA2R+OpK9/yaS7RK8utWQfo3UfDlyJy6Y91qlG0ZDXcXUPa40Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702453942; x=1702540342; bh=IikDPD6jbTPCIfjTpK6kFvZMdeXg
	of5FgKKPsLRI3mQ=; b=a9/6ZjshxAADOKa4QrgHFLpFnxAQWtUw1m9QurJ5LIt2
	qsJOSKO2cxRlIfhru7FqZs5Df/QsOtDehz6WPo1roLrvpaJaLbBwvDA/PAyBjMtd
	X46UNuhlrA9TGY/as3pGU1uNyYj6FZEeJSOsKTUJJEH4sfz53EaLqKciODqIbf7r
	K8GaxK+3sNFcq0uw2fKpuNXWaoWktPkqUC8lYHvMUh07B+ob0xbNx8cgivGLMxx/
	qztUXbQN7X3bsCxCMikhQTa9rtP77PFAMvoc5OWuJKwhnheXb8tyCa7OSNbv/xD2
	BYPaRuappODvHcZyck9ih1qMJ6zKnaLDy1MB7Z4lnQ==
X-ME-Sender: <xms:tmJ5ZTOfOwbiiFh221nbcWpb6_BBIAebHNO_RslMllIEnqhqEsacyw>
    <xme:tmJ5Zd-2ZH3YQZMywbO0FIE7Inl9qMaDeZ7wVMj-bG9s0LGDIb1uZ98ckDy00MaqM
    zV_vNR1HAoEfP_AiK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tmJ5ZSSPIs8Bme-dwrW-FzJ8hi5fsSnS-NGWVL0TwxJ8biRH-23sYg>
    <xmx:tmJ5ZXu2ZLBxm4DZ_UocAty9d51qGl1zQGkdOWTCvEhhU0Lo9BoIIg>
    <xmx:tmJ5Zbf4e7ZwmmLERoGmOp08kMNv6cL0xQgHaVtqPvZhBA6NGQwZOQ>
    <xmx:tmJ5Zf5r0H-Z3va3eM5UE7n8hm2hmEalmdlTPq2uIOfPYMRBcFx4Ig>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 18315B6008D; Wed, 13 Dec 2023 02:52:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <129fa764-dc7a-4979-95e8-39a15c487095@app.fastmail.com>
In-Reply-To: <20231212-optimize_checksum-v12-1-419a4ba6d666@rivosinc.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
 <20231212-optimize_checksum-v12-1-419a4ba6d666@rivosinc.com>
Date: Wed, 13 Dec 2023 08:52:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Conor Dooley" <conor@kernel.org>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Evan Green" <evan@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v12 1/5] asm-generic: Improve csum_fold
Content-Type: text/plain

On Wed, Dec 13, 2023, at 02:18, Charlie Jenkins wrote:
> This csum_fold implementation introduced into arch/arc by Vineet Gupta
> is better than the default implementation on at least arc, x86, and
> riscv. Using GCC trunk and compiling non-inlined version, this
> implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
> respectively with -O3 optimization. Most implmentations override this
> default in asm, but this should be more performant than all of those
> other implementations except for arm which has barrel shifting and
> sparc32 which has a carry flag.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

