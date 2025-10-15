Return-Path: <linux-arch+bounces-14118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AFBDD623
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDEF64F34E2
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F41D514E;
	Wed, 15 Oct 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b="Gd5NeiJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slVqLMoM"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822752EC574;
	Wed, 15 Oct 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516817; cv=none; b=Xz6xpgsVH4iOmPRA0YAcV0QB8GMLozOfIhCjKj7Qz8O78XiVnhMbgmz/Fa88vBeRYNcRzHMM3kSe7SwAH+fmyTXhcbq86BQtHL+4uqy+0jbvNfS+XRLqd4IsWwfIZ+sPnY3QOzJF2s7FGpZpH611LZyQKqQNZRhbhzlU3gxdeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516817; c=relaxed/simple;
	bh=tErLpBVJjnu0MQU/D9jXT3uMXRJkN/y+btNY5pxe+lU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cFAwAsQTD87S1Uexsdul6BcdTznx7nxUbJ0LxMHyLr/6KNhH3euw1+S7LAh3JRb5E+lp48DUIDMBoooHCHDMhgCY+wbz3dRJlSud1lOW1nNDixJzGMTd6V+s0M7fnv+pDGP7KGptB8tGQbJVJr/p+n7RcQkVfO/6iFEJTv9+s0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net; spf=pass smtp.mailfrom=wolber.net; dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b=Gd5NeiJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slVqLMoM; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolber.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 9BBEE13800A9;
	Wed, 15 Oct 2025 04:26:53 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 04:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760516813;
	 x=1760524013; bh=t5nJJ2CgRu6lm+HZXXoNQXnHJygS4YGR2lcUURAIT6U=; b=
	Gd5NeiJZJnXq59Lbe+HDax/gkj3d9zlfofnCdcXpaXjwnpV8DKvxwo0r3eQIMgIF
	r4C9S+b6Amt3tumpZ2x7tGP4WK3Ss34L1o8FbYk28cQ639q5iZ8F7ZHLwL5DNWuQ
	zb5ZMeXyeWYsWlNULdvQ2EL2Kckn4aWUhIKjCCBgN/Of3Kh4MmCJg15VVo1MKq80
	u6Qi5XuFkRIjgI1dLljT6JINSEhdPN0v1L9ME1Evo4G80OflccZ3IXVQm8MKe/Zp
	Ix5r61uzqYNbSpEJXLArwUNQmpSwp1g9YUTrQCRMCeO0gnnWMn+NqYTJbAShaMBd
	LyfuahOvwobaoV9iedCosQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760516813; x=
	1760524013; bh=t5nJJ2CgRu6lm+HZXXoNQXnHJygS4YGR2lcUURAIT6U=; b=s
	lVqLMoMQwoArypuRWQHBYR4UNUxJVViWJF/QAB8BDOoZ0rkuYy51oLamjfyxFONw
	bCpYpk9bs1hcs1R4qK7emmEDhoKFp7APFDdtyPWvgVkQ4XNdebQ0ZtDgI0I0mXcH
	7FNL2DyL5C5998zXAQ9sC0l8yLUTMuBx+748u1DUjKW3EJQU2kI3KsGEtedkjUJL
	oUHcp2GokZJ3y2I8DcN7jbC696R9qX4i8i4CYN3BsHodOPTWqygx/1u6/YqdFEAj
	Y31CU3eCfSsZrC9C0AcLTw5/bmgMGdWKRLP6fN1VZgfCDGJesS1BGyAE35s0l1DF
	Vhbtp/PT/RPM5CT/L/CeQ==
X-ME-Sender: <xms:y1rvaCDqsRMKROR0N_cZx5Xpx6j3dJ_022ISU3jkIlNRiO7_IUwyVg>
    <xme:y1rvaHVDKKwbAOGfyyEJJcwasTlxvmFCGLeO5xo9A6MWeDHwlR5tiHLTs9FT-ztm0
    K7eQQ-U2blgzDrRtEHqCTw42aB7SxSKpEd3iSJ251YOuxEY9bOdGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofgggfgtfffkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhu
    tghkucghohhlsggvrhdfuceotghhuhgtkhesfiholhgsvghrrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevudduteduieegvdelvedugedtfeegjeegteevgfelgeetueetuedvtedt
    vdeuieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhesfiholhgsvghrrdhnvght
    pdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    hpsegrlhhivghnkedruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgt
    phhtthhopehmrghtthdrkhgvlhhlhidvsegsohgvihhnghdrtghomhdprhgtphhtthhope
    grnhgurhgvfidrjhdrohhpphgvlhhtsegsohgvihhnghdrtghomhdprhgtphhtthhopegt
    hhhutghkrdifohhlsggvrhessghovghinhhgrdgtohhmpdhrtghpthhtohepmhgrthhthh
    gvfidrlhdrfigvsggvrhefsegsohgvihhnghdrtghomhdprhgtphhtthhopehsrghmuhgv
    lhdrshgrrhhkihhsihgrnhessghovghinhhgrdgtohhmpdhrtghpthhtohepshhtvghvvg
    hnrdhhrdhvrghnuggvrhhlvggvshhtsegsohgvihhnghdrtghomhdprhgtphhtthhopegr
    nhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhm
X-ME-Proxy: <xmx:y1rvaOYJlMD8DHKGrnv6rhDc3RTrkWoOZC-i7EIiqNKs-vBNGYY7jA>
    <xmx:y1rvaDZiYZOM4hjcm13H7w3UEARIoGgIa0uj0uzPcJzFYICN5ZQK6Q>
    <xmx:y1rvaNQJtk4pthMkt-tCyJ9iG-MLlHeKUWmW3NL-7bD-w1uzNFdDHA>
    <xmx:y1rvaI3Dqhl9l4nYXMT1TbpmBVLh1Plq2X__JCJ0Gn-4GJ-dXXU9ng>
    <xmx:zVrvaCz3CLUWWXRj_ZMqZVOaIMLmXf8FqrY9YtloQg9nbnG_TW2UrMFj>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E888718E0054; Wed, 15 Oct 2025 04:26:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 08:26:50 +0000
Message-Id: <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
From: "Chuck Wolber" <chuck@wolber.net>
To: "Peter Zijlstra" <peterz@infradead.org>, "Sasha Levin"
 <sashal@kernel.org>
Cc: <nathan@kernel.org>, <Matt.Kelly2@boeing.com>,
 <akpm@linux-foundation.org>, <andrew.j.oppelt@boeing.com>,
 <anton.ivanov@cambridgegreys.com>, <ardb@kernel.org>, <arnd@arndb.de>,
 <bhelgaas@google.com>, <bp@alien8.de>, <chuck.wolber@boeing.com>,
 <dave.hansen@linux.intel.com>, <dvyukov@google.com>, <hpa@zytor.com>,
 <jinghao7@illinois.edu>, <johannes@sipsolutions.net>,
 <jpoimboe@kernel.org>, <justinstitt@google.com>, <kees@kernel.org>,
 <kent.overstreet@linux.dev>, <linux-arch@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-um@lists.infradead.org>, <llvm@lists.linux.dev>,
 <luto@kernel.org>, <marinov@illinois.edu>, <masahiroy@kernel.org>,
 <maskray@google.com>, <mathieu.desnoyers@efficios.com>,
 <matthew.l.weber3@boeing.com>, <mhiramat@kernel.org>, <mingo@redhat.com>,
 <morbo@google.com>, <ndesaulniers@google.com>, <oberpar@linux.ibm.com>,
 <paulmck@kernel.org>, <richard@nod.at>, <rostedt@goodmis.org>,
 <samitolvanen@google.com>, <samuel.sarkisian@boeing.com>,
 <steven.h.vanderleest@boeing.com>, <tglx@linutronix.de>,
 <tingxur@illinois.edu>, <tyxu@illinois.edu>, <wentaoz5@illinois.edu>,
 <x86@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
 <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>

On Wed Oct 15, 2025 at 7:41 AM UTC, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 07:26:35PM -0400, Sasha Levin wrote:
>> This series adds support for Clang's Source-based Code Coverage to the
>> Linux kernel, enabling more accurate coverage measurement at the source
>> level compared to gcov. This is particularly valuable for safety-critica=
l
>> use cases (automotive, medical, aerospace) where MC/DC coverage is requi=
red
>> for certification.
>>=20
>> Changes since previous patchset [1]:
>> - Rebased on v6.18-rc1
>> - Adapted to lib/crypto reorganization (curve25519 exclusion moved to
>>   lib/crypto/Makefile)
>> - Minor correctness fixes throughout the codebase
>>=20
>> The implementation has been tested with a kernel build using Clang 18+ a=
nd
>> boots successfully in a KVM environment with instrumentation enabled.
>>=20
>> [1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illino=
is.edu/
>>=20
>> Wentao Zhang (4):
>>   llvm-cov: add Clang's Source-based Code Coverage support
>>   llvm-cov: add Clang's MC/DC support
>>   x86: disable llvm-cov instrumentation
>>   x86: enable llvm-cov support
>>=20
>>  Makefile                          |   9 ++
>>  arch/Kconfig                      |   1 +
>>  arch/x86/Kconfig                  |   2 +
>>  arch/x86/crypto/Makefile          |   1 +
>>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>>  include/asm-generic/vmlinux.lds.h |  36 +++++
>>  kernel/Makefile                   |   1 +
>>  kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
>>  kernel/llvm-cov/Makefile          |   8 +
>>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>>  kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
>>  lib/crypto/Makefile               |   3 +-
>>  scripts/Makefile.lib              |  23 +++
>>  scripts/mod/modpost.c             |   2 +
>
> I'm thinking I'm going to NAK this based on the fact that I'm not
> interested in playing file based games. As long as this thing doesn't
> honour noinstr I don't want this near x86.

I am working on a noinstr patchset that will precede this pachset. As it tu=
rns
out there are several areas of the kernel (128 that I have found so far) th=
at
are missing the noinstr attribute macro.

Example:

kernel/locking/lockdep.c:
	void noinstr lockdep_hardirqs_off(unsigned long ip)
include/linux/irqflags.h:
	static inline void lockdep_hardirqs_off(unsigned long ip) { }

The latter version is intended to be optimized out if the kernel is not
configured to use this feature. However when the kernel is instrumented for
profiling, the stub is not optimized out and ends up in the .text section
rather than the .noinstr.text section.


> And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
> solutions is like 2 too many?

Optimization makes it nearly impossible to correlate GCov results back to
actual lines of source. llvm-cov instruments at the AST level which enables
precise mapping back to source code regardless of optimization level.


A detailed rundown on this issue can be found here[1], with the most releva=
nt
excerpt reproduced here:

> In the following gcov example from drivers/firmware/dmi_scan.c, an
> expression with four conditions is reported to have six branch outcomes,
> which is not ideally informative in many safety related use cases, such a=
s
> automotive, medical, and aerospace.
>=20
>         5: 1068:	if (s =3D=3D e || *e !=3D '/' || !month || month > 12) {
> branch  0 taken 5 (fallthrough)
> branch  1 taken 0
> branch  2 taken 5 (fallthrough)
> branch  3 taken 0
> branch  4 taken 0 (fallthrough)
> branch  5 taken 5
>=20
> On the other hand, Clang's Source-based Code Coverage instruments at the
> compiler frontend which maintains an accurate mapping from coverage
> measurement to source code location. Coverage reports reflect exactly how
> the code is written regardless of optimization and can present advanced
> metrics like branch coverage and MC/DC in a clearer way. Coverage report
> for the same snippet by llvm-cov would look as follows:
>=20
>  1068|      5|	if (s =3D=3D e || *e !=3D '/' || !month || month > 12) {
>   ------------------
>   |  Branch (1068:6): [True: 0, False: 5]
>   |  Branch (1068:16): [True: 0, False: 5]
>   |  Branch (1068:29): [True: 0, False: 5]
>   |  Branch (1068:39): [True: 0, False: 5]
>   ------------------


..Ch:W..



[1] https://lore.kernel.org/llvm/20240905043245.1389509-1-wentaoz5@illinois=
.edu/



