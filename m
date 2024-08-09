Return-Path: <linux-arch+bounces-6129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780E94D418
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9492CB22299
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1019755A;
	Fri,  9 Aug 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LEl8Cede";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqeWWJs6"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515E1922DB;
	Fri,  9 Aug 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219232; cv=none; b=ear9fBbbzMcrtFxHcu6aUHfsSF5Y78bLZ5pS5G+bDi5Ic4RqLVFOh4AXk9IMsxG8jDnbwRlLze/nm04oxMN841CeHixTIItMjGi+b20tAxeIYRIs5PPJZ8/eFIr5238Qqz7Qo3tIlqnHufWovPYSj3T6qaNBgy3VyiLWVCX7nxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219232; c=relaxed/simple;
	bh=b6/4Phi0wH7FFsBh31R0+WplVBsLpARLS994s9I343E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=iZs8gFuS+gQmW8/L8poYNGoUWMDoiHxdT9M3F3Ceq5T3HRQVgsU4yTkNNdOmjDG2hyga97/lbCUxWdgvhcK47Z5fyKhCF/+5BtWBIZDdQdii+6FCwzv78RJ6xziGOWooFMEq18fEGF6aMB/WLNGDE2QB7T9NWB4P1OZ95AwnAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LEl8Cede; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqeWWJs6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E618138E00C;
	Fri,  9 Aug 2024 12:00:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 12:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1723219230; x=1723305630; bh=iZ
	5NReUgn6OsOfJIpAgObrur6AOb0YrjqjdjPJ0EOnU=; b=LEl8CededdLS0vnJ2w
	WfKmIBMmlqfa1EvhnHR3iD2jkbKRRRYzGK3IUTdBK4sbDhMYvS9Q4bIHu4eJBGzr
	rRnh9Vajftf3CgGacqPoUTVD3B2oEtxNCQaiKRxi7Ol0XzLxMPrtQquG+COrTdTv
	qO0+MHurlEmfu1+c1AmPOsieBtgPGhm+/KE72apkYTW/u47j6pLU71zIhpre7aFw
	aWy1YDsfypXAybGPWLdx/xonSI1ys4nfCe/n2hILOEpzD8x51ypMbTG9fgLj+UP4
	zcW/LkqpvXPvtAqIVHoCogCAwfwF2e5/iZLtOW0s4NjIkCC0PabqgQ7ng9kMVDgA
	VA9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723219230; x=1723305630; bh=iZ5NReUgn6OsO
	fJIpAgObrur6AOb0YrjqjdjPJ0EOnU=; b=mqeWWJs67OUhUiGxuGxKaShWmqPfg
	Oifx534b4kwx/erCWX7dIU3aSv/O2suEFIYlF/WZZbyCgojQz9CJiVO3N+x/lSBj
	a2JNeT0FfZ9iN0DbeuIA9IvcJppa2m8gl8Bzy+cOSRRt6HFidP+8szV4Wx6jjsj3
	SOk4SFJ4q0XDFPcA3OHw22zFTqAyyyfGcscnHhb//v53Ng2eYV+dX2BbvLpE4u8o
	Gk2fvnHWJHB2pLkxO2JuFJQ+NMsLpsvxBuoDNFrDSEutKRUA1cBszeIwdHxY4VH4
	o9WGEwsD01eWrlklIzA4qBkWbySl+Acg+RVgslNnF8oNpdxyOr5DxuWfw==
X-ME-Sender: <xms:HT22ZgAcH5B5GUm_3PX0YNz7S-EAE78Vb1tf3aj6A9s05p6eyD9FsQ>
    <xme:HT22ZigIXWiXSKg9X6HXqlXDcNMM9hyPakbrpq3IB2mGuS-zar59ddM3Y3xmoQw5I
    YMu1kT-VWM0Juc1Cmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthejredtredttdenucfh
    rhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqe
    enucggtffrrghtthgvrhhnpeevgfefhffftdfftefggfejhefghfejffevveffuefhhfdt
    ieeuveefhfffueegvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdguvggsihgrnh
    drnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehruhguiheshhgvihhtsggruhhmrdgtohhmpdhrtghpthht
    ohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtph
    htthhopehjrghkuhgssehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdgr
    rhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HT22ZjnBMDFGb2mVHirIcD1wX5slPA18XZ3yWcBVhRzx9oVbRJXpMg>
    <xmx:HT22ZmznypJnk9jTgkDBe00VOY50CHrIQIBiw1t-5pgQwp5eOoim3w>
    <xmx:HT22ZlRVIwhfp9EBbVAJOFoocFLNz2s0hM5zUkrMPraWk3bqfPk4KQ>
    <xmx:HT22ZhZpCzhWoT8ncDmpwoZbo4i9I48SRcxOG0lF5VFibvaAi_hJNQ>
    <xmx:Hj22ZjO7zZtekYJ-g_8Unvg7sCWBg5U_I7cRpwfYMiKrEHDyx5J5vZiO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BAA87B6008D; Fri,  9 Aug 2024 12:00:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 17:59:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Rudi Heitbaum" <rudi@heitbaum.com>, "Jakub Jelinek" <jakub@redhat.com>
Message-Id: <30fdaeb5-520b-4f41-97a1-072c035e1b1d@app.fastmail.com>
Subject: [GIT PULL] asm-generic fixes for 6.11, part 2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 343416f0c11c42bed07f6db03ca599f4f1771b17:

  syscalls: fix syscall macros for newfstat/newfstatat (2024-08-02 15:20:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-2

for you to fetch changes up to b82c1d235a30622177ce10dcb94dfd691a49922f:

  syscalls: add back legacy __NR_nfsservctl macro (2024-08-06 08:57:02 +0200)

----------------------------------------------------------------
asm-generic fixes for 6.11, part 2

There are two more changes to the syscall.tbl conversion: the
'__NR_newfstat' in the previous bugfix was a mistake and gets reverted
now, after triple-checking that the contents are now back to what they
were on all architectures. The __NR_nfsservctl definition is not really
needed but came up in the same discussion as it had previously been
defined in uapi/asm-generic/unistd.h and tested for in user space.

TThere are a few more symbols that used to be defined in the old
unistd.h file, but that are never defined on any other architecture
using syscall.tbl format. These used to be needed inside of the kernel:

   __NR_syscalls
   __NR_arch_specific_syscall
   __NR3264_*

Searching for these on https://codesearch.debian.net/ shows a few packages
(rustc, golang, clamav, libseccomp, librsvg, strace) that duplicate all
the macros from asm/unistd.h, but nothing that actually uses the macros,
so I concluded that they are fine to omit after all.

----------------------------------------------------------------
Arnd Bergmann (2):
      syscalls: fix fstat() entry again
      syscalls: add back legacy __NR_nfsservctl macro

 scripts/syscall.tbl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 4586a18dfe9b..845e24eb372e 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -53,6 +53,7 @@
 39     common  umount2                         sys_umount
 40     common  mount                           sys_mount
 41     common  pivot_root                      sys_pivot_root
+42     common  nfsservctl                      sys_ni_syscall
 43     32      statfs64                        sys_statfs64                    compat_sys_statfs64
 43     64      statfs                          sys_statfs
 44     32      fstatfs64                       sys_fstatfs64                   compat_sys_fstatfs64
@@ -100,7 +101,7 @@
 79     stat64  fstatat64                       sys_fstatat64
 79     64      newfstatat                      sys_newfstatat
 80     stat64  fstat64                         sys_fstat64
-80     64      newfstat                        sys_newfstat
+80     64      fstat                           sys_newfstat
 81     common  sync                            sys_sync
 82     common  fsync                           sys_fsync
 83     common  fdatasync                       sys_fdatasync

