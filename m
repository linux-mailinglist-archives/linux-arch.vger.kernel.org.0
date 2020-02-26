Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E567016F60D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 04:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgBZDWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 22:22:00 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36793 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgBZDV7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 22:21:59 -0500
Received: by mail-qv1-f68.google.com with SMTP id ff2so693117qvb.3;
        Tue, 25 Feb 2020 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BD1v6ba+2r56oC0/ebLwqYI1y4GFppKRXuPk+6nsRH8=;
        b=YdiogCH1KkMuVBITidQZokgpQeKA3s8zG+vfkM3gTUNQgmBd4rHvC0+ckVBZswyjNS
         nm9eLiiq8mk3pG4Kvg7LlsVLr/2ORtmqBw9rFQKXDafoderhSmFCT736eTq7VOkGZvMb
         852/mYuLIhNKEIgHqU/v1ll8pPnUDjXS5ohVkjF8MWUru6KL+OcWQqpfl2/2GGhBs77M
         M2SdNAU/waAo91bHe7Bpub502rfCJz5UZOREZzaP5o20GUtZ8alPnP5Fdjv6Tt4TvHMF
         zGlAdMowzbpt6afwOVeOMSSW1JFPWYgnrTLCOZvBzDtY9meFvqlRjrL70Zeb5cqKENJf
         LPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BD1v6ba+2r56oC0/ebLwqYI1y4GFppKRXuPk+6nsRH8=;
        b=Zn2WrGG1LBhOWtE5brRCK+Yr9EMKNMVBP96DQImqIg4IQD0veAqYjvRJgjFKaz06YE
         o2SEL4czipvRx+1mZzp/Ivk55KmQ6XMZny/HDZbA77BhU7liDPtAqad0Vgsbyna8N2tl
         4uS7H8RpzwmT5GaVcUc+MtAnaH/iNCw6I60W9sAiQeqsvrMaB+XyzzzReZjAJrCcFU5p
         M0I0UNA+u/kHN/eXZXPTwo1U7mq/8JCNihAcqZ6fhkv8MhA7WKFrw5PYYouSJIbX6er/
         nC5uY3/WIWw5cihbgb8GCS3nr1hR7MYLOiN+uNbB4xZDRdx82bgucz5Vhl+t5XkhGuMZ
         zItw==
X-Gm-Message-State: APjAAAVtQnzHUWAawojSTvdHiXsKHk+edqJKJ6hp9ZFYB0zKbBT7g6m5
        qxyDeVJ9dGnOluRXiY3umBg=
X-Google-Smtp-Source: APXvYqzNBdzTkdJdbZng4SXlA0GJlJqTbzKL1u6PAVVOHA7Frl8p+t3f77RnPOpt2/YtCtPh2+KWZQ==
X-Received: by 2002:a0c:f404:: with SMTP id h4mr2600337qvl.251.1582687318833;
        Tue, 25 Feb 2020 19:21:58 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a13sm347602qkh.123.2020.02.25.19.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 19:21:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 83E462151C;
        Tue, 25 Feb 2020 22:21:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 25 Feb 2020 22:21:57 -0500
X-ME-Sender: <xms:VORVXkfe4OU3IO88Qlia6dMTXr0Xrap-bSEBXf7TW_GKDXjcbaOhTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduhe
    ehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:VORVXu67VdYHcCh3iC8cmV4C6GL2_FSvtfOWROhiNB5xdN6CKOkFdg>
    <xmx:VORVXldtRuACX9KojoLYBVKeYiS96AwJ02WgUUqbWbP_ZPaybQodUQ>
    <xmx:VORVXmewzs-GS7VdtmKqSZYdejydTVmT0Q1nGY8wBpFnPlX4o0HTXw>
    <xmx:VeRVXl-Rok7nkLNZhGohG54SohVOLylpgmjz_3CqA20NHgmzsETd2fUjmf4>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7692E3060FE0;
        Tue, 25 Feb 2020 22:21:56 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org
Subject: [PATCH] tools/memory-model: Remove lock-final checking in lock.cat
Date:   Wed, 26 Feb 2020 11:21:40 +0800
Message-Id: <20200226032142.89424-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In commit 30b795df11a1 ("tools/memory-model: Improve mixed-access
checking in lock.cat"), we have added the checking to disallow any
normal memory access to lock variables, and this checking is stronger
than lock-final. So remove the lock-final checking as it's unnecessary
now.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/lock.cat | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73a..827a3646607c 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -54,9 +54,6 @@ flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
  *)
 empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
-(* The final value of a spinlock should not be tested *)
-flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
-
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
-- 
2.25.0

