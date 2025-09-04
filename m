Return-Path: <linux-arch+bounces-13379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD30B43CE6
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F10188DD20
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76591C1AAA;
	Thu,  4 Sep 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VpnvOczL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CoPrQf+L"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48F1AA7A6;
	Thu,  4 Sep 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991920; cv=none; b=k9H/nIsubxnghZtF2Ecq9LtHx/RuE0n2M9xWp3Jk6CkD10cXOGnjZz14cncF78/8TRBRCrLll5X9MDukiLG61n0tA7mj/QBDUSTJk9rcVUTOACs8wFjeTS4qgVQm/LihRIYbqQiP1216RFbGjpaC3XaRgLiTifdLQut5t871sCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991920; c=relaxed/simple;
	bh=Xbsr3mMaL9NCZ3jddPXvCK0BHPT4UJ86jyDK9FcPFZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rdRKw4XUQqyZbGk8sEvi6It+S/8ADaiWofG2XtSaZJ2TBmwd4RkkpfKNRSHv62LweIisZ6pF4fOFgmaOnZ2l4SJCX6iyQqLVK/BSnMoac3C1O6ddkhe4HZ9d4/7wmu9MJRkbaiCB+pGbDn/O6BLohRlo0zF5GPvdunbjzGNVd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VpnvOczL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CoPrQf+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 15:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756991917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gzlN8F33jc5mv1D5YUXNt8JDHCEp4+wRIW4ePyrbL50=;
	b=VpnvOczLfVbbqODlZMbXhaQVt/6ilYtkg01NC7JF8K25ek4wSwP1YBy2XJXSqC3K7pazLG
	eB84uIYIVyAzzVvd7DKBNOIIaPtkaFau1wsV+F+PEvs5txRLyy6PCnbQ3SS8ymONx/GKxm
	/tLMQkBaa/Nf06T4iHbSI7Zm+OFtEnurS0hkrYeyCWcLhRWjYsf1B6ojb4zWOjmNG4va3W
	mYcEBnVG9ImBG28c2q+EZp7HPWstF+ST7QWOTjBZUSI9JadpxGF2WK2TEu0tJP4rsnC5+T
	N/exAW15q2WhIw3a+iUBrKVH4zzOkNXCArLn2477b3cj0guLSBXKpGqsKQ/nlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756991917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gzlN8F33jc5mv1D5YUXNt8JDHCEp4+wRIW4ePyrbL50=;
	b=CoPrQf+LBKZs1H4pu3WxB5ZZ4tAxZwspJ1+iPVWaRAVm9XRsIOrxuqnWcJ84FCMMbD0ayP
	GSzwMhhBAKR4v0CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthias Klose <doko@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>
Subject: [RFC] Don't create sframes during build
Message-ID: <20250904131835.sfcG19NV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

gcc in Debian, starting with 15.2.0-2, 14.3.0-6 enables sframe
generation. Unless options like -ffreestanding are passed. Since this
isn't done, there are a few warnings during compile
| crypto/chacha.o: warning: objtool: .sframe+0x30: data relocation to !ENDB=
R: chacha_stream_xor+0x0
| crypto/chacha.o: warning: objtool: .sframe+0x94: data relocation to !ENDB=
R: crypto_xchacha_crypt+0x0

followed by warnings at the end

|   AR      vmlinux.a
|   LD      vmlinux.o
| vmlinux.o: warning: objtool: .sframe+0x15c: data relocation to !ENDBR: re=
pair_env_string+0x0
| vmlinux.o: warning: objtool: .sframe+0x1c0: data relocation to !ENDBR: ru=
n_init_process+0x0
| vmlinux.o: warning: objtool: .sframe+0x1d4: data relocation to !ENDBR: tr=
y_to_run_init_process+0x0
| vmlinux.o: warning: objtool: .sframe+0x1e8: data relocation to !ENDBR: rc=
u_read_unlock+0x0
=E2=80=A6
| vmlinux.o: warning: objtool: .sframe+0x12765c: data relocation to !ENDBR:=
 get_eff_addr_reg+0x0
| vmlinux.o: warning: objtool: .sframe+0x1276ac: data relocation to !ENDBR:=
 get_seg_base_limit+0x0
|   OBJCOPY modules.builtin.modinfo

followed by a boom
|   LD      .tmp_vmlinux1
| ld: error: unplaced orphan section `.sframe' from `vmlinux.o'

We could drop the sframe during the final link but this does not get rid
of the objtool warnings so we would have to ignore them. But we don't
need it. So what about the following:

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -886,6 +886,8 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS	+=3D $(call cc-option,--param=3Dallow-store-data-races=3D0)
 KBUILD_CFLAGS	+=3D $(call cc-option,-fno-allow-store-data-races)
 endif
+# No sframe generation for kernel if enabled by default
+KBUILD_CFLAGS	+=3D $(call cc-option,-Xassembler --gsframe=3Dno)
=20
 ifdef CONFIG_READABLE_ASM
 # Disable optimizations that make assembler listings hard to read.
--=20
2.51.0

