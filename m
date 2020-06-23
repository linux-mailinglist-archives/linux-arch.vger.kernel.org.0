Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5320482A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 05:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgFWD5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 23:57:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbgFWD5T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 23:57:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49rXXq4mX5z9sRf;
        Tue, 23 Jun 2020 13:57:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592884636;
        bh=SGaAFIZ55OPJuGe6GsMrtqm3VezTYTtWZ6QJtNyf7cI=;
        h=Date:From:To:Cc:Subject:From;
        b=ei8UJQ2e7Vl5arK9VnPMV88d6XWiFjV7Ukz+o2bsqTR6TaZ93LxVyQQf958+n0paj
         Uk62JcCwdsNbBnImb3SdHYhiQsHg4Z5c+jZyQ7zG4pTam1SpxQQ0Yt1F4+4b6wQ/QE
         DnS2LTQkCCMYajMCL+2Ijw+a5rBK6vo8unSIQWJMK/uvcjb8muDzPEuVwvwuHeg1+v
         x3y4FFzbYT0uT3sMloUc1Bz+UcDcDVR9BBb5mOYLSwTHwGkeevDcIDmybZYjsZTlrF
         EqRhsrSsJQdDLIQUlg8pHNa0LkK6lBhHstqhkD/WkUGiyPqUgAux8/2wGybYrzLJt5
         v1vb6AlztnkVQ==
Date:   Tue, 23 Jun 2020 13:57:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arch@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] make asm-generic/cacheflush.h more standalone
Message-ID: <20200623135714.4dae4b8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gxL3=hDPdEgWdgdriEUXhr+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/gxL3=hDPdEgWdgdriEUXhr+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Some s390 builds get these warnings:

include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct' declare=
d inside parameter list will not be visible outside of this definition or d=
eclaration
include/asm-generic/cacheflush.h:22:46: warning: 'struct mm_struct' declare=
d inside parameter list will not be visible outside of this definition or d=
eclaration
include/asm-generic/cacheflush.h:28:45: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:36:44: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:44:45: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:52:50: warning: 'struct address_space' dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
include/asm-generic/cacheflush.h:58:52: warning: 'struct address_space' dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
include/asm-generic/cacheflush.h:75:17: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:74:45: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:82:16: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:81:50: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration

Forward declare the named structs to get rid of these.

Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush=
.h")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-generic/cacheflush.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cachefl=
ush.h
index 907fa5d16494..4a674db4e1fa 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
=20
+struct mm_struct;
+struct vm_area_struct;
+struct page;
+struct address_space;
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
--=20
2.27.0

--=20
Cheers,
Stephen Rothwell

--Sig_/gxL3=hDPdEgWdgdriEUXhr+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7xfZoACgkQAVBC80lX
0Gz5jAf/TGFJGFjGN3TkM/wWdczKpOSNE/vrqZGpIBaG68WZWv1hno3xS2NBYppg
luuXUwLZsA5afsboen5N1BE4n4yBiqk55ySVNI73QGoW7UC9itB10O2/zafkVq3u
vLoYV0LLLPpxBsGEiEIoh1YlCu8UBPVRY/MJkH9vVqF+fvTBylFjsOuOFjxTGGMM
QvXnWPrm6kpeABa3OFzmr8hUnSjCTKbMdRMrJY/8rMUSB+YItIUsqPX1+WKW9jwl
FsO4gkf8bQT2deOUR9rGwP67ypW5kHln2q+WcqZ3wzwmmYq/mTgreyG4bnCKmIeR
+dZh2Qf3fkr8DLzekHAayhvTIFn2yA==
=vDO3
-----END PGP SIGNATURE-----

--Sig_/gxL3=hDPdEgWdgdriEUXhr+--
