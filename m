Return-Path: <linux-arch+bounces-13612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DDB574E4
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 11:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B41778CC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB22EA730;
	Mon, 15 Sep 2025 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXPR1bVn"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A83D984;
	Mon, 15 Sep 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928419; cv=none; b=hwqkFM70H/iPuRwKBji1rF/rUCmWCLCpfjJe4pVF2l+5saXmzsLGJ7rJhBdRbdLQoJl/c7HZPpdjf64YiTcIEFGTunfgAg3/NrYyQuc+DjxCtTLuhU1LWq/FcLCopfNKHtZlLBn8GcOyPK4N5gt+L+nLhDC8aF5YZYe34spLYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928419; c=relaxed/simple;
	bh=0ny8FKWjpUlbLud8VuX99OuONGyKCRz9Iotsxs0Aopw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=istNtp0za0MRjRT/wnj6/0sXCGLBO0fIxVK04Z+u3ge36DkB1SIRzCdkQxy77IpCybvIImdKc3NyFV81HnH70iCcpQGZtZiboIchsl+iYYvmACkLoAQ8l87Ig0UsknBO/FlTHbFxcGrA9jr6QKTDkK44Pw2EQuXXezyX/nnSSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXPR1bVn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 385BF140020F;
	Mon, 15 Sep 2025 05:26:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 05:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928416; x=1758014816; bh=qB5j5tPDORmdLoU8aR2TXEt209oeznvEGDo
	zn2hFDXo=; b=FXPR1bVndsbxvdAus3OYAegJiWque9bPlLzTAjV7DJvzRw/tMpi
	NqZsa3wpk/eHcgqPzLS5H5nb0PzLLlGdVavwovhns5ZqgqBTkpbC06jAzYjMqxSW
	OWtiYlAndcQDq2jp2wGLAKCC7wRtfek9XG+HfjOAHgmafoIALR2Xx9EtZYRH4l3w
	t7f3spWOMxzqhmgbVVVmClvr5yF0+oE2LH5xm/EelN9BzVNfDkaF3ABR29H0R7g1
	UVvn9vEjjsNAojKIcuzeR+4bMa0anBrrHtEV6AmdpstIaA4Ja19Eda6vz/iK+4Hm
	ka/fXU4xZVxnPq1RQlcENUjXA9wDYB4spPg==
X-ME-Sender: <xms:39vHaE1QE2pFrgzQbcY9bE2RK6dSIubB6M0yfdIDxUp6R6kcIoFnSw>
    <xme:39vHaJhs8xrDU-wj9xNJ3J2fHEGs3pMi9aGOH6FYGjMaNLNZmfpHphjzX4Hd-tL0s
    fp-AR56He9YwAFsN3M>
X-ME-Received: <xmr:39vHaEZLwGt4VxZhRZDNR7xRUqkZUCnpIrkqZzPfiiXTqq5w4HdmNNHMPRygEE1zlhFk6Ypsk5CACzMb21pAqTJs6ujEszJGTSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtg
    hhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:39vHaFUS-TllTcenWAQP1Pr1NfefUNmI2ediOKRwOUO5q1S7Bqrt-A>
    <xmx:39vHaMHLTnfA1PWVnpNDavVrzp_7yzH82Dnm7c2qkY9yBou4tYKaAg>
    <xmx:39vHaPYxcmTdBLpNkfjyc3ovnscn6NuinLMr6a5o0y_umFEXJtSXfA>
    <xmx:39vHaLGV9M12b-1gKcMso0TsmGPyLQgoVJ_TANBqy9RYwGw299Sjzg>
    <xmx:4NvHaBsm2NqGSf4IwAc1PaH3UlTBBsX1W3yu2HXkg9n7WGk6wc0a1rGB>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:26:52 -0400 (EDT)
Date: Mon, 15 Sep 2025 19:26:46 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>
Message-ID: <c130a0bd-f581-a1da-cc10-0c09c782dfca@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 15 Sep 2025, Arnd Bergmann wrote:

> On Sun, Sep 14, 2025, at 02:45, Finn Thain wrote:
> > index 100d24b02e52..7ae82ac17645 100644
> > --- a/include/asm-generic/atomic64.h
> > +++ b/include/asm-generic/atomic64.h
> > @@ -10,7 +10,7 @@
> >  #include <linux/types.h>
> > 
> >  typedef struct {
> > -	s64 counter;
> > +	s64 counter __aligned(sizeof(long));
> >  } atomic64_t;
> 
> Why is this not aligned to 8 bytes? I checked all supported 
> architectures and found that arc, csky, m68k, microblaze, openrisc, sh 
> and x86-32 use a smaller alignment by default, but arc and x86-32 
> override it to 8 bytes already. x86 changed it back in 2009 with commit 
> bbf2a330d92c ("x86: atomic64: The atomic64_t data type should be 8 bytes 
> aligned on 32-bit too"), and arc uses the same one.
> 

Right, I forgot to check includes in arch/x86/include. (I had assumed this 
definition was relevant to that architecture, hence the sizeof(long), in 
order to stick to native alignment on x86-32.)

> Changing csky, m68k, microblaze, openrisc and sh to use the same 
> alignment as all others is probably less risky in the long run in case 
> anything relies on that the same way that code expects native alignment 
> on atomic_t.
> 

By "native alignment", do you mean "natural alignment" here?

