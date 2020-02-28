Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C413F173D68
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1Qre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 11:47:34 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48063 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgB1Qrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 11:47:33 -0500
Received: by mail-qt1-f202.google.com with SMTP id x8so3374959qtq.14
        for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2020 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BnK1UC8c2/CTg4QSSZm4VfbP+eP/ZMTQTgyW0tFmuUo=;
        b=oKHI60QZm2rlT6eBR6VI7kjQy/pmu9oHGrNy5GtFXYulqvu2WVhbxI6VKR0aJSZo0s
         0Kq8RgQ5pC99AQczsAgQNGlqf5AXSdoRFDll9Cu30Ikbq3MPnZlbObjMyBsGSEW5/u3J
         DV5rRIbYPHCudOQB2m87fmFy+50kFlUtQmLWzfU6IixBggrmfSm1gAmArDijGrlaoC8X
         1ZB0cGKlwNlTE/lvavlzG7Hi+X/7o+WUo9ITg9o6wcelcRa+ZW6pIk++JzmDMB/YQ1St
         JssiVMa/xjuZRwv0j4u6iF4r981UiGPtXMC5+JbwHrvqMQBDiMFuS3tby67vkeVHyjR5
         VAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BnK1UC8c2/CTg4QSSZm4VfbP+eP/ZMTQTgyW0tFmuUo=;
        b=Z67M1kKt5XcTBZbka76m4uHrCL1huL6xoRD+fSaThCl8N4UchIUk0bCzDzVGHAiSVw
         IxyT1tKb6iJwFSxmgBR77hcU0GcBXuUq/9WKzi15cC7xMjTIRijxUfKali9vq9+FdZOU
         US4+XM2NOGvE+rhfKQA++t471uWo8+NdqLKzxWXy7c7JK+PYK4qn+IoWl+iPzMdSheTv
         Whh+OgUGWWGPZ85z5cGz3OQL5kXn/zx18lk9SOncAzD6SRyehqkmB15dI88KoDQeMSOZ
         seynfywif8UOIlCMHKrFIoIdOqi0S7MZlEpzzgWYij3OI6GFBSyIMBjnfDg3z76vrIgt
         Yxaw==
X-Gm-Message-State: APjAAAXW7IOA/FIH0patt+XJvFw1UuQeomonm1dCvPuLRDIQ8k0z4iJ7
        Iozoe1bxYpRqKvHTL7G6FuZOsGDI7w==
X-Google-Smtp-Source: APXvYqzJx21ry142l0iuLlgEHIDwP/oc8aeEElRCwP142AhTC+YK6mASR70FruAnTTEZVOchzHvuEhoIeQ==
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr4596272qvb.84.1582908452572;
 Fri, 28 Feb 2020 08:47:32 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:46:21 +0100
Message-Id: <20200228164621.87523-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] tools/memory-model/Documentation: Fix "conflict" definition
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For language-level memory consistency models that are adaptations of
data-race-free, the definition of "data race" can be summarized as
"concurrent conflicting accesses, where at least one is non-sync/plain".

The definition of "conflict" should not include the type of access nor
whether the accesses are concurrent or not, which this patch addresses
for explanation.txt.

The definition of "data race" remains unchanged, but the informal
definition for "conflict" is restored to what can be found in the
literature.

Signed-by: Marco Elver <elver@google.com>
---
 tools/memory-model/Documentation/explanation.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e91a2eb19592a..11cf89b5b85d9 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1986,18 +1986,15 @@ violates the compiler's assumptions, which would render the ultimate
 outcome undefined.
 
 In technical terms, the compiler is allowed to assume that when the
-program executes, there will not be any data races.  A "data race"
-occurs when two conflicting memory accesses execute concurrently;
-two memory accesses "conflict" if:
+program executes, there will not be any data races. A "data race"
+occurs if:
 
-	they access the same location,
+	two concurrent memory accesses "conflict";
 
-	they occur on different CPUs (or in different threads on the
-	same CPU),
+	and at least one of the accesses is a plain access;
 
-	at least one of them is a plain access,
-
-	and at least one of them is a store.
+	where two memory accesses "conflict" if they access the same
+	memory location, and at least one performs a write;
 
 The LKMM tries to determine whether a program contains two conflicting
 accesses which may execute concurrently; if it does then the LKMM says
-- 
2.25.1.481.gfbce0eb801-goog

