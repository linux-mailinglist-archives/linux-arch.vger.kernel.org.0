Return-Path: <linux-arch+bounces-6656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F027960686
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E6DB23C36
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE619DF9E;
	Tue, 27 Aug 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KmI89gKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dolzJs3+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78F19D8A4;
	Tue, 27 Aug 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752789; cv=none; b=O1OnyXJo9q3nSR/rM+IXFnd4vXFkqXWiM/hNLdJF9hQG+hZQZzd7C+HnEct+yv+PCRD5FjDX7cNQDUfkh/gfrHmZh7MFSnKs5uyOmp+no9d4mDtEL1WVWmaFPBZO+21OILek+ZjojBl3AE/nMXBbL3n2uX9RcoSuYE0gefaqNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752789; c=relaxed/simple;
	bh=0gIKJBCJIngU14neZhUiwBiIsIWjLZ6FZjKB9uQSRz0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GJ45FmUSaylwdUKFTAMTrZU/XEEHiMqb9YtrbvZlWE8U4PUIPJIXltUnGqBEppVrE9HTQSUp8kHTwIZ8WfrhAIJc28fQB86BjrX+UDQ1BDvgkwVpnO/TI0UPzTA7iPK1lHyYN+TyvrhBiK8DMX7d1HbEwiVAWZ0JV9aw+6WybYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KmI89gKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dolzJs3+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 779D8138F115;
	Tue, 27 Aug 2024 05:59:46 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Tue, 27 Aug 2024 05:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724752786;
	 x=1724839186; bh=5+ahPqz+wUqbchfcJRTGxUBq/MCrVrzFJecPrVS+88Q=; b=
	KmI89gKntQkahciViBufBQ4WzAtQN/aF+d95+6TFPYmOMeqUNUJW1TsSGLJvfn6c
	kbv0CZT3Rd8sUBNVGxo6fKVhHRR9jYLLD9icMIqii+t1MSigsQnoB3eXhQnFKlec
	zlGLwyyFXA6Nqk2jUPwL3FZFah8kXXfddtVd7SRWUaiLgtOhdPtDBA3bSIGShEo6
	BRsq1s3L+HRO/WDAgjYVEXaiOINQ4PDprEj1PpIu1449Ir41OOC5XRjH9WJq4Qzc
	ynHXBsEGGUXYFQCffLBNl9U/xXXtcCP7YJ9mZGtbeldaHHxurZGaPNp2euiIiVOw
	nmF2seofWxaxTCZUwgLyRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724752786; x=
	1724839186; bh=5+ahPqz+wUqbchfcJRTGxUBq/MCrVrzFJecPrVS+88Q=; b=d
	olzJs3+CtSItImG0V2R2GV7dnVjPwKFq0tB9Oqj0QHdiseJnJz/hbjRnfqzK59TQ
	4OEguW8eddonLXp/V6CdygKNXEyVlKU+uA615eI2ldkGC19fh6g9TNGVlRQvAn5/
	pc0gwnPYAUiFvjsrX0iF1P3aEC/0CB52TY7hpYH2O13QHB/fkHp29fxu4TwHKasZ
	XOwh10djCwqhXZe2OiZnJlElONRxvLPYe9s/Iji1A0KoLyanNEU1jlu+nRAXqiKr
	PClEh0owH+B1Qx+P37Qs5C0fMxF9c/jH4ophiLQXXAjklmFuxYAC8f7L466w/STP
	g6+msN/rshiWkZeJMKb1w==
X-ME-Sender: <xms:kaPNZnxaoi8GRNjPUmD-oT_dBtAdLXT1QzzZD4sVI7hMUFpTtTIxJw>
    <xme:kaPNZvQKsl_-mQQdrKL5rzhaQR1xHpqdsvjESFb_Nlu05uGPYM9sDrI49NafYafTB
    Q2J0TF8adk7tV8MsxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtg
    hpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpd
    hrtghpthhtohepthihthhsohesmhhithdrvgguuh
X-ME-Proxy: <xmx:kaPNZhU69lzcxUhSfacmpZp7nfIUu-P7-meYsy9xFT1mFU5U8_Hbow>
    <xmx:kaPNZhgFRdOKbLJ6FHKyj-81WbN-KONGrDqIc499j0liw-VpW25Ldg>
    <xmx:kaPNZpB_WrWZ8OYAkaACQjECKZxYxGJoTqUjS9fbUD9Hh98ucYyh_g>
    <xmx:kaPNZqJMyn_RxonKjNSIC_IUqHH2_tULeMDUxTH-bvHi3OcTR3NGhQ>
    <xmx:kqPNZhxUL02RTIgdMAntEKQbrMDQoOxizRrf2TZ6lMpklbuTz06Gkhj->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 651AE222006F; Tue, 27 Aug 2024 05:59:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Aug 2024 11:59:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
In-Reply-To: <Zs2RCfMgfNu_2vos@zx2c4.com>
References: 
 <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 27, 2024, at 10:40, Jason A. Donenfeld wrote:
> I don't love this, but it might be the lesser of evils, so sure, let's
> do it.
>
> I think I'll combine these header fixups so that the whole operation is
> a bit more clear. The commit is still pretty small. Something like
> below:
>
> From 0d9a3d68cd6222395a605abd0ac625c41d4cabfa Mon Sep 17 00:00:00 2001
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> Date: Tue, 27 Aug 2024 09:31:47 +0200
> Subject: [PATCH] random: vDSO: clean header inclusion in getrandom
>
> Depending on the architecture, building a 32-bit vDSO on a 64-bit kernel
> is problematic when some system headers are included.
>
> Minimise the amount of headers by moving needed items, such as
> __{get,put}_unaligned_t, into dedicated common headers and in general
> use more specific headers, similar to what was done in commit
> 8165b57bca21 ("linux/const.h: Extract common header for vDSO") and
> commit 8c59ab839f52 ("lib/vdso: Enable common headers").
>
> On some architectures this results in missing PAGE_SIZE, as was
> described by commit 8b3843ae3634 ("vdso/datapage: Quick fix - use
> asm/page-def.h for ARM64"), so define this if necessary, in the same way
> as done prior by commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
> vdso/datapage.h").
>
> Removing linux/time64.h leads to missing 'struct timespec64' in
> x86's asm/pvclock.h. Add a forward declaration of that struct in
> that file.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This is clearly better, but there are still a couple of inaccuracies
that may end up biting us again later. Not sure whether it's worth
trying to fix it all at once or if we want to address them when that
happens:

>  #include <linux/array_size.h>
> -#include <linux/cache.h>
> -#include <linux/kernel.h>
> -#include <linux/time64.h>
> +#include <linux/minmax.h>

These are still two headers outside of the vdso/ namespace. For arm64
we had concluded that this is never safe, and any vdso header should
only include other vdso headers so we never pull in anything that
e.g. depends on memory management headers that are in turn broken
for the compat vdso.

The array_size.h header is really small, so that one could
probably just be moved into the vdso/ namespace. The minmax.h
header is already rather complex, so it may be better to just
open-code the usage of MIN/MAX where needed?

>  #include <vdso/datapage.h>
>  #include <vdso/getrandom.h>
> +#include <vdso/unaligned.h>
>  #include <asm/vdso/getrandom.h>
> -#include <asm/vdso/vsyscall.h>
> -#include <asm/unaligned.h>
>  #include <uapi/linux/mman.h>
> +#include <uapi/linux/random.h>
> +
> +#undef PAGE_SIZE
> +#undef PAGE_MASK
> +#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> +#define PAGE_MASK (~(PAGE_SIZE - 1))

Since these are now the same across all architectures, maybe we
can just have the PAGE_SIZE definitions a vdso header instead
and include that from asm/page.h.

Including uapi/linux/mman.h may still be problematic on
some architectures if they change it in a way that is
incompatible with compat vdso, but at least that can't
accidentally rely on CONFIG_64BIT or something else that
would be wrong there.

     Arnd

