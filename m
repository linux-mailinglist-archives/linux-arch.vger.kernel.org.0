Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4332CBBEC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLBLvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLBLvR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 06:51:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40DC0613D6;
        Wed,  2 Dec 2020 03:50:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so6398221wmb.4;
        Wed, 02 Dec 2020 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6oALCZiLGYDvc9Go/LDdvbufLPYANCU6ChnU4YZkuI=;
        b=YnhtXaGf3WEJPdExvpOXRBuHi7JPMSuw9YS0u8nAO2DvpfoGEMo1qy/GQm2Bfm00w5
         cuWcaEXg5WlVCSmY5936/SWKZXo2OuUVAnQFb3UVgbxiLyxqxApXdL3ZXieH15yW+6X9
         S/nF7vSPBzay4ZJYEvuqXrTpJK5Io3lo8vhEzlaArSZ/iNF+kUiK1R713WkqCo58dvNG
         /fTaEOMOEuqlz1FD9TkJHx6dThZ4mQtjjsa6Cx2OqRs9d1lysX+yNP2AxUd2BKn5TU6O
         qI5qTi3nvEe24f8RmGjgOXReTegjIQn9+i91MDCA20DCAnflowrukgjyV/ibijrs69NW
         InDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6oALCZiLGYDvc9Go/LDdvbufLPYANCU6ChnU4YZkuI=;
        b=e+YxZ60v65kFhYFdFhyB54xuLHlZydwqgiIcHKbGSmoMvifLlK5bCXgMY9o6vhdLYb
         DV3uQzjShb4f2W1EoL31RAiQBrECC3TFA6D1wRmfzTqxg5y0Kljr7y2bnuYhlG3pK4sO
         0PLZ4L+V8GJ2drrf7zlemBTtSobgH+vfiYbrhrMNcJmIqs92tOG00IK47HrxLRwfaWGn
         4fH5EI/SYaQLNTVA5gTitpDLMJzJEz6Ho49Cr0SSDv5ro59+lpejhFmc0OKv/aM7tKFv
         +dDvQIJAaPysNXvGIM/YJtEbMqGis/m0wBnvS+8aiOOiXAOP3DHUmR2nEopEGVEQkMU+
         PstA==
X-Gm-Message-State: AOAM532wvRrfJQAkTB/0EF5ajMw57GhamFRzcZvkGqZmk1zYAzUFqZys
        p7aUZuONXaug4Qxv6GBok6qRq4/iWPpygfcPQwk=
X-Google-Smtp-Source: ABdhPJy8+tbwg1apCmnRHY8nQ8MoPlFqA0ZJMGi0Iv5/fpvHeox9MM3U+7OnFWIK/ASP2i1Z2JmsyJPmKxX5bBEkX6Y=
X-Received: by 2002:a1c:b742:: with SMTP id h63mr2739418wmf.122.1606909835392;
 Wed, 02 Dec 2020 03:50:35 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
In-Reply-To: <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 2 Dec 2020 20:50:24 +0900
Message-ID: <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for kind advice. But I'm so afraid to have questions below:

 > - it proposes functionality w/o user (dead code)
     Actually, I add these series functions to rewrite some of the
resource clean-up routine.
     A typical case is ethtool_set_per_queue_coalesce 's rollback label.
     Could this usage be an actual use case?

 >- it lacks extension of the bitmap test module to cover the new
 > functions (that also wants to be a separate patch).
     I see, then Could I add some of testcase on lib/test_bitops.c for testing?






On Wed, Dec 2, 2020 at 7:04 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 02/12/2020 10.47, Andy Shevchenko wrote:
> > On Wed, Dec 02, 2020 at 10:10:09AM +0900, Yun Levi wrote:
> >> Inspired find_next_*bit function series, add find_prev_*_bit series.
> >> I'm not sure whether it'll be used right now But, I add these functions
> >> for future usage.
> >
> > This patch has few issues:
> > - it has more things than described (should be several patches instead)
> > - new functionality can be split logically to couple or more pieces as well
> > - it proposes functionality w/o user (dead code)
>
> Yeah, the last point means it can't be applied - please submit it again
> if and when you have an actual use case. And I'll add
>
> - it lacks extension of the bitmap test module to cover the new
> functions (that also wants to be a separate patch).
>
> Rasmus
