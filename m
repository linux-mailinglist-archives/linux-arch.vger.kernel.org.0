Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB57170D55
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgB0AlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:41:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47095 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so1466807qkh.13;
        Wed, 26 Feb 2020 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+35hcLU4zzCdOSfG6fb49K/S0DW2VGPDWnNF5rpuiwQ=;
        b=C6JJsnK7U6NH9bhM50SS5AaCEip1/9eZSxoE8ch2DFmRyvUT3hqUbAjzwko3y9slFB
         tsdg4fsQ2hwndAR/NLdR7ppc14xEy7PzLBF/a10jm5ee56/QZ9oFM1For7qifsoq9WIn
         8bxfuFf3GmiAwRKDhw0GO2Kpvlol1oAgVP3RaMDqSIzyL4gzP/e2ukbzQOJ940UIVDZj
         zuQWQR7hOjrLO5vUt7fu+NPhcJU47qBfEDCcWCcUn6CxT6YS9+aVTYYb1eV0NnKkLGsb
         JfRQuVHn++8ei6vHbz+E3LI4BrDxbcUxQouJxcTV3ZzO/+0Z7jBlFKzhv2JmtPVSMn8K
         5H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+35hcLU4zzCdOSfG6fb49K/S0DW2VGPDWnNF5rpuiwQ=;
        b=reAxmwG+S88w5h/2rlI6Xd9BUETMdJb/OWXT4ATch0myj/XS9fcMSTbWtlvYd84TIJ
         WD4snyO6GEQZQ4CCBMHqaMAlYmT16cAXlHw0uzWIZH1iBFoO4ikzP4NKMuU0u1Os2nqg
         WZpIp6I/8arSWymtQp3kJEk2L+f9e9BbjrUBaYp0/LlfGqL99Rxn9JR1nxSJfdse51Tq
         mYGw34pIJ30rza0oQnH+8YNtDmUVPnMVT5Dd4w/kYfnWgkW3s7XzzJeXRPCqeet7flfV
         4SoivUTHShIm2E3hz+J3Bi4+vRojGn+z6A7T/3CF6EzKSUQwm1BTcxRE70GLqMU6qPyk
         Gz4Q==
X-Gm-Message-State: APjAAAVwEvOQObXiAE22Wq1xyYVcJCrPdIc1881gjLTzsuJnEH2S1fvv
        S3oiirqrFLjhruC4oMHD/us=
X-Google-Smtp-Source: APXvYqz2Fl2DvUj2IXnbioeSwkulWhQ4FlmVWlyZ7mbn3Sioru7DxSnGZyv4ixPuQjfnkVsEuXl6ng==
X-Received: by 2002:a37:9302:: with SMTP id v2mr2254596qkd.208.1582764069352;
        Wed, 26 Feb 2020 16:41:09 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t187sm2106200qke.85.2020.02.26.16.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id EA9E621FE7;
        Wed, 26 Feb 2020 19:41:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:07 -0500
X-ME-Sender: <xms:IxBXXsusYIdv7Sp1_DEWFqgLo0tc5vONdVI3zpuKwKl7-J0BiwQzsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:IxBXXkdGHYHydNSQQr1aHzIZms5_qu4s9diVzi8e7RO4WsEU4-BEXg>
    <xmx:IxBXXk4cUPTR_zL1cKVbCpyUEsrvjdNUMG4PeCEBWGz08hR-xmhh9Q>
    <xmx:IxBXXnxCX1MWfDtdDjmyJFY0mjYIol8f6Qdhkl2rLxBqAePrlhFTGA>
    <xmx:IxBXXolnGpfTia30vL-ma_quOY6uVx7BK1Rh2gYGP1P2zq5TJsFibN1hHLA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B4F73060FD3;
        Wed, 26 Feb 2020 19:41:07 -0500 (EST)
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
Subject: [PATCH v3 4/5] Documentation/locking/atomic: Add a litmus test for atomic_set()
Date:   Thu, 27 Feb 2020 08:40:48 +0800
Message-Id: <20200227004049.6853-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
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
index ceb85ada378e..67d1d99f8589 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
 the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
 and are doing it wrong.
 
-A subtle detail of atomic_set{}() is that it should be observable to the RMW
-ops. That is:
+A note for the implementation of atomic_set{}() is that it must not break the
+atomicity of the RMW ops. That is:
 
-  C atomic-set
+  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
 
   {
     atomic_t v = ATOMIC_INIT(1);
-- 
2.25.0

