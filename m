Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B7163CFF
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 07:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSG0o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 01:26:44 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43885 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSG0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:43 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so10317635qvo.10;
        Tue, 18 Feb 2020 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AcgEW7Nzia0J/XRf8fWH9Xd9Cf6gra4pdDV/CfwMW8=;
        b=GkQkIkwu3bSBbkX5iqfaiTQ/EWXrz7RZHKk2yfg4nz7wWXo3quKjX3E1IRLce3DGxm
         DplPfnCtn7dp9hhWpY/m2B8BJGFYwXZ4UFL26QEpai5NBUKZGR5LUxerP3pM02MKRmDb
         dbW3rq5C3WlbwtJzU7rGzptNTJ9bijeu49I5lcCvqqRyXt4Li7Nq5AHG7qh8BocxZuo8
         3JUvL2bDAEQF29tEpfdh55zkmHyWcE/+4NjUILBwfQEZWakU1a79/LBR/96xkGKzeJYO
         Yfxk5dow2hM9ycQ54JPXQNrGf0NQYMRyENq95jFH8CIJ0xPJUS1qXXTBufppfHlVvrnG
         pHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AcgEW7Nzia0J/XRf8fWH9Xd9Cf6gra4pdDV/CfwMW8=;
        b=an9qdWkJg9iZy6SckGcjEHQJuO7sb44o41kielXRHYDWn+RWH5lVjYUUDioKxogaRK
         tt+qc3TGWkUTPuSts5mXg4toWlm4Q/x3Zk+UqY0oNgEUm4v0/r1eb6EOI7s580BlwF1w
         LABL7VBJxIZIWb4YqCwhpzVurRexHtuFBzfhr4+DJCvzSVMEAW5/9/I6RGVulfHcsoqW
         DJVgszClK0V5Fuqt08E+5oFgNXZ2eHruF3WpGK5ToeqqanCtZFE014LZuoS7yTeUZk86
         jRK0Cg4Y5NnDUT6DEeulA5AMEqiFnXaK2HDOKOxr1o6X2ZsL5PwmBO1MYj5ZXBBN/S4p
         5GSQ==
X-Gm-Message-State: APjAAAWWfEcNX8OAfoyvnNyy9w6wdRU0TmyMzibN9uYFFEOG5dpc1MSz
        yAspTFribQ2KTsSptBb71/k=
X-Google-Smtp-Source: APXvYqzKwD91/nC2RbUzYfJ4VcV0Uo/JIoQ1VLbyw/Ly/Uh2gsKDSrQwovgooWirT3x3ZqGaABhHpQ==
X-Received: by 2002:a0c:a281:: with SMTP id g1mr19893975qva.168.1582093602261;
        Tue, 18 Feb 2020 22:26:42 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g84sm528780qke.129.2020.02.18.22.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7F9B52221A;
        Wed, 19 Feb 2020 01:26:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 01:26:38 -0500
X-ME-Sender: <xms:GNVMXmv9xhC6qNyttzhAS_dCGFzqMF0jdB2vfajqLYe5Y2NjOIAnuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpihhnrhhirgdrfhhrnecukfhppeeh
    vddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:GNVMXpLvH150ImJ4YxZj3Q7cZIgosNe75Fm00EUVZ6qP5-CZHjDInQ>
    <xmx:GNVMXjgX4Y6OBKcc6r73mxGCrsDQkM7zIm9fZuXYoCio95u-9zSecQ>
    <xmx:GNVMXtvrvoMiU0sMYDbfkbaYwRATfJM6Irh7uW_6vazje5SaU45ayQ>
    <xmx:HtVMXiN7X9oPH7cijwrpi040vXQDHgFB4xchEe4BixliuaIOj1SJ59dEryk>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id A263A3060BD1;
        Wed, 19 Feb 2020 01:26:31 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
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
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [RFC v2 0/4] Documentation/locking/atomic: Add litmus tests for atomic APIs
Date:   Wed, 19 Feb 2020 14:26:23 +0800
Message-Id: <20200219062627.104736-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A recent discussion raises up the requirement for having test cases for
atomic APIs:

	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/

, and since we already have a way to generate a test module from a
litmus test with klitmus[1]. It makes sense that we add more litmus
tests for atomic APIs. And based on the previous discussion, I create a
new directory Documentation/atomic-tests and put these litmus tests
here.

This patchset starts the work by adding the litmus tests which are
already used in atomic_t.txt, and also improve the atomic_t.txt to make
it consistent with the litmus tests.

Previous version:
v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/

Changes since v1:

*	Move the tests into Documentation/atomic-tests directory as a
	result of the discussion with Alan and Paul.

*	Word changing on litmus test names and other sentences in
	documents based on Alan's suggestion.

*	Add local variable declarations in 
	Atomic-RMW+mb__after_atomic-is-stronger-than-acquire to make
	klitmus work as per Andrea's suggestion.

Currently, I haven't heard anything from Luc on whether the
atomic_add_unless() works or not for the LKMM, but based on my test and
Andrea's previous test, I think it actually works. I will add the
corresponding changes to the LIMITATIONS part of LKMM document if I got
a comfirm from Luc. And my PR:

	https://github.com/herd/herdtools7/pull/28

is still not merged. So this version is simply an RFC and comments and
suggesions are welcome!

Regards,
Boqun


[1]: http://diy.inria.fr/doc/litmus.html#klitmus

Boqun Feng (4):
  Documentation/locking/atomic: Fix atomic-set litmus test
  Documentation/locking/atomic: Introduce atomic-tests directory
  Documentation/locking/atomic: Add a litmus test for atomic_set()
  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()

 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
 Documentation/atomic-tests/README             | 16 ++++++++++
 Documentation/atomic_t.txt                    | 24 +++++++-------
 MAINTAINERS                                   |  1 +
 5 files changed, 85 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/atomic-tests/README

-- 
2.25.0

