Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2258E5AD75
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2019 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfF2VLF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 17:11:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35954 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfF2VLF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jun 2019 17:11:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so12106727wmm.1
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RnN8+araUIrTEOZsBFjA6OS/4XJR8mt8ImjbzPCHMmk=;
        b=cBJYEcqwp4nEnjU9R3h0ZoBvLcdkF+X9VSuvAk68akW9zWj6vJCCrUirrNw3/UJXpZ
         SSi6UaenWa0Nz3yg/67TqBZopY1REBJcPM9iGsKp74eLmIeevpViiAWYaLSc8dHNG0pF
         KZf2GmGdFY+J7AvjAc7L709OZoTbDnzkr544g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RnN8+araUIrTEOZsBFjA6OS/4XJR8mt8ImjbzPCHMmk=;
        b=XVXRvVk7wGMzJHWMlnL8etu9ml6KitQVNAU5dPD5Yzn2cNJF1OCBrHvbuEpEWVHn4h
         7taqS/20XeSVh/7+lVI13y1a+/e3QyaDp24BCMfaIhD1XJ42sOLkRmAUnCjdtYSxa/FT
         AGbceEnfoUOcjWz783dy/hhL/z9ce33MIQsi0lNHZrgvMC4jQtbIKHqpgAyiaA2DCBmI
         0NfUi2b/VqYhWLCuQO6n6IVc8+nSZdGJCQoFuJjc3rCkwp4SP6L6preQys62P3a1178f
         vUQWBZNtP2NzMcP6bImNgO4rMsaZ1tjABgmc7/v0dAJHd4jDn/h4teCKHJ2dD+vedZDR
         KueA==
X-Gm-Message-State: APjAAAVrq8WoQQ7nu/zsd1BfAWpWx0PBHk29W0R0IrsFMrQ52wGeuoR9
        H55c9k4xqG27LnnQYkJZiHz8KCp1koM=
X-Google-Smtp-Source: APXvYqxWmfR5B1+1TqkLISrF7bzXpZeR5DVgcFemebukmqjixJbC8msEscsyZ7BAus7i/llmtJ0hug==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr12136114wml.90.1561842662451;
        Sat, 29 Jun 2019 14:11:02 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-62-100.net.upcbroadband.cz. [94.112.62.100])
        by smtp.gmail.com with ESMTPSA id x20sm5402150wmc.1.2019.06.29.14.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jun 2019 14:11:01 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH] tools/memory-model: Update the informal documentation
Date:   Sat, 29 Jun 2019 23:10:44 +0200
Message-Id: <1561842644-5354-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The formal memory consistency model has added support for plain accesses
(and data races).  While updating the informal documentation to describe
this addition to the model is highly desirable and important future work,
update the informal documentation to at least acknowledge such addition.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 tools/memory-model/Documentation/explanation.txt | 47 +++++++++++-------------
 tools/memory-model/README                        | 18 ++++-----
 2 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0c..b42f7cd718242 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -42,7 +42,8 @@ linux-kernel.bell and linux-kernel.cat files that make up the formal
 version of the model; they are extremely terse and their meanings are
 far from clear.
 
-This document describes the ideas underlying the LKMM.  It is meant
+This document describes the ideas underlying the LKMM, but excluding
+the modeling of bare C (or plain) shared memory accesses.  It is meant
 for people who want to understand how the model was designed.  It does
 not go into the details of the code in the .bell and .cat files;
 rather, it explains in English what the code expresses symbolically.
@@ -354,31 +355,25 @@ be extremely complex.
 Optimizing compilers have great freedom in the way they translate
 source code to object code.  They are allowed to apply transformations
 that add memory accesses, eliminate accesses, combine them, split them
-into pieces, or move them around.  Faced with all these possibilities,
-the LKMM basically gives up.  It insists that the code it analyzes
-must contain no ordinary accesses to shared memory; all accesses must
-be performed using READ_ONCE(), WRITE_ONCE(), or one of the other
-atomic or synchronization primitives.  These primitives prevent a
-large number of compiler optimizations.  In particular, it is
-guaranteed that the compiler will not remove such accesses from the
-generated code (unless it can prove the accesses will never be
-executed), it will not change the order in which they occur in the
-code (within limits imposed by the C standard), and it will not
-introduce extraneous accesses.
-
-This explains why the MP and SB examples above used READ_ONCE() and
-WRITE_ONCE() rather than ordinary memory accesses.  Thanks to this
-usage, we can be certain that in the MP example, P0's write event to
-buf really is po-before its write event to flag, and similarly for the
-other shared memory accesses in the examples.
-
-Private variables are not subject to this restriction.  Since they are
-not shared between CPUs, they can be accessed normally without
-READ_ONCE() or WRITE_ONCE(), and there will be no ill effects.  In
-fact, they need not even be stored in normal memory at all -- in
-principle a private variable could be stored in a CPU register (hence
-the convention that these variables have names starting with the
-letter 'r').
+into pieces, or move them around.  The use of READ_ONCE(), WRITE_ONCE(),
+or one of the other atomic or synchronization primitives prevents a
+large number of compiler optimizations.  In particular, it is guaranteed
+that the compiler will not remove such accesses from the generated code
+(unless it can prove the accesses will never be executed), it will not
+change the order in which they occur in the code (within limits imposed
+by the C standard), and it will not introduce extraneous accesses.
+
+The MP and SB examples above used READ_ONCE() and WRITE_ONCE() rather
+than ordinary memory accesses.  Thanks to this usage, we can be certain
+that in the MP example, the compiler won't reorder P0's write event to
+buf and P0's write event to flag, and similarly for the other shared
+memory accesses in the examples.
+
+Since private variables are not shared between CPUs, they can be
+accessed normally without READ_ONCE() or WRITE_ONCE().  In fact, they
+need not even be stored in normal memory at all -- in principle a
+private variable could be stored in a CPU register (hence the convention
+that these variables have names starting with the letter 'r').
 
 
 A WARNING
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 2b87f3971548c..fc07b52f20286 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -167,15 +167,15 @@ scripts	Various scripts, see scripts/README.
 LIMITATIONS
 ===========
 
-The Linux-kernel memory model has the following limitations:
-
-1.	Compiler optimizations are not modeled.  Of course, the use
-	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
-	to optimize, but there is Linux-kernel code that uses bare C
-	memory accesses.  Handling this code is on the to-do list.
-	For more information, see Documentation/explanation.txt (in
-	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
-	and "A WARNING" sections).
+The Linux-kernel memory model (LKMM) has the following limitations:
+
+1.	Compiler optimizations are not accurately modeled.  Of course,
+	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
+	ability to optimize, but under some circumstances it is possible
+	for the compiler to undermine the memory model.  For more
+	information, see Documentation/explanation.txt (in particular,
+	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
+	sections).
 
 	Note that this limitation in turn limits LKMM's ability to
 	accurately model address, control, and data dependencies.
-- 
2.7.4

