Return-Path: <linux-arch+bounces-5171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC191ABC4
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9981281DA8
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9E1991B0;
	Thu, 27 Jun 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xt9vYmew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVOA5dyh"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9822EF2;
	Thu, 27 Jun 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503289; cv=none; b=cuhQsLBBgSY+8mtZZp4pDo3LIZEt5qMpEtkr/5NQoF44C3zWLgO8vw86TXzsXDEHWFGLcgGkcbp4tAsUU7p21q9gv3j+ATHY+HQs4QJjDSRTMneNlqxYYgJqBbAksl9r92rIxBB7vJR00CnM+Onho50Cr06MmZJz30FVvmkNXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503289; c=relaxed/simple;
	bh=mgnSZbv9s1UDrPgwquXpFaPaJbetPkHMpZpbhSy4sdQ=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=oSVNr7q9tDVk9iBtX3D0N+IldT75RZ39XfTjs8KmX0uLtT3g4e04hykEIrqQAod6ZtCFYFGayOQlj+bXymkJw2suUq3xLN7Qus6UjklxrNI/iQO+rRtGVJ7l+9kkFZMWtCJdD8vUCXNHORv+U2XdjTLReK90w3owpeni+HFQovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xt9vYmew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVOA5dyh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F2CE1380123;
	Thu, 27 Jun 2024 11:48:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 27 Jun 2024 11:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1719503286; x=1719589686; bh=RXNn8CughpYiNE0XVk1z0mrQSBSu7ZpL
	KF+Sxmfz0CU=; b=xt9vYmewSr+NwSDUc+2CrGcP6bPKEmWaYer2QYQd56mIKAVn
	OxFCZJS0ycsqOEFNPQ/IJd0A1YqqLqPNSADmscRvFnS53/tbI1+L7CjhBXxGjzhw
	THk4gKXAoQ1+MymvsO6iCoutR98fl4XllsYzvlGnAd2kmpTjNkH5KnBddCNKDYLY
	beuiPARE+A588jFxyzb4+qNbNfYhk6j2+nKMReuEtJ40nUMQey3NDC4S2OLPEAl4
	WzBU1SNqYOC1g82kpTA57vNxR41anVee33qiSh0d/hs1VoLRIm9vVUX1ToHM2jQW
	rZrZWdtFmzG0g7ydHMv+NuH6BQLUi/JzvT3fQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1719503286; x=1719589686; bh=RXNn8CughpYiNE0XVk1z0mrQSBSu7ZpLKF+
	Sxmfz0CU=; b=YVOA5dyhSCrVm//0hOmdTknULSD6RPRVKQjm+6txFYH2olLmNrQ
	6tXpXxGNWg68lwkHmSErIE+OozGSpd4RvqZHJopjUpwSBY2YqKyjzVyNt7O/NsPA
	sGHnjF1D1ZpV1uDUHH9eTj8TAe4Fv7FpywWM0d27u9r/NNGGbe6cqxvgQc7m+vWD
	sWuslLsxcjNE5Y5PJFTEsrSH39UDYTWdI/fPqudvZl5fCVV3bBcspNrkKSYShxeZ
	AHhcffU/uvgjD0FXoM5AZg2ewdVyQ6JQOoqPKC5Rh9+ZdaYEA7UEawnmeOy88hkf
	Bi1sJGJFlOiB05ThGWpa/L5d7gouyUtxKRQ==
X-ME-Sender: <xms:tol9ZkqGq6cd9_2Tg1g6LzY7UKwAiLDD28T6qTso1B-IDkhG6bdqzQ>
    <xme:tol9ZqrF3L4qbsb0Sf7WjgfmS7lyhhG6PiwaYGAs2H-PfMPDL_-lhbNLbuymBqYwZ
    aZxWgYZ4gzGPCHV4NU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tol9ZpM9rzkYHDkx1M6X3OfNI_3ikYsicE4trIKleiUJ1khDevYL5A>
    <xmx:tol9Zr61VoNNWVA0Q5UGt62pVtyCqFjnpQ-H6tAQ1lFEnLnDhFfYHQ>
    <xmx:tol9Zj7an15US46HuBwzI1smRuKExv4ERCHg3YVtkig_5te4neAc5Q>
    <xmx:tol9Zrg8Ml5nJeftkhqBNa3d6wpSBuLFa41K5XAyiUvvFchqYx--yg>
    <xmx:tol9ZtuwREKpO17UDq7Xg-BdX-mcekpDWyqEcU7UnMDTybcRRzXdvZqk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 385DFB6008D; Thu, 27 Jun 2024 11:48:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cdf46f76-ee89-4c20-afd8-94a629d06e70@app.fastmail.com>
Date: Thu, 27 Jun 2024 17:47:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] asm-generic fixes for 6.10
Content-Type: text/plain

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.10

for you to fetch changes up to 7e1f4eb9a60d40dd17a97d9b76818682a024a127:

  kallsyms: rework symbol lookup return codes (2024-06-27 17:43:40 +0200)

----------------------------------------------------------------
asm-generic fixes for 6.10

These are some bugfixes for system call ABI issues I found while
working on a cleanup series. None of these are urgent since these
bugs have gone unnoticed for many years, but I think we probably
want to backport them all to stable kernels, so it makes sense
to have the fixes included as early as possible.

One more fix addresses a compile-time warning in kallsyms that was
uncovered by a patch I did to enable additional warnings in 6.10. I had
mistakenly thought that this fix was already merged through the module
tree, but as Geert pointed out it was still missing.

----------------------------------------------------------------
Arnd Bergmann (14):
      ftruncate: pass a signed offset
      syscalls: fix compat_sys_io_pgetevents_time64 usage
      sparc: fix old compat_sys_select()
      sparc: fix compat recv/recvfrom syscalls
      parisc: use correct compat recv/recvfrom syscalls
      parisc: use generic sys_fanotify_mark implementation
      powerpc: restore some missing spu syscalls
      sh: rework sync_file_range ABI
      csky, hexagon: fix broken sys_sync_file_range
      hexagon: fix fadvise64_64 calling conventions
      s390: remove native mmap2() syscall
      syscalls: mmap(): use unsigned offset type consistently
      linux/syscalls.h: add missing __user annotations
      kallsyms: rework symbol lookup return codes

 arch/arm64/include/asm/unistd32.h         |   2 +-
 arch/csky/include/uapi/asm/unistd.h       |   1 +
 arch/csky/kernel/syscall.c                |   2 +-
 arch/hexagon/include/asm/syscalls.h       |   6 +
 arch/hexagon/include/uapi/asm/unistd.h    |   1 +
 arch/hexagon/kernel/syscalltab.c          |   7 +
 arch/loongarch/kernel/syscall.c           |   2 +-
 arch/microblaze/kernel/sys_microblaze.c   |   2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |   2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   2 +-
 arch/parisc/Kconfig                       |   1 +
 arch/parisc/kernel/sys_parisc32.c         |   9 --
 arch/parisc/kernel/syscalls/syscall.tbl   |   6 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |   6 +-
 arch/riscv/kernel/sys_riscv.c             |   4 +-
 arch/s390/kernel/syscall.c                |  27 ----
 arch/s390/kernel/syscalls/syscall.tbl     |   2 +-
 arch/sh/kernel/sys_sh32.c                 |  11 ++
 arch/sh/kernel/syscalls/syscall.tbl       |   3 +-
 arch/sparc/kernel/sys32.S                 | 221 ------------------------------
 arch/sparc/kernel/syscalls/syscall.tbl    |   8 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   2 +-
 fs/open.c                                 |   4 +-
 include/asm-generic/syscalls.h            |   2 +-
 include/linux/compat.h                    |   2 +-
 include/linux/filter.h                    |  14 +-
 include/linux/ftrace.h                    |   6 +-
 include/linux/module.h                    |  14 +-
 include/linux/syscalls.h                  |  20 +--
 include/uapi/asm-generic/unistd.h         |   2 +-
 kernel/bpf/core.c                         |   7 +-
 kernel/kallsyms.c                         |  23 ++--
 kernel/module/kallsyms.c                  |  25 ++--
 kernel/sys_ni.c                           |   2 +-
 kernel/trace/ftrace.c                     |  13 +-
 35 files changed, 116 insertions(+), 345 deletions(-)
 create mode 100644 arch/hexagon/include/asm/syscalls.h

