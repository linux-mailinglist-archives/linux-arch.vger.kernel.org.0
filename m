Return-Path: <linux-arch+bounces-9231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CCB9DF9C4
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 05:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FD0B2109B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 04:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976317C64;
	Mon,  2 Dec 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="me4qs2Io"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51DEC4
	for <linux-arch@vger.kernel.org>; Mon,  2 Dec 2024 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112132; cv=none; b=MlOs/Vr8QXhpytAgzxf2XbVfRTy2mpQd5QzEsCxWGo7nUVRumz/QWvza1MhKGSxcvwm7aXGGIIhGl87KtZ4k0AuX5TlN8+XemzS5wDdwxHIuzxHKddfCkuC8/h4GVTtu8/bxHndFjhTN0QgRNpbealYfiGSB4TUv8911E9Oxjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112132; c=relaxed/simple;
	bh=7q4T5rMTe/3oQZqZ1grTJosxaKA0lS2U96sbyl0vYis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UftzJNrsHkpgfLEAt0ZYcYdoGgo8/UIXydYUOfmBJg0ZV8lwLlZKGEwGXlTqiooVq7PSegBmvthE/UMEPAiNU2jgkCevoirHFPZoEosQ2tJOhC/WTPdjC4kiLjwExlidPNOC2ZI32PzV+fEdhVDw3EH78rJcOteP8sDytpsN/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=me4qs2Io; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kSBA41bLW1pXuf4Jh6JCVL9ds/D2xXd3FUNQRvbkAOA=; b=me4qs2IoxZNroC/pYgOf4eQRbf
	XtKQP1cfY/18tEQvHsAaXn2p4j4ijh5DDLPqXixeHBN9+o9sWEXOS8EgjSzla4zvlrjGt/dplHlK6
	YMPkPCYGuRwCPBkWrcCQXwyGxIZp+aDw89QAdHFrfznyaf1CI4nlAvYGvfH31jLTFlkTJ3MOAgnZt
	iSuS59jkVw4pwawotURKXz1DCiTkQaN7Hn2NTnyYaL38MOZUZmS8yF08g9ZUc+wY4Z3jLqVXKq8Hh
	mKEZHdbSKzMCtfdIKVemdbW0Blr4XD8+IBz6Oep/S60rXfe+SmaZ5uP7GFB4wZ8wibxnFPZPi/RSq
	BhpkB5Tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHxdP-00000003unS-3LmC;
	Mon, 02 Dec 2024 04:02:07 +0000
Date: Mon, 2 Dec 2024 04:02:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCHES] untangling asm/param.h
Message-ID: <20241202040207.GM3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently the kernel-side include of asm/param.h is handled in four
different ways, depending upon the architecture:
    
1) alpha:
asm/param.h resolves to arch/alpha/include/asm/param.h, which
	* pulls uapi/asm/param.h (resolves to arch/alpha/include/uapi/asm/param.h)
		* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
	* undefines HZ
	* redefines HZ to CONFIG_HZ
	* defines USER_HZ to 1024, which is what uapi/asm/param.h had for HZ
	* defines CLOCKS_PER_SEC to USER_HZ
    
2) arc, arm, csky, microblaze, nios2, parisc, powerpc, riscv, s390, sh, x86:
asm/param.h resolves to (generated) arch/$ARCH/include/uapi/asm/param.h, which
	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
			* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
		* undefines HZ
		* redefines HZ to CONFIG_HZ
		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
		* defines CLOCKS_PER_SEC to USER_HZ
    
3) arm64, hexagon, m68k, mips, openrisc, sparc:
asm/param.h resolves to arch/$ARCH/include/uapi/asm/param.h, which
	* defines EXEC_PAGESIZE
	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
			* which defines HZ, NOGROUP and MAXHOSTNAMELEN
		* undefines HZ
		* redefines HZ to CONFIG_HZ
		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
		* defines CLOCKS_PER_SEC to USER_HZ

4) loongarch, um, xtensa:
asm/param.h resolves to (generated) arch/$ARCH/include/asm/param.h, which
	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
			* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
		* undefines HZ
		* redefines HZ to CONFIG_HZ
		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
		* defines CLOCKS_PER_SEC to USER_HZ

There is an additional complication for userland side of xtensa - it has
a private copy of include/uapi/asm-generic/param.h, with extra definition
(NGROUPS) stuck in it.

Once upon a time we used to have NGROUPS in all asm/param.h (all with the
same value); in 2004 that got removed, along with the limit on number
of supplementary groups.  Unfortunately, xtensa port got started out
of tree before the purge and hadn't been merged into mainline until
2005, and several years down the road that was enough to escape the
consolidation of asm/param.h.

The difference between alpha and the rest of architectures is that on
alpha the userland HZ is not 100 but 1024.  That wouldn't be a big deal,
but kernel-side we want the userland definition seen as USER_HZ, with
HZ itself redefined as CONFIG_HZ.  Since nothing in the macro body gets
expanded at #define time, there's no way to preserve the value HZ had
been defined to - not after we redefine it.

This series massages the things to simpler and more uniform shape.
By the end of it,
	* all arch/*/include/uapi/asm/param.h are either generated includes
of <asm-generic/param.h> or a #define or two followed by such include.
	* no arch/*/include/asm/param.h anywhere, generated or not.
	* include <asm/param.h> resolves to arch/*/include/uapi/asm/param.h
of the architecture in question (or that of host in case of uml).
	* include/asm-generic/param.h pulls uapi/asm-generic/param.h and
deals with USER_HZ, CLOCKS_PER_SEC and with HZ redefinition after that.

Branch lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #headers.param
individual patches in followups.  Review and testing would be welcome...

