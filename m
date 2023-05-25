Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443CC71187D
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjEYUxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjEYUxh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 16:53:37 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3725135;
        Thu, 25 May 2023 13:53:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5619032c026so2739997b3.1;
        Thu, 25 May 2023 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048015; x=1687640015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e72vGCwhPoa8gN25X6qmdDXVUsdWWJFQx8MjqDcoGDA=;
        b=PRDb4uH8g3Vv6gZWsZ1gkHY+ANMWnqtSqEQNi+t68NKJyRAPGtGIjXS+o6ABKHZ7yv
         q51K7Vr8Q1brsvSZQkdt4WeLJo6vXr04Grr6RxGrB/PY5E3pp1cBQWvGni0wb9TWYIbM
         5FWOkPlw4M42rE2TxcMBGldDhB3WLqb55j0CqgwQEW0TmVHxxCeHx2Zs7VLCqGumlN8c
         PmQWTAjBOIMu7fHadjtAjQF7IDQQLa3x/OUyFY2aJiBpGADt0K07OCNxrHer3KqiVV69
         GxawL7cJdKwcX3ZUAGYa8EVBTKoLWza/yXtntrwGkP8KyxHL6U40gF5XovIoxt2V2Fr9
         5Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048015; x=1687640015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e72vGCwhPoa8gN25X6qmdDXVUsdWWJFQx8MjqDcoGDA=;
        b=l90JmrOaZOXkoBsdhktrwpn3XrEl/jjYeJMgz6i+MdH9WsGjeB08++NnFb7CwyrNJ6
         tXC8jcwfxHxDy59iWdaIt3RVQ+Ro4dQuX/rehxzA/qG5hwLyzi7eQmPq+uV8BVJ9I4LB
         vngnvWCHPt+T+ICtj41g9K4VXfAIU9kUP5K/kTnm9i+Pmar222BLN8rLNKKrjF1LKrFI
         N2Ld3sdgLPcsqOAwyqnbAaltsXzNMSOXCTSgtDentXPvLIrJxF1KN0B1o+Q4p0dO8VNx
         pQDqCduwbS/nFeg97063NXmuDmpL/o535skw9KJO4Tj29N25kxjXbeJzHyx15GgyW3tq
         5idQ==
X-Gm-Message-State: AC+VfDzRpz8rywqMG6sXfKpWGiyCWE/Us9uX9OghUtxHrDQ/auR7F7M8
        DH4Vle3t+J6hFXdNtsGjfQcAWvuEvExVCOLWqj+HThRu8vKL6A==
X-Google-Smtp-Source: ACHHUZ6an6zID91jt8f3LQ4QGAvFJ9u++x53xf0fSCLXe0WivFCmGXJlgIcqvJgo7KICituWVYFJf3qgdSw5/O75Zdg=
X-Received: by 2002:a81:4810:0:b0:55a:84c9:e952 with SMTP id
 v16-20020a814810000000b0055a84c9e952mr1013445ywa.17.1685048014974; Thu, 25
 May 2023 13:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com> <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com> <20230525202537.GA4967@kernel.org>
In-Reply-To: <20230525202537.GA4967@kernel.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 25 May 2023 13:53:24 -0700
Message-ID: <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 1:26=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, May 25, 2023 at 11:04:28AM -0700, Vishal Moola wrote:
> > On Thu, May 25, 2023 at 2:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > > > +
> > > > +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int =
order)
> > > > +{
> > > > +     struct page *page =3D alloc_pages(gfp | __GFP_COMP, order);
> > > > +
> > > > +     return page_ptdesc(page);
> > > > +}
> > > > +
> > > > +static inline void ptdesc_free(struct ptdesc *pt)
> > > > +{
> > > > +     struct page *page =3D ptdesc_page(pt);
> > > > +
> > > > +     __free_pages(page, compound_order(page));
> > > > +}
> > >
> > > The ptdesc_{alloc,free} API does not sound right to me. The name
> > > ptdesc_alloc() implies the allocation of the ptdesc itself, rather th=
an
> > > allocation of page table page. The same goes for free.
> >
> > I'm not sure I see the difference. Could you elaborate?
>
> I read ptdesc_alloc() as "allocate a ptdesc" rather than as "allocate a
> page for page table and return ptdesc pointing to that page". Seems very
> confusing to me already and it will be even more confusion when we'll sta=
rt
> allocating actual ptdescs.

Hmm, I see what you're saying. I'm envisioning this function evolving into
one that allocates a ptdesc later. I don't see why we would need to have bo=
th a
page table page AND ptdesc at any point, but that may be a lack of knowledg=
e
from my part.

I was thinking later, if necessary, we could make another function
(only to be used internally) to allocate page table pages.
