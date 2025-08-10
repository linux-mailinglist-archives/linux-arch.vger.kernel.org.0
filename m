Return-Path: <linux-arch+bounces-13101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FAB1FC45
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 23:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2F1887BF3
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012527C854;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRWX9qby"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED827BF7E;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860351; cv=none; b=aYhCmA1wcMmdwi4LMrSPG+ppKTdybylLhkYs4Jb7QOLy8yD5XWGE62tfWDuN4YZ6SGUk11tr8esAdxNyKMxPW6A2cmfqD0s3rScas9vvbBpAxJXSk9D/IiMyp8zBnHrNveWJBznjFcxs4bGf3DaDtABWeLU4uPIFmMAdUIukylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860351; c=relaxed/simple;
	bh=+EPDIqigYF0dLwDVKm4n7P07Soa8UCdwgsSbIhQglhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oyUgp3qRB2j4IMdggGxG2kfr9C3Dp9FbXnN2SAJV4dQgskndKgIrP57GITai/O90fWuVpif9A9ruVSCtGy7JSHrqy4KYKpSVlfz1Naco4FfKvprxsZz4qCP/YZ/fCzlEvmBjjzjAC6lyNFc1oJ437rv4W/K3oZIPDFW8mzvZuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRWX9qby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2A6C4CEF1;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860351;
	bh=+EPDIqigYF0dLwDVKm4n7P07Soa8UCdwgsSbIhQglhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PRWX9qbyv9u6FbnKrFjePyfsaZ737MOhr4mO7TsZ7R+GzU8zlYvZAYf8JD/OXtEUT
	 hA9ZGe4MgMB70B1Zw0njMIw4A2/fhOmu8/xlsiHxmIUZJvNyZW6a8uiunB9JTjc62k
	 WQvCcnsGvL3edUrU5mU3msfwtOhFXOborJRekZFipn3fdTQKLp1K+FdaZrtWvHMoCG
	 BjGMfqHcgkkIzLtrpEo6cyj4t26pG93hr2845rzETZe270MpglUmq+wxcG1OLi+DB/
	 81Kg/BR1SiRTfzYt5r1OrTvGUw8lrqFdyiU9Eqy8LtRG2Wu0knKnUQq5VbApAR7XFV
	 wpBAVMLGZQIKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB739D0C2B;
	Sun, 10 Aug 2025 21:12:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note
 names
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486036374.1221929.319441619761028585.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:43 +0000
References: <20250701135616.29630-1-Dave.Martin@arm.com>
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, hpa@zytor.com, James.Bottomley@HansenPartnership.com,
 akihiko.odaki@daynix.com, aou@eecs.berkeley.edu, agordeev@linux.ibm.com,
 alex@ghiti.fr, andreas@gaisler.com, anton.ivanov@cambridgegreys.com,
 bp@alien8.de, bcain@kernel.org, catalin.marinas@arm.com, chris@zankel.net,
 borntraeger@linux.ibm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, dinguyen@kernel.org, geert@linux-m68k.org,
 guoren@kernel.org, hca@linux.ibm.com, deller@gmx.de, chenhuacai@kernel.org,
 mingo@redhat.com, johannes@sipsolutions.net, glaubitz@physik.fu-berlin.de,
 jonas@southpole.se, kees@kernel.org, maddy@linux.ibm.com, jcmvbkbc@gmail.com,
 mpe@ellerman.id.au, npiggin@gmail.com, oleg@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, dalias@libc.org, richard@nod.at,
 linux@armlinux.org.uk, shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
 svens@linux.ibm.com, tsbogend@alpha.franken.de, tglx@linutronix.de,
 gor@linux.ibm.com, vgupta@kernel.org, kernel@xen0n.name, will@kernel.org,
 ysato@users.sourceforge.jp, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Tue,  1 Jul 2025 14:55:53 +0100 you wrote:
> This series aims to clean up an aspect of coredump generation:
> 
> ELF coredumps contain a set of notes describing the state of machine
> registers and other information about the dumped process.
> 
> Notes are identified by a numeric identifier n_type and a "name"
> string, although this terminology is somewhat misleading.  Officially,
> the "name" of a note is really an "originator" or namespace identifier
> that indicates how to interpret n_type [1], although in practice it is
> often used more loosely.
> 
> [...]

Here is the summary with links:
  - [16/23] riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
    https://git.kernel.org/riscv/c/c9502cc7bef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



