Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EA2C72BB
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgK1VuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733074AbgK1TFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:05:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F0C061A54;
        Fri, 27 Nov 2020 22:01:55 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b10so4878104pfo.4;
        Fri, 27 Nov 2020 22:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FhECr7kZx6Fc6F/T39W8mVgPHiuG0xnk7fsqY4ZRTsU=;
        b=akXhWtdIF75g3t2rcbr8+H3e717hmONzSYFHvb1+PebOnf/5A7ADV+f95GkdADp1Xw
         rVQUYkEVRZ8oRV0itkLbKNIP8FARWM2G9Oti43BRWt/fFj17LD9N+TaEnSJvn/diDI9R
         o7nwlSD0v5Ggzmu9AtOOTmGWCravvv90vDIgVs2xfg3Kgk9KWTX1tSMdNOMR7sgO/afz
         RVDbY++Kcu6ttL3RymkNcBcijQomZ5CoELZ59DktjlzLHFmqnGNwkexhRE/W0BHGpW4E
         gWISl0ieMQpfIUjAs133swgjqjqmPo7TlURAAsoRHYI8VC0Cv+noZIIb5xu8q73KZoin
         le8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhECr7kZx6Fc6F/T39W8mVgPHiuG0xnk7fsqY4ZRTsU=;
        b=RFlg2GBS1OyPxopWeHZ63lob7Mg72mfv5i8Hxd9539V6ObWmCu3XXQKe02rPZhl7Ex
         6YTpwh9S1FA2ciiyY06ZVU17ewJMqEqmf6cWhLE8+OaRM74OHhZPyq+gZv87noH9xWgO
         zCnsra3MHtuQR2pKIn+PFOwyUQxCyH5gCzf46TwKY37QXeItCZoznWkhd4HsXvkGzNph
         lXwGolyXezubeqM0lhJvnf59stQbWiXHPWmUfG4Rl7qlG396J3shB7t8h1NlLic4N4Md
         fOjHvliAA2xsK6WbmhRgpOKea3Vm6EbLacAIbx7dyX2BnQOjhVoTDrvBW2V9G+bl+dah
         9EWQ==
X-Gm-Message-State: AOAM532fQPSFt41dFd1taBtSTTVZNtVIbXTEXLxagYhFXVrI0pN/mnxU
        uF7n9VB2gEjAi4+LHyq9Whw=
X-Google-Smtp-Source: ABdhPJwq5xtRf+P8uMYJh+O/eLqFZb5b2Dx2sWfW3jY+Q2qecyNpLon8OX1FH+sqel7MmIF5iYswXQ==
X-Received: by 2002:a63:d058:: with SMTP id s24mr5780104pgi.297.1606543314795;
        Fri, 27 Nov 2020 22:01:54 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ie17sm12925088pjb.9.2020.11.27.22.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 22:01:54 -0800 (PST)
Subject: [PATCH 2/2] tools/memory-model: Fix typo in klitmus7 compatibility
 table
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-6-paulmck@kernel.org>
 <12e0baf4-b1c9-d674-1d4c-310e0a9b6343@gmail.com>
 <20201105225605.GQ3249@paulmck-ThinkPad-P72>
 <2acf8de5-efe9-a205-cb62-04c4774008c0@gmail.com>
 <20201127154652.GU1437@paulmck-ThinkPad-P72>
 <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0f7b4255-cb68-bb1e-6717-3b60a3020c36@gmail.com>
Date:   Sat, 28 Nov 2020 15:01:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 4f577823fa60e14ae58caa2d3c0b2ced64e6eb43 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sat, 28 Nov 2020 14:32:15 +0900
Subject: [PATCH 2/2] tools/memory-model: Fix typo in klitmus7 compatibility table

klitmus7 of herdtools7 7.48 or earlier depends on ACCESS_ONCE(),
which was removed in Linux v4.15.
Fix the obvious typo in the table.

Fixes: d075a78a5ab1 ("tools/memory-model/README: Expand dependency of klitmus7")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 39d08d1f0443..9a84c45504ab 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -51,7 +51,7 @@ klitmus7 Compatibility Table
 	============  ==========
 	target Linux  herdtools7
 	------------  ----------
-	     -- 4.18  7.48 --
+	     -- 4.14  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
 	5.6  --       7.56 --
-- 
2.17.1


