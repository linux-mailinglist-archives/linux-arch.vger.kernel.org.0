Return-Path: <linux-arch+bounces-14117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E33BDD31C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0E13B2464
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF915539A;
	Wed, 15 Oct 2025 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Pq+2ekRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PP8As33C"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C019478;
	Wed, 15 Oct 2025 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514500; cv=none; b=GPIrtnG5oFHbTUm7EPTSY+TztxhhDXdaIMZhoxuzRVypZ6vs6lbvh/CW4hFiJUfmpo61iRMu5QRNeuLdxOysMDFMllRlJRIgNpfglFkGokspAT5q70WxfB8JxLd0lrVDznU8sUzrrtVxlzcaF1LRSzl/7cwfBcCQNzi0znqxYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514500; c=relaxed/simple;
	bh=Q8le+30L67JnqHzyVz6EUJ3Z7+QstWCPGdsdpO6AnNM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OeN7xKlyeplo9H/yAEkMyy0r5RcdCbR1E1AqUpJQK19MOo9qP1xp80t9yQBd51DFUZpNNacShfEtTMq8W2itVbzgpLwH3qhkACC9T0G5aJ1rjoykqNQ6LoT5hr6F6rjZpNrpKqm2CeufAgCOw/nP0tEj1jmaGmwCH5f6QWTd6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Pq+2ekRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PP8As33C; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAD2C7A01B8;
	Wed, 15 Oct 2025 03:48:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 03:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760514497;
	 x=1760600897; bh=RPb7u4xx/8qqCuf2oUI5wjlc24oyWMuCecmZxoE4X84=; b=
	Pq+2ekRObjZTvtZI7FGIsKHXZ7rTbxjIXIeXLHekKKFmJglgIlgL/G3JVVKS2cPq
	zmt+s1bJVdERsg24Ov8++y87RCvGIhKTAOZx9XPYADKYar/0rqtZCFz1FcV+iTJ9
	SP9byB1UdPGjXxa3PETMNIeVa/7+SdOt2NQxAwAyC2bxJ77mQ+Yc2Xy0xei0mGls
	dVENzhycADwBQCJM9jKH+aDfz+v92TV6GU3d3Ps4Jx8ohdQ3i7erHqSdN/cZy8GC
	8wgf/RxY3/KNBaUdoR1dWyVtPZJioASGLf908ZdxTr/ASl04cAsEuBChfD2D9lif
	HFVwZp7GONk2shTsHYWrpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760514497; x=
	1760600897; bh=RPb7u4xx/8qqCuf2oUI5wjlc24oyWMuCecmZxoE4X84=; b=P
	P8As33CD5/IVeoE5nDPaUB08USXI3sb0M8eLdwrJ/xa666ST4nxkdPU/820fjm9d
	cadcQmKuC+jMNdiNsUSKF3p3Ih5jtqRClvOH2citjgFU8lcqVwdGay75uNeF/T5U
	P0ToLFsESgxZx3udHJVJWqWEKBrvKGYcsa74+ce3csDBcKV2kCvHx5b+gXK2cnJW
	pR4QygXrl8Gw31vrpGS9ap7CHLpga/R56PHTDbD3F85irFCk73HtPNyTekEAVRD+
	4tpym6B56tn0/nz2/PqyoddWhIc5M6rrLTb+oDrdpkqIZ8UiLjusKl19dbUUPZc4
	fd3ZIAntYp3YYLeGI6MZg==
X-ME-Sender: <xms:v1HvaF1eoori7IPYSnFkTHnRFQMj1BjLOOuctp9sLUBli-Ih2bmbSA>
    <xme:v1HvaG6PNGcjuDfQr4mxHFSUC1rzYJbTJw3TsF_tiNNjKlC4i3MwlAy_1OJay-vHO
    680_rJLK_A_ADNBg1OUXcDkanDl1KYndVZBYp6xz2hJRaYAZTvyn_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhope
    iiudeihedvtdejgeegfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgrhhhi
    rhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepihesmhgrshhkrhgrhidrmhgvpdhrtghpthhtoh
    eprhhonhgsohhgohesohhuthhlohhokhdrtghomhdprhgtphhtthhopehlgidvgeesshht
    uhdrhihnuhdrvgguuhdrtghnpdhrtghpthhtohepfhgrlhgtohhnsehtihhnhihlrggsrd
    horhhg
X-ME-Proxy: <xmx:v1HvaHGhZmoNBMd1kYBSezIFtgDlQJhQoeDAmRm8ZjtbdWMODQvFmg>
    <xmx:v1HvaAvDypVvQShhy7wsGqQYcrx8Doz1ApqeFWMsNx-OYB8pNGJ4ug>
    <xmx:v1HvaNl-cI05bZPbO9fJsBJe_h29tuGHTXu4P_SjJF7MfM8VzqJvhA>
    <xmx:v1HvaDMNHvClW8XavlcxP4ut7l3HfEmziXf88sKkVS7ouAlId7m79A>
    <xmx:wVHvaP4mykMyhdrihqGaClJRS0DTgfIa8AZQPYxcPVi1I8sJh8yWF1Io>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8177B700054; Wed, 15 Oct 2025 03:48:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-HrBBL8x6OF
Date: Wed, 15 Oct 2025 09:47:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuan Tan" <tanyuan@tinylab.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-kbuild@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 i@maskray.me, "Zhangjin Wu" <falcon@tinylab.org>, ronbogo@outlook.com,
 z1652074432@gmail.com, lx24@stu.ynu.edu.cn
Message-Id: <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
In-Reply-To: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
References: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
Subject: Re: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with PUSHSECTION and
 conditional KEEP()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025, at 08:16, Yuan Tan wrote:
> Hi all,
>
> This series aims to introduce syscall trimming support based on dead c=
ode
> and data elimination (DCE). This can reduce the final image size, whic=
h is
> particularly useful for embedded devices, while also reducing the atta=
ck
> surface. It might further benefit specialized scenarios such as uniker=
nels
> or LTO builds, and could potentially help shrink the instruction cache
> footprint.
>
> Besides that, this series also introduces a new PUSHSECTION macro. This
> wrapper allows sections created by .pushsection to have a proper refer=
ence
> relationship with their callers, so that --gc-sections can safely work
> without requiring unconditional KEEP() entries in linker scripts.
>
> Since the new syscalltbl.sh infrastructure has been merged, I think it=
=E2=80=99s a
> good time to push this patchsetTODO? forward.
>
> Patch 1=E2=80=933 introduce the infrastructure for TRIM_UNUSED_SYSCALL=
S, mainly
> allowing syscalltbl.sh to decide which syscalls to keep according to
> USED_SYSCALLS.
> Patch 4 enables TRIM_UNUSED_SYSCALLS for the RISC-V architecture. With
> syscalltbl.sh now available, this feature should be applicable to all
> architectures that support LD_DEAD_CODE_DATA_ELIMINATION and use
> syscalltbl.sh, but let=E2=80=99s focus on RISC-V first.
> Patch 5=E2=80=938 address the dependency inversion problem caused by s=
ections
> created with .pushsection that are forcibly retained by KEEP() in link=
er
> scripts.

Thanks a lot for your work on this. I think it is indeed valuable to
be able to optimize kernels with a smaller subset of system calls for
known workloads, and have as much dead code elimination as possible.

However, I continue to think that the added scripting with a known
set of syscall names is fundamentally the wrong approach to get to
this list: This adds complexity to the build process in one of
the areas that is already too complicated, and it duplicates what
we can already do with Kconfig for a subset of the system calls.

I think the way we should configure the set of syscalls instead is
to add more Kconfig symbols guarded by CONFIG_EXPERT that turn
classes of syscalls on or off. You have obviously done the research
to come up with a list of used/unused entry points for one or more
workloads. Can you share those lists?

      Arnd

