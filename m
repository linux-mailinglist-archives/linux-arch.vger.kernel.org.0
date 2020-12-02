Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38ED2CBA17
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgLBKFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 05:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbgLBKFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 05:05:21 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C63C0617A6
        for <linux-arch@vger.kernel.org>; Wed,  2 Dec 2020 02:04:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so2976288ejb.13
        for <linux-arch@vger.kernel.org>; Wed, 02 Dec 2020 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2wK+SflPRbjYVi77tMFczNFaefq/+v7eYCY6aqL0Dk=;
        b=bVO0rlUvIw1AdYtEvq7dl8VyY+qyie7H/qPxoruOvWHpd/77weF9FvlLWaD9YFfhgy
         QAOrQMvhAaApkQ4whj92STIDXdMQCyC+DZZV5hBUg4n/El62LpF6f6J3gSz9ORevu2wF
         i/TBCT02fWq2q47FXfhhPYhiJiRDtGyVFMHTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2wK+SflPRbjYVi77tMFczNFaefq/+v7eYCY6aqL0Dk=;
        b=svtqs/uByZnCD6EQ01QZ7x3M3xFd2q0FBwViS4TsEiPe5Mi5XTvry+QpK7n2beccNs
         wHtwY7OigrH/rLljzlIG7cbWlbWwrkMlyuzmqFs5yXwP/6F5v9f7SGcAI9PWho1cprY8
         LRiAhQbUkD3B/7Gu3dhTswiQanRZU2Fe0YMo+6hZWvUjva9ryW9ICLPxsy8+Um4xtyS7
         +/AOC5ObKuF0FCaMFghuMNex5JeA4+9vsjUXIbn3D8xdv2chdHbEn/xxgOpr7PGj81Wm
         CTH+rY6o3iAzH5DK3onq2FHpfMsn47Y4axecP8J4VSkjkqEnMUO7SyqWwTW44J7L3/r0
         yljg==
X-Gm-Message-State: AOAM530qkEDrllhPjKFYO1OlDtXfP3qcFxrDQVDKM5Xg0y4slgF/BIND
        K981+yhltz/de4LNGvC/FK9BIH45Rp0C5g==
X-Google-Smtp-Source: ABdhPJzpkAGir7ziC7QC+svpkAEpoRzlwaxlnYLvzym46j0cacf2e+dFT8ttvmImRsG9XVUvX213Zg==
X-Received: by 2002:a17:906:a1cb:: with SMTP id bx11mr1509253ejb.508.1606903479488;
        Wed, 02 Dec 2020 02:04:39 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id pk19sm806705ejb.32.2020.12.02.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 02:04:38 -0800 (PST)
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yun Levi <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
Date:   Wed, 2 Dec 2020 11:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202094717.GX4077@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/12/2020 10.47, Andy Shevchenko wrote:
> On Wed, Dec 02, 2020 at 10:10:09AM +0900, Yun Levi wrote:
>> Inspired find_next_*bit function series, add find_prev_*_bit series.
>> I'm not sure whether it'll be used right now But, I add these functions
>> for future usage.
> 
> This patch has few issues:
> - it has more things than described (should be several patches instead)
> - new functionality can be split logically to couple or more pieces as well
> - it proposes functionality w/o user (dead code)

Yeah, the last point means it can't be applied - please submit it again
if and when you have an actual use case. And I'll add

- it lacks extension of the bitmap test module to cover the new
functions (that also wants to be a separate patch).

Rasmus
