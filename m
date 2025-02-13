Return-Path: <linux-arch+bounces-10140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2BA33EC3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 13:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437B916240B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C9221542;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsakIyUP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF67215059;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448388; cv=none; b=kVu37ZLcvZiFthsn3P01+pv2wFAqGefd9CR0GZRgOAtyGWIUy8PxFJNzCJnLw8X3N8TOFw4rU4Anms9VrH1rPZqrRM4Tfvu9W4R9gHOKXGnvDJWATIIYfoFBhlEdmVCyOiKRfK9MLaTDuZJn7vI3C+m0fa/zbu8c2rj7vZBZ6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448388; c=relaxed/simple;
	bh=/wM8GJMjDr++3muLjDT+A1c8YGcYigrvRmRrvP2JhqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1I99PyVEArnCdZv42Eq00ryhk1aiuptCc9ieS5Um98ISLspmYimIzwtnpHm38mini9EJSn1SPWAUMcNKRNPSLA+NTsfrP7hWRhRTcjEURDYyMcxs45d3dzokWt23e5wZWsAcoc3VKrVEQUzE+nkCIwWJKPY0BMKdUA8i2w/4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsakIyUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2C2C4AF0B;
	Thu, 13 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739448387;
	bh=/wM8GJMjDr++3muLjDT+A1c8YGcYigrvRmRrvP2JhqM=;
	h=From:To:Cc:Subject:Date:From;
	b=KsakIyUP6InZZhoVKGUXXS+hqMFFVMUxosTtPp4R4ZmhZvyV0/tKDNcPIX0ai+fkR
	 V3TyQlUUWJ6hL/fvH7DnXhmgaC49009azkIfXrPIcWVe6Tlq3n6XKphRmEXb31T2CW
	 WChLAGQnxA4fOtxhBkJONZTZbJZkdGSI7pKJhlrEAOFp3kNg9ejGFMGxBK3Q+88Z+v
	 qsDwzIzrPXDoWHGSRE8/hfiDQwfRDGngpCDjlbow9nCg8Lp9+unnXRsSeqqCg66Fbd
	 XAz3+Mk2XT7f9gjFFZw1E67H17ooOLGcUn4/zZdGQYyIhSyJmodfHiAxM0LsHdlovK
	 DnTnDKZ8W9RwA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiXz7-0000000BIUz-1GYb;
	Thu, 13 Feb 2025 13:06:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <mchehab+huawei@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFCv2 0/5]Implement kernel-doc in Python
Date: Thu, 13 Feb 2025 13:06:13 +0100
Message-ID: <cover.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

That's the second version of the Python kernel-doc tool.

As the previous version, I tried to stay as close as possible of the original
Perl implementation, as it helps to double check if each function was 
properly translated to Python.  This have been helpful debugging troubles
that happened during the conversion.

On this version, the ReST output for the files included under Documentation
is identical to the perl version, except for:

 - blank lines;
 - white spaces;
 - this version suppresses return (and description) sections on a few places
   where this is left in blank.

This version also replaces the old script by the new one for doc generation,
to make easier to test its results.

It should be noticed that  there are some sutile nuances on the way Perl 
and Python handle  regular expressions. In particular, Perl compiled 
expressions with qr{}  behaves as non-capturing groups, sometimes optional
ones. I documented it on one place, but I had to use non-capturing groups
on other parts of the logic to achieve the desired results.

This version is on a minimal integration scenario: it just replaces the
exec file to use the new one and gets rid of an obsolete parameter
as on this version I didn't implement support for Sphinx < 3.1.

On other words, it assumes that the patch requiring Sphinx >= 3.4
will be merged.

I also didn't remove on this series the old kernel-doc script, as this makes
easier to test both variations, e. g. using:

	make cleandocs && make KERNELDOC=scripts/kernel-doc htmldocs

will make it use the original Perl version.

Comments?

Mauro Carvalho Chehab (5):
  include/asm-generic/io.h: fix kerneldoc markup
  scripts/kernel-doc: remove an obscure logic from kernel-doc
  scripts/kernel-doc: don't add not needed new lines
  scripts/kernel-doc.py: add a Python parser
  docs: use kernel-doc.py script for kerneldoc output

 Documentation/Makefile            |    2 +-
 Documentation/conf.py             |    2 +-
 Documentation/sphinx/kerneldoc.py |    5 -
 include/asm-generic/io.h          |    6 +-
 scripts/kernel-doc                |   23 +-
 scripts/kernel-doc.py             | 2752 +++++++++++++++++++++++++++++
 6 files changed, 2762 insertions(+), 28 deletions(-)
 create mode 100755 scripts/kernel-doc.py

-- 
2.48.1



