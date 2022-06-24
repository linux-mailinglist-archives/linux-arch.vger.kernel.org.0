Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A3559F9B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiFXRIo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiFXRIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 13:08:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398651E60;
        Fri, 24 Jun 2022 10:08:39 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIMOy-1nqSvK0TRs-00ENS2; Fri, 24 Jun 2022 19:08:38 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-317741c86fdso31022967b3.2;
        Fri, 24 Jun 2022 10:08:37 -0700 (PDT)
X-Gm-Message-State: AJIora+vOReRoiC0ol6rAf1TN1n5lpY9MjcHfMs32HjfyxUReNol3N7a
        26A5lClE/+ipAMln9vDPfZ4vhcpYmfYWx6jsmPI=
X-Google-Smtp-Source: AGRyM1tBSdPwbFq9GZSjizWzVuAB7giujhHzzt55cTqkntbPy6yauQrkbaXTZ2eocC/Zbg06KphUioMdhsic93kqOWE=
X-Received: by 2002:a81:b93:0:b0:317:791f:3c0 with SMTP id 141-20020a810b93000000b00317791f03c0mr17394782ywl.42.1656090516599;
 Fri, 24 Jun 2022 10:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220624155226.2889613-1-arnd@kernel.org>
In-Reply-To: <20220624155226.2889613-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jun 2022 19:08:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04C+ZavWb2nnYs-02CKZq10OA8rDE7QHMFF5qZzb6t9g@mail.gmail.com>
Message-ID: <CAK8P3a04C+ZavWb2nnYs-02CKZq10OA8rDE7QHMFF5qZzb6t9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
To:     linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
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
X-Provags-ID: V03:K1:cui5DZKm2UZs4D6xVfnz2Gnj6IaNBXSsNsy8dkyFFcf5zgG8W9N
 THm08VdtRdX/KI3hpQL0WwzH6+ZkmeayH2g6LC9T4JqNSp3zkjkVrPnBiwO/wGWL2hyrjj8
 hAUFsFgAXbY58a4KXnJIdRUV4TfbVu+JW4K5PkSzY3kRBkEr4UKUfTvXJeiru5EhTLL2TtJ
 wHZ88KKL+ozSPjchnpxbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVyTIRisiFw=:XyqgDRsNqkZE8ZfaKwZVDv
 b0a3W5I/Wvl/obs+EfzaOaAo1o+AqQVCPceu8TcV592SxfTnxERW1BfZ4/C0veb5TdvVs34Tn
 YMOTQ+MXMuovUm9oYj9RQ39CFefWQdXulJmKlLiHG+DJIZA39Ao7iJpbVMGvCTFFELZ3zb6nI
 D/aEzVULUnbktOEQCopSCr2YGo49AWega6KKlWkbTB/NXP+bD52xeeAJaUz8TxLzbAvxGwgcq
 ApQSwbILzb7pgrA9E8mwXwm2aSgmPJn6CbD1WjXjQkOJbhTBvlv5DpHQKF0dK3N5y04rW4g37
 Z1FPBjwlJu8kIOE6Qzf9ySvOsnRGFGHDFaS9kT+NrJaI2583NHMNjIBl/EMyvkD6BGZ0Cmn/c
 3ekzpBQwH6x6gNXLD0V/8+TZChRy1/XCPRyign08nafSzxP8sFS8UwcZpRjQ1k+fcUxQ+YwwA
 il6uUCDBDUfyFcCgTUUnCFpvs8ALuUVTuHN+jldFZ5o14igqHveXY0jc0okHB9RdX5uiWyZZM
 y5jVfq5hIWKJlejd7+P5AeC5N0Q3pYkw3uOE4ZMjRWoo7epLR/FeQDfc7/L5MnDXBf4v6verl
 tUZ0igFL1hjF4WePaNc1BZL2CvFB0ItvrYBINsMXY78tf6i4a9bSIAZr1FqxWgDxphbzfe7Pl
 fEs9Axp55DpsRybGJPMpBPzbuBHe2xc9x21QJkaWi7C279675pu4ESmixsjYq/nglEJvrz3mj
 p/PRo9FZn+uoIcxBACd3Sgpwiu0bAEw7cGe18jR54XATmirpfmMvlMsV7gwFFTp6DGQ8YaiK4
 SZpqvCxoxMdAPhZuX9j4WvuOInBQ3ngPAYQofTuAfqvFJ7GdfofZ8nt+uucvHb4mJSCnpwBgO
 ALrq0cCWmln+i3BUJ02oLMwfcbaXWYIpsQul1zBQo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 24, 2022 at 5:52 PM Arnd Bergmann <arnd@kernel.org> wrote:

> Arnd Bergmann (3):
>   scsi: BusLogic remove bus_to_virt
>   scsi: dpt_i2o: remove obsolete driver

The dpt_i2o removal is overly large and got dropped by some of the
mailing lists,
if anyone wants to see the full patch, it did make it through to the linux-scsi
list at least:

https://lore.kernel.org/all/20220624155226.2889613-3-arnd@kernel.org/

         Arnd
