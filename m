Return-Path: <linux-arch+bounces-9432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B69F7AE0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D5165DF3
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80A2236FD;
	Thu, 19 Dec 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hXPuViTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ai01Jq9/"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67A22145D;
	Thu, 19 Dec 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609799; cv=none; b=RQpmB1JnruusagIg4nawAAqFfkydYaTJqWcdAwJ5YXQ57xYvW3KcFEoSH9M79G0V7dWH9UKuU4Ucr4wXDsuC10+5oMERnlqOf72OEPC32xI+DtEufJ2jIZqlKNXdJvVbi0A6caBU5CHLwCX6rIpmJT7at9ZkH2uuWGNoiudLWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609799; c=relaxed/simple;
	bh=Qg3sRh/NrBVXvAQf4LtjFbJFl+QuBJMpT2uDuNKPfUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gGE5l3jyEP6HZwsTlMvI7cGA6lI8h+YzDiKr9jk72vENFZQj4tehu6crx2tojGzLvJbZZgGB2oe1EciY51xXJV8bEah3yKKJtxgMA5qo3sHduSjvRuzNO/u01ECdE0xD6LZ6fbmT8BwBWmcDE+wYnQPlQcksvgjewnR2AnDBWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hXPuViTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ai01Jq9/; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 716412004CE;
	Thu, 19 Dec 2024 07:03:15 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 19 Dec 2024 07:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734609795;
	 x=1734616995; bh=HsWGYit1QfbykpeRihgbuA09LwqwIdTOxzn2rND9d44=; b=
	hXPuViTWoL+d8uTD8HWKH6l9JI3Qeg2+RU0afqJ+27Me3anlO7iAkrJodDU6SDBN
	Q072WguaY7168vuinaZpdAtQ10DTGk5RYTaX/LadyRHQOzWPD3JbXXKn0mlciYNp
	/X0ieAaHbhoMwp3jLFOIUY9qD8vUGL6DA6lT6SSUUoc7L2j+JHlZHXtf+NE7YFbT
	eOs3kJAp5E5/dY87oP0aB928LrOITs5+5CDiuYcjTHYJJciZmW9Z0XBEYdV4CiNk
	Wx0h3kLrKDDoQBv9F7H04Cd/klAwrIBGOvI957eyJztC01JCmdqrxlQ1BlkaCsQa
	jWQXaNegO8DxO9+esrj5GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734609795; x=
	1734616995; bh=HsWGYit1QfbykpeRihgbuA09LwqwIdTOxzn2rND9d44=; b=A
	i01Jq9/TVKRojX7wRVqPg0h5WKcLpoStUlzFB/1DKY70YpqmGkR7fHOcpORUn0um
	O3veblgy+PhgwTHKsaLsX62avtsXgZfoU3nI7C6pm24TvWQrJZfq+Rh9JerC4NLS
	ciJ2sAoN9cCbyrQeR85kewBkWKH6IQre7lcblf9ImmbyUTndDKyoIi7iBFB4FLD3
	0KT6+xxFdEY0omS5lwTLd8ccH+7S9mGeb77Qi1x6f+uVivOh3MspIan1aTLYH7mp
	jKgm3f81NG86TuM3m3J6GqmunKFMUSCLyYI+YxETM8+cFfzgpaomgMZfCdOwfBTG
	wCLqOyPW6qgnvCJJQUe3A==
X-ME-Sender: <xms:ggtkZ9XFnFb5Shp28v0VE5L4v36r3JhISx0lVUCjHpWxkY9h9zUZvA>
    <xme:ggtkZ9m1zxghtWwVIpwNk_zL1gyrBICU15_y-0Zl2SKXv0fhrUuFhEsigWuxSN5vN
    yjOkbkuwRFOCJ_P5pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrg
    hrmhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhf
    ihgtihhoshdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehi
    rhhoghgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhith
    htsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhgvihhthhhpsehkvghithhhphdrtghomh
X-ME-Proxy: <xmx:ggtkZ5a7PffbNu-Ay1FQMOqZTJrFGnnXD5tGmRrSyWO2ytuqef_FkQ>
    <xmx:ggtkZwUP_QJ3AoR1Af7G1uuLVO1kijbfSFTGznwbJEEi8KUxCINq9Q>
    <xmx:ggtkZ3mnHQzr0RzOZWTVBet3C-Iqpqn-7c60fklTEsnKTuixPrkLGA>
    <xmx:ggtkZ9egiZ9brX4PP9vRZHihWLda5MfhHjVBPTo81Ntc2DfeKXzPOA>
    <xmx:gwtkZ1q8kWVe1DguqO4AMWKc4WtDvHUh-cbDE_TCaSipIJZV6Dnl5eox>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C9372220072; Thu, 19 Dec 2024 07:03:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 13:02:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 "Ard Biesheuvel" <ardb@kernel.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Uros Bizjak" <ubizjak@gmail.com>, "Dennis Zhou" <dennis@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Keith Packard" <keithp@keithp.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Kan Liang" <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-sparse@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <0afeae21-a663-43c9-91ff-f0357f5ac06b@app.fastmail.com>
In-Reply-To: <Z2QJKZBsgvPMgRo_@J2N7QTR9R3>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-32-ardb+git@google.com>
 <c4868f63-b688-4489-a112-05bf04280bde@app.fastmail.com>
 <Z2QJKZBsgvPMgRo_@J2N7QTR9R3>
Subject: Re: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 19, 2024, at 12:53, Mark Rutland wrote:
> On Wed, Sep 25, 2024 at 03:58:38PM +0000, Arnd Bergmann wrote:
>> On Wed, Sep 25, 2024, at 15:01, Ard Biesheuvel wrote:
>> > From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> We obviously need to go through all the other version checks
>> to see what else can be cleaned up. I would suggest we also
>> raise the binutils version to 2.30+, which is what RHEL8
>> shipped alongside gcc-8. I have not found other distros that
>> use older binutils in combination with gcc-8 or higher,
>> Debian 10 uses binutils-2.31.
>> I don't think we want to combine the additional cleanup with
>> your series, but if we can agree on the version, we can do that
>> in parallel.
>
> Were you planning to send patches to that effect, or did you want
> someone else to do that? I think we were largely agreed on making those
> changes, but it wasn't clear to me who was actually going to send
> patches, and I couldn't spot a subsequent thread on LKML.

I hadn't planned on doing that, but I could help (after my
vacation). As Ard already posted the the patch for gcc, I
was expecting that this one would get merged along with the
other patches in the series.

Ard, what is the status of your series, is this likely to
make it into 6.14, or should we have a separate patch to
just raise the minimum gcc and binutils version independent
of your work?

      Arnd

