Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42BC163D06
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 07:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgBSG0n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 01:26:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45689 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgBSG0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id d9so16404066qte.12;
        Tue, 18 Feb 2020 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=rKJxhNv5wGvJhsKnTBK4YtRp/YPepIxCZibTeVVJBsakRBUVYiE/RvvKM2SWoSiv6W
         3rpgBtrigG316w1IRLPT9cKv6yhp5IhmOj4otpCaBUt0LxNryk+XP/LfFv3gRsa2iQQu
         8xcNUrTjWB6N52Fycm5lSOVHLTU5fHz0FdrfTWdmHNk/N9aXIUHjLdl7nSJuVf//aAEX
         xuLrkaLj1DxvafN6QEjRiiGNpBk2Q3PUsIgo1D9XMw/7H+hmT8hjjtKH3lorcbR51T0N
         TR2CgkSPQ2M3qcp7owB2NVatDudLwvR2OCcezgNwdxjybPYORERA9/vlefem4e//seiL
         lXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=PtrRbYgPJ8yITorQ1FOOwYCmv37SCAu86xL+WnBbWze/TGhauA1REXVdFiLpmlbHLM
         7BqzU4dlpS3Acz6YRVrpY0oRIute9G+qHMC3F0B5/1izlKrXgMGvVIcneiME82G9F2lj
         ZnzniEzVp/NwdBXYgyEF8QXfYNO4UHy4X1+gWm89Rxblpc05r9ztCXIzqlkF8lRlMbNV
         /Sn3FnCqbggRnyEUnSasjyU2R6mrCorIEbwxauwdTzV06vE6hnAuKXSGjyHX5Lvzyt3c
         PeeMAMEwz8siuAoaW7zFMYFIaCPfzLJ8PLjf9C7DU3p4wUOmTMtNaj41bXw2ve7KD2Sa
         FKyg==
X-Gm-Message-State: APjAAAUfOpL0Jbq85wT14kLIFtR0MndqSXDuK7B1RKmGHekowrqwUTj9
        R0JSsVy8+uencokkfPow9M0=
X-Google-Smtp-Source: APXvYqwfVzawCJrdissi9cmzdJabtwsuniKtGZBlaEuIVuZkbOCOlCZMIkYy6D2m6vTP8Os6GYqalA==
X-Received: by 2002:aed:3344:: with SMTP id u62mr20250881qtd.73.1582093601653;
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y28sm547964qkj.44.2020.02.18.22.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:26:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7ECCA221BC;
        Wed, 19 Feb 2020 01:26:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 01:26:38 -0500
X-ME-Sender: <xms:GtVMXrDm7Vx5VOCzDI3RoNAvRsI0Ueomuqg22faeDmcFjdspBpcnpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:GtVMXnjQz3FM3-6rYtmdj67kEqpGWJZtJkZ2Pqcq5JqglgPnIp7mew>
    <xmx:GtVMXhb8J_2C6ibBDNg6nOembC_ZG3KxJvpPwf6_WRlJtOWlhNJk9Q>
    <xmx:GtVMXgkqPPH6ewkKC3jxHBilQX1c6kqvWKpZ2oh8ForIKxp7wGRoHQ>
    <xmx:HtVMXvtq_GinbBygnVbgOqKTr6sfozOKADlbPAmSGVFMBt16_BJcxyVN1Qg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 940D8328005A;
        Wed, 19 Feb 2020 01:26:33 -0500 (EST)
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
Subject: [RFC v2 1/4] Documentation/locking/atomic: Fix atomic-set litmus test
Date:   Wed, 19 Feb 2020 14:26:24 +0800
Message-Id: <20200219062627.104736-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219062627.104736-1-boqun.feng@gmail.com>
References: <20200219062627.104736-1-boqun.feng@gmail.com>
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

