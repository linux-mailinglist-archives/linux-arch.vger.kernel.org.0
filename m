Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C6170D4C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgB0AlF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:41:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39473 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id e16so1521331qkl.6;
        Wed, 26 Feb 2020 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OdPtLBop+fC+UYcJhsj8xgvQ6AFBIgkeZOtZL006YA=;
        b=Evu0pvTuDu5Cnqs7pLtSruDmtez5tqpYKV4/So80R/WTbqrDCje7SHf5ICzXJUVzeP
         jwWhO+zTNZwkHIFFHwMe79GR4R30pInqmUlvZltzF5gqRhwL/0+FgUlIFYu5qZlws5HQ
         pCREjbBhQnT//Jtxz+wyw59hmFEEBuTD6CcyV6u///7RvfccIZPn+B95W+xGHUZb0U1T
         G8Ru1+1l+elTr1FSLVCpeLbPTlUlcI+D3SxqkEha8XG7aCxYjpV6qb/aXPqV34sVfSPj
         02blhWdIeEIBxY2dyW/7GbeFJgB3Vz8z23d605/zYJi2mFoluVr+5wgDEhKdXCLmnjgU
         mtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OdPtLBop+fC+UYcJhsj8xgvQ6AFBIgkeZOtZL006YA=;
        b=JyRKQb0ZfNuenndd5MIuNLNpBRz74ILDn8xvf5MJ3nhKVy11m1U2P6qjxMLh2p/BR2
         aF2hdmZRFpzsl/o0Nb2Xuj6mCM6AyqirOICe6JttnnMKI2XehWlczcjLd+MtO73JDQrL
         a/h4jahkAUV/JmiV6TYxoJNlKlU/t/DY00SwxlXEjMy2tTdcjjUslHhEXjh8jdcic/wB
         e9+Uup7snbak/6NWvEd595YIo9fAjN26QiXugfNKFVLw80gVBLvLQsX/WWTegt+BiEWp
         RYfdlBdJjo27s4UH+4w2LRwb6lsIjT2f79o668F89erc6P8yP60ChYf7ywxx3hXKS3/+
         WqEQ==
X-Gm-Message-State: APjAAAWxNEXbF8frTtsVs7cz6Qo9arSCUOTDgsGN8kkUWCVQfps/qERr
        uPWur5SXfYgZfLMVpb62IGA=
X-Google-Smtp-Source: APXvYqwNdg6qTDXs6Js9yWF7MsODuS8t9r2umsIaFcnEMaU6i1Jc9Faey2EdkdKn2UyJ70iEwNYboQ==
X-Received: by 2002:a37:e409:: with SMTP id y9mr2374269qkf.352.1582764063541;
        Wed, 26 Feb 2020 16:41:03 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w21sm2251344qth.17.2020.02.26.16.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 46E1A21F8E;
        Wed, 26 Feb 2020 19:41:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:02 -0500
X-ME-Sender: <xms:HhBXXj1ydKbc0boCSM0pNQ0jKhosqSawnU6__taT-Ma_Om2hW_KXUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HhBXXjDwq_Cb3rbLtqc6Et36mFmixp0T3cJGligzyQnqyz4TSXvQpA>
    <xmx:HhBXXkNq7d0zqZvFiapCroHQj7R9rvFgMKpqC6fLbn2-Hs3j4RdzdA>
    <xmx:HhBXXnQ61IhTNEfHYgOzXeWHZZq3v_1E_Ie-agFvL4MdRUQq7tHIEg>
    <xmx:HhBXXjtR2sTBXjE_x_neRGvqYD7XDUTyejJgYBKzK45aeN5QxIlo_-ejjx4>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC3463060FCB;
        Wed, 26 Feb 2020 19:41:01 -0500 (EST)
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
Subject: [PATCH v3 1/5] tools/memory-model: Add an exception for limitations on _unless() family
Date:   Thu, 27 Feb 2020 08:40:45 +0800
Message-Id: <20200227004049.6853-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
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
---
 tools/memory-model/README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52f2028..409211b1c544 100644
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
+		definition in linux-kernel.def). atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback
-- 
2.25.0

