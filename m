Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103C842CB29
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhJMUiX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJMUiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 16:38:22 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5CC061570
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 13:36:19 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id h4so7183056uaw.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxmlE0jWTvIABAOfcWenbXPbvIcFQQi9okWp6MfW2Rk=;
        b=dSwYr10Czbxlxm7F67KMPvvJG9P3phmX0JBl9Ty+/TuGFPA0rsFQPLdAUoKK7dCh41
         9uMqVVhVMu8cioCd5Y2rVX+7tzSExeucmzg+GfpGSWafRxGh8Gyy8x1nICbhYFOuPD6D
         3227y+5cZC8ZqIXulPV6s4wxTMnUNoNxZWlJCUJPUHt7ok0hfsJ1g5kTSrZHeY83Opte
         PjM3CPJpRBV6Ne9KK7m1wElFoUStioYCCRwZGX4K9me+zIOdMy8qMo85c+Anyhox/lm6
         iXOplN3FBIrzrEB21N8FpE/yOlyfK5kcbAcrdtkcX8rZY5rZcInFj05k5egv2a7iGkLD
         SojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxmlE0jWTvIABAOfcWenbXPbvIcFQQi9okWp6MfW2Rk=;
        b=ijHys0X6cp3UGeOWdBwKLsuLzOtvipkz5/SihBThWdHu/gCzbK/Teys/GIdgPRU6MA
         DONfo1qq3NVILqa6dIoIHWeCqHd0f5YkuHy5n6WDWCLfwGLNHx5jdPnOOfvGC9WePmoM
         g2FELHn6AnSO0DFknK0MqRfrwk7g4P3zVlx7KwXTX4Wld9qicX9cQAQzU6CWg7DHeSNs
         Xwfdyk+dUtv10um6LKED5+p2nyN9q238k+ndt27/2E+Zft44orjZG0zWj1IQYqQL0MhA
         3FOL9Xm2ffGBOgsBCuL1qiaWgusfw3LFRRlxNRAJEbZ23D8+BWnMAbDvk0OeovARF/Uw
         8g6g==
X-Gm-Message-State: AOAM532Fe61zaDEOYJIOlahao8YNAbOVA+8vbwaVEk7QWWb0S2gMPNav
        3y2NSPP1jCE6TI0BocgZ16sxTMGkpqczwkuuZE4pyA==
X-Google-Smtp-Source: ABdhPJxCWJwH8wsDAPq7q8Ma8DI8v/ghsdOiUWd7ssye0vrKNbb4cbAPYMkSxDl5594oZyze0+c7hz4obonnasO/r/c=
X-Received: by 2002:ab0:540e:: with SMTP id n14mr1776903uaa.73.1634157378226;
 Wed, 13 Oct 2021 13:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007002507.42501-1-ramjiyani@google.com> <20211012085915.GA25069@lst.de>
In-Reply-To: <20211012085915.GA25069@lst.de>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 13 Oct 2021 13:36:06 -0700
Message-ID: <CAKUd0B8UUFKif0OOQG_4gUcyoWPgsau+KWtWt__Vjuxfw13kmg@mail.gmail.com>
Subject: Re: [PATCH v4] aio: Add support for the POLLFREE
To:     Christoph Hellwig <hch@lst.de>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 12, 2021 at 1:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, Christoph.

~ Ramji
