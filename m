Return-Path: <linux-arch+bounces-3729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651298A6E97
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3491F21206
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81612DDBD;
	Tue, 16 Apr 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mizTO6zH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12612C7E1;
	Tue, 16 Apr 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278428; cv=none; b=q/r0lJWPa2sZmojctEvePQrfxcSxuPeFCdYw/iWYLPhVwraNwRGyqwq+pKihp7EgvbNYRy14R06U/lGyMcHaxZilXJW9emypkRn2B6sKjozFR4i1fQVGo+ck1qx4mKNv1W7b6oDwAkbBozUkPsp+ke4d3sYIDBEt0zFCACwyEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278428; c=relaxed/simple;
	bh=ulix9quus3PlYbJVuwvHVIOelWLtNPYkNwdfm+1e6eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H09SLdq6RSSqykwvwcshy8PwtKqXqOIMtwKjG/SErt95JFl+l5093fCiGBvQUVW16gSStqKnjpVHTSZ4PR6aM2iyke6sePVZBUQf4WbIRXUNZQvwvbztltV8+FJVNPY5rs8nrTGfEUzqn0o49jhbWnGZA6rGHkB0ZuvVhHfwBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mizTO6zH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DEEEC2BD10;
	Tue, 16 Apr 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278427;
	bh=ulix9quus3PlYbJVuwvHVIOelWLtNPYkNwdfm+1e6eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mizTO6zHQsmhhoJXPvj7Bd6z6SPnKSeEeEX1PNLVcS2zL7EWaQJl9v1W/RV70RYXL
	 rQHmcie6fJHXC1AaGvx3pZ2GthYw8agK9VgZoj43fXbvDnxG9CLrb7nyvmdLKCnkkV
	 IJCkust3+LFhAwgsXg1SkA0zbGV1lt54TCAGUUu6L6OZZGHBi1UYfvPQfiQ2v/yrfF
	 /MGgpvv7ahlKkdGp4IfXxAQw2Gg/AEjXrD1wN9NqkjOPlxi6r+xp0+oj1z71jwCjgq
	 GT6fhUwqUzzb3h3saCJAAUs55eNYm/ndolg2LdBOiel95QXFmDG2jy9IUCEPx1bKf6
	 eoS8J4Zh0arBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67E56D4F15E;
	Tue, 16 Apr 2024 14:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 14:40:27 +0000
References: <20240415162041.2491523-5-ardb+git@google.com>
In-Reply-To: <20240415162041.2491523-5-ardb+git@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org, masahiroy@kernel.org,
 arnd@arndb.de, martin.lau@linux.dev, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 olsajiri@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Weak external linkage is intended for cases where a symbol reference
> can remain unsatisfied in the final link. Taking the address of such a
> symbol should yield NULL if the reference was not satisfied.
> 
> Given that ordinary RIP or PC relative references cannot produce NULL,
> some kind of indirection is always needed in such cases, and in position
> independent code, this results in a GOT entry. In ordinary code, it is
> arch specific but amounts to the same thing.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
    (no matching commit)
  - [v4,2/3] vmlinux: Avoid weak reference to notes section
    (no matching commit)
  - [v4,3/3] btf: Avoid weak external references
    https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



