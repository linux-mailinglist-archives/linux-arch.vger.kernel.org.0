Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DE19360C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZCkt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:40:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34174 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCZCkt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 22:40:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so5054390qke.1;
        Wed, 25 Mar 2020 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1af+D2AebQAL+ZNe9HKMFm9Ob8sejTypDhg8sutTV4I=;
        b=qTQVCMmrM1xJU21p3GyIaBlSY9bI6VbPXSH2UrWtbGqro3Z00+cuGfDgKZ82tqdDEF
         1a2bcImmvUoTpRlMpsAIK/pvgugeX5KIgfJQuao+XLfEI34n5BFI14ab9L3hD/uLpNzL
         9ItHnG3TDxjxr11F6NNdqmHyb/hk+y1guWUCFkUhNttX3ESAfJUcIKcPORSLFU1voIwX
         Q4BbgAbVlcorsL8nuXEewnzor7ZI0bWRB2ze1Ev1fqVuoLZRxUDgYIgumTaxYogpRTtw
         aazs0pagqo1uRfb3NnqKrm4fARNZSc5ZDllkFtUFbeAs0uftbQq2vHNZfC7R/0olgF1y
         iscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1af+D2AebQAL+ZNe9HKMFm9Ob8sejTypDhg8sutTV4I=;
        b=cR4SGPOQo+Gos/L1rCOObMHn6PzI0V7YGo7f7w/1kKLjjzw35xw1Sl/Xua0qK+m9ug
         fts3jSt2YWiEfv1pJFCXYas7JHD+eRycqFZ2AlSdD9n0MmV5U5sBGvj1PWTOBqu+arFe
         wwpwNTVPkAwIx/aWiniOZ1YjBKtYHmDPwvoZCZj7Fgx6ClzLT912oLPjIMZ1DDYCPjIr
         7nwU5hrao+60PpBtXEUrWIXDreMHvfu8lPe7x/3WcLaMh+zG5DICUScp72m0Sl8XW4b9
         oreTN0rOiVvp+ZFoyDo9X1HHGLcHTwuJBKrOU+X+kyYjppeJyIUVhYAUoU0At7VWUnPO
         T0Bw==
X-Gm-Message-State: ANhLgQ3p8BOKW52184wDYJJ9A8W0xZWkq4HldUbxvsSldSCelhyaD2sB
        jpFxpB9Dq5kmipPvbBNSLGQ=
X-Google-Smtp-Source: ADFU+vv6CrtxltXHQ+tWyD+SenKIy/DQ5b2cpEeIKQakujzkIu4sCAAbpaJgrUXhpNbPwi9zJHEFMg==
X-Received: by 2002:ae9:ebc1:: with SMTP id b184mr5904222qkg.49.1585190447577;
        Wed, 25 Mar 2020 19:40:47 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z18sm657779qtz.77.2020.03.25.19.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:40:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9D8FD27C0058;
        Wed, 25 Mar 2020 22:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 22:40:45 -0400
X-ME-Sender: <xms:LRZ8Xs50mDUrjKI688-r7iyppocEhsXdU4sTQbVjsby6JqWgiKPu_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:LRZ8XhWsR60j6MirpO8r4rPmP5sJ4BwjKLVQdIs5P8CrOi38W--Oww>
    <xmx:LRZ8XoM8FlEY7Kg0G_b5VHMlbx5nX2DG85r4gqPS_SiQykmIzJqp5A>
    <xmx:LRZ8Xkhj11fW0lxJH6yqC4QFFFoO1BUV5zqMswADVEJEtADpeXe2HQ>
    <xmx:LRZ8Xqs7MiIB0cDXLlgknbuaPQNSqo9LWSbIsfMRyo80XI_QJsm6U4t9DFg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14932328005E;
        Wed, 25 Mar 2020 22:40:44 -0400 (EDT)
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
Subject: [PATCH v4 1/4] tools/memory-model: Add an exception for limitations on _unless() family
Date:   Thu, 26 Mar 2020 10:40:19 +0800
Message-Id: <20200326024022.7566-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

According to Luc, atomic_add_unless() is directly provided by herd7,
therefore it can be used in litmus tests. So change the limitation
section in README to unlimit the use of atomic_add_unless().

Cc: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/memory-model/README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52f2028..b9c562e92981 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
 		case as a store release.
 
 	b.	The "unless" RMW operations are not currently modeled:
-		atomic_long_add_unless(), atomic_add_unless(),
-		atomic_inc_unless_negative(), and
-		atomic_dec_unless_positive().  These can be emulated
+		atomic_long_add_unless(), atomic_inc_unless_negative(),
+		and atomic_dec_unless_positive().  These can be emulated
 		in litmus tests, for example, by using atomic_cmpxchg().
 
+		One exception of this limitation is atomic_add_unless(),
+		which is provided directly by herd7 (so no corresponding
+		definition in linux-kernel.def).  atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback
-- 
2.25.1

