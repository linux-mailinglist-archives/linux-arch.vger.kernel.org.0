Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBB55F088
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiF1Vu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiF1Vu4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 17:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D812E686;
        Tue, 28 Jun 2022 14:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6D7618B3;
        Tue, 28 Jun 2022 21:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3A5C341C8;
        Tue, 28 Jun 2022 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656453055;
        bh=Eulr4Y0cWb7qjc6CpxCm3Vct1+OoFSfv0gPahuMP8H0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elEeeKUDea9hk5aQmAteuIyRdHZZsKhLl3Vgkrf0ebuHMVDyxzs1owwkAc5icxtXR
         Tv3y3Ypg5BZfSAA4fm/1du/h9YT9oUMVvzdwBxhJY45v0cynFE7MH/FGecsgnZV2dk
         iPm6ogOEDIT42r9PUlRQz9dQNjh6tOzSwvfw+orYrQP8DJdAcBTb8Txl9TLsSqkRI5
         7J7GSf1511sS2KBwajo4lNLtrnzx6YNYJIcRb3aJarxomVr3XyXRVQbc5LQe6sATzH
         Szilv/6OGgYptkfbHHlymMEVoWlRUtOrH4DB1kh3spBftyplxnSoqxW2EfM72iufIW
         dnOIf5/XmvBRg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3178acf2a92so130916397b3.6;
        Tue, 28 Jun 2022 14:50:55 -0700 (PDT)
X-Gm-Message-State: AJIora8t+Tbp0ONZp1rsopAHnWHF4ZtgcARhu00sjUOo9OWfh5FHrdMN
        iOowDmIdqZf0/seXxsuCn+4f1ZlUFPeUG2TB790=
X-Google-Smtp-Source: AGRyM1uiK3Jm9EI3ugNHld4Mw8359HNpN0AV60gdNeVzfnYPf20oZVN1walPYmvUh7o4VEBL7hhWBeeKgOlyyZ+Nc1k=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr283034ywe.320.1656453054172; Tue, 28
 Jun 2022 14:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com> <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com> <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com> <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
In-Reply-To: <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Jun 2022 23:50:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
Message-ID: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 28/06/22 19:03, Geert Uytterhoeven wrote:
> >> The driver allocates bounce buffers using kmalloc if it hits an
> >> unaligned data buffer - can such buffers still even happen these days?
> > No idea.
> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
> code path is still being used.

kmalloc() guarantees alignment to the next power-of-two size or
KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
is cacheline aligned.

      Arnd
