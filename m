Return-Path: <linux-arch+bounces-3522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB189DE14
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953941C2374B
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F14131185;
	Tue,  9 Apr 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c8Wwn4ub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDC6ByAb"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318312FF65;
	Tue,  9 Apr 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675099; cv=none; b=peNazNQmBCoCiMV7QlKMu4LR87T3CoDDvnwZatgLl2X/kbXaYhxADFHWaYbGuU3wuDkR9sB3Wl/YoU7WQMXJKeaBSshituiV3fqTo5U3Acuqg5mdLchOp35n1nOlm4zaH9kJUxkvp0bPd720SNMj0c1hU+mcapH5Og3tx7JPbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675099; c=relaxed/simple;
	bh=K9ZmIgxNNGcqdTJbrehXS3OPMQPiMNM/e71i+yjPS20=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Uo9p0Yk37VoEuSojPCG3j+i7mjO/44ihuQs61ynvOArZdMvhC7GEeb66Z84W1y84XlE1ul4bz0PR10QWkdGjGkaPIpOieD3Mfmp5S7hef7ChXmwr6XNPu2SovhEnf/9y4z2qHnczH5MW8y65VIxfgIgu1ddgsx0MQjWtxODVKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c8Wwn4ub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDC6ByAb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DF595114013C;
	Tue,  9 Apr 2024 11:04:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 11:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712675096; x=1712761496; bh=K9ZmIgxNNG
	cqdTJbrehXS3OPMQPiMNM/e71i+yjPS20=; b=c8Wwn4ubBXL7a28OepgsduacGi
	c7LO4v9Kn1tvZS7AagwBMBS5RwMDf7b7lAc2mRR0STBNOkfiSX6ZPhoHFdIi////
	i6WDjtwidkI+MWydDlswprCapC6zYevrwDTXsSVAB4hacntijrnC583yaEjt2pAo
	2GauPq/KnQHU+zD1dEiCKYYxujAh4t7aGYgtZ+JSqN1PsEDuAQKD2W2q7MjyZ+ZN
	rwFrriu3GKoJb4ogc1K2ulxqdxgr02St7Jw5YmU1gSbzeiAjL9t4HRZw15F+674r
	vcVF4ZdjHVeuGonMJ5DGFmV7iwC3sUplQmxINb3JuDQu1KJLT48I3vT8VO0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712675096; x=1712761496; bh=K9ZmIgxNNGcqdTJbrehXS3OPMQPi
	MNM/e71i+yjPS20=; b=WDC6ByAbA9fPQpigfuVI/+HAy7ODa7C2FliHQ2NSz1SI
	8kb2fJxha4JT1zTgSkrCewXjmZe3aXOiKWDnfus2WcRYOwGdS9g6+txoIYk4J3zK
	AIXx5J5Mgqfh62oFRT6wXwOD9emWNoyZL25TfWhWweSLLVYGlJu4KfTcVlcQ7fy0
	7NP7H78RVze8grD16Kar8iYq0/HthOfwmX+J9y0FZhZ0lofrZwhhQVyPykGw3tNz
	khpxsviwkexdgiStPoKkG4QCt1zwzLkU15yPhf9Hwo+zC8HumWq0EASG+kG8K8zw
	U6KdgaSp0wN9trUk7Z/AGGGEuYUxbOKi+/EodRppWw==
X-ME-Sender: <xms:GFkVZvp8ZsQVrgXXlo-kFHQbjdzlgS-inXgPPWURk4nBFawa8YvNNQ>
    <xme:GFkVZpruWf6tDkqYADOvVYF_qzbErj6PYRxWf4SwxWOXN6Iy02uTjmO0qn1VZPg84
    DjHZtmuhsKeYDone8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GFkVZsNLAZLPg4pngm0_psZAg38hmi31GgNM8HNcS7I86DyWoWQJjQ>
    <xmx:GFkVZi7gRYuWR8E0EO0kk2OmYGZ5w6kH6JpSWwpx9HyjiueENIBsZA>
    <xmx:GFkVZu6L1d4ul5dBimvBvwMxwjXsazwmOewmAtf8pzcSqmi_rqnoDQ>
    <xmx:GFkVZqgE86DQ09lBfEgqJdCDg96c4dKymTeri6578QHdQu23xsrSzg>
    <xmx:GFkVZrz1jnejCGrjROR0cuQhf2CIvdisRFrv4lnyI7Fmk6eCrb4eFtYH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 59AD0B60089; Tue,  9 Apr 2024 11:04:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b60ba66d-4028-4fc1-89be-41889768990b@app.fastmail.com>
In-Reply-To: <20240409150132.4097042-6-ardb+git@google.com>
References: <20240409150132.4097042-5-ardb+git@google.com>
 <20240409150132.4097042-6-ardb+git@google.com>
Date: Tue, 09 Apr 2024 17:04:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, "Andrii Nakryiko" <andrii@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v2 1/3] kallsyms: Avoid weak references for kallsyms symbols
Content-Type: text/plain

On Tue, Apr 9, 2024, at 17:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> kallsyms is a directory of all the symbols in the vmlinux binary, and so
> creating it is somewhat of a chicken-and-egg problem, as its non-zero
> size affects the layout of the binary, and therefore the values of the
> symbols.
>
> For this reason, the kernel is linked more than once, and the first pass
> does not include any kallsyms data at all. For the linker to accept
> this, the symbol declarations describing the kallsyms metadata are
> emitted as having weak linkage, so they can remain unsatisfied. During
> the subsequent passes, the weak references are satisfied by the kallsyms
> metadata that was constructed based on information gathered from the
> preceding passes.
>
> Weak references lead to somewhat worse codegen, because taking their
> address may need to produce NULL (if the reference was unsatisfied), and
> this is not usually supported by RIP or PC relative symbol references.
>
> Given that these references are ultimately always satisfied in the final
> link, let's drop the weak annotation, and instead, provide fallback
> definitions in the linker script that are only emitted if an unsatisfied
> reference exists.
>
> While at it, drop the FRV specific annotation that these symbols reside
> in .rodata - FRV is long gone.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

