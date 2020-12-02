Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1D2CC515
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 19:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbgLBS2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 13:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbgLBS2c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 13:28:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1BDC0613D6;
        Wed,  2 Dec 2020 10:27:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i2so5118046wrs.4;
        Wed, 02 Dec 2020 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydQfEfGfc0N0qiJ5oWHcbHhyRsLLnIu0b8pXAHWYB1A=;
        b=MuYyPO4TnlK08+JUUwVy2q06Ru0NqVQXpM6eH1SAvjkUBTngufNo4mZlcodeyRFkhg
         WGhLsS35bhW63ROAEKx3ptsolAqnVC8dHbSL2C212z7VvTV0Lg6sdYchGOtYuvli5jBg
         zjMLVy9EHRfMA0CrnCwoBFlXGRZO6whNd4YWfL6nrJlcmxhbSagPHFKpdBErLqsgkoBh
         4M+JjxWEeu7Ipd3ZCR+gghmyaUV6GRqlBOk/GJt9ZDyrt5rsDX0gPfiF2I1uwJDbDS3p
         GHDJ2uNL2/4RdnFBilVAN4PTCtHMitG+dLct30C4wktD2gSQwZVPGXVYK+v1tsUBW21h
         dsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydQfEfGfc0N0qiJ5oWHcbHhyRsLLnIu0b8pXAHWYB1A=;
        b=A+W4vrts6YZ8zTtPh4KgNO5P21MblawhZeA4Cxb0FZMA7s4rwuf7oPQm1wyhOCd/H6
         jmCejzXxL04PnPzGoQi/l5zl+cZ2Yu4Nn7sN8ZrEObjaskzAjUb00RdFLz7F3VwKcG4y
         VKZ0gFlP3uQBh7lxFb8xTLCzlUdlS27wriZXW/qzz2Kmqn5hOAUhni2CAtyLQq4W1agU
         OXILPKd3PbqSDkdza7vIAcqSfLxdDt8zgUkOP0eNjl9yuIfAyciESUEDID+iiWbSuzEs
         Mk1SuzEKfNJh+wWlcOam/2CVY+ClyRyw6OgmebRMDJ1Zr7XqFi1iZ+OlUxWhUJ8uoDKp
         bonw==
X-Gm-Message-State: AOAM530fvjGXXXkC3BHdb7C4bDKdocOXeP2igHC/s2kMy2Zzgx/L8co7
        sAK+gLzoyykZHpwL1gV9Xsf+Kphka+OBiG2zbHE=
X-Google-Smtp-Source: ABdhPJyEJYfjsTAHdPlpaUi/h+47rkpYAXzfUBNhxLP6y7DGmQSQBa58WhiOW08d4ox/Ce7pgVf6tVpHh5eZEJcHsCk=
X-Received: by 2002:adf:f602:: with SMTP id t2mr5212372wrp.40.1606933664584;
 Wed, 02 Dec 2020 10:27:44 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com> <20201202173701.GM4077@smile.fi.intel.com>
In-Reply-To: <20201202173701.GM4077@smile.fi.intel.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 3 Dec 2020 03:27:33 +0900
Message-ID: <CAM7-yPSWvsySweXSmbvW2hucce8T7BOSkz-eF5t7PJE6zv5tjg@mail.gmail.com>
Subject: 
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 2:36 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 09:26:05AM -0800, Yury Norov wrote:
> > On Wed, Dec 2, 2020 at 3:50 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> ...
>
> >  I think this patch has some good catches. We definitely need to implement
> > find_last_zero_bit(), as it is used by fs/ufs, and their local
> > implementation is not optimal.
>
> Side note: speaking of performance, any plans to fix for_each_*_bit*() for
> cases when the nbits is known to be <= BITS_PER_LONG?
>
> Now it makes an awful code generation (something like few hundred bytes of
> code).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

> Side note: speaking of performance, any plans to fix for_each_*_bit*() for
> cases when the nbits is known to be <= BITS_PER_LONG?

Frankly Speaking, I don't have an idea in now.....
Could you share your idea or wisdom?

Thanks.
Levi.
