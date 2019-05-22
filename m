Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2EB266C3
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfEVPSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 11:18:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbfEVPSX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 May 2019 11:18:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7653780D;
        Wed, 22 May 2019 08:18:23 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41EE23F718;
        Wed, 22 May 2019 08:18:22 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, jcline@redhat.com,
        geert@linux-m68k.org, vincenzo.frascino@arm.com
Subject: [PATCH v2] checkpatch: Fix spdxcheck.py
Date:   Wed, 22 May 2019 16:18:11 +0100
Message-Id: <20190522151811.50348-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The LICENSE directory has recently changed structure and this makes
spdxcheck fails as per below:

FAIL: "Blob or Tree named 'other' not found"
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 240, in <module>
spdx = read_spdxdata(repo)
  File "scripts/spdxcheck.py", line 41, in read_spdxdata
for el in lictree[d].traverse():
[...]
KeyError: "Blob or Tree named 'other' not found"

Fix the script to restore the correctness on checkpatch License
checking.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Note: Rebased on linux-next/master.

 scripts/spdxcheck.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 33df646618e2..6374e078a5f2 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,8 @@ class SPDXdata(object):
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "deprecated", "exceptions", "dual" ]
+    # Note: exceptions needs to be parsed as last directory.
+    license_dirs = [ "preferred", "dual", "deprecated", "exceptions" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()
@@ -58,13 +59,13 @@ def read_spdxdata(repo):
                 elif l.startswith('SPDX-Licenses:'):
                     for lic in l.split(':')[1].upper().strip().replace(' ', '').replace('\t', '').split(','):
                         if not lic in spdx.licenses:
-                            raise SPDXException(None, 'Exception %s missing license %s' %(ex, lic))
+                            raise SPDXException(None, 'Exception %s missing license %s' %(exception, lic))
                         spdx.exceptions[exception].append(lic)
 
                 elif l.startswith("License-Text:"):
                     if exception:
                         if not len(spdx.exceptions[exception]):
-                            raise SPDXException(el, 'Exception %s is missing SPDX-Licenses' %excid)
+                            raise SPDXException(el, 'Exception %s is missing SPDX-Licenses' %exception)
                         spdx.exception_files += 1
                     else:
                         spdx.license_files += 1
-- 
2.21.0

