Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A42066E2
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgFWWGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbgFWWGJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 18:06:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DEC061573;
        Tue, 23 Jun 2020 15:06:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f2so36482plr.8;
        Tue, 23 Jun 2020 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDvYeSwILl+ri+l9jZHUM8y8x/wYMMzADkWu9RmXrSo=;
        b=dzU4Ed/ImAme9+5EQAW93l3gN3Z9IxT1PZpF9jnwj9Wf8AvR+9mA3rQ5vtaLEwxsyl
         fN7305gp7CT0pAGQnj+FTJYHSl5pF8yQcnIHru7OcYjQyAas86eoXzj3wAdqCktkjB3e
         LbZVTPV9G87bHAgHBmvKr5nwgs3BKG5Mc47TL/XbESDccTh2TdC+kZET6uMdpL2XPMyl
         78tYqq+IM9ycvA3OLEFD16MucJbYnB2VaxLi18V02R7UZEoY25k1dK7Izk5zciS9qSaK
         YeM6+flDsq+G4Lk8OBcst+GJsml+rnjCwy7tAIDDJCR+WLqw8ZPH1NO2U03ZeqF8Jh14
         sM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDvYeSwILl+ri+l9jZHUM8y8x/wYMMzADkWu9RmXrSo=;
        b=Fs9a4plrJRf085b80jOiSRQYQvvwufuZEyDcfpz5YVKEuz8/AB4EGTyqXdmGQZodQh
         TkNk27Qnu8PWyeZhSQ+4T5PAHz5LtcGbFbytD9zFoT7DUd0A63wG+2ByUBIyzVRkWk9r
         wi61L3EnBkQfgXiiH+NmHSlUEQ31sG6YjWh46RT5osusDsI3R3WfFt6Xkr6g6WLD9/WC
         cUCrKQUlowiQQxjJ361r5Oz855q2cZZDp1nOJxPaSgPoNFtcFG24c9F+WVicoy1QViJM
         H1ybKwhQjtBaOJCs6cg8CW+Y5bMJIRz85C7ftRxwuKN//NHGa0j6XtJHfqLBm0v7KJtB
         K4CQ==
X-Gm-Message-State: AOAM531idPiUHHdBj6ubQZcuj+cm+9JJOkCLjREj60aJOsJyBkAiVT/R
        F5JdsxcDHKp6eJoWbe/o1Ig=
X-Google-Smtp-Source: ABdhPJxyQC/bVJqzzDpDaPWE0ga8nqoKuPoYYEhk840glpTNPkpaIfTnzAiEQrsORoAKGE6DvYONWw==
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr25381364pjb.20.1592949968545;
        Tue, 23 Jun 2020 15:06:08 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s41sm3469390pjc.51.2020.06.23.15.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 15:06:07 -0700 (PDT)
Subject: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56 in
 compatibility table
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
Date:   Wed, 24 Jun 2020 07:06:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623155419.GI9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 89f96cba0db5643b1d22a0fe740f4c5cac788b29 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 24 Jun 2020 06:56:43 +0900
Subject: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56 in compatibility table

herdtools7 7.56 is going to be released in the week of 22 Jun 2020.
Mention the exact version in the compatibility table.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 90af203c3cf1..ecb7385376bf 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -54,7 +54,7 @@ klitmus7 Compatibility Table
 	     -- 4.18  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
-	5.6  --       HEAD
+	5.6  --       7.56 --
 	============  ==========
 
 
-- 
2.17.1


