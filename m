Return-Path: <linux-arch+bounces-15474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A15CC5094
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C273008EEE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD930C605;
	Tue, 16 Dec 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wRGHMtmb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0B2EC557;
	Tue, 16 Dec 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914587; cv=none; b=A/M8GZffg0EbAjvlSESAlqBSlqHWyRxQQEA1htrAQ4DD6NArqnxChrcWpJEUyTJ65M5v3yWZHpEGShB91/YeFTP00UFvxCgZEzKOaGOwOE03pTu+Ttqp/UYEXLut5M2ebg7DqvA1/H96fzuQ8ooYI0tgZmW+jvtZOSQjaG2t/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914587; c=relaxed/simple;
	bh=3FmpwD62IJUHDHR/I5ZYeJX9OsU87aYBt8XiqHww6dc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nqAcJLd/XnQ8Vi1gP02lw1o1DvYKWMo3M6F6VSbiFq+7hFxxo4EoigQ14LmIzpXWC/nHjIPASbeOztEXx3BOOEjlj06rYvD2s3VbIRZOCSDepKgI3F2+WGTgdrObmqj5dZArVGTj6WNGoru243Ab5J5e2ws7aWaWYc9rNekIHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wRGHMtmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B246DC4CEF1;
	Tue, 16 Dec 2025 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1765914586;
	bh=3FmpwD62IJUHDHR/I5ZYeJX9OsU87aYBt8XiqHww6dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wRGHMtmbERcpA6VCd7VdIJSxWeMMV3MufiaICwJM2JxmUckd4/ZDamGIp98xLnU7Z
	 uebteatGutNpSVaCbIbB+LV6ZmqtugE23SVf1F34zvnJxpCPzgUWlQUA1tUgyCpZP6
	 5X1mflTa7f2NerKLz8PKwSVTiVXS5dHxJMQ76kh8=
Date: Tue, 16 Dec 2025 11:49:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexei
 Starovoitov <ast@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 bpf@vger.kernel.org, Rich Felker <dalias@libc.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Gary Guo <gary@garyguo.net>, Geert Uytterhoeven
 <geert@linux-m68k.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Guo Ren <guoren@kernel.org>, Hao Luo
 <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>, Jonas Bonn <jonas@southpole.se>, KP Singh
 <kpsingh@kernel.org>, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Stafford
 Horne <shorne@gmail.com>, Song Liu <song@kernel.org>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Yonghong Song
 <yonghong.song@linux.dev>, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v5 0/4] Align atomic storage
Message-Id: <20251216114945.df117ce1f176dd7752244cfb@linux-foundation.org>
In-Reply-To: <cover.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 17:31:05 +1100 Finn Thain <fthain@linux-m68k.org> wrote:

> This series adds the __aligned attribute to atomic_t and atomic64_t
> definitions in include/linux and include/asm-generic (respectively)
> to get natural alignment of both types on csky, m68k, microblaze,
> nios2, openrisc and sh.
> 
> This series also adds Kconfig options to enable a new run-time warning
> to help reveal misaligned atomic accesses on platforms which don't
> trap that.
> 
> The performance impact is expected to vary across platforms and workloads.
> The measurements I made on m68k show that some workloads run faster and
> others slower.

Looks nice, thanks.

I don't know which tree this is aimed at.  I grabbed a copy for
mm.git's mm-nonmm-unstable tree, can drop it again if this pops up in
linux-next via another route.

