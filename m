Return-Path: <linux-arch+bounces-2931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C243D878929
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 20:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF15B215E2
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060EF56473;
	Mon, 11 Mar 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga4H7MB+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B054F95;
	Mon, 11 Mar 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187116; cv=none; b=fLSpYwdj/WQusaKWQB/JT0czjoqa80F6iJy7iheGBPXtOTHsp8PHLa+XpUnOJH7M6/HGyTRhx6E+J/o6PJ5ZFZrWYfAmquNlfDB9pkvyNYWurNe+vD3EJzpX/wmgqPUfBQLO82aem3vbqPr5GIvTdv3b4X5Hwxbr0O3WqyD0Fz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187116; c=relaxed/simple;
	bh=ssNflA7VlumiRNbQACID7MitO221/D8PNzUcKbsa064=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYg0LoFrXRxkF7Vuq/T270Z52crJxSNj8Ik0gRidkSQPCWt+WGF31U8Mdg7sIFjKqqNof2lt1zY4TNCFm8/rNtIAPrIhj2tYJsvA6c0ngH/H5tZI8kXcWvRb+9VBqVSoriLOs1HG8X05mNChHx5Ju72jdeeMLLGvk/06hoyekRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga4H7MB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4714C433C7;
	Mon, 11 Mar 2024 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187116;
	bh=ssNflA7VlumiRNbQACID7MitO221/D8PNzUcKbsa064=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ga4H7MB+n/UszT8fQQAyc+ZafKIC/IoT6PXlcO0UCBq+eoH1GEx/oe+cfs1WzM6E9
	 7K1BfFeslSgIgq+An2+bRA5NGTjQKD6ZQ/35nUX7WLO6/RPlWpltiwgpApdKgojNzN
	 uuhd/WghRDZC6KRkaajxhi08GN82/2o+tXriQTHiASR22+uFQB6FF6pn6odXas/cli
	 AIMcBBvCG8omT6PVIcLfdRKpmjjIRCtQ9vxnBaFxs/QmBNTQjYCq+Ny5NOopW57PhH
	 165aUX0uYO/MZqnp8tvTXi5BZurCChOZXOknCyHEWc6QxvvUwycAdIIEKxlPWZSIU7
	 yws3clDWr5pMQ==
Date: Mon, 11 Mar 2024 16:58:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Shunsuke Mie <mie@igel.co.jp>, Yafang Shao <laoar.shao@gmail.com>,
	Kui-Feng Lee <kuifeng@meta.com>,
	Nick Forrington <nick.forrington@arm.com>,
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>,
	Rob Herring <robh@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>,
	Vishal Annapurve <vannapurve@google.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 12/13] tools headers: Sync compiler.h headers
Message-ID: <Ze9iaape_1Du4oAa@x1>
References: <20240310020509.647319-1-irogers@google.com>
 <20240310020509.647319-13-irogers@google.com>
 <1ab20914-b6d2-fe39-7b14-c1ccebaa34f6@arm.com>
 <CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com>

On Mon, Mar 11, 2024 at 12:24:24PM -0700, Ian Rogers wrote:
> 5) headers we have just so we can use shell scripts to scrape
> constants for beautifying things in perf trace

> (5) feels like the headers should be alongside the shell scripts to
> avoid polluting tools/include.
> Not that I propose fixing any of this here.

Yeah, 5 is why we have things used just for scrapping in
tools/perf/trace/beauty/include/, that now has just socket.h, used by

⬢[acme@toolbox perf-tools-next]$ tools/perf/trace/beauty/socket.sh | head
static const char *socket_ipproto[] = {
	[0] = "IP",
	[1] = "ICMP",
	[2] = "IGMP",
	[4] = "IPIP",
	[6] = "TCP",
	[8] = "EGP",
	[12] = "PUP",
	[17] = "UDP",
	[22] = "IDP",
⬢[acme@toolbox perf-tools-next]$

I'll see if I get a series moving things that are just for scrapping to
that directory, then test on the container build images I have.

- Arnaldo

