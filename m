Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08034193611
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCZCkx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:40:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36034 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgCZCkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 22:40:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so4147815qtb.3;
        Wed, 25 Mar 2020 19:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3wMLtwJjVx+cW6i5BwYTXEhVTKTsG2r4lo8N4p/ptY=;
        b=G+XtDpPYFDSyRzm0QXWKZwQ1v4BUaj6m0HrOPZTJHDU3pfomu98YgSKwFfgzg6spNT
         MA/Im34q5ZDnMIVDB04KS2MZ6ywaKwGuzN5sxLdAkkKzrzv/xALvRWvBLm67Jg8GmqcD
         SDvcbfJSJPkLPYIEtwwQ3HIO7SB+UZa2Ef2ghVJshGBcGjJTJRcnJb/vg5+Lq4qiU3oA
         vdBKRD1F9pBN9MB4xTVS7Eb7+NXh7FQmfPPvAmCZs76yu8PUFLYQlzk6EcglAeT3iq9G
         NXH1XN2z1N78uOO5wCL/szfhsHW/bQUbR62QUD2MvRgWj1vuu7ac5itB89CuebQUegGO
         S6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3wMLtwJjVx+cW6i5BwYTXEhVTKTsG2r4lo8N4p/ptY=;
        b=lO9U8w6+OCI7bBn8ie+i28oIdNMmtjgs9nffZCCEDIAO43pePl23M5oDTQCEd0oIpD
         pEwz85sKVZabPcTqi6BTYOvRHKCyXnXX8lSWTtAkio27o8l9rdw0hHUmZtpCmEUSxDQO
         r9uV8EZWeRaI8LFYiyci+4HFoRKDdZtmOW528bm29VzlHcahHkXC50ikhsw8YPe6BJCA
         BFEEUJeLuVlNIA1WtpNpr1Yx7APUGE/h3ZhWWQQeeuuqw5/IFLGPwGR2GHzIho6caMlu
         /Xg0ZKWM84W6LWUqS5k+5QO5du/TD2es4xwjHocAiMKY6tWK/DX0n7CebUCmenbc3aLA
         ECXg==
X-Gm-Message-State: ANhLgQ1ZJkDCSLwWBi0xYRyPADWJU40ouutSkSfC9clm/n6XDOlvValb
        ZJY7ylBXnwRTDei3j1/pN6g=
X-Google-Smtp-Source: ADFU+vuBYJphO1kTx7mC+IwOjpOMaxnxWuorjwSu3zdstMRXUhAMpjk5Wd3f7oSj7xg9X7A6HUovpA==
X-Received: by 2002:ac8:5458:: with SMTP id d24mr6099798qtq.255.1585190450781;
        Wed, 25 Mar 2020 19:40:50 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u15sm671282qte.91.2020.03.25.19.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:40:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A946227C0054;
        Wed, 25 Mar 2020 22:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 22:40:49 -0400
X-ME-Sender: <xms:MRZ8Xqd8-e4xC1P39ujhKq2Cuq7B4duhzav-mY5x6Nao14FdrU43cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MRZ8XtIR3odx_LF3yzi81FiCAFdznMqZoAVYaOoLhkhBjZaMKRdwvQ>
    <xmx:MRZ8XkRopE2VapEkhzcYlNz9SqWQ0difShU7j7nyusQlX4ZP4iAJ7Q>
    <xmx:MRZ8XrGX5wVt6WtziPOuUHhgv5x3wTjshA0ZcEXQv55_IZmJ7UHlGw>
    <xmx:MRZ8XgnzRFB-Ng4uvMGCighA-lZ7GYgscs2tR7on794xWeWpf6GyiZYOs8o>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27FAE3067F32;
        Wed, 25 Mar 2020 22:40:49 -0400 (EDT)
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
Subject: [PATCH v4 3/4] Documentation/litmus-tests/atomic: Add a test for atomic_set()
Date:   Thu, 26 Mar 2020 10:40:21 +0800
Message-Id: <20200326024022.7566-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
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

Besides currently the litmus test "atomic-set" in atomic_t.txt has a few
things to be improved:

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

4)	The name and the paragraph describing the test need to be more
	accurate and aligned with our wording in LKMM.

Therefore fix these in both atomic_t.txt and the new added litmus test.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/atomic_t.txt                    | 14 +++++------
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 +++++++++++++++++++
 Documentation/litmus-tests/atomic/README      |  7 ++++++
 3 files changed, 38 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0ab747e0d5ac..67d1d99f8589 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -85,21 +85,21 @@ smp_store_release() respectively. Therefore, if you find yourself only using
 the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
 and are doing it wrong.
 
-A subtle detail of atomic_set{}() is that it should be observable to the RMW
-ops. That is:
+A note for the implementation of atomic_set{}() is that it must not break the
+atomicity of the RMW ops. That is:
 
-  C atomic-set
+  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
 
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
diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
new file mode 100644
index 000000000000..49385314d911
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
@@ -0,0 +1,24 @@
+C Atomic-RMW-ops-are-atomic-WRT-atomic_set
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
+	(void)atomic_add_unless(v, 1, 0);
+}
+
+P1(atomic_t *v)
+{
+	atomic_set(v, 0);
+}
+
+exists
+(v=2)
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
index ae61201a4271..a1b72410b539 100644
--- a/Documentation/litmus-tests/atomic/README
+++ b/Documentation/litmus-tests/atomic/README
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
-- 
2.25.1

