Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E414333913A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 16:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCLP2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 10:28:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:58795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhCLP2e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 10:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615562901;
        bh=5kxWxnJH6TxGILTbWiEuWrtMiE4DpLAno4eP5DaAVnM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kiKXOysos2SmX0B8pydGx/TlqeNKGYPZVqafF9L5KKf1Al2XFMky8lQfp1MKLafQR
         u/QUfHptnDrDwR7jBurSje/dRs7eWKoCvC+Tz3VLm8bFRNSY83gukQN+tuzcSAODwF
         IZKra52x10JkVmVRzlG1owQNUrmao7pr1QvPzkEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1lutsH2fjA-00aZGP; Fri, 12
 Mar 2021 16:28:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH] docs: Group arch-specific documentation under "CPU Architectures"
Date:   Fri, 12 Mar 2021 16:28:03 +0100
Message-Id: <20210312152804.2110703-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ebQTw4lZ+rVZ5nvFoAmTj5OAS3v/fSaT0/jFvCvQVpD2gpKnVw
 DilHPjUKk0X3YA+e0yFNd1JIULXgIiQL40MkLj7dZA8ysVSSilzZ7qMxg0HWQZ1wZq9/0K3
 AlikEl29YsjY9T29dZz7XsfV1x5rdiUHqcVejJieZkb79pkNISCbXGhKVp5K9eocWVNHWNb
 CCflKytTdcFSBiCjkTG9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uihwH/s/73s=:+hoH2NdeT68B6TmcizC9x1
 TXVdHUe+JqESQt16Cq5/oXL3DvFyFqeaXccPt9272v//kgr3m8I0HKN4pRVradhhqBazITH7z
 BbDh82hc+C6xAu1YOOl/p58eCju57v2gzTnsTnIk3KJBaFXpo0gOUT01yse58b2Gb0TLHmP3B
 iO8qd4J12Wkpa/Nfs/y7NWqqO6bUrRiUQVHiuhAst9cBuXHRD1PYYx6y4KwAuTjYb6hQ/Rxsu
 4Rh7HBmuXbztjNUPCa1/AbxuAiiivPP3OlMWQW1sJIijtCfksooewFj0nnHAoynHoLyynUkun
 t7RGGKqiPEQHhHHpzpJvVZJ9NNDhGoiRMeh//UM8cVa6rYYMma2SPhXVJk/qSTyAikR6LbV4N
 pouSs8E9SSJWIj6CfbEn7BMDuaWfDS0ZRMjlecjFRrgopGIbOjg1XNZesVdGqhfbiaZd/shtG
 AsOwJORRB9VMct6kVmuYcX4AfHQ5M9VEbN4ivte5AaQjT4ir1Xj8kt5slQuR2CZfwdNT2KHYs
 wmru5aU2NjA2wff8w7VcDcb/bf9G9hp+Ja78L4MemUNHGE58bgAIUtePAP9eCp7jU1zZ5K7IC
 94guYKUzco1RFQa3/Mhw+T2PK8021yuCHoF8lwcPt/q1jy+xssVya+koF1aBOWK9pkfjA8f/R
 l5ZsYi/Zl4oZ4lLN/SnKD2i+q6cPvMru0mG9BjYePiTHwchhHlsDRG4Fq0dO+Xj9OjqSngkzU
 aMc0KVWmjwEupvidUCE+dXxuIwMiLE0bzmsokMK3PDoTKCDvSVKzYORAKsl5L3x4VyOXMc/9F
 OtjA0VL0FSNja1T1BVrci/JdSpkHG27IJCCohsnGiksPsKAC849jSCMly54uYsmxeXUoPoAdo
 +ABCTXVJnsJjMza5TP8Q==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To declutter the top-level table of contents (the side bar), this
patch reduces the architecture-specfic documentation to one top-level
item, "CPU Architectures".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

As a side effect, the TOC in index.html effectively gets one level of
detail less. This could be fixed by specifying ':maxdepth: 3'.
=2D--
 Documentation/arch.rst  | 26 ++++++++++++++++++++++++++
 Documentation/index.rst | 20 ++------------------
 2 files changed, 28 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/arch.rst

diff --git a/Documentation/arch.rst b/Documentation/arch.rst
new file mode 100644
index 0000000000000..f10bd32a5972e
=2D-- /dev/null
+++ b/Documentation/arch.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+CPU Architectures
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+These books provide programming details about architecture-specific
+implementation.
+
+.. toctree::
+   :maxdepth: 2
+
+   arm/index
+   arm64/index
+   ia64/index
+   m68k/index
+   mips/index
+   nios2/index
+   openrisc/index
+   parisc/index
+   powerpc/index
+   riscv/index
+   s390/index
+   sh/index
+   sparc/index
+   x86/index
+   xtensa/index
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 31f2adc8542dc..54ce34fd6fbda 100644
=2D-- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -149,27 +149,11 @@ Architecture-agnostic documentation
 Architecture-specific documentation
 -----------------------------------

-These books provide programming details about architecture-specific
-implementation.
-
 .. toctree::
    :maxdepth: 2

-   arm/index
-   arm64/index
-   ia64/index
-   m68k/index
-   mips/index
-   nios2/index
-   openrisc/index
-   parisc/index
-   powerpc/index
-   riscv/index
-   s390/index
-   sh/index
-   sparc/index
-   x86/index
-   xtensa/index
+   arch
+

 Other documentation
 -------------------
=2D-
2.30.1

