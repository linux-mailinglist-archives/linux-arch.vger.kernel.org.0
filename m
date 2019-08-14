Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31AA8D70C
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNPQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 11:16:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNPQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 11:16:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so20421604pgp.4;
        Wed, 14 Aug 2019 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wsVnwmigkmT3Rahf877vpCdAPdXMJgnKcW+9pRCbf0U=;
        b=l2q3ENC3uusG4I6tZz2qs5ot8piw/Higo2vEyfy5v0cjkt0A1UxxHWNQjG093gvz90
         kPB76E3Z0GDORpoUc/xQqFLMP7wdRMttUhbN0XmtfXh9RbSbJHHSJ3rcVigQua93taGe
         rVbbPOz9ru1iJADQIin97wWKq75wTxXvpvlpGJg7WOzUBe0LXM6xb7+jbU4VhhXms4S1
         c+1bGcmH3qk2BCjJgASQpxv5uhJQM0Y7syT7ZY7G8HuVV3anfrEyYjZDsaThz++bul88
         qrE5eu19Bv0MgMyEwrXsgN2pu+yrnmsZwfiyaCfNk36pWFv8rtKrYItxdfmQf7N1zTiL
         nfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wsVnwmigkmT3Rahf877vpCdAPdXMJgnKcW+9pRCbf0U=;
        b=I91/ELz5FF2koLWLMYUDPPV1jpUtM6TT2bLFrDxRZ05N1CmKsztuJQdIXz5hYl2DDR
         67F7NnqgNdqvDOsu0Kry6AdTgcrh5kqEuxaZPoe5Iy6cAl0PgoobK2jUa8xY2v+NjKAJ
         pE9uUR6hevrgOuZgxQX50E7Sn1Is2bLt7I+6hmP/i3kfUX/Ihcin9SNu2c6hxsS28FUV
         KRCKaV7YyqfkzM9rjfTiwKeIEmvE17bjHUYd70YuQGVOTCeTlbi5OVZn262Adv1KeKq6
         NOiF/FFzVeWcHpyLXLKrWpqk7krkG4NarRLnzn0x2lAzjuYBcDeRE3QRTUuKOWqGSslk
         qBxA==
X-Gm-Message-State: APjAAAVwD8uCrPPqUe72yujoRtlnmsW9deTu8Vg3AiRszHWbVcUd4Eby
        17yp2wWGxZ13rZknPCi2t00=
X-Google-Smtp-Source: APXvYqyqH1bkDMyM6dpdQ7oV7ZdhgKHXoYfYrWNV0XMY2RhnGxGzKXkbPoH0t6erAik3eN8lOaChAg==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr262818pjq.120.1565795798981;
        Wed, 14 Aug 2019 08:16:38 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 203sm90939pfu.30.2019.08.14.08.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 08:16:38 -0700 (PDT)
Subject: [PATCH 2/2] tools/memory-model: Mention data-race capability in
 jugdelitmus.sh's header
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
 <20190812180649.GM28441@linux.ibm.com>
 <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <a94b590d-5683-932d-5354-b77b91e7af4b@gmail.com>
Date:   Thu, 15 Aug 2019 00:16:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 67092cb93f7a0fd3c4f9a300637e4f5c61fc944a Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 14 Aug 2019 17:48:25 +0900
Subject: [PATCH 2/2] tools/memory-model: Mention data-race capability in jugdelitmus.sh's header

Replicate description of data-race capability from the change log of
commit ("tools/memory-model: Add data-race capabilities to
judgelitmus.sh") in the header comment.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index c91130814593..1ec5d89fcfbb 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -4,13 +4,19 @@
 # Given a .litmus test and the corresponding litmus output file, check
 # the .litmus.out file against the "Result:" comment to judge whether the
 # test ran correctly.  If the --hw argument is omitted, check against the
-# LKMM output, which is assumed to be in file.litmus.out.  If this argument
-# is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
-# In addition, non-Sometimes verification results will be noted, but
-# forgiven.  Furthermore, if there is no "Result:" comment but there is
-# an LKMM .litmus.out file, the observation in that file will be used
-# to judge the assembly-language verification.
+# LKMM output, which is assumed to be in file.litmus.out. If either a
+# "DATARACE" marker in the "Result:" comment or a "Flag data-race" marker
+# in the LKMM output is present, the other must also be as well, at least
+# for litmus tests having a "Result:" comment. In this case, a failure of
+# the Always/Sometimes/Never portion of the "Result:" prediction will be
+# noted, but forgiven.
+#
+# If the --hw argument is provided, this is assumed to be a hardware
+# test, and the output is assumed to be in file.litmus.HW.out, where
+# "HW" is the --hw argument. In addition, non-Sometimes verification
+# results will be noted, but forgiven.  Furthermore, if there is no
+# "Result:" comment but there is an LKMM .litmus.out file, the observation
+# in that file will be used to judge the assembly-language verification.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
-- 
2.17.1


