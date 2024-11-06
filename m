Return-Path: <linux-arch+bounces-8870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEEA9BDE8E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 07:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E21C23418
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 06:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323C1922D4;
	Wed,  6 Nov 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B6c5g3iJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D11922CB
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873384; cv=none; b=asUu22V4/HHJPCuBu56js01NvKt/MOcGKkqNsKRGpOiqghWfTUVY6URlP/D33Rny7a/ZeO4cQXZ8k53IzVGdQIK/I9ytwjPiXboIDG6ySUTizuuwyWlW9bTNilFiAO4PEvYsIGAuO7COiqdlgkbdzIGS6Orrggl9X8GSKBGSEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873384; c=relaxed/simple;
	bh=x1naZKJ3LLb9WnrFG/vJjvbExX0qGk0ADQSvQmyqo+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elGtye79IyVVKH7J9sy5aA64L6Hn2MKRyiLmhHAN5B39gbgtQW/B7tTTqxDlOTotil2GmtsNX5dT1O5/Vv25PUNrbCwbK6bIOGMUVJ4hZjDWOwK494HXSxhthiJbbUeeiaPKxoX06BsbCrH7cB7tGlSmTPI6s2iHFGj08qfyhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B6c5g3iJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bsu9j53Gd9q0Xq0y/a+uvm1cRNSBjc60mOzyTvRmkVQ=; b=B6c5g3iJki5ElKSRF4qAdWoQvr
	pIYPTPzRem0Z/wlj5nNFgEuLKrg3wYDm+mZdpYdgwZcO3OswDFjhu6GeudjdbaAMWmaopxxIWdqhm
	pQyB7XFGaqQDqhxfTGASpdGn16YFpYaohKytHa5WnqQZ6ZlrQJe0iUb1tWfrX874WSTPZc8AXWdOf
	R0AgP/HcTvH0xn2rou7dBsrh++Dw6uoKyZ+Gv8sxfHxLiKX3JwUXRsML9Ig3Yt5upX8lJngA/0wRh
	saqp/JSD/os1aW5GzPn7Hye6kEBVJ6AZBiApr9N9sE7JGdfXYufCdI9EI5A+T0i9yEX68mIEO2O6J
	CVl7SGrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZEY-0000000BX1V-19Iq;
	Wed, 06 Nov 2024 06:09:38 +0000
Date: Wed, 6 Nov 2024 06:09:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCHES][RFC] cleaning up asm/vga.h situation
Message-ID: <20241106060938.GW1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	asm/vga.h and linux/vt_buffer.h are playing odd games that might
or might not have made sense once upon a time, but currently they are
too convoluted for no good reason.

	vt_buffer.h defines the primitives for access to vt contents -
scr_{read,write,memcpy,memmove,memset}w().  In all cases it's an array of
16bit values - attribute/symbol pairs.	Normally it's just a kmalloc'ed
buffer; there are few exceptions:
	* vgacon.c has the active console contents directly in VRAM;
for such consoles vt.c code will end up accessing that.
	* vgacon.c and mdacon.c use those to access the text-mode screen
image directly in VRAM.

	VRAM is little-endian; for kmalloc'ed buffers the endianness is
up to us - all accesses will be via scr_...  primitives, so in absence
of VGA_CONSOLE and MDA_CONSOLE we can simply keep them host-endian and
turn the accessors into obvious inlines; that's the default.

	The few architectures that might have VGA_CONSOLE or MDA_CONSOLE
may override that.  Overrides are too convoluted - we have 4 macros
(VT_BUF_HAVE_{RW,MEMCPYW,MEMSETW,MEMMOVEW}) asm/vga.h may define to
control what gets overridden.  Situation:
	* alpha: needs separate handling for mem and iomem cases,
overrides everything.
	* arm: fine with defaults.
	* mips: keeps everything little-endian, nothing special needed
for VRAM access.  Overrides everything, replacements for memcpy/memmove
are identical to defaults.
	* powerpc: more than slightly ridiculous - if VGA_CONSOLE or
MDA_CONSOLE is enabled, same as mips, defaults otherwise.  The ridiculous
part is that VGA_CONSOLE is actually impossible to enable there, but
MDA_CONSOLE (that is to say, support of ISA Hercules cards for the second
monitor) *is* possible.  On the boxen with ISA slots, that is...
	* sparc: overrides everything, replacements are all identical to
defaults.  Neither vgacon or mdacon are possible there, so that's fine,
but why bother with overrides in the first place?
	* x86: fine with defaults.

Defaults themselves are also overcomplicated - there's e.g. handling
of the case when we'd overridden read/write, but not memcpy (which
never happens).

	There are several other things in asm/vga.h, in addition
to these overrides.  One is the helpers for byte VRAM accesses -
vga_{read,write}b(), used only by vgacon.c and only to read/modify the
screen font.  Hell knows whether it really needs to be done byte-by-byte;
pointer is always to VRAM.  Incidentally, the loops in there are
just weird - 8192 bytes of iomem read or written one by one, with
cond_resched() after each.  Apparently, qemu with 64 vcpu managed to be
stuck in that for more than a minute...  Another thing is VGA_MAP_MEM()
- finding where VRAM is mapped.  Used by vgacon, mdacon and vga16fb
(the last one - x86-only).

	All of those are provided by asm/vga.h on anything that
might support any of the users, so there's no point keeping them in
asm-generic/vga.h - as the matter of fact, that file can be empty,
which would kill arch/sh/include/asm/vga.h.

	Patch series cleaning that up lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.vt_buffer
Individual patches in followups; please, review.

Shortlog:
Al Viro (4):
      vt_buffer.h: get rid of dead code in default scr_...() instances
      asm/vga.h: don't bother with scr_mem{cpy,move}v() unless we need to
      sparc: get rid of asm/vga.h
      empty include/asm-generic/vga.h

Diffstat:
 arch/mips/include/asm/vga.h    |  4 ---
 arch/powerpc/include/asm/vga.h |  5 ----
 arch/sh/include/asm/vga.h      |  7 -----
 arch/sparc/include/asm/vga.h   | 60 ------------------------------------------
 include/asm-generic/vga.h      | 23 +---------------
 include/linux/vt_buffer.h      | 24 -----------------
 6 files changed, 1 insertion(+), 122 deletions(-)
 delete mode 100644 arch/sh/include/asm/vga.h
 delete mode 100644 arch/sparc/include/asm/vga.h

