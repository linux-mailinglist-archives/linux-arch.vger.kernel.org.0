Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020992580DB
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgHaSUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbgHaSUk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:40 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E850214D8;
        Mon, 31 Aug 2020 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898040;
        bh=/cQY8SHnmeN2qROlixP7f0nuMs0oBDtsjLVTuDBChGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djG+s73pVcYEJU5lJJLAmTA8ijMGUWzG2Va6EJASwAkbNmS5gt1R4Wa0bUKBX28kW
         ewcD5/ToxxVWXA70bZAmU2Hd0jI4p4vMFQTCG7TojZnq44iQOFbEW+sgXVSSI8llUO
         c6VIj7N1t9zdVVk/ABxSn4MjII8iHJbdxdu//o3Q=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/9] tools/memory-model: Update recipes.txt prime_numbers.c path
Date:   Mon, 31 Aug 2020 11:20:31 -0700
Message-Id: <20200831182037.2034-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The expand_to_next_prime() and next_prime_number() functions have moved
from lib/prime_numbers.c to lib/math/prime_numbers.c, so this commit
updates recipes.txt to reflect this change.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/recipes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 63c4adf..03f58b1 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -1,7 +1,7 @@
 This document provides "recipes", that is, litmus tests for commonly
 occurring situations, as well as a few that illustrate subtly broken but
 attractive nuisances.  Many of these recipes include example code from
-v4.13 of the Linux kernel.
+v5.7 of the Linux kernel.
 
 The first section covers simple special cases, the second section
 takes off the training wheels to cover more involved examples,
@@ -278,7 +278,7 @@ is present if the value loaded determines the address of a later access
 first place (control dependency).  Note that the term "data dependency"
 is sometimes casually used to cover both address and data dependencies.
 
-In lib/prime_numbers.c, the expand_to_next_prime() function invokes
+In lib/math/prime_numbers.c, the expand_to_next_prime() function invokes
 rcu_assign_pointer(), and the next_prime_number() function invokes
 rcu_dereference().  This combination mediates access to a bit vector
 that is expanded as additional primes are needed.
-- 
2.9.5

