Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3707B11508C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 13:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLFMqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 07:46:20 -0500
Received: from ozlabs.org ([203.11.71.1]:34691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMqT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 07:46:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47TslW10tCz9s4Y;
        Fri,  6 Dec 2019 23:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575636375;
        bh=oyct4tPxjrlkjB1zVGbKoKAWyEMXqFKQz+rA6a80J+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=LDjqbEKiUq8oNBats/yrnw90N+Rzv6Z+iiPnbOmZZ7DL568ZE4JOjjBHlEHFJfoeC
         O8SOYmwLdmsN/V6kENixnnz/vOn5jzuNy7pWqQswsJTHN0f6lUjVdWV07IzT1YCnzG
         1kL6GA7mRfq+HW2DeqJRjs0wlndNWkpM8er9OpYHENOK74c0gU4iuMOYCsOKOIFdBq
         X+dupxBqvuGoTt7G8GxlraeFfKp5A0+6fkI8sOnQrpLnXb8TO52AAXLDQdhAsk4l/7
         Pel8A8JoKvjlh+CqVUqwUBN4H7e+QZd4Je2t+OCOU6hgqTDNkgZRQDLShw8uq+fP7g
         X1AGIjbhox6vg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dja@axtens.net, elver@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops)
Date:   Fri, 06 Dec 2019 23:46:11 +1100
Message-ID: <87blslei5o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc update for 5.5.

As you'll see from the diffstat this is mostly not powerpc code. In order to do
KASAN instrumentation of bitops we needed to juggle some of the generic bitops
headers.

Because those changes potentially affect several architectures I wasn't
confident putting them directly into my tree, so I've had them sitting in a
topic branch. That branch (topic/kasan-bitops) has been in linux-next for a
month, and I've not had any feedback that it's caused any problems.

So I think this is good to merge, but it's a standalone pull so if anyone does
object it's not a problem.

cheers


The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-2

for you to fetch changes up to 4f4afc2c9599520300b3f2b3666d2034fca03df3:

  docs/core-api: Remove possibly confusing sub-headings from Bit Operations (2019-12-04 21:20:28 +1100)

- ------------------------------------------------------------------
powerpc updates for 5.5 #2

A few commits splitting the KASAN instrumented bitops header in
three, to match the split of the asm-generic bitops headers.

This is needed on powerpc because we use asm-generic/bitops/non-atomic.h,
for the non-atomic bitops, whereas the existing KASAN instrumented
bitops assume all the underlying operations are provided by the arch
as arch_foo() versions.

Thanks to:
  Daniel Axtens & Christophe Leroy.

- ------------------------------------------------------------------
Daniel Axtens (2):
      kasan: support instrumented bitops combined with generic bitops
      powerpc: support KASAN instrumentation of bitops

Michael Ellerman (1):
      docs/core-api: Remove possibly confusing sub-headings from Bit Operations


 Documentation/core-api/kernel-api.rst                |   8 +-
 arch/powerpc/include/asm/bitops.h                    |  51 ++--
 arch/s390/include/asm/bitops.h                       |   4 +-
 arch/x86/include/asm/bitops.h                        |   4 +-
 include/asm-generic/bitops-instrumented.h            | 263 --------------------
 include/asm-generic/bitops/instrumented-atomic.h     | 100 ++++++++
 include/asm-generic/bitops/instrumented-lock.h       |  81 ++++++
 include/asm-generic/bitops/instrumented-non-atomic.h | 114 +++++++++
 8 files changed, 337 insertions(+), 288 deletions(-)
 delete mode 100644 include/asm-generic/bitops-instrumented.h
 create mode 100644 include/asm-generic/bitops/instrumented-atomic.h
 create mode 100644 include/asm-generic/bitops/instrumented-lock.h
 create mode 100644 include/asm-generic/bitops/instrumented-non-atomic.h
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl3qSS4ACgkQUevqPMjh
pYCp1Q//TrG2tPMDPHpWqCzNdWoh96zpIo2UsauDcc8l+XT7shkwHcGnpoECgCfK
NjhP77qqXI61E+5qUCfO16/j5g6PbvvG/E/xlQEdgX7lIxBeGs4IkoRU8QjkJ9w5
wAjG/XwaMJ21CQY2F51dn9NPQUvFxKV0o6QJ+/pIFBnv0eeYCtRWno7+tZGIiMhk
ExfJhR0rnBdBc6oonNOTAfWn5u51FRRqUeICeo4iFoICu5v4cTbPiU3/8bZYzhSb
wM9WdG+/IUs02PffIQF4GDyMmzi/Qm3Ujl3tUIEaFHlfN9pF6X7Yog7Co26CShJj
No4wJK5rS3ECXmwo7Yd69sV9FZrMZZvGY9x7p7bEE7mqk1fHMaM3DMXvR8Gx6UGM
NCXX2QIIigz3RUTbj3CW2iZa9R/FTSFXs3Ih4YDDJdPNanYpcX3/wE6mpwsco8do
lxWcN1AMGXLiaNdQ8IkRZ6hOLH/Po34RvDo1P1mS06NzfyyTZW7JNiUtU2HSqPRs
vjIkHDM7585ika6jeDHU4cJaLy7bsCNV2fLsHWDE3Xno43g7qcKGOx+PtO25XubZ
iP1vojR4Qml+e3ySf6dDiOIDltSWZwjCGtbi2gmdErHiLdLeJX2XGjC36Qnep6u6
15HIWzX41tg8y4QRJDmPyeDm3Ccbabz+m4LaccbdObgGWVwxwgA=
=06Wr
-----END PGP SIGNATURE-----
