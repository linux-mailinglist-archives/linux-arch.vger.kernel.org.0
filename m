Return-Path: <linux-arch+bounces-12772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B92B0510D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 07:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C211AA7C9F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8425BF1C;
	Tue, 15 Jul 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD3WsebZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526D9460;
	Tue, 15 Jul 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557840; cv=none; b=BkjkvlFmc7ipMRdreq/sefIL+nfspa10FQRKJubaWeQN0irHvJFtLGMuhXvx3S68KnzmMQYLqzE+jEud7mGZFcQAKfrRDPQ9SwQzmEuUd8acTAPul035h45Q1tT5BfslTeedT8K6Wr9lrTy6PGmRAvMvtCRdx/HQ57/hCkxk5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557840; c=relaxed/simple;
	bh=6J3hCrPuy++HUhp2ZStrBO9vMI6jCI0BvgNUFtgBHOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2aReAtwNHQlYSU87Y84psucLvrdkSN1qRLdXnddAuZVm28YmtzffoiSKJ6qgj2rjs5bvXnVmgCgHkyPuELj6L4PHfUErH3Pd0FjCFiQ6538zZMPOQj3YfxcVkOUhmqFxdvUmtnJ/tOzwSkca3a1WROOH6WDgwkMtC1DCWTaXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD3WsebZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCD8C4CEE3;
	Tue, 15 Jul 2025 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752557840;
	bh=6J3hCrPuy++HUhp2ZStrBO9vMI6jCI0BvgNUFtgBHOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OD3WsebZ74BNCweLXWK6ZDpiy1GYCnmXu2xh27/ENvLdsLSkrLFQ6mR5l1mP+HUMG
	 MShniYJqNM1s31wMmQw8FxDkHjit4SvfyoI6wUc1GOv+6z5AyvmnmyD6drAojuQ7np
	 fOs0Zsj44GMv/NBf25ahV1vQZSouQi2ASuXroB6TqmINioyqTPuLu3wfF4V0KxSSjK
	 0PR45/X7hWdpadu6p9W0SgtO5vmgSyqWPe258S/Buu2TrZcJGDDU9K/fmM8I4Uoql0
	 Hu69E3heOIAt/PsIe2m0WLAzWWr5PZ0Gr/ihpETockVthBQZ9NoB8xkXw0f93zawy2
	 SFMRROjblWu6w==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Zankel <chris@zankel.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note names
Date: Mon, 14 Jul 2025 22:37:11 -0700
Message-Id: <175255782864.3413694.2008555655056311560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Jul 2025 14:55:53 +0100, Dave Martin wrote:
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

Applied to for-next/execve, thanks!

[01/23] regset: Fix kerneldoc for struct regset_get() in user_regset
        https://git.kernel.org/kees/c/6fd9e1aa0784
[02/23] regset: Add explicit core note name in struct user_regset
        https://git.kernel.org/kees/c/85a7f9cbf8a8
[03/23] binfmt_elf: Dump non-arch notes with strictly matching name and type
        https://git.kernel.org/kees/c/9674a1be4dd5
[04/23] ARC: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/237dc8d79627
[05/23] ARM: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/49b849d11cd1
[06/23] arm64: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/87b0d081dc98
[07/23] csky: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/2c2fb861fc59
[08/23] hexagon: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/55821111b1b3
[09/23] LoongArch: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/1260e3b13584
[10/23] m68k: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/e572168e8d2a
[11/23] MIPS: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/18bd88faa246
[12/23] nios2: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/8368cd0e4636
[13/23] openrisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/10cd957a895f
[14/23] parisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/92acdd819b5d
[15/23] powerpc/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/307035acefbd
[16/23] riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/c9502cc7bef5
[17/23] s390/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/d6a883cb40fc
[18/23] sh: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/afe74eecd88f
[19/23] sparc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/c9d4cb25e94e
[20/23] x86/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/3de0414dec7b
[21/23] um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/40d3a88594b5
[22/23] xtensa: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
        https://git.kernel.org/kees/c/cb32fb722f4b
[23/23] binfmt_elf: Warn on missing or suspicious regset note names
        https://git.kernel.org/kees/c/a55128d392e8

Take care,

-- 
Kees Cook


