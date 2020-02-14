Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA015D0CD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 05:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBNEBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 23:01:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43204 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgBNEBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 23:01:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so6128026qtj.10;
        Thu, 13 Feb 2020 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=tfw+i46CoImuNrXLomkqtzbpyGPjfqqMaQ20+xnbCM4U6AdsXDLV6cd0KQkdB2tkBP
         DlSm8x9WPztoXOtNQU8bnnkvG7k7xkEdwRJ8TJsNB4mQ3Sz7WPgzzoIQ61VwdcjtcKoZ
         RhMOJlTjUtVPqhXLLZlzSjF7MBEuv7Hh2bSFX2tStHUApSxgq6cjSw174aSv7OhlsP4x
         tbtufKSUUuarF3UFmlanaI1FmAeEYqAUcEZfUJeKBjXtpVmMUvkESkieuHhn3X3SnZ0w
         hTD8dIHViQ9QoN0+1K2WqMn0xMKB0sEQ81EZNpZRvADaH4Kz7e+oFUUptKpo6OoSOXnd
         3dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=N+rfumG20yTwbljf2+rrwGEtmy/AFylmdygEuDOx7okl3LzV1egF9f2GymlqDdbi7s
         l9wuGIn/Q1ipH5YnZ412xZ7T2eek5Rmss2VzjEepaDTYc9RJzDJv4mRiGmDbrGcagPLs
         p980Fkkn9A46nW2nThRSL6VcWvLOKbTZqYAipgfda83tamFLum8EPFy7p2icggz5xUzF
         x9GCWFV5RblkEtnPe7JxUY7ktz5uwsj0uKGlPdK7+CpoWe4Gym0hs8p6lpgzsFhPubWS
         fpijw23eyM+Fsqk0gL2a3TwIGB1Bq7hzbHrCOnhwUcZKZxNvqOp6sJvyIvwjRhRaQ+RZ
         kZow==
X-Gm-Message-State: APjAAAU3xT7yD3DwhmUG+Btv0bt3jGWvb3kCJMpSw1vojftrJaBxVQ5A
        GC+YAOsYFqmcmRfERntyxIo=
X-Google-Smtp-Source: APXvYqz+CpxxHM7HAQQy4oI6NoLmMH3eYlRg7FQX2lA44UfsLr/2jVVMHCEaWB7kqSFVG0BoUrt7GA==
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr1109339qta.112.1581652908940;
        Thu, 13 Feb 2020 20:01:48 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d20sm2652885qto.2.2020.02.13.20.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 20:01:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C498022171;
        Thu, 13 Feb 2020 23:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 23:01:46 -0500
X-ME-Sender: <xms:pBtGXhLwMEovTebqxP8JRPaLFRHZmSwEb0rcF3oDCszGH30hqqzWOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pBtGXn50StNXB9QNYdnCgmlf16zm3jCXKv_4dvljpJVafLv_LpnnEA>
    <xmx:pBtGXomdJ5D_75uEL46XWo0sjHEWddFpAinHwaNUOR3Cpnoo9hYItQ>
    <xmx:pBtGXpKC-5yoh-eUBrWqNzID-lW82koRqdCLZDkndgju77nnnKwqlw>
    <xmx:qhtGXv6vzDg8rZAPE-y1TFNcyAb95mAYNwLDjC56g7izGhAPxQqTYJY8jfg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AD7330606E9;
        Thu, 13 Feb 2020 23:01:40 -0500 (EST)
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
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 1/3] Documentation/locking/atomic: Fix atomic-set litmus test
Date:   Fri, 14 Feb 2020 12:01:30 +0800
Message-Id: <20200214040132.91934-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the litmus test "atomic-set" in atomic_t.txt has a few things
to be improved:

1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
	the rest of the document, which uses "CPU0" and "CPU1", but also
	unacceptable by the herd tool, which requires processors start
	at "P0".

2)	The initialization block uses a "atomic_set()", which is OK, but
	it's better to use ATOMIC_INIT() to make clear this is an
	initialization.

3)	The return value of atomic_add_unless() is discarded
	inexplicitly, which is OK for C language, but it will be helpful
	to the herd tool if we use a void cast to make the discard
	explicit.

Therefore fix these and this is the preparation for adding the litmus
test into memory-model litmus-tests directory so that people can
understand better about our requirements of atomic APIs and klitmus tool
can be used to generate tests.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/atomic_t.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0ab747e0d5ac..ceb85ada378e 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -91,15 +91,15 @@ ops. That is:
   C atomic-set
 
   {
-    atomic_set(v, 1);
+    atomic_t v = ATOMIC_INIT(1);
   }
 
-  P1(atomic_t *v)
+  P0(atomic_t *v)
   {
-    atomic_add_unless(v, 1, 0);
+    (void)atomic_add_unless(v, 1, 0);
   }
 
-  P2(atomic_t *v)
+  P1(atomic_t *v)
   {
     atomic_set(v, 0);
   }
-- 
2.25.0

