Return-Path: <linux-arch+bounces-10333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD65A41837
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 10:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F47D3A4674
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7424502F;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IknIikHH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D6245015;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=IaddgZF1UShkUUvEih75XIxNNOvokGWFoL429PNoHDW0MNy2T2BwJEsmHRuqD+TKfAlAu5wYc4aUI+iZ54tEtx5Io9YyyDR/NZ5dHpQ/QoHJ/eqDm18xBhZCVp1DobDQByxHjPDXB/J6iYgi5YFzRv38+7gt8aSxGk6YQQYyC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=44L74dHmGe2TU7EQRUfkK0TjEkVHS2UIUGo5a4H4lz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AedpQtMzoKUhPHnvunhHGBQu7tcwE1wwlvXSKECceMbW9RaQmHQa+9OXgGnzMJuHH8pEXLAU+u4K2KWtzoT3ZfcuaMfoOAs9imKQp9SNxJFlvHpPEBYdgXs3tU8Ld+DQ32Dngq4nCRHoEipUWulmwK3W+DWoETotjQJYDiTWIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IknIikHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ADAC4CEE8;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=44L74dHmGe2TU7EQRUfkK0TjEkVHS2UIUGo5a4H4lz8=;
	h=From:To:Cc:Subject:Date:From;
	b=IknIikHHAiNqRFJKwiAvsVwQK1WBhsAlo6h2pWfVvsEfYX3BBFpUeoraIWLKCBd8p
	 wC7muDfBiORTJVrDugS6wOaso2nqSVhssZMGlITsVp5wL4xuc3GLUdz3oBWnYBr+eW
	 aj4owju7TA2G27ISW9QBWMVRebWBdo4MMLqIMNlWZvuj4TgP0C4tH5lHwFPboF1sGb
	 moNIlihBZUJ+2wkBViyrsQS8RrGh4+Mz8z1Wc7ZhwRarLBlFOPeAqytwQB2XmN1VDe
	 NIfBXcEKNZBVAvjxZJADACwluVtE6iygQ2fPe+iG7Hq3Tnhcl+K1YiE3S7fL/qyDvp
	 l9hNvTRd7m91Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3R-3GJK;
	Mon, 24 Feb 2025 10:09:00 +0100
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
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH v2 00/39] Implement kernel-doc in Python
Date: Mon, 24 Feb 2025 10:08:06 +0100
Message-ID: <cover.1740387599.git.mchehab+huawei@kernel.org>
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
kernel-doc originally written in Perl. It replaces the first version and the
second series I sent on the top of it.

I tried to stay as close as possible of the original Perl implementation
on the first patch introducing kernel-doc.py, as it helps to double check
if each function was  properly translated to Python.  This have been 
helpful debugging troubles that happened during the conversion.

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

On version 2, kerneldoc.py Sphinx extension now uses the Python classes
if KERNELDOC  environment var ends with kernel-doc.py. It  keeps a cache
of previously-parsed files to avoid performance penalties when the same
file is added on multiple places.

This series contains:

- 4 patches fixing some kernel-doc issues. One of them is for media, but
   I prefer to have this merged via your tree, as it suppresses a warning
   that happens after the changes;

- 2 cleanup patches for Perl kernel-doc;

- 2 patches renaming kernel-doc to kernel-doc.pl and adding a symlink.
  I opted to have the symlink in separate to make easier to review, but
  feel free to merge them on a single patch if you want.

The remaining patches add the new script, converts it into a library and
addresses lots of minor compatibility issues. The last patch changes
Sphinx extension to directly use the Python classes.

The only patch that doesn't belong to this series is a patch dropping
kernel-doc.py. I opted to keep it for now, as it can help to better
test the new tools.

With such changes, if one wants to build docs with the old script,
all it is needed is to use KERNELDOC parameter, e.g.:

	$ make KERNELDOC=scripts/kernel-doc.pl htmldocs

Mauro Carvalho Chehab (39):
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
  scripts/kernel-doc.py: Set an output format for --none
  scripts/kernel-doc.py: adjust some coding style issues
  scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
  scripts/kernel-doc.py: move modulename to man class
  scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
  scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency
  scripts/kernel-doc.py: Properly handle Werror and exit codes
  scripts/kernel-doc.py: some coding style cleanups
  scripts/kernel-doc: switch to use kernel-doc.py
  scripts/lib/kdoc/kdoc_files.py: allow filtering output per fname
  scripts/kernel_doc.py: better handle exported symbols
  docs: sphinx: kerneldoc: Use python class if available

 .pylintrc                                     |    2 +
 Documentation/Makefile                        |    2 +-
 Documentation/conf.py                         |    2 +-
 Documentation/driver-api/infiniband.rst       |   16 +-
 Documentation/sphinx/kerneldoc.py             |  183 +-
 .../media/ipu3/include/uapi/intel-ipu3.h      |    3 +-
 include/asm-generic/io.h                      |    6 +-
 include/uapi/linux/firewire-cdev.h            |    3 +-
 scripts/kernel-doc                            | 2447 +----------------
 scripts/kernel-doc.pl                         | 2439 ++++++++++++++++
 scripts/kernel-doc.py                         |  240 ++
 scripts/lib/kdoc/kdoc_files.py                |  281 ++
 scripts/lib/kdoc/kdoc_output.py               |  792 ++++++
 scripts/lib/kdoc/kdoc_parser.py               | 1714 ++++++++++++
 scripts/lib/kdoc/kdoc_re.py                   |  273 ++
 15 files changed, 5930 insertions(+), 2473 deletions(-)
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



