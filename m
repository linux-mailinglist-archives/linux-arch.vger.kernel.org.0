Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70C32565F8
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgH2IUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2IUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:20:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A4AC061236;
        Sat, 29 Aug 2020 01:20:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l2so2154985eji.3;
        Sat, 29 Aug 2020 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=0FDeOqqqmN/2W5Amk5t+HI0NVVDnV6N35z/hnvPE1Mk=;
        b=C8lb4AKtQ+M33Y77NbBEHl+g05YntNtQ9wg/DNkcVkY2tEVrWqWU832s+5rZyydcRC
         rNFzso/E2YSTeHOUoKrSNOXrax+BMKBhaMEEOHpJY0zRHqb4aE6h3oTW4yKA2mjHOcuB
         m14csMkL9ETdckrw9M/0vOtK5WQmGZxwWrrBH5Ugp4uO9shQwaIWuQnte/YgZnjuRwr/
         AzQKxke9o84pcEnFzYqnrGRziCcnIA7WGbcNF+LyF/dyK5ez4FQ1ORlxE7sRESgIrAfz
         ldI7U+NNC5jErzBUNLf6KlZJIj7n2OcYHPq5PisCkVSpBvZrqbDH0CUo7fZ2JXU4Emw7
         AAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=0FDeOqqqmN/2W5Amk5t+HI0NVVDnV6N35z/hnvPE1Mk=;
        b=irfitns0Sx/3Hv4V+A73R/74QUxPxT2aNoEiI9/mgcZAGUVQPaIVFX1/nNIvlHHA6e
         o+1iMBfxXWjkEJ39eMgmnDuwdlyub6wDQiE3J+0HOA90PQDs8qWvw0FK12NzFVi6x9MN
         qw3IMsqsAGTigJdm9AvzdcQM5pl7XMEc/ADoT00b43Vu1wIBHt2hLvx/AKpEeRpTL4k3
         uh2GrTufii7RUfvZxsUy+vfnpaSpLD2QWAUMZcNYhk3/4qwcmtRxaU3mxWvAnhhvs4yt
         zQ6zV3T/SQKyBHNX3AubVdJvA21QwWtTlVZUUpNp/x6zjPR2OxTaw6NrARubCZJZ+D+d
         NYvg==
X-Gm-Message-State: AOAM5303OziC8Tc2qR2AUX3HOQo7PfBFon9WdUUBWJeKW7BqmPKEko4J
        YszptPr9pVsbuYJavWprPdY=
X-Google-Smtp-Source: ABdhPJxFGzmps12K7nCfy55JGVMy+SCSvPss64XL3SCEY8Z2mVmSppYYUT3emqokc40pw2auCCHbVA==
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr1239762ejb.454.1598689201237;
        Sat, 29 Aug 2020 01:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id f6sm1561718ejh.92.2020.08.29.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:20:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 0/3] memory-barriers: Apply missed changes
Date:   Sat, 29 Aug 2020 10:19:50 +0200
Message-Id: <20200829081950.2709-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080816.1440-1-sjpark@amazon.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Oops, I forgot adding 'From:' line in the body.  This will make author and
signed-off-by mismatch.  Sorry, I will send v2 soon.


Thanks,
SeongJae Park

On Sat, 29 Aug 2020 10:08:13 +0200 SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset applies missed changes that should land in the
> memory-barriers.txt and its Korean translation.
> 
> The patches are based on v5.9-rc2.
> 
> SeongJae Park (3):
>   docs/memory-barriers.txt: Fix references for DMA*.txt files
>   docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
>   dics/memory-barriers.txt/kokr: Allow architecture to override the
>     flush barrier
> 
>  Documentation/memory-barriers.txt             |  8 ++---
>  .../translations/ko_KR/memory-barriers.txt    | 32 ++++++++++++-------
>  2 files changed, 24 insertions(+), 16 deletions(-)
> 
> -- 
> 2.17.1
> 
