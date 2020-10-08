Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93F287B5B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgJHSHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgJHSHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 14:07:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581DFC061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 11:07:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a15so6760466ljk.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKk/VT0Zv8qI3D7sbgRhgfSvVf+aeJ/ZPwzBQu8xm0A=;
        b=a9j1ZivYk1raQuIq5O2uIkdBWyL1W6C2/LIcIUuQJSA9o1uITQT4BQHzhv6vrdgiWq
         EdlKwzlw+O6i//LU9krzqM0vvemf49ttQPqpuc3V1RTMBCJ30TKmd39wKDHt5JLtWCMk
         VjsAZ6iXZnk59UXD8jZ23t939m+4h6dkPsm+SsAWpG9+OjcxxIn0JeFF7R5TphH8PWg3
         rqN8gdoo0unZnATgwbuJ2Md891rUNYncteRH7/+x2p5ykNxNvKCu8FpA2U05bmMbW0Od
         WQ46HLAzHyJcLCjLWHScGzllIgmQq3I2D8XYxtZCSJSzjl/ft4URk+7zuKG0AWEulrdE
         3fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKk/VT0Zv8qI3D7sbgRhgfSvVf+aeJ/ZPwzBQu8xm0A=;
        b=qaJE23QlpHM+xVQnl4c+RtZCaxqxgJbydvDvbsZd7rposgjcky4vA9tBazMH2GOa/E
         6JqBP9LaWvCxqMDmRHjHQbWyiGQrI9U+S/RK2P1tRtkGfkyZfnolI4QpWzzYkUWFHIu1
         C2VyFmLACUR0+LlbNDb6e6I4dTwjVerRwuiTaMwKo7vXUGtjZUn7EReb51tr7fERO0Jh
         VmSG342NJtUYD4afK8QngrXAlN2eYBSpuwuhDbeUMpms1fEwPWXzHeIyZimb2eSBTpje
         TxhEBGA3LqZJOFAbZrnamG4B55qWt5dhXNlV3n2mGAjR1xuz1dgAerhaPIhXkxWZSofz
         wfcA==
X-Gm-Message-State: AOAM530Hd9g/GZ16ZPLZSerAkkyx59C7UCl+J4TiGIUx8tQg9sYbuACV
        nJ6R8fmFk6dHZAfAM4ml8/svHYYkW4A8WJK/g5epppYAULkcDREL
X-Google-Smtp-Source: ABdhPJwCbujWGHcvkO8AMl/N6HR2u7EbpsYf2/phtokuOA7kQ25RSBHoY31hC8vemcHRrsr8NJFH1UL0vJ0DiX64AI8=
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr4091353ljp.378.1602180468715;
 Thu, 08 Oct 2020 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
 <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
In-Reply-To: <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 21:07:38 +0300
Message-ID: <CAMoF9u3Kn8CXtzOHookc-hi3djZgPdMA+-j5DUSiR0B=KjVHRA@mail.gmail.com>
Subject: Re: [RFC v7 10/21] um: nommu: memory handling
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 6:47 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> >
> >   * These operations must be provided by a host library or by the application
> >   * itself.
> >   *
> > + * @mem_alloc - allocate memory
> > + * @mem_free - free memory
> > + *
>
> Actual kernel-doc would be nicer.
>

Thank you, we will make sure to use the proper kernel doc throughout
all patches for the next patch series

> > +     empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +     memset((void *)empty_zero_page, 0, PAGE_SIZE);
> > +
> > +     {
> > +             unsigned long zones_size[MAX_NR_ZONES] = {0, };
>
> Hmm, what's with the extra scope?
>

Will clean it up in the next patch series, thank you.
