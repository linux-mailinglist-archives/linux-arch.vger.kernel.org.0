Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42F338861
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhCLJPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 04:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhCLJPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 04:15:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7741C061762
        for <linux-arch@vger.kernel.org>; Fri, 12 Mar 2021 01:15:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i61so6912899edd.7
        for <linux-arch@vger.kernel.org>; Fri, 12 Mar 2021 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vr0Lv80xX3Xl1L8m7N3BWIS/MyIzX8iL/K8kW4thpIU=;
        b=CqF/Vmp9d1IQSuSoyVR1p1PonzxnRC7YVWCuT73D3c7/UoVTQwfy4d3lTqaj04mPUQ
         w6sDy8AQC/jxvaSTTu0yKndZ7nBoRAi41EFLCvhlDfC8iVzFOPC/8fvKvRQIeAiQgh5V
         KRZ+w8tWAPqNUkdW2da/uoIpNh1yN0K7orKRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vr0Lv80xX3Xl1L8m7N3BWIS/MyIzX8iL/K8kW4thpIU=;
        b=EA0BAMsl6vMS9X34Rgl7bjZhrz024ATnmZotO1gOLmiuV8ElrxzykXi5JTnaZooTmX
         vhc8Y3PGP/A8A3oLBcVaOTQIj20KOo48Vm8JgaDk73WzyaaDQs+wmF+rnOlz5ZgyTrCX
         Mrb7zqkMroq8KFem4Omu8PRqTA2j56lScCu4RD5smEHqcinkU3PF/1R4SUYYH14J3th/
         XnnCE6fe87vygzYXEus6wOXUhKY/h5vi78YOGMMaqFj9ooQNZPGoZMref1MRiU3622V1
         m42k4BcbyQa28izyueS0ZeU6Hix1X0AVsTlBACuJeKh0v3Cs2BDiGrVORPeNHRD/GOhR
         x5NA==
X-Gm-Message-State: AOAM532UdkmVgqDk9iYqYOCuIh0xqdJJEuQmf+LrQLTuVa5gs4+WdCxe
        t+iNtueE+zuzMEq4yiPIlDwx2Q==
X-Google-Smtp-Source: ABdhPJzojpw5MISuvwhn5uCj+GlJAixi2DNi1NCX+H/oDGcpqgnrVUfFvP7Bn2/KE8Wd2h5/no6lTw==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr12757182edu.323.1615540501369;
        Fri, 12 Mar 2021 01:15:01 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id rs24sm2493668ejb.75.2021.03.12.01.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 01:15:01 -0800 (PST)
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for the bitmap API
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-15-yury.norov@gmail.com>
 <YC6HoF2lhSlrYs3j@smile.fi.intel.com> <20210218153424.GA701246@yury-ThinkPad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d677abac-ad3e-7483-b808-4b826d3afd66@rasmusvillemoes.dk>
Date:   Fri, 12 Mar 2021 10:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218153424.GA701246@yury-ThinkPad>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18/02/2021 16.34, Yury Norov wrote:
> On Thu, Feb 18, 2021 at 05:28:32PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 17, 2021 at 08:05:12PM -0800, Yury Norov wrote:
>>> Add myself as maintainer for bitmap API.
>>>
>>> I'm an author of current implementation of lib/find_bit and an
>>> active contributor to lib/bitmap. It was spotted that there's no
>>> maintainer for bitmap API. I'm willing to maintain it.
>>
>> Perhaps reviewers as well, like Rasmus, if he is okay with that, of course?
> 
> I'll be happy if you and Rasmus join the team. :) Guys, just let me
> know and I'll update the patch.
>  
>> Otherwise, why not?
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sure, you can add my name/email as an R: line (or whatever means
reviewer), and consider this patch (with or without that addition) acked.

Rasmus
