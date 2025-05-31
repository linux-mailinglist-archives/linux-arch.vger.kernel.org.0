Return-Path: <linux-arch+bounces-12162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45090AC9A2F
	for <lists+linux-arch@lfdr.de>; Sat, 31 May 2025 11:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB2F1BA521F
	for <lists+linux-arch@lfdr.de>; Sat, 31 May 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A222376F5;
	Sat, 31 May 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sz4IZZbz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDSX/gnq"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BE78F4E;
	Sat, 31 May 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748682616; cv=none; b=pikQSFsEY7Y8MTM3WPW7Zq/uMBrTkmPgFyoEMFL6wza5Kt01kfiOYXdRea6Ris2u9kR9DY2rHD22+0mLK7KhR85644EshvDsD48Qp7eD71hkrE5GdCZCXSN6jxml4UMw3FAUsEaMzKTXM8Q94KgAVbJOScq0TnGfTVEaMUJghr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748682616; c=relaxed/simple;
	bh=S7wsb9tmfVZDNNnUG1r3Rq5K3E7DRT2sd2LlOM/ibMQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=QF5y+mTaxJrVksXEkaK4VrSWgwQhn2Q5HwiEFWj2Oh+WbTdmJX3h5WDiAwQDn6iRfVaObZefaZ8jSbeg0+pGKvss+RypzS1ccOdkBJUzEoZx9ck4GJOxnK30VW6d13u1Q1c1yHxctS8Cw9VK57crwhuoKNi6F+DMHnRt1YFZHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sz4IZZbz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDSX/gnq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 55656138034E;
	Sat, 31 May 2025 05:10:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 31 May 2025 05:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1748682614; x=1748769014; bh=RX
	O4f3Yp6Be71rD2cH9gM61HbHGWJD/s7+tuHyvcz5U=; b=sz4IZZbzEd7DDdVpIP
	PcvuT23+ITNiLVgPM/ZwbxesELoZPwW5k6dEvBLAPTuMUQIsy6tRZNOH7QvB/dmJ
	NFQLHWXj9R7XNM8httMvK2n3NyIaAvpUEVIidEoHqQc88LYKExFQd2PHiueDT/R3
	s1cOaTIAmYfd4Zl2di0KogiuLcn86CkJnASeb2Skt9m35eaC8LBs79D7TAU2XkYY
	SMJM+iJSKdBEPXfRYxmfqtujfowd8HThjyGe/9tL+BYLFthRnRNeoHh53B6N2XQ0
	78gj7nZLJsomffo2rY09wU8G1Bw6A+zvwU+7rH4AT1GfdIQxejpG4MQgv6ynHTQH
	qTsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748682614; x=1748769014; bh=RXO4f3Yp6Be71rD2cH9gM61HbHGW
	JD/s7+tuHyvcz5U=; b=lDSX/gnqofokQz3vlh2ZNFDjUTV/FIwwX0zhFNEmtcm7
	cIAKkvmjnKFmlhwQsGoRNPxgHL09iRpqD+vjUXzjH0hCXMX8TLQtdHW6jMoQeDwW
	mWw529YDvlkgyvUH6tpoKiBd4gPw7frqQViSEGc8CXbx62ivpx/tDyuNcMd3OD4S
	Rqh421esWYP4jv425UXUtPpqYps4UiheSwV2wobami9nwo1EXCFAbQY9npvEvsw+
	UHcghVkxi1T7+QNWlO3yOM/TQJUKD2kL4R8r/N8inNb5WHgecGSUlwmIkF6EUfco
	vSHCGRLAweeTczuIQBISNpcH+5U4BrT3xDuALJQ6mw==
X-ME-Sender: <xms:dsc6aIhtHfr4LZdGNKoMy7tjoUrGxaTEshiQ8hJxjjjJMjzTZ2lnDw>
    <xme:dsc6aBDvRSByIYaUh0tsGtfvBgdVWhYUfYHYr4lkiq4g65UNuJlUmn64UjHSIi1gj
    oIH32iQQlMXY9SQyH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudehudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    ufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoe
    grrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeduleeigeekveeugeet
    tdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhksghuihhlugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dsc6aAGCr8yQaaseQMm_XQw4bZ095G5ZcWNy3prGMpNDFUCkKUcXUw>
    <xmx:dsc6aJSsVtH9gcAsTJWgx2yz1bCs3TBYSBJtlX9KAM_Mj1yE7P4bfQ>
    <xmx:dsc6aFw3qK1oBAaTZx1JPlv4RKKfH8K5kxcR1osQPu3OWGao_VlLGQ>
    <xmx:dsc6aH7WEmQyHMUDTYsHrMIGmeCqAze97w2bgFFUe44teRBWQHKJNw>
    <xmx:dsc6aHf5EfpfJKJ4dzibYskkAxRFVm6jl0WdKbgtXw1s1FYvv1tXWftn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1CC9700060; Sat, 31 May 2025 05:10:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 11:09:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kbuild@vger.kernel.org, "Kees Cook" <kees@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Message-Id: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
Subject: [GIT PULL] require gcc-8 and binutils-2.30
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/gcc-minimum-version-6.16

for you to fetch changes up to 582847f9702461b0a1cba3efdb2b8135bf940d53:

  Makefile.kcov: apply needed compiler option unconditionally in CFLAGS_KCOV (2025-05-21 16:08:42 +0200)

----------------------------------------------------------------
require gcc-8 and binutils-2.30

x86 already uses gcc-8 as the minimum version, this changes all other
architectures to the same version. gcc-8 is used is Debian 10 and Red
Hat Enterprise Linux 8, both of which are still supported, and binutils
2.30 is the oldest corresponding version on those. Ubuntu Pro 18.04 and
SUSE Linux Enterprise Server 15 both use gcc-7 as the system compiler
but additionally include toolchains that remain supported.

With the new minimum toolchain versions, a number of workarounds for older
versions can be dropped, in particular on x86_64 and arm64.  Importantly,
the updated compiler version allows removing two of the five remaining
gcc plugins, as support for sancov and structeak features is already
included in modern compiler versions.

I tried collecting the known changes that are possible based on the
new toolchain version, but expect that more cleanups will be possible.
Since this touches multiple architectures, I merged the patches through
the asm-generic tree.

----------------------------------------------------------------
Arnd Bergmann (6):
      kbuild: require gcc-8 and binutils-2.30
      raid6: skip avx512 checks
      arm64: drop binutils version checks
      Kbuild: remove structleak gcc plugin
      gcc-plugins: remove SANCOV gcc plugin
      Documentation: update binutils-2.30 version reference

Lukas Bulwahn (1):
      Makefile.kcov: apply needed compiler option unconditionally in CFLAGS_KCOV

 Documentation/admin-guide/README.rst               |   2 +-
 Documentation/kbuild/makefiles.rst                 |   4 +-
 Documentation/process/changes.rst                  |   6 +-
 .../translations/it_IT/process/changes.rst         |   6 +-
 .../translations/zh_CN/admin-guide/README.rst      |   2 +-
 arch/arm64/Kconfig                                 |  37 +--
 arch/arm64/Makefile                                |  21 +-
 arch/arm64/include/asm/rwonce.h                    |   4 -
 arch/arm64/kvm/Kconfig                             |   1 -
 arch/arm64/lib/xor-neon.c                          |   2 +-
 arch/um/Makefile                                   |   4 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |   6 +-
 include/linux/unroll.h                             |   4 +-
 kernel/gcov/gcc_4_7.c                              |   4 -
 lib/Kconfig.debug                                  |  10 +-
 lib/raid6/algos.c                                  |   6 -
 lib/raid6/avx512.c                                 |   4 -
 lib/raid6/recov_avx512.c                           |   6 -
 lib/raid6/test/Makefile                            |   3 -
 lib/test_fortify/Makefile                          |   5 +-
 lib/tests/stackinit_kunit.c                        |  10 +-
 mm/mm_init.c                                       |   6 -
 scripts/Makefile.compiler                          |   2 +-
 scripts/Makefile.gcc-plugins                       |  16 --
 scripts/Makefile.kcov                              |   3 +-
 scripts/gcc-plugins/Kconfig                        |  10 -
 scripts/gcc-plugins/gcc-common.h                   |  45 ----
 scripts/gcc-plugins/sancov_plugin.c                | 134 -----------
 scripts/gcc-plugins/structleak_plugin.c            | 257 ---------------------
 scripts/min-tool-version.sh                        |   6 +-
 security/Kconfig.hardening                         |  76 ------
 31 files changed, 25 insertions(+), 677 deletions(-)
 delete mode 100644 scripts/gcc-plugins/sancov_plugin.c
 delete mode 100644 scripts/gcc-plugins/structleak_plugin.c

