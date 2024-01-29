Return-Path: <linux-arch+bounces-1799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2157841363
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 20:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748F7B23213
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75056F090;
	Mon, 29 Jan 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWbbtAsj"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6D6F08C;
	Mon, 29 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556411; cv=none; b=VrLSzrfbqx96thyqLZRIEJYdqK4PoTPpnYqr9MQQo+/y/8UXf/etk0dFufBvLnuG12w5ZlYQ3Z3EBv9HRyw5g8HGR2UiKSmLHJI3cMHUn1KrM5nD67S+XTimZxDPfp/IW0mDm4WrZfW5Lyyj2MnjOoq4ZebVvkckDb6NsiTed3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556411; c=relaxed/simple;
	bh=WCpofLADI/TtlOTzhU5rxUynIGsq6yxpyzjwonyD2Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qo8X4U+NDpYtXvr9KBHeuyL78E0EsSk1vU20h0ScAxnNGrkjhVNVehKbdHEPXSJdeByR3WRbatBA9oqbrXJbdglZQmApHvQ0aaOySrYzsKzJkrBgEOQp9wFXCsE4WORW7WMoPC6mnmxWA2EmUGOfne0Vt2NpjE4IeBq5I1LIPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MWbbtAsj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CM6jMUxL5JdmH0z8Tke9mp44y/iUJY+JlOXgwEOFhWs=; b=MWbbtAsjLeiRHl0zDMPNFiBE+c
	C4q9dmcYk6O0EmxaUd3QNi14MQrhKCpa7StonYtHrHJQOTOwCeyL0Wt2/+YUq88dxiayUbf6nTj74
	/63F3vT2suez5Vdcp9BiEgXXJU17pQSI2vydCgsJHa1j2u/NaMzj0nZZ14mkXbbqs+0UHsW5huuVz
	zS13BMPZul4tRSbSecmukWmR8jGoxQa+/LXeiaqZyG19UX7wOwHSCAQKdRG331f1oAL9AA9LjLJgU
	4o0Ih8XXvzVgrk9iQUZjg2IHeNb0Bq3ZCt2j9GOzeBmciW3wy16wJGqPfun9HeqvaJUWexYMdH+Y3
	KV183AuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXHN-0000000E67X-2EK6;
	Mon, 29 Jan 2024 19:26:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org,
	deller@gmx.de
Cc: mcgrof@kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] modules: few of alignment fixes
Date: Mon, 29 Jan 2024 11:26:39 -0800
Message-ID: <20240129192644.3359978-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Helge Deller had written a series of patches to fix a few 
misalignemnt annotations in the kernel [0]. Three of these
patches were tagged as being stable candidates. Because of these
annotation I suggested proof of the imapact, however we did not
easily have a way to verify the value / impact of fixing a few
misaligment changes in the kernel for modules.

For the more hotpath alignment fix Helge had I suggested we could
easily test this by stress testing find_symbol() with a few set of
modules. This adds such tests to allow us to both allow us to test
the impact of such possible fix, and also while at it, let's us
test future improvements on the find_symbol() path.

Changes on this v2:

 - Adds new selftest for kallsyms
 - Drops patch #1 as Masahiro Yamada already applied it to linux-kbuild/fixes
 - Removes stable tags
 - Drops patch #3 as it was not needed
 - Adds a new patch with the issues noted by Helge as a fix
   to commit f3304ecd7f06 ("linux/export: use inline assembler to
   populate symbol CRCs") as noted by Masahiro Yamada
 - Adds selftest impact on x86_64 for patch #2, this really should
   be tested on parisc though as that's an example architecture
   where we could see perhaps more improvement

[0] https://lkml.kernel.org/r/20231122221814.139916-1-deller@kernel.org

Masahiro, if there no issues feel free to take this or I can take them in
too via the modules-next tree. Lemme know!

Helge Deller (2):
  modules: Ensure 64-bit alignment on __ksymtab_* sections
  modules: Add missing entry for __ex_table

Luis Chamberlain (2):
  selftests: add new kallsyms selftests
  vmlinux.lds.h: add missing alignment for symbol CRCs

 include/linux/export-internal.h               |   1 +
 lib/Kconfig.debug                             | 103 ++++++++++++++
 lib/Makefile                                  |   1 +
 lib/tests/Makefile                            |   1 +
 lib/tests/module/.gitignore                   |   4 +
 lib/tests/module/Makefile                     |  15 ++
 lib/tests/module/gen_test_kallsyms.sh         | 128 ++++++++++++++++++
 scripts/module.lds.S                          |   9 +-
 tools/testing/selftests/module/Makefile       |  12 ++
 tools/testing/selftests/module/config         |   3 +
 tools/testing/selftests/module/find_symbol.sh |  81 +++++++++++
 11 files changed, 354 insertions(+), 4 deletions(-)
 create mode 100644 lib/tests/Makefile
 create mode 100644 lib/tests/module/.gitignore
 create mode 100644 lib/tests/module/Makefile
 create mode 100755 lib/tests/module/gen_test_kallsyms.sh
 create mode 100644 tools/testing/selftests/module/Makefile
 create mode 100644 tools/testing/selftests/module/config
 create mode 100755 tools/testing/selftests/module/find_symbol.sh

-- 
2.42.0


