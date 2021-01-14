Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B112F6357
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbhANOlO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jan 2021 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbhANOlO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2021 09:41:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB7C061574;
        Thu, 14 Jan 2021 06:40:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a188so3445707pfa.11;
        Thu, 14 Jan 2021 06:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ePYx9dKDNpbUDjL182iKKsQVVt1VuxmjJIv0p7ij4fU=;
        b=NxZ95+4RbRdPqWaQmaihXe2AouiSI7ayT+emMpPbQ0mfttzG9dVN/Y07MBhlkmop0n
         1K5PZjs8tz/63upN6JxzOdk2JHQZRFMWhvKIc0tVSWoUTbgqlbZDS7cXqevRmpT17VBz
         ujC+YLr/9zhjUZXwTnPm9onb3FxiV+jSQpLpaY+wWTWlHWOmsl++VMD482C4E11yYjt9
         Ts4JxNDNxyuamP5yRdbPNt/Hao4fDp5Hl6v7s/qCblYORvPNA09gslV1QrSs4ayzENOD
         BvRuQJazOfxXfh0JKeMW2QM8ZqXXeaufOyC88GqLrtO3NK8G8l67Bexww7ALgiN0t9Oh
         YHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ePYx9dKDNpbUDjL182iKKsQVVt1VuxmjJIv0p7ij4fU=;
        b=WOYJIpEoNDoUcUOVSsuGrLcGV5GMti/pCZXizuthJxyNqcx5NnpGo1TiTdK7Ihlnt1
         w9To2n2kYPHzl8wB587HvOKqptekvYo/ei4OwivbFmkNIGrNft4NHvqF80LroLnZTSjT
         OImkhET1AcBG6HF67nR2gUO8Wu253PFUJg/yLsZVm48FHVjMDmMADXRvLhuuQlujj2CU
         2mApaKOY8r5R1QFJCCz2oCtpUey0NOt+ixtL6RF6+Ho4w6JNrJJ48TKhpGIUF738LDFk
         5SoEeULSuXGupmbgwEiDGqGOduBYrmyjnbPKFZYo/Vpss8r0DvYLLyABxpWbZNA/IRUP
         5m8g==
X-Gm-Message-State: AOAM53092Dcj4ss4RsjHi7ksATsFrn3c4Zu3alvRDM/iF8Yz7+cgnJ+r
        6bp6y9Zg22Y+lBmyKS2jVsM=
X-Google-Smtp-Source: ABdhPJx+riCtG5h3gZgsChhEc6rcJrlhVYlFN94Ax4q2ALDpwzFK2SHJo4nD0HDYawJ8JAXuThJBzA==
X-Received: by 2002:aa7:9d81:0:b029:19d:ca64:3c62 with SMTP id f1-20020aa79d810000b029019dca643c62mr7922193pfq.16.1610635233734;
        Thu, 14 Jan 2021 06:40:33 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b7sm5647052pff.96.2021.01.14.06.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 06:40:32 -0800 (PST)
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -rcu] tools/memory-model: Remove reference to atomic_ops.rst
Message-ID: <28849fc0-1d1e-6e1b-380c-672da2622aec@gmail.com>
Date:   Thu, 14 Jan 2021 23:40:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 1d7642add7f74ca307f1bf70569e23edf8b1a023 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Thu, 14 Jan 2021 23:09:07 +0900
Subject: [PATCH -rcu] tools/memory-model: Remove reference to atomic_ops.rst

atomic_ops.rst was removed by commit f0400a77ebdc ("atomic: Delete
obsolete documentation").
Remove the broken link in tools/memory-model/Documentation/simple.txt.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Paul,

This is relative to dev of -rcu.

        Thanks, Akira
--
 tools/memory-model/Documentation/simple.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 81e1a0ec5342..4c789ec8334f 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -189,7 +189,6 @@ Additional information may be found in these files:
 
 Documentation/atomic_t.txt
 Documentation/atomic_bitops.txt
-Documentation/core-api/atomic_ops.rst
 Documentation/core-api/refcount-vs-atomic.rst
 
 Reading code using these primitives is often also quite helpful.
-- 
2.17.1

