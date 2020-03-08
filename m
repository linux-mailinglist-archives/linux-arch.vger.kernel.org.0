Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5417D601
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCHUAY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 16:00:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:53429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHUAY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 16:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583697610;
        bh=5NB8LwQMEvov2zrTRiSnhoKN590O6XxnwdUjG/0cBtU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bStQPB0kDiEdJ1iuKcjufnf5bqKEjxVCdTPPYrZ25TwwY+mHnsldR6Cv5YHljWrC7
         UR7/DQEFwb7LpDOFHvAsYCzmg9hza1n52NZKMJUKybhDJWeG/ZjwuaYslSWFolbPMV
         qKtZzoyP2TqVzHDYUpptqzG78sUlNDD8DNBXwhig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1jS8wG2sGU-00seM1; Sun, 08
 Mar 2020 21:00:10 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 3/3] docs: atomic_ops: Steer readers towards using refcount_t for reference counts
Date:   Sun,  8 Mar 2020 21:00:06 +0100
Message-Id: <20200308200007.23314-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z15oJjooRKTTsLoeHqs+S+XtNMzfWJb/k0eTrWC6vXtAkWl5Yke
 V2O0zrYdI9o2LVloVIG1f2+kKa1byBzaizxeUCMCqQr6fU1fbMklbN8k45+Eh69eQr2u5Q/
 DcgQ5YHxzTbPl4hkI6oyG2TXp58hj1oDLpPsRV389rpboi5C/pykMpyGhtt12wyRC96JM6O
 6CWclKPLLUCPsgqfWCXhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:57m9kADrkYk=:m5A9Ng7axhqlvIfaIRYweD
 V/54F+iwmL3X+FU5FIVDQOpgi+AmD5+UJmBxO2DKATOrRA4D+7VNyirXD7CC1CWwvtjqyvA0m
 sBPB+5qFGkfqbvs1kVKaYt0etzbqstr/GP8NuiElMt1FAOPXBg40pjDdoleimgWwtxpANmYkY
 ni9rM+YTK/wFekfSiZhuqE5uRBQdNBYsgGlkLZ2Jar0d8N3tnQquUYhV7rMEkCDlNGLq+bVCQ
 ma5ksa00/YPCSVm2dfyGNECswp8VZTx8u6hsNHhDMKMHOf7uSZT6aJ0LLtPa7iaDR5y7pnbGL
 /WX0TWQ2NEQDDtIHbssh15Q/YB4pZ9aEVoXvCAQf0bffcrALhVpYEzHCUMRUO+fm0AfwjnLSH
 8rNHjWMKPZron+IhygRLBRHzUZ73BKK/esolNpJRvdcIVIBbbPNkdrewR2pzj85IzCAEHrZKh
 HI0V0cJ60WuKp9zOmTw0PEX5/ysc4r1dkSfCmLPq4/2cB1K7wRAuZn+oKrxmMwVMqOWxMAv2p
 c8F5AOHq4Pvg9lhVLQapWlBiAbawg+83Jahaix3IVbIRxrmfUw0BE6cRL54WKscssfGc4Sqm4
 96tDctmdNINVSuji9B8gWACTP9fpkj8KB2g8A2+ZsjyfvC8yuzWkgK0Azpw7DRpbO65kon2ik
 7jlO3QEsEQ6C8PekXadwQIbPU95corTwXDz7hnzv3JCkjTB16blYrE246lbItB3PpA46qZv95
 kMEsUk80T/U4WDEPQclM9Hn2UKFpgHO2TsnfDPZvaDQueqSst+l8S8f9NSuiw+YNTjdzuKRu1
 zKRlBueDe5cUlVTWr0RJiRC8HjDvQgBzs3Ugo3/IFVEJZYz051MSF+3PAM+o89CxCq/sGNYc4
 UZjpcxIv7H60md1RfKQb0h1kbPbogukdoYrxZBTpi6/RWWfekQjb6Pz5J3Lwkp19B4hnEHEun
 g+UhEu5oquCq/r9Ffyr1DtjqU8MuMKGrz4G8cmyJr8+k6GFFJffMoAfak923ldJarRGkeYxDO
 /NAJiVv829nYdkSErzaxbnJcEMPFJyYoczoBvbJCi229ojem7cUibVHIUbEFb+93iRNxLvTJf
 no5aTAjNI+jvKF2gYeD7ehCTkVkRNlVppc6ZzV5C0CqgTFhY3w5jMnpbVGy4BdQ/orD8MV1hh
 993YSvM/9OK9D8xJa6wxjq+kM7bBAuUUKqBovGw7gsbiOuW6TLQEvmv5H7pLl/5UdL1whWcVD
 MeiOpE0rGstp4cZVK
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst         | 6 ++++++
 Documentation/core-api/refcount-vs-atomic.rst | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 73033fc954ad..37a0ffe1a9f1 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -392,6 +392,12 @@ be guaranteed that no other entity can be accessing t=
he object::
 	memory barriers in kfree_skb() that exposed the atomic_t memory barrier
 	requirements quite clearly.

+.. note::
+
+        More recently, reference counts are implement using the
+        :ref:`refcount_t <refcount_t_vs_atomic_t>` type, which works like
+        atomic_t but protects against wraparound.
+
 Given the above scheme, it must be the case that the obj->active
 update done by the obj list deletion be visible to other processors
 before the atomic counter decrement is performed.
diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation=
/core-api/refcount-vs-atomic.rst
index 79a009ce11df..d979ff5166ae 100644
=2D-- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -1,3 +1,5 @@
+.. _refcount_t_vs_atomic_t:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 refcount_t API compared to atomic_t
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-
2.20.1

