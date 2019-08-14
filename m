Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818F28D700
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHNPOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 11:14:08 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:44252 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNPOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 11:14:07 -0400
Received: by mail-pl1-f173.google.com with SMTP id t14so50793065plr.11;
        Wed, 14 Aug 2019 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gCnccQTqt1TRhZousM+vcIN96ilUiP0gMRpcGtjYEMY=;
        b=pyo3c5ocqozp/w167fimJi74vKzb/9pxXSdNIGBMN2rre9nrpHKc8UM09QS0MI9dgY
         mtAh9neYqv0/v7/+EM2lvpLLLlosARSbyXVcYdk6Y27KiH6tdEJLvguImDLY2t087lfW
         N6/TYoDKKMRoisj9+A4Rwfk/Bp/drypKPrjaSdYIvvO5YqoFnmLv8OPKVR2sJzsxNugJ
         6L+EFOEIDdB/TCO71H0Aiu9PREwK+0BvznI3LZ3LwtUrSnxJVti+mbQJo9yjoLLAYkOo
         ezMS38AvMwZYWP/RHrI+j05QpSkDSokyxNOUq7kApShr++J0OMxxw6QwemCjFS+elxI5
         6zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gCnccQTqt1TRhZousM+vcIN96ilUiP0gMRpcGtjYEMY=;
        b=dZFYf5zJSbda/XdCHRHX3tteIgBnVdu12yudgBopOsXJtD18qA5mEpApQ6N6VLjtjU
         NdetV3Mu4ufLE9s6ymU+WFsYlsRpd7iuRXdYWztKM5oIrwMeMD0uPim52+Z1WNrV7NsG
         vgx7VJRgQXODDYGzQBT5tIWAcX3O6sXevm8cv73sWRi4GIT+bzTmLnfV21oCUkoV0fFd
         wwo0Q/LablNxWG/se6wGwggUcIxPAHanoqeFMidkNd6w9uEZOxfyNPzCoIwM7+0+AUA7
         jivfUauDtu+4ABd8iYraT9EN9Q3q6WT9U3UEA31dL0DN3sxZeAZh1TyBJdigb495Tpk3
         LyPg==
X-Gm-Message-State: APjAAAXJj5Cg9gZ3SoK33RWAcoSlQ5x6Ojp+cIGMxK575oxSOtbBcHNn
        I/4dBYc0a/i0EnqJ92ULw8w=
X-Google-Smtp-Source: APXvYqzAkbmn85pTOhEKsugN0FloVlGEhNHnwZnCPQ5UnqmdI9zhZfAThjItj0dOSwgsT4HIVTZoVg==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr43774122plb.158.1565795647004;
        Wed, 14 Aug 2019 08:14:07 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x22sm67086pfo.180.2019.08.14.08.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 08:14:06 -0700 (PDT)
Subject: Subject: [PATCH 1/2] tools/memory-model: Reflect updated file name
 convention in judgelitmus.sh
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
Message-ID: <1dbd392a-876c-1d6b-f718-76a37f1d55ee@gmail.com>
Date:   Thu, 15 Aug 2019 00:13:57 +0900
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

From 6251ebb775a81f1ac158f197ad8110b8f98c4248 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 14 Aug 2019 17:20:54 +0900
Subject: [PATCH 1/2] tools/memory-model: Reflect updated file name convention in judgelitmus.sh

Commit ("tools/memory-model: Move from .AArch64.litmus.out to
.litmus.AArch.out") swapped "HW" and "litmus" part in .out file name.
Reflect the change in header comment in judgelitmus.sh

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 6408c012bdf5..c91130814593 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -6,7 +6,7 @@
 # test ran correctly.  If the --hw argument is omitted, check against the
 # LKMM output, which is assumed to be in file.litmus.out.  If this argument
 # is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
 # In addition, non-Sometimes verification results will be noted, but
 # forgiven.  Furthermore, if there is no "Result:" comment but there is
 # an LKMM .litmus.out file, the observation in that file will be used
-- 
2.17.1


