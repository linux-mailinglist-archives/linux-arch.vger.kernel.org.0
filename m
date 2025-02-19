Return-Path: <linux-arch+bounces-10212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86827A3B418
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3895716DE59
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0E1CEEBE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKP1bejj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04D1C5F18;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=JEXHGWCAOt8x+Uy9V2n6voAGOUT4KqguYhrWSDUYzhqQ2wxzL8LHbLnsLuo/a76xR1kkXMX0ofRsdght2f+gHhAoAUr/yTUytCXZuwiL9zFOL6BFo3uEU3/77mhZO5vXP8XqSYROIKObQ7Nb5praw8ROKhi1o62a2iwkFDZHbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=blm26kWj5aQPEC4WfZGgw5G7lh0zITYqtzpGclMk880=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3Eb1iQX5LQ8hdmfP6QbM0gJN6ycc8AUgfa9BXAuHO9wpin9jFi6OD6EkLAKEmviw60mF22BJZdshV0vbiDTcwhrG//awlVCsu1Cg2xaYCEFNHs2dBWIkdiRbki1xi00+CdZOn9Q9Zehut5El2ZRxGNKPtytZ4JSNoT3oe3L9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKP1bejj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE268C4CEE9;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953971;
	bh=blm26kWj5aQPEC4WfZGgw5G7lh0zITYqtzpGclMk880=;
	h=From:To:Cc:Subject:Date:From;
	b=rKP1bejjozwruOcYXC7DVtcNbc9dWLljp5JbRDFwx5MOQYoPN2YDgwfMfem/0otDe
	 M72RCfVu1Rs1U0PeZOC76Kfw+lsYkS2p2EZj60tw6fb/ic7XQYyo2no1vJfaERqiJX
	 1eSJzLrk1iNx7pjVXKn8rKKbpLR1JGc8xXVrwAtNTAMuaTOwSPVrUrbtQtLd0SviHO
	 2MzdtWQSbPhHuVIfEZYRn2OWE450ZoM3/H4WHznjOz0yf7gjVcyd3BRAWWc6IRMtov
	 WYmLwEbXo1IiLMORuB8MYBqto3mOsG6ciXL+uXI2yVYNsJUMEeUh6jCfA9W7GS/N0d
	 UbkRWVTgdz57Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVh-0000000Gv4I-3tcj;
	Wed, 19 Feb 2025 09:32:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <mchehab+huawei@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH 00/27] Implement kernel-doc in Python
Date: Wed, 19 Feb 2025 09:32:16 +0100
Message-ID: <cover.1739952783.git.mchehab+huawei@kernel.org>
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

This changeset contains the kernel-doc.py script to replace the verable
kernel-doc originally written in Perl.

As the previous versions, I tried to stay as close as possible of the original
Perl implementation, as it helps to double check if each function was 
properly translated to Python.  This have been helpful debugging troubles
that happened during the conversion.

I worked hard to make it bug-compatible with the original one. Still, its
output has a couple of differences from the original one:

- The tab expansion works better with the Python script. With that, some
  outputs that contain tabs at kernel-doc markups are now different;

- The new script  works better stripping blank lines. So, there are a couple
  of empty new lines that are now stripped with this version;

- There is a buggy logic at kernel-doc to strip empty description and
  return sections. I was not able to replicate the exact behavior. So, I ended
  adding an extra logic to strip empty sections with a different algorithm.

Yet, on my tests, the results are compatible with the venerable script
output for all .. kernel-doc tags found in Documentation/. I double-checked
this by adding support to output the kernel-doc commands when V=1, and
then I ran a diff between kernel-doc.pl and kernel-doc.py for the same
command lines.

This version uses a minimal integration scenario: it just replaces the
exec file from the Perl to th Python version.

This series contains:

- 4 patches fixing some kernel-doc issues. One of them is for media, but
   I prefer to have this merged via your tree, as it suppresses a warning
   that happens after the changes;

- 2 cleanup patches for Perl kernel-doc;

- 2 patches renaming kernel-doc to kernel-doc.pl and adding a symlink.
  I opted to have the symlink in separate to make easier to review, but
  feel free to merge them on a single patch if you want;

- 15 patches with the new script. The first one is the new tool on a single
   file. The other ones split it into a library. Then, there are several bug
   fixes to make its output compatible with the original script;

- 1 patch adding a .pylintrc file to teach pylint about scripts/lib/* dirs;

- 2 patches adding some extra functionality to Sphinx kerneldoc extension;

- 1 patch switching Sphinx to use the new tool.

What is missing:

- a patch droping kernel-doc.pl;
- a patch renaming kernel-doc.py to kernel-doc (or changing the symlink).

I opted to not do those final changes here, as this way we can better
test the tools.

With such changes, if one wants to build docs with the old script,
all it is needed is to use KERNELDOC parameter, e.g.:

	$ make KERNELDOC=scripts/kernel-doc.pl htmldocs

Will make Sphinx use the original version.

Mauro Carvalho Chehab (27):
  include/asm-generic/io.h: fix kerneldoc markup
  drivers: media: intel-ipu3.h: fix identation on a kernel-doc markup
  drivers: firewire: firewire-cdev.h: fix identation on a kernel-doc
    markup
  docs: driver-api/infiniband.rst: fix Kerneldoc markup
  scripts/kernel-doc: don't add not needed new lines
  scripts/kernel-doc: drop dead code for Wcontents_before_sections
  scripts/kernel-doc: rename it to scripts/kernel-doc.pl
  scripts/kernel-doc: add a symlink to the Perl version of kernel-doc
  scripts/kernel-doc.py: add a Python parser
  scripts/kernel-doc.py: output warnings the same way as kerneldoc
  scripts/kernel-doc.py: better handle empty sections
  scripts/kernel-doc.py: properly handle struct_group macros
  scripts/kernel-doc.py: move regex methods to a separate file
  scripts/kernel-doc.py: move KernelDoc class to a separate file
  scripts/kernel-doc.py: move KernelFiles class to a separate file
  scripts/kernel-doc.py: move output classes to a separate file
  scripts/kernel-doc.py: convert message output to an interactor
  scripts/kernel-doc.py: move file lists to the parser function
  scripts/kernel-doc.py: implement support for -no-doc-sections
  scripts/kernel-doc.py: fix line number output
  scripts/kernel-doc.py: fix handling of doc output check
  scripts/kernel-doc.py: properly handle out_section for ReST
  scripts/kernel-doc.py: postpone warnings to the output plugin
  docs: add a .pylintrc file with sys path for docs scripts
  docs: sphinx: kerneldoc: verbose kernel-doc command if V=1
  docs: sphinx: kerneldoc: ignore "\" characters from options
  docs: sphinx: kerneldoc: use kernel-doc.py script

 .pylintrc                                     |    2 +
 Documentation/Makefile                        |    2 +-
 Documentation/conf.py                         |    2 +-
 Documentation/driver-api/infiniband.rst       |   16 +-
 Documentation/sphinx/kerneldoc.py             |   46 +
 .../media/ipu3/include/uapi/intel-ipu3.h      |    3 +-
 include/asm-generic/io.h                      |    6 +-
 include/uapi/linux/firewire-cdev.h            |    3 +-
 scripts/kernel-doc                            | 2447 +----------------
 scripts/kernel-doc.pl                         | 2439 ++++++++++++++++
 scripts/kernel-doc.py                         |  224 ++
 scripts/lib/kdoc/kdoc_files.py                |  274 ++
 scripts/lib/kdoc/kdoc_output.py               |  753 +++++
 scripts/lib/kdoc/kdoc_parser.py               | 1702 ++++++++++++
 scripts/lib/kdoc/kdoc_re.py                   |  272 ++
 15 files changed, 5730 insertions(+), 2461 deletions(-)
 create mode 100644 .pylintrc
 mode change 100755 => 120000 scripts/kernel-doc
 create mode 100755 scripts/kernel-doc.pl
 create mode 100755 scripts/kernel-doc.py
 create mode 100755 scripts/lib/kdoc/kdoc_files.py
 create mode 100755 scripts/lib/kdoc/kdoc_output.py
 create mode 100755 scripts/lib/kdoc/kdoc_parser.py
 create mode 100755 scripts/lib/kdoc/kdoc_re.py

-- 
2.48.1



