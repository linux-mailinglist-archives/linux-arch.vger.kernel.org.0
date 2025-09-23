Return-Path: <linux-arch+bounces-13723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C1DB94974
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F899480089
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE930F547;
	Tue, 23 Sep 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KJ/uoZSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n56CdQSY"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236822ACEB;
	Tue, 23 Sep 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609741; cv=none; b=d2hYS//AoQGPdm5GM5JFc4CqFkA/zAqLAm/mgmJ6hF8BqhvLmmE/Uxsun2TPuS77yPFfCYNQ1e5cgVkQZFYbxJOlpx3vWH18g2Xv9zl8oYitrVqfvKJVYS4yx0OYwdCr8mE8T7JGl+tfxvCpxJTvw0VINh+hNzgTxEJxFA9q9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609741; c=relaxed/simple;
	bh=P2NZE0n7MiiCBiDkONlBcF7pHNIFkrE7kKcJAW4C+7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cKEPh/6QQFESWxK2MRDz1NetKV8ke6aqSkkTiE0Cst3HXocAlw2VqW0V2Uau2gQm61ADvOKoXTawW6FHdd3U8RKzBeT6lrtLsyuSHiPB07igr9iA4041BTId5GeqoGefyPRdd63Jv1Doqf9VO2Gwd1Giq1jASDjHAX+mU2T8AbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KJ/uoZSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n56CdQSY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A5831D001BB;
	Tue, 23 Sep 2025 02:42:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 02:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758609736;
	 x=1758696136; bh=FGIY+8FPwLmeSxHeWRctWFodP+GvxlDpxtszJgK+wmY=; b=
	KJ/uoZSPCFOJF/mKFgRtiYu1BW8AHiIfxYaIFWTetBxkOrCIUxpEhCAAW3TJlbQQ
	0QL46MDn6ciaqGC8hURh+jQ65BejQ43Qow1rNVI0TF+YLudXYfY95zyfiWzynenA
	9Bcsn1vG1lZRKTQwSlzgjHIA90dIhc3IR0Dxmkf11iEHo3gKBJNej0c+ZjFVPItG
	v7ljgd+EFeZgrzgP40bn4/oOoZr5O9Iti08vRjk0HfC+qAVpuAZ9SbJckuB4hWiC
	q+SFU/TDhLGcM1bOc6YXaRWdBNcdHIAi+PN/1NRhw3pE9u88dLTobOSVDg/b6g5c
	uh/1xT0AItgKwzwlLu0h7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758609736; x=
	1758696136; bh=FGIY+8FPwLmeSxHeWRctWFodP+GvxlDpxtszJgK+wmY=; b=n
	56CdQSYqTIjhJCjuGCdY0FLYA/n9lhBI5Vc68IloiXWlubOZlhNhQWeCbQK4RCxV
	dYBTORXZzzbTckttkIVMNL9j6qmtFXKGoeP5Olb2i7EL7Bolfe3XqRWPq0eekh/X
	IGzYqUUABiNfj68HZy6M4+NA9xgX2MTbIYjSAbMhGOPARJGtNNPU3QM8BWTpjvC1
	7PGGQOSZsoFb0LnEEwStmw+l064xTfHc4HjMYuhptSw3gfsy1RP/Sx3ZdvfHkDOS
	e7U07P3Io0Wzr6f/XABZbWGn4TePEXRGlAR4VeBzvkNiVfZCbQsl27VEhw4jOl3t
	/e+Rk6stMkJigX01TeKxw==
X-ME-Sender: <xms:SEHSaLfRv4wJx3kGRpNW3f_6PEUSqSACtOysukxBvlg4sB0Toq5TsQ>
    <xme:SEHSaMCIWSY3aMaH8h84iq5YQfeeyvRVzObM39zou4RDx-NvhNUrCyZ2HbL_lGE-L
    Li-ZCvTyPM9t86JsPB-HHjGN2RFz-vvAdsLiicTZv-pncUUwIb-u1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:SEHSaLZt85JBELa0ynK_Bqeo5OyYk9b6SWCDQSXJ7I2wvH-O7yXc2Q>
    <xmx:SEHSaAy5aZBx2Pq5DuONae2JZN-M0sna_xwnxnAb7cyfKZUOjxPInQ>
    <xmx:SEHSaKOzRPWWBb21wl8_cReV-OS-YBAdhaBJKkbJxo9VusRlBgJsFw>
    <xmx:SEHSaPeNVoHHeB-I4CJbWy_BOVP4pPdW7FWLUSyQVoN-hx5h6hPtpg>
    <xmx:SEHSaLWyzVYQtT6HT50iJTXYdiLL9IhC-DBs-1qMXnO5T5FCbQByWfMg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59C0A70006A; Tue, 23 Sep 2025 02:42:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Tue, 23 Sep 2025 08:41:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <d707b875-8e3c-4c18-a26f-bf2c5f554bc2@app.fastmail.com>
In-Reply-To: <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 08:28, Finn Thain wrote:
> On Mon, 22 Sep 2025, Arnd Bergmann wrote:
>> On Mon, Sep 22, 2025, at 10:16, Finn Thain wrote:
> @@ -8,7 +8,7 @@ struct vfsmount;
>  struct path {
>         struct vfsmount *mnt;
>         struct dentry *dentry;
> -} __randomize_layout;
> +} __aligned(sizeof(long)) __randomize_layout;
>
> There's no need: struct path contains a struct dentry, which contains a 
> seqcount_spinlock_t, which contains a spinlock_t which contains an 
> atomic_t member, which is explicitly aligned.
>
> Despite that, there's still some kmem cache or other allocator somewhere 
> that has produced some misaligned path and dentry structures. So we get 
> misaligned atomics somewhere in the VFS and TTY layers. I was unable to 
> find those allocations.

Ok, I see. Those would certainly be good to find. I would assume that
all kmem caches have a sensible alignment on each architecture, but
I think the definition in linux/slab.h actually ends up setting the
minimum to 2 here:

#ifndef ARCH_KMALLOC_MINALIGN
#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
#elif ARCH_KMALLOC_MINALIGN > 8
#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
#endif

#ifndef ARCH_SLAB_MINALIGN
#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
#endif

Maybe we should just change __alignof__(unsigned long long)
to a plain '8' here and make that the minimum alignment
everywhere, same as the atomic64_t alignment change.

Alternatively, we can keep the __alignof__ here in order
to reduce padding on architectures with a default 4-byte
alignment for __u64, but then override ARCH_SLAB_MINALIGN
and ARCH_KMALLOC_MINALIGN on m68k to be '4' instead of '2'.

     Arnd

