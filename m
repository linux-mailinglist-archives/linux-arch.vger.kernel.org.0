Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890DF31285D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 00:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGXcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Feb 2021 18:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBGXcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Feb 2021 18:32:05 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89445C06174A;
        Sun,  7 Feb 2021 15:31:25 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a12so12756674qkh.10;
        Sun, 07 Feb 2021 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=o5IhRHEGMqXqh+QGBqGS9tIVGn7/L64cLJSFPIY/AWc=;
        b=oaXRUPA2F/7aryfPuau3KqPF6FZaskYAxYMUtjXPSU/iaRh+dp3vv/WuM5lHSsOH77
         K796rEVfqQxzbx7kpzn7bED/l1qsnf/K952NVEG/4Hu8N1ukn65rB5CNWYZkigHXs17B
         YG4YnsxkHnfnATuIsVrMv7o7kZC73L1tQMQx/wLGfTmHiMQE5HLEX41Wid5z2eLwvatY
         YDCIG8BhiVTcTji8wVLbtF4McQNOov4L7QmmsE7dOuOBoD/eLN+XucGQ38cshoziwC4U
         CcWSYNxDJm2UlVrBdYpF+Ebkfy1m1/3mU899InPMB9fOwUzyYYL+GNMDAfUUGRu5VjJf
         v+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=o5IhRHEGMqXqh+QGBqGS9tIVGn7/L64cLJSFPIY/AWc=;
        b=nCrlQ4sLAHpTB2MEOlt3qdWxYoamZ1LHqg+HIKLGzHjm1ij1EY89ET8ZC0kGAnLt+u
         d9DLRuRLo/yuvpXteMePV1qD8bHAZG6SHFhxuDQCIO1DP0jIeHVH5FzJsMnZJ7dMegHw
         +jT3LFuTAuzTkgdyu4FGfhBJMNHEfjGisaJm4c+20a4QECNB9clLTjffGfaF36TSNiDs
         SX4VFnxhMB/WoRFNquYMW6HpaQM+1rJOoBoh3BZUqcbJfWp7Q0LEiDPLi9KCTwWcLGZ6
         6HEmGZRtBHdXIIXe3YqrwvGs9XNG/fjB1cVUWNnMT+5GA8/EDYr9Ptjh7qkrLP/mue/B
         k+bg==
X-Gm-Message-State: AOAM533rVOAC4kPnf8cojtsBEYaWBL/BhpRxtn50HAbryd/gurB+/bnL
        bNtcmoqFXKC3VmuFtnyxg90=
X-Google-Smtp-Source: ABdhPJwxl0ho6ygvAdO4u+DaD7lks38s9pkwgumfoUrWph/Twl9ejj5QD7qkIjSM5ocHuqPwFjJnHg==
X-Received: by 2002:a37:a58d:: with SMTP id o135mr14012949qke.204.1612740684640;
        Sun, 07 Feb 2021 15:31:24 -0800 (PST)
Received: from arch-chirva.localdomain (pool-68-133-6-116.bflony.fios.verizon.net. [68.133.6.116])
        by smtp.gmail.com with ESMTPSA id 12sm15494228qkg.39.2021.02.07.15.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 15:31:24 -0800 (PST)
Date:   Sun, 7 Feb 2021 18:31:22 -0500
From:   Stuart Little <achirvasub@gmail.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: PROBLEM: 5.11.0-rc7 fails to =?utf-8?Q?com?=
 =?utf-8?Q?pile_with_error=3A_=E2=80=98-mindirect-branch=E2=80=99_and_?=
 =?utf-8?B?4oCYLWZjZi1wcm90ZWN0aW9u4oCZ?= are not compatible
Message-ID: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I am trying to compile on an x86_64 host for a 32-bit system; my config is at

https://termbin.com/v8jl

I am getting numerous errors of the form

./include/linux/kasan-checks.h:17:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible

and

./include/linux/kcsan-checks.h:143:6: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible

and

./arch/x86/include/asm/arch_hweight.h:16:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible

(those include files indicated whom I should add to this list; apologies if this reaches you in error).

The full log of the build is at

https://termbin.com/wbgs

---

5.11.0-rc6 built fine last week on this same setup. 
