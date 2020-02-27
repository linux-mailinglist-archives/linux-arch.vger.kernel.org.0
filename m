Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43A0170D59
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgB0AlI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:41:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33965 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AlI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so1555427qkd.1;
        Wed, 26 Feb 2020 16:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=F2qNJqQ/nxukuQLqMQ8LDKqVQBLaSEuhqxKYY3WL/1rQyqPyPcnxh+w8Y4m0c3No+e
         e4yL6M5uxZDuAqzoNlVWrhOBmVeSU8rbwoXtMb7Xli80pnCYFx83Dl/svFSdGA+nHulk
         SHhVulTUyXtftksHmP9YYkk8cUKNCViCConM8aBI8QDFXfr2FsWS8NcYA7utOy0683RP
         pldYJOLfnIWiGTFxL12qoI0QnijGKROo86t/gmiuEnqeh0nfh5hrVhCu3StbKi0LeCzt
         ij5GElt/oaE3OaPO14+F1yQ4w3D5OincfD8sS8rpkJuHC5xxx5bcuGXaTF52r11WFvIX
         gKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ2H7GSAMnnXMQ7tQkUf2nC+EabJVUC+NrDmPk4E/8c=;
        b=IOM0MdWP6sli1WmNxXG6xkIH/aQiobcPE5Vstme1hIT3rX64mT55XIKt8xJVB3x7ER
         0+ZD2bf+qvePPsSA2nX5AS68EiyJhQI9eJudw7Bmzaimzi3wtiSigz0ESHvvx5gnR6tO
         j0tb1OG7Ah8JFoRZCM6/Cj2qt51cUx0jRvLCzt/jkoBGFPZF/+NgI2xzn/za4DJbU7du
         itibIrhGW+bIcS5F/53BoBBAEzPKA2Jw6B+Jsp9ZVteJyTtUS8PfuPIQGHJbnO8CqlG1
         57UI2MwTTXuPr6WZXWFN9hgWUhswg7CJTxKpXlTUi4w5+Fi5Yqwyk5k+jYP8plNgPN6S
         OBWg==
X-Gm-Message-State: APjAAAXTfXyxvXpcWYfy2drk+Kq4Uv+REyhMmJbufLYiw9Wqv1vPo/Ss
        ks5RDv0fjhJcDJxGaQEZOYw=
X-Google-Smtp-Source: APXvYqxbrLXw6tXXxDuP+1PBrZ9eNPIEJkkS+t9oY+RvDA8x2O1me/3roihbgHVvYBApBxtXmr+KSA==
X-Received: by 2002:a37:584:: with SMTP id 126mr2098625qkf.109.1582764065840;
        Wed, 26 Feb 2020 16:41:05 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v10sm2023422qtp.22.2020.02.26.16.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:05 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 21246210B8;
        Wed, 26 Feb 2020 19:41:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:04 -0500
X-ME-Sender: <xms:IBBXXp0byI8Sr1nDu6VpUAIgtrlRuKCMN0Ry4a51SkX4P-y0ZWBNGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:IBBXXiqhLDuq95SCxipoY0USLZMaMlu1AeklX_bKUstbsb6bz9Pehg>
    <xmx:IBBXXq1ZajnbXx-U5tRwjunkoodHC4S34iNuX1mpw6GPT6x-ZlvQQg>
    <xmx:IBBXXr26NzkUi5vBxayz9uU2VVE7EoL4ItgLR8Rpn8OVuC9nAwgkaQ>
    <xmx:IBBXXg8NCRnsrgeQOyuxkvyj6WtqEkzsZ7FLVm1IeOFoOJYNxkSJzOErAq0>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 93B4F328005D;
        Wed, 26 Feb 2020 19:41:03 -0500 (EST)
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
Subject: [PATCH v3 2/5] Documentation/locking/atomic: Fix atomic-set litmus test
Date:   Thu, 27 Feb 2020 08:40:46 +0800
Message-Id: <20200227004049.6853-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
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

