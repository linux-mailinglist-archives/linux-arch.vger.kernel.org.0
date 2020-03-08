Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856ED17D5F7
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 20:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCHT5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 15:57:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:42973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCHT5C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 15:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583697395;
        bh=k4B7xsbQs+bGw1/7XAkvqtfIygtmmkN+AUAITvCNN/c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dMwiXmLYL52XV8WSu9yMkmq0S+luVbFbLbWoj+XuVizgA/OBMQV0RbyDYuLEUGNZZ
         SPsT4HG1k8jfjcIT8p7uzvFbaTviNgXFMCYnzXoObQisd35cFvjWrNJqMPtQuclLc5
         ED+DLfpxgPG084xMFFyObMRNHx8Lj33Qjt8ftcjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1jqyUd0tRo-00g3N3; Sun, 08
 Mar 2020 20:56:35 +0100
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
Subject: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Date:   Sun,  8 Mar 2020 20:56:15 +0100
Message-Id: <20200308195618.22768-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2bg8Bw8rRMj0oQrgWU3DtrKtOTVoYSHypqxza7mwLqSU6cjHy7t
 HpxSsUXtJnGg4PJvcF/WuMzdv5v8zwtOzwku9Rz/GUDhwJ+Ncj5MS5AR4JFAzLSW7UMxmV9
 DusUfn8Z3oUJcMmh5KpTEu2gTm0vilnq6GAKaHcvNnqbviO4D+NtGHomHRHTzCkYF/i7RSy
 15mW72yvO88kd2Q/ovVFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2km+uksWJ5M=:+BGq6we/viAuTeermSySs0
 aLE3qtDiTK2CsCUTKziii8WMqPYrX9qlgVC5/7Kf7msmsF1brw86mqPfSANg9ZsODcHJG9ZFS
 0UYafyIirulDcvowp2v5pmpst8NXYnO2lli3D7BZ0lUoOH87icTr2mG1T7ZH5evSbFoJRn1k2
 blUTUACesrC1Qm04hBlGxMa9sRddrjLlQTdBjwXSEuqWInYBJtjaj8o6dF2CF1eceAvBfjvS6
 9/PpkOcto8SWPP/rLZQ+OA1fsKjefWyWSozV8SY0TzXLgqayKo6sSahIL2hiy4FlD6oclGLNI
 1Kh6VuBzM1+jPWKq+pJVDMdsmAXRVlHuSL3RokNGrWTo4/pctEA5XXoYWdvD0qfpOxhqExwKD
 i9m/ezrJiYe0Z+kdJvvdilZcsRCwuSfLgbjLxFmCVvj1Yk6YE29qP5nDkg2tIzWEW/X9zF49n
 uCbzKN9baKwOtLauSNyy350l2VUFfM0pc3KwoQThuNMWgQwwNQqCQf9oO//gcOsrYu2SobRVO
 Q7nsxC8jpUcpFQf15SeWyCduIQoVizINptckXx70blOsnPHV8wp/unClL5/BPX3NQGXG/nP8R
 GIL+SRa9BUs58lFPsIdve7mQtD8Kc60r3rAwKDl9ci6bviIpeRlAJTnXxKeyvf7JDndOb+YHB
 lGrEIkRpy2YGsn7Tium/VdCKw6HVSgtAx5L1tRmVBxGJxocBurMT6/yOw9GQVvjjDZDP7ksgv
 +tSPixnXDcJxXk2Z0X2yZPeKrXYOUdF8/JtmiOJ+Z/e0VNQYwLGPs92DOtiC4WVNFSgBziNoK
 qddxZZ79JPicJEriHCiPDkcBD4g+uDhJF35L/OS8W0UM/SdtayeErP9O4UCXH9iHoYsCaGVOh
 sn9wYrTyWtV21I5ZNyfIJiYDmN+R/HRj1a2KONb1oUVSN/PsmV0H/Wd8Gvvz8SoqZIHVS96oM
 n8tlEhAYx7nSRKYi6rg+xsb+H6Sq6V4XGFmHnroFnMTUSR7g9xpwvHStrTZZ/uVDtonmVgfVl
 eMW9aDb8htQ7ORFbXs7AVoQ6nrnYUH24RckMI5epo1S9nj5ikPnjNpaKOubMk0SMxuN4qfWKj
 pOQa3LC0Y6LSZQs3KkmoRXTZJv9THA1tSAv53k8mpJlrn/yb8q++NFiuPyy652dB65LNgMasN
 JOAArZV8CkS/a6FXdHA7/eYRTwPSDKue23/9nF7ShjhcX3bTJwHqneW2WcIGKuWQyFI84tOnM
 flTRSV0JpZZtWF2HZ
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

this is a short series of unrelated fixes that make the atomic
operations documentation look and read a bit better.

Jonathan Neusch=C3=A4fer (3):
  docs: atomic_ops: Remove colons where they don't make sense
  docs: atomic_ops: Move two paragraphs into the warning block above
  docs: atomic_ops: Steer readers towards using refcount_t for reference
    counts

 Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------
 Documentation/core-api/refcount-vs-atomic.rst |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

=2D-
2.20.1

