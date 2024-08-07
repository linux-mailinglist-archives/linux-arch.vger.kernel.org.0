Return-Path: <linux-arch+bounces-6100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D1294A161
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 09:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB23B1C225C1
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0CC1C5797;
	Wed,  7 Aug 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="it1nFqAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mVYRJZ6i"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823B1C461B;
	Wed,  7 Aug 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014684; cv=none; b=eCJSTUuqeuMWd4ujphrzKbqB81+6yAZB244qpa/GFKJYXSRPOOR3rqX+WR8QlqVhblKki/vyAAVzOz/cTylW8a4qhWIfk1U0WbpjUAut4vUykSQH1knOdEIrfvOZWACR0zuN1UFV62N30qbqPj3RdhRUDiSzK2aMfssc4L9smho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014684; c=relaxed/simple;
	bh=F862vX5qpUUBsn/1LPZYBnpMJbnc8WAT8B8S0EloY3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MTWUryIavJ3W4rHy6Bkv5fs9ZwlKjsuzATrTGgne7In45SJSp76oJawtWXSXIlWC1wBXZRlOowO1lyCeutusTxuoFj5VX8mMUf3tlJQL9QO8buTK+Z+n1DKu84cfEnavL4HnTJViI8aODApp08i1kbyMBk4GzRz4v7vnLSCjBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=it1nFqAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mVYRJZ6i; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DFB8A1151B3F;
	Wed,  7 Aug 2024 03:11:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 03:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723014681;
	 x=1723101081; bh=NQ27EvoTcQ5YltamaUJRabj60y3nedLTPu/Abkp62H0=; b=
	it1nFqABeTOcFXrQUyjzky+30FkIudmtY5PKvHZozq75eI9hhOxhTKE6zavrYJre
	wsdJPK4sFjxCxozyxrypZ57h6N+Nqe10c2k0qiYFUDp511iXVHhqYmalK5DPDfcC
	Zht8NPj1eUZG2c1nHrDpRVFD1H2mpm14lIA6F8SWxyRJNSpZxDr+Lp6ND4aqeFlN
	iZ+2uUGggbS5nii9PTGc6nCaF2mc0sjOZYIOgVGCr6b9jVN6aXB9M8sgYpxsxuul
	ZtKRcoO/kN2DQE+iBHtBGdJuinx1cPHmYmUthlRjGMTEWMD12OJ06EM+FKxvrxdt
	oPVecP/YsebbZ7hybFg/tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723014681; x=
	1723101081; bh=NQ27EvoTcQ5YltamaUJRabj60y3nedLTPu/Abkp62H0=; b=m
	VYRJZ6iD0M/JhJMAeJ4vu/R7Xx3GFkFrr0KPh9r9u2vZ5+Sj9AHNqgMZrPy75NVz
	LlCq3BlhM+D0BzKYv+RPGCAJuyt8nLb3Eqwc12nP07OgxljalkiiR3XbfXq7Yy6Y
	oQX5gJ2g6LY0EPN2OYdF7bb6kq9UcnsZYkVZ4oOKx9MlZOBWPfQcJWOlZsKyxNiI
	MReK2xv4g+bVF2u1o71C1VhtIDbcesxhtFG50xXuOSO2oG916M+sAfZ4zBevj7Fo
	MPh9wir1f4Yz5YpB7gYPgbwU8TTf8ALoYnphvmEA4mZFXyZUP0yo/W22JG942dhG
	G/jAiVUalQvG6sQhlVMHw==
X-ME-Sender: <xms:GR6zZkyRm_YK3jHBm9XKVrtPEB7AGXL5pL-uZOpr1vJ7Lc0SM_eKMQ>
    <xme:GR6zZoRBzeZYbFYXEIVtN3pxg-onLg_fvsaAFeD6fOQTJi_qxAyzgtagg64JHlcEF
    WOmT-kQX5Keg-UrZlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:GR6zZmXVUYM7gaYMvxD0rdGaTwWNw4ykCZtWvSbs4MOJ80xOcAq5xg>
    <xmx:GR6zZigGkAPsM-FvMCcuB02_Ap0CYxkCJdQOD0hHdN4XwRUTSfnwFA>
    <xmx:GR6zZmBT_oJKWD01D5WbIGKuQns9ilqFNAAPajTXZHmH1XD9Asw_1Q>
    <xmx:GR6zZjJcmOLkQYZxmV9fnCAGAT3qmjCsZJhfzenwWpgq3BFdfjOBuw>
    <xmx:GR6zZq59IJfuUu0tPvoQGA3c0YYPkQuadY1w1g_MzJBudxlrOPZMb6UO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 93552B6008D; Wed,  7 Aug 2024 03:11:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 09:11:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Namhyung Kim" <namhyung@kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: "Ian Rogers" <irogers@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <10a643ba-cafe-411e-855e-d93d8144f470@app.fastmail.com>
In-Reply-To: <20240806225013.126130-7-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
 <20240806225013.126130-7-namhyung@kernel.org>
Subject: Re: [PATCH 06/10] tools/include: Sync uapi/asm-generic/unistd.h with the
 kernel sources
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 00:50, Namhyung Kim wrote:
> And arch syscall tables to pick up changes from:
>
>   b1e31c134a8a powerpc: restore some missing spu syscalls
>   d3882564a77c syscalls: fix compat_sys_io_pgetevents_time64 usage
>   54233a425403 uretprobe: change syscall number, again
>   63ded110979b uprobe: Change uretprobe syscall scope and number
>   9142be9e6443 x86/syscall: Mark exit[_group] syscall handlers __noreturn
>   9aae1baa1c5d x86, arm: Add missing license tag to syscall tables files
>   5c28424e9a34 syscalls: Fix to add sys_uretprobe to syscall.tbl
>   190fec72df4a uprobe: Wire up uretprobe system call
>
> This should be used to beautify syscall arguments and it addresses
> these tools/perf build warnings:
>
>   Warning: Kernel ABI header differences:
>   diff -u tools/arch/arm64/include/uapi/asm/unistd.h 
> arch/arm64/include/uapi/asm/unistd.h
>   diff -u tools/include/uapi/asm-generic/unistd.h 
> include/uapi/asm-generic/unistd.h
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl 
> arch/x86/entry/syscalls/syscall_64.tbl
>   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl 
> arch/powerpc/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl 
> arch/s390/kernel/syscalls/syscall.tbl
>
> Please see tools/include/uapi/README for details (it's in the first patch
> of this series).
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
>  tools/include/uapi/asm-generic/unistd.h       |  2 +-
>  .../arch/powerpc/entry/syscalls/syscall.tbl   |  6 ++++-
>  .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |  8 ++++---
>  5 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h 
> b/tools/arch/arm64/include/uapi/asm/unistd.h
> index 9306726337fe..df36f23876e8 100644
> --- a/tools/arch/arm64/include/uapi/asm/unistd.h
> +++ b/tools/arch/arm64/include/uapi/asm/unistd.h
> -
> -#define __ARCH_WANT_RENAMEAT
> -#define __ARCH_WANT_NEW_STAT
> -#define __ARCH_WANT_SET_GET_RLIMIT
> -#define __ARCH_WANT_TIME32_SYSCALLS
> -#define __ARCH_WANT_MEMFD_SECRET
> -
> -#include <asm-generic/unistd.h>
> +#include <asm/unistd_64.h>

This part won't work by itself, since you don't pick up
the generated asm/unistd_64.h header but keep the old
asm-generic/unistd.h header. Both have the same contents,
so the easy way to do this is to just keep the existing
version of the arm64 header for 6.11 and add a script to
generate it in 6.12 the way we do for x86, using an
architecture-independent script.

> @@ -68,7 +69,7 @@
>  57	common	fork			sys_fork
>  58	common	vfork			sys_vfork
>  59	64	execve			sys_execve
> -60	common	exit			sys_exit
> +60	common	exit			sys_exit			-			noreturn
>  61	common	wait4			sys_wait4
>  62	common	kill			sys_kill
>  63	common	uname			sys_newuname

Have you checked if this works correctly with the
existing tools/perf/arch/x86/entry/syscalls/syscalltbl.sh?

Since not just table file contents but also the file format
changed here, there is a good chance that the output
is no longer what we need.

Unfortunately, the format on x86 is now incompatible with
the one on s390. I have a patch to change s390 in the future
so we can use a single script for all of them.

      Arnd

