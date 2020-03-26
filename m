Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584BF193607
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZCks (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:40:48 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44999 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZCks (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 22:40:48 -0400
Received: by mail-qv1-f65.google.com with SMTP id ef12so191815qvb.11;
        Wed, 25 Mar 2020 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idGta4luNVSKS6GW2+ESu4EKkWBs8WP4Ue5RLpisqic=;
        b=s58FkVK2VS5nIUEpx35Dg+XpAtamo8rZb+W7VG0G/DfjqjVvXf7y/UecHk/tLag54N
         vf5IVrJhKPMQRau3Dr/COlsOVXtXxcoBfRLv0HlxwvE3icS7lil46z1vahQz9GDaafPS
         ak4W7KtRR0fS5oRTsfHO9+BI0ofWOm0YuSYs/pRvjpDPwVGAKvXiJ25ZcyJPZDrCiIeM
         xCx/gcH9VtBJWU+ahIaNsQvA3KEpOii8p0iUOvyc5gRUWHzG7cpf3M5xpMyyHRdu3xyx
         2/QU3KYVzFeV87lbYwtX51BaieZIfyVCWmnoR+jHabH/MFhzUz2lt37DLgDCcWBDwqru
         L4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idGta4luNVSKS6GW2+ESu4EKkWBs8WP4Ue5RLpisqic=;
        b=PfOfe6uvsgOue+ozZGHYVtkFfDccbQt/b0e6g9ma/4LxY/p/q2GxZse8ThR+wpvpt7
         tPNSY5jhbSsKF6qAOl0cbVkNmNRAL6QW2VZnMCgu83jarhv9rng/SLNKcjlVz5XNar0S
         vnsi73vRXC+/q9j9HiRCpMQdts3OUysWCplgHC1STYdx1czKXpRQ+Okvkp9VNFM/Jnbs
         MJTYeLROIucizw6XzJDjyfVf++C4hzxztfNQKFXWaZ9lJ+RFWyvC224vmsD2hU2TulGY
         bnyOFHqHQPplxvrzMSj7kp+ygaeYWakZp5vKdJG5BYillhIRdIpC2gaItDbsY9OLujI5
         8z1w==
X-Gm-Message-State: ANhLgQ38WmO8J5ea98IvLOmkUkRJDctM8TORAIuzN2WQAO5t4BFQ1yQ0
        z/hdh/oaFxNXNR+OX8rFNV8=
X-Google-Smtp-Source: ADFU+vsNgnyfhpljlUm/dd7r6QFg2qIKSawuCXxyyfiCk8QkTD9A9rzxOdk6a6c4CI+6pvQeypDvRw==
X-Received: by 2002:a05:6214:205:: with SMTP id i5mr6096054qvt.223.1585190446959;
        Wed, 25 Mar 2020 19:40:46 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l45sm707146qtb.8.2020.03.25.19.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:40:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6617127C0054;
        Wed, 25 Mar 2020 22:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 22:40:45 -0400
X-ME-Sender: <xms:KxZ8XuzYz1XdCG71TvFXZcDBhEMaq9mdUMlLldpu_OyE2ZaVSJelhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpihhnrhhirgdrfhhrnecukfhppeehvddrudehhedrudduuddr
    jedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KxZ8XqsrYAPpxlYTwLZDAk6zNoXWHSmlILR9YSbu6of4qAOBUHGIsA>
    <xmx:KxZ8Xlx9kDc2ZAydTrQCeAvmwF5VnMmcoypos-NOSRDlcabCfF0pTg>
    <xmx:KxZ8XidfLuidvEfXmH14XIedyjYDDAiynzuXmHdAzbAaviKdWLg5-A>
    <xmx:LRZ8Xpzo-nfrkR_oI-YGuRPbLxM8WKrPUepKcZxEb5CSq9Lriy5R4PUvcRY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24BC33280063;
        Wed, 25 Mar 2020 22:40:42 -0400 (EDT)
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
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for atomic APIs
Date:   Thu, 26 Mar 2020 10:40:18 +0800
Message-Id: <20200326024022.7566-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
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
v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/

Changes since v3:

*	Merge two patches on atomic-set litmus test into one as per
	Alan. (Alan, you have acked only one of the two patches, so I
	don't add you acked-by for the combined patch).

*	Move the atomic litmus tests into litmus-tests/atomic to align
	with Joel's recent patches on RCU litmus tests.

I think we still haven't reach to a conclusion for the difference of
atomic_add_unless() in herdtools, and I'm currently reading the source
code of herd to resovle this. This is just an updated version to resolve
ealier comments and react on Joel's RCU litmus tests.

Regards,
Boqun

[1]: http://diy.inria.fr/doc/litmus.html#klitmus

Boqun Feng (4):
  tools/memory-model: Add an exception for limitations on _unless()
    family
  Documentation/litmus-tests: Introduce atomic directory
  Documentation/litmus-tests/atomic: Add a test for atomic_set()
  Documentation/litmus-tests/atomic: Add a test for
    smp_mb__after_atomic()

 Documentation/atomic_t.txt                    | 24 +++++++-------
 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
 Documentation/litmus-tests/atomic/README      | 16 ++++++++++
 tools/memory-model/README                     | 10 ++++--
 5 files changed, 91 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/litmus-tests/atomic/README

-- 
2.25.1

