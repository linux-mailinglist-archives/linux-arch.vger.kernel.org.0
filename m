Return-Path: <linux-arch+bounces-9647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D9A05902
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF98018874C2
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561311F76C7;
	Wed,  8 Jan 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cy+D97Sp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSIdJfQw"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BA1F37CF;
	Wed,  8 Jan 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334117; cv=none; b=k2qh1SZbOeoEnN9iRA6mjEJMZ1tIcxceZbOfmpqqBVr7KVazMmDFf1en10yICmQJlA5MF+n81UeV769FHSXVeFRzTIGbLHEglpltR6kntnBhea2wnfT/ctSv859wYmJhOv3IAQqRg46w8emLzMKollvfhhfW/2rC46NZrMVULG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334117; c=relaxed/simple;
	bh=DGrWIQkRqJa7hR4QRq6PBJRqLuAJ4GspDnLAHEtpQyI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aVtvMDB5h2U9Vf2tkyslyneFwY578HA0qROQeKCZ7r7jLD+9W8KR/wjO2iXMegK+PBEEO/nqHossIb/rqNWCrRtBz/wwnuABcPPXayclkAuxcEkq6Gjj3RooswCL6ejJOGDnaXatQGyYqkVaGpSuSTCAdGyUom2VNVqHrqNKrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Cy+D97Sp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSIdJfQw; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 01AD8200CCC;
	Wed,  8 Jan 2025 06:01:54 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jan 2025 06:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736334113;
	 x=1736341313; bh=20U5sO/u0uYru3hxNMHsooCdHBrAIIWG/43UdZigSIo=; b=
	Cy+D97SpayPKf50CJRucU/OjuqxmZo1HPxdDHfFjtk4V4dzkHIGqqI4ZeTBGBIwQ
	CU43a3abN/lpxbZArBxq7/TC680Cne845B7Mt9ZmA7It+HSwgjARBYDZNaSmXNM2
	krcib2kkSpUfF5s2H8og+FziqnBYnNGV+oIkJokZXGPBRm2uRnZPUxupBCIsLyF3
	L95dQfXdiAUWRhy4AoFiIf7vssy39N0gIf97bLCYb6UE+9UATBG8UEmpoSxSvb3y
	VSe4QWYZNxY7/CiTOh3EVoghZyEg8uCRUsZwXWBw32ptH23GUNZihG2RL0COZuPY
	JUo0rYJf6FqI9B/v7Pe1QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736334113; x=
	1736341313; bh=20U5sO/u0uYru3hxNMHsooCdHBrAIIWG/43UdZigSIo=; b=M
	SIdJfQwmksvBJ00U9HcUOaODS1attuTNvWMQryD5z90DVgF6hJ7NU+/6na9R1zMX
	N4e5muAPBw/KbD4IiqcgMdfPyL5oytjmreBUaObCMGSlSguiImcZFV+PHOogQ0C8
	sfMV/tSn2hosWoXw0QfBP8yg8ww3eBodDuz6q/i7vkKifow1ceZYP7CRJ/mj2xVC
	a+qiTqelX8Gs/hSLYFr9PAhNoCapvXPNYTkqh4KLORdzvEktytEn7MA+4vx6ltiH
	wkTkgfP+WzoCXr6QB8GCjvYhe0eFs2cVoTQLmYEZANUV5rBtinqFmbMvZKxf3ghZ
	EQACF6/J+VIomkI/RscUA==
X-ME-Sender: <xms:IFt-Z6UmaWSjYb7Gh0zcpksWzDDdEPgfiSYLh-0i-y9aLcE3r6zD_A>
    <xme:IFt-Z2nOjzdfh823ysQc1S2oDX-1-nZXTq_53rcym6EIbKwXeGB0UjDLQAu3SVTJl
    FqMSA1gCW8wUUAwYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghvihhnrdgsrhhoughskhihse
    grrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhm
    pdhrtghpthhtohepiihhvghnghhqihdrrghrtghhsegshihtvggurghntggvrdgtohhmpd
    hrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghn
    ughrvggrshesghgrihhslhgvrhdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtih
    drfhhrpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthho
    pehvihhshhgrlhdrmhhoohhlrgesghhmrghilhdrtghomhdprhgtphhtthhopehhuhhghh
    gusehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:IFt-Z-aQ2SmgS3nXZ8HOHScIMD5VPYsyBFMZLc-J-VgcUAnAe2HzCw>
    <xmx:IFt-ZxXCvJZ1AcFo5fB-biVPFqTsSFdNnldK9XWf-i56cAUN39KLdQ>
    <xmx:IFt-Z0lFXSJuGe63NytzX7QBWDpUz5bkZTKgpNbVjZZcysvLCNf6UA>
    <xmx:IFt-Z2eyKBxnx9FUnENXCTF11sxAJ8UI5uJaB8BKG5BUdEYntabkhQ>
    <xmx:IVt-Z-tKPBuX6yCR5FGPupQm8IjlY8CNUkvhyqGI8S0AmCpHcXU81GMM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1006D2220072; Wed,  8 Jan 2025 06:01:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 12:01:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qi Zheng" <zhengqi.arch@bytedance.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "David Hildenbrand" <david@redhat.com>, "Jann Horn" <jannh@google.com>,
 "Hugh Dickins" <hughd@google.com>, "Yu Zhao" <yuzhao@google.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Muchun Song" <muchun.song@linux.dev>, vbabka@kernel.org,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Rientjes" <rientjes@google.com>, vishal.moola@gmail.com,
 "Will Deacon" <will@kernel.org>, aneesh.kumar@kernel.org,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <fd6e7ad9-9d57-40b6-a8f6-455ea3ab3d27@app.fastmail.com>
In-Reply-To: 
 <26d69c74a29183ecc335b9b407040d8e4cd70c6a.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <26d69c74a29183ecc335b9b407040d8e4cd70c6a.1736317725.git.zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 03/17] asm-generic: pgalloc: Provide generic
 p4d_{alloc_one,free}
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 8, 2025, at 07:57, Qi Zheng wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
>
> Four architectures currently implement 5-level pgtables: arm64,
> riscv, x86 and s390. The first three have essentially the same
> implementation for p4d_alloc_one() and p4d_free(), so we've got an
> opportunity to reduce duplication like at the lower levels.
>
> Provide a generic version of p4d_alloc_one() and p4d_free(), and
> make use of it on those architectures.
>
> Their implementation is the same as at PUD level, except that
> p4d_free() performs a runtime check by calling mm_p4d_folded().
> 5-level pgtables depend on a runtime-detected hardware feature on
> all supported architectures, so we might as well include this check
> in the generic implementation. No runtime check is required in
> p4d_alloc_one() as the top-level p4d_alloc() already does the
> required check.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 17 ------------
>  arch/riscv/include/asm/pgalloc.h | 23 ----------------
>  arch/x86/include/asm/pgalloc.h   | 18 -------------
>  include/asm-generic/pgalloc.h    | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 58 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic

