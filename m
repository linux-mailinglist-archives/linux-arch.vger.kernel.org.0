Return-Path: <linux-arch+bounces-11772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C327AA6112
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88340179CA9
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508C204C00;
	Thu,  1 May 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="cBpesFUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kDYazz0g"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED861BF37;
	Thu,  1 May 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115152; cv=none; b=hPKrMBNB/GYNwxOyBrlkRJ0pBh6JKOhXtP2adfW0KQfQK0/UDMtjliRcqUYbhfav23Xr0ahiA+Oa/4Tb6MUdTXeZ32X7zM3OlUCkirhnTXx1qPCiADKqbaDVsCcSG6X/4xMTA9h48XyryO0UGbpXAZY3+v13DdPQfMDkb9e50UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115152; c=relaxed/simple;
	bh=VLD7XIoD5ReEFcrucrl4apHEsDnocbY1koqmkGjrqzI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZGfC5uQyBfLbpb36r2E8QYglNNgidc69odi4z0TA5yMUf94nWFxiXN4IdvHlMUrkCw1gVfkiQAPnb16VvhHX0rGMb13XqQRGDtE759IZxDo2jRuPuMPvsaE+JOnxJj+WY/qIGBhqOgQU/cYQgHhiF4AT9jqzPOR0egoh5uDBai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=cBpesFUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kDYazz0g; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B80D1140211;
	Thu,  1 May 2025 11:59:08 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 01 May 2025 11:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746115148;
	 x=1746201548; bh=P86Ohs1P8SRKraqsep0iM5Yj8o6Xx1WvCw4YHG9svg8=; b=
	cBpesFUxaz35VLgm3m1KLq26nTfeI0q1EHxsP2VlI3m8DHgIN1iZTI8uAlI6Ay6g
	FCXFhK/+FxI0xChhVi6/5gmlD6C0yfBUjxM00GOw6O39Q/27dSwLx9vYNsjj9bld
	SyN6nnxb9yb0J6qqGHDIQ2hJeeKzopyNKz8cLoC1NkV8cIWRBDLNidO6xEKa0Bpj
	R5EIIa3CaRCkKdi0/UsW9EXwSDOnRJ9+FgDn8OEFxQ5iMBKZHQ/Q/z8jEKmTQjuB
	ICS2D6n1wLlj2REqwHAjY6FDi7QrvKzNTf0iJPRDpY2xosJ+RZVdpun1jUpp8wWC
	J8f8oflTiYGSkk0dTmbVIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746115148; x=
	1746201548; bh=P86Ohs1P8SRKraqsep0iM5Yj8o6Xx1WvCw4YHG9svg8=; b=k
	DYazz0g6aKRC/z8NfoPGU+KkdcC62v8J0u+xl6oTsY24t1Rsw+8E/IYhKcC5wJnO
	Cji5EXYwamcTlYQI55jx2FKTgZD/YrfrRLqAr3lMjKjxsBAmLSEORM1bksvP29IM
	BL/RRSTsp3eUHVjpMH3ZzAaCSmMHPR+RjNyNNwYNzvD9PVwrsCRvOF8iN+n5Exe4
	WmGhUEH0Ns1Kc4Gb83rQqbWEUUYI8PcfDuP8Nh7XZ6LqxxK152jQf9+/H9FYQy/0
	vCXFtp0/0N8YkdI13fp7gV+ErhyxgdTtOCMOM7bAlQ79vIT34eIDscSwyvCCIykD
	Ssx+IXL6mon3wvGTBiOpQ==
X-ME-Sender: <xms:S5oTaInsvDTIj9-N1IsiVcsYDWfVTa4aDt7LeNcoM3yJGB1OMok-rA>
    <xme:S5oTaH3oNVWRY_wg_K1dhi84O1Ej7BkeH6GaNt0rJTMW1yTA4h73SQrSNlwHNPb-r
    cDuwni6DJNiSUSZoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffv
    vefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoe
    gugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeegleeifffhudduueek
    hfeifefgffegudelveejfeffueekgfdtledvvdeffeeiudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhn
    sggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrnh
    gusegrrhhnuggsrdguvgdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgt
    phhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvgguugihiiekje
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhm
    rghilhdrtghomhdprhgtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheplhhm
    sgesihhsohhvrghlvghnthdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:S5oTaGqjcGfV9TrE7Kfky634s-JRoD6U6GoZpxcRb3ztJhj0dY89RQ>
    <xmx:S5oTaEk8YhSeiDXcB1J2g0mhPoRjbK5vKjNsPXfzI7WOopDBbVZbHg>
    <xmx:S5oTaG0FjQ16RRYs3xXu4uaYRht9-jYl9ferVGnyxrB32NcWcduBYQ>
    <xmx:S5oTaLvZTX-3klhyGctryRehyXRO2A3wxJvNmVIJBp18WavEzcBKlA>
    <xmx:TJoTaMuFENA3JfsvHkLNs8Gyi5He84zRZcEAHwzpet835-v-VST1daqA>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54FA918A006B; Thu,  1 May 2025 11:59:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7116480ff90ddb52
Date: Thu, 01 May 2025 08:58:46 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Lorenz Bauer" <lmb@isovalent.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 "Shuah Khan" <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, linux-kselftest@vger.kernel.org
Message-Id: <ec03896b-feac-4fa5-a213-7e9f57e15f72@app.fastmail.com>
In-Reply-To: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
Subject: Re: [PATCH bpf-next 0/2] Allow mmap of /sys/kernel/btf/vmlinux
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 1, 2025, at 7:28 AM, Lorenz Bauer wrote:
> I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
> With some upcoming changes the library is sitting at 5MiB for a parse.
> Most of that memory is simply copying the BTF blob into user space.
> By allowing vmlinux BTF to be mmapped read-only into user space I can
> cut memory usage by about 75%.

Cool! Maybe teach libbpf to use this as well? So everyone else can pick up
the win transparently.

>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
> Lorenz Bauer (2):
>       btf: allow mmap of vmlinux btf
>       selftests: bpf: add a test for mmapable vmlinux BTF
>
>  include/asm-generic/vmlinux.lds.h                  |  3 +-
>  kernel/bpf/sysfs_btf.c                             | 25 ++++++-
>  tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 3 deletions(-)
> ---
> base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
> change-id: 20250501-vmlinux-mmap-2ec5563c3ef1
>
> Best regards,
> -- 
> Lorenz Bauer <lmb@isovalent.com>

