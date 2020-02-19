Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37434163D05
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 07:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgBSG0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 01:26:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45868 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgBSG0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so21985321qko.12;
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HMg8C//Gc14csw0uJPav6rU/FNvPunllTjWyYZF7cs=;
        b=BwTM2rKpbmRJBBxznI9VLrAlLa2aLq/X5Ul5iRpm6uXEVJ3eA4i62bLj5zXWVWhwk2
         S+7TJiY60G6JkN7dfslcGmM6325/nE2H+J8zvs3JxpijXb4gWkMm8wOoCKkEDImoWn8d
         Hi5g3PXKcmWZ2Rzbz7YVTtNp8vLjFbKMaORaE7wdzSVLSzGI61W5ySAZjEwfYzbHXGz+
         W2FjMkJMrmOk+t6F39SYL0MW4tXlxf0v3esnp+4OMxws5zKG1AWcQh0EpYbgxvHUPJRC
         qfJGhYPMdtCIUMFZkyjkxYOi76Cj+ywtv7Ufy+gyzcLBoBT9ZSHD03VbcbGbObrAbX/U
         haug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HMg8C//Gc14csw0uJPav6rU/FNvPunllTjWyYZF7cs=;
        b=j1VvZoOL+4ni5G9o4dQz4xPVePCID1NN+lAQVvE5Sd8ipyW5X63EnG0KAG777A1TOF
         6fxddua86IBYQpkWwlGyZhzOoTTwW+HAtw2Um1GAwiu8nkKlIxUxY8sg3Xb1QJ0ufgR6
         o+PI4y0UF8nRRPOM8L+rhX+6cXDhRkQokHM0ZJTWi/9QKvl/SL2ARHv/cgnsB4vCLAzI
         ApAqUXFAdmenBovJMO9mEAQXAB5zZh+aKUged0tfWurDWPx5LKHToKk+KvwBxiP+i2cb
         McNRAMf8t392VRGfA4hYSpHG/2IzSgQHj11fHLkqcff/9w4EAIlVE5T+0TFChfu7yzAn
         33cw==
X-Gm-Message-State: APjAAAWAnljHnowEgF4d2RlaqCwX0v6OhILLJKu72xnQaa0HMThQuWjk
        NIymcazJV4jVSNKZt5XK668=
X-Google-Smtp-Source: APXvYqxif1JyhDWqZCyKF5l7TytfFOs+IG1mg2VnPW0A5QjnL+NDfKXjp22JVJUBD3EkrFlg/CpmvA==
X-Received: by 2002:a05:620a:9d2:: with SMTP id y18mr20914420qky.98.1582093600631;
        Tue, 18 Feb 2020 22:26:40 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y26sm478351qtc.94.2020.02.18.22.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:26:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7CFEA2206E;
        Wed, 19 Feb 2020 01:26:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 01:26:38 -0500
X-ME-Sender: <xms:HtVMXsKQZ7RtJVp6-LZqPQQ_TxmM5zPbI2OoBdLp3pddcFzGrNLKyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HtVMXqqDX8mnsUWq_4MxORSs_0abbgoIZK6dexLEFaj0yNdV_OEpKw>
    <xmx:HtVMXi4En_YNQcX6xibtsYmbypY00n9FdnPj62gzw6eyphc8bTkgmA>
    <xmx:HtVMXuLHIpua12sk5q6kYmQWUgTGQ-SdovYsITP2iH_ufmFNrhZcjQ>
    <xmx:HtVMXuMWtjPMr95Qncg_6zo6T1g7ZVdm6s5Ks_8S9rui9zTI-pDEJdsUeq4>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C75E63280064;
        Wed, 19 Feb 2020 01:26:37 -0500 (EST)
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
Subject: [RFC v2 3/4] Documentation/locking/atomic: Add a litmus test for atomic_set()
Date:   Wed, 19 Feb 2020 14:26:26 +0800
Message-Id: <20200219062627.104736-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219062627.104736-1-boqun.feng@gmail.com>
References: <20200219062627.104736-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We already use a litmus test in atomic_t.txt to describe the behavior of
an atomic_set() with the an atomic RMW, so add it into atomic-tests
directory to make it easily accessible for anyone who cares about the
semantics of our atomic APIs.

Additionally, change the sentences describing the test in atomic_t.txt
with better wording.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 +++++++++++++++++++
 Documentation/atomic-tests/README             |  7 ++++++
 Documentation/atomic_t.txt                    |  6 ++---
 3 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus

diff --git a/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
new file mode 100644
index 000000000000..5dd7f04e504a
--- /dev/null
+++ b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
@@ -0,0 +1,24 @@
+C Atomic-set-observable-to-RMW
+
+(*
+ * Result: Never
+ *
+ * Test that atomic_set() cannot break the atomicity of atomic RMWs.
+ *)
+
+{
+	atomic_t v = ATOMIC_INIT(1);
+}
+
+P0(atomic_t *v)
+{
+	(void)atomic_add_unless(v,1,0);
+}
+
+P1(atomic_t *v)
+{
+	atomic_set(v, 0);
+}
+
+exists
+(v=2)
diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
index ae61201a4271..a1b72410b539 100644
--- a/Documentation/atomic-tests/README
+++ b/Documentation/atomic-tests/README
@@ -2,3 +2,10 @@ This directory contains litmus tests that are typical to describe the semantics
 of our atomic APIs. For more information about how to "run" a litmus test or
 how to generate a kernel test module based on a litmus test, please see
 tools/memory-model/README.
+
+============
+LITMUS TESTS
+============
+
+Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
+	Test that atomic_set() cannot break the atomicity of atomic RMWs.
diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index ceb85ada378e..d30cb3d87375 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
 the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
 and are doing it wrong.
 
-A subtle detail of atomic_set{}() is that it should be observable to the RMW
-ops. That is:
+A note for the implementation of atomic_set{}() is that it cannot break the
+atomicity of the RMW ops. That is:
 
-  C atomic-set
+  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
 
   {
     atomic_t v = ATOMIC_INIT(1);
-- 
2.25.0

