Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA307559D8B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiFXPnp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiFXPnn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 11:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B8496A8;
        Fri, 24 Jun 2022 08:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A114B8294A;
        Fri, 24 Jun 2022 15:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D9EC341D1;
        Fri, 24 Jun 2022 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085420;
        bh=ZrmSkwlqS2brnFN5Iry4JvejPq5gajOP5sg4Z4I3Hws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i9DTlTGAF2BSmIOGQb/gQyl7aMHalsUj8NoMTbK5Fd4cCyIuwAgENb43b1h9IH48h
         qp06qkk0zTx1HwRItvR0GItuPv+lz/7ChUX2E9qCxtTjXMu4b192guwea5c4SjI521
         4+UtTh2cv+kB26alAMsm83DdMDj5HP1Dh3uN2MA4aDR81torLsE+iHB1xV9EKT5lIO
         YEBYFhN226Zo4lYaEZEdr9mkWZhgmYyh//FjHYkPt20RneGhxwqQqJoNaBsRywsipP
         0iHfl24ek2rhJLBp6JuP3w86bddR2dx3a1MCX9Er4aQzEcWmIImB57bGTJCYzWnVbz
         3KOVO6Rr8xY7w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3177e60d980so28301487b3.12;
        Fri, 24 Jun 2022 08:43:40 -0700 (PDT)
X-Gm-Message-State: AJIora+a2tgAI1JsNgqWGQSPRIYyrOsFEVZvt3NWKO1ZwY8EX75G2Bvh
        plqLVhbtN1Z6cfVaeJLRZH3dt8A3Ekh8k51snUQ=
X-Google-Smtp-Source: AGRyM1tAwe56Z5fVE7/SpL81F9wGW1RUV71QXwxRBZMigOoQ0lhjNRQtgXoHzM5M7/mN527O+TQVqWtjCC96MjmmS9c=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr17066465ywv.320.1656085419237; Fri, 24
 Jun 2022 08:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org> <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
 <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
In-Reply-To: <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 24 Jun 2022 17:43:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0onDqNtteOjGu7R8vUvy_ycYSYnxJURCcoyxtZDcji=g@mail.gmail.com>
Message-ID: <CAK8P3a0onDqNtteOjGu7R8vUvy_ycYSYnxJURCcoyxtZDcji=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 24, 2022 at 5:38 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> On 6/23/22 08:47, Arnd Bergmann wrote:
>
> Driver works with this change. next_inbox is the correct pointer to pass.

Ok, great! I'll add a 'Tested-by' line then. I was already in the process of
preparing a v3 patch set, will send out the fixed patch in a bit.

         Arnd
