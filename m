Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA19B57DB8D
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiGVHxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiGVHx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 03:53:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39779A6AB;
        Fri, 22 Jul 2022 00:53:27 -0700 (PDT)
Received: from mail-yb1-f170.google.com ([209.85.219.170]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6bwO-1nQq2V3URK-0181c0; Fri, 22 Jul 2022 09:53:26 +0200
Received: by mail-yb1-f170.google.com with SMTP id a82so1187523ybb.12;
        Fri, 22 Jul 2022 00:53:25 -0700 (PDT)
X-Gm-Message-State: AJIora/ZHyUgD5VkFQf5/vF8glimQkjAQkqEftpXb7IMf53pNTLKKz8F
        8Hfw5QODRPegyfl6L1yTzF2bHwYBcCdCWIrgdMU=
X-Google-Smtp-Source: AGRyM1u41IXDpMEFZlEyB5V83L7UcLnJ5KdxUhKbRxndnLJwe/AJGnvb+uTj5YbKPfI9znCIi02PXAb+ssOFnGHCMII=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr1946760ybq.472.1658476404347; Fri, 22
 Jul 2022 00:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220721134924.596152-5-shorne@gmail.com> <20220721173733.GA1731649@bhelgaas>
 <YtnMEwh3U3Ng9q4a@antec>
In-Reply-To: <YtnMEwh3U3Ng9q4a@antec>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 09:53:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3T0GvYyRgw=ojD_wts_pfdzfqXS8iNfUYuByBvLF9SGQ@mail.gmail.com>
Message-ID: <CAK8P3a3T0GvYyRgw=ojD_wts_pfdzfqXS8iNfUYuByBvLF9SGQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
To:     Stafford Horne <shorne@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GyKN2OGbq7WMnNBdWdjP7c/D3wETv7o5qIY3iUXZ0SZBcUODOBi
 y/2oc4nWzWfGhx920x7qjJNgq3cKW8FvcP4ddZbc5AH0wujWPnEsxJMFhv85XHUCCdmMCQD
 lpnk3ju8GNwD3cSTOwpPHeT8/fv9/3/3FwunYyDsUYLsdM3FQblN2Lbb2ckVV1mSs0FuxYX
 /K2lr4p8IehXeQVUdp6Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lmr2UG70+3U=:3mdYK+j0Uwq0w3AmY62R92
 nFNmmj11hyREYqORORfZjkL0b0/Amq2AaIHtCIb6nc/qnYQuxKe4jlQG+rqeqzYNkQewLElH8
 zhhQo6wCjpZ60e/P76vmJiJo0mF5DpYuKm3VDiReb6S93agW99zDkEdzBoYbc2dLWsgdoJVVF
 3lT1m+HJKjYehHJ7dzfh+jB5rdOtHjTtsky9/sTY+xznXzmjDELA6FdHSOYsNNzhnhHgXJaqT
 MwYZHsF33V5Y/ZWoOe5AJ3c0ASOvhB3bHEa0pI7Z++h6tceyR1eaOu695BoIz/yKuNrnNU+PO
 ZsWw6BHyVTWfYYZbNq0hwIJXUk4S6KQ9sQkDpgZ0Q3PKhNLQa4Xyk9SDpFnt4UOPjqtvqq+4X
 EdFmprEVEhP8nxJ0plYow86U0J8q1A31mZYUR98iQpukWVci9DMSKI2PUaRQcONNLqQsscN0R
 pp97kdGB8LtdjX6qb+L2lJcRRKZEdQRZIzVXKb80MZu2UVfqcdsiKJEoYfI6yo2WGsLtAXSoL
 psGvbmq5Rd98o6qr6JBX99y3eFsgVr8pNqUb82gCrQNVBhuguYXwijokBQivWw7RrZEB61KlT
 ki+S2AwTVRSb/Z8Lumn7bIr62H8P4KdPV3dwKs5803Ss9uxMkDynpkPXUpeQMKwO833v2YPlj
 Hwxd+PrhoWwBANnFV4GGyfP9ZDDZjgGkeAw3p/VzoPVkfvhISyhmvXHzDly2Kb4Zop7vlocMm
 JgCLHg4dn1djlrJiYrUG0yy27kwAOVemL07C66GOrWp0jbn7VT250lNj5OitJ+upouE6GhdUF
 r5+BVh1PMtaX+rLxdNTjBAOEouaku+O1QsEIGgkQVCcnXMjoNAMx+P2WAdGGKWAO5wC8UF9df
 VvCLvmBa7SXtxlofk1Hg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 11:58 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jul 21, 2022 at 12:37:33PM -0500, Bjorn Helgaas wrote:

>
> Thanks, you are right, I think some of the earlier functions may have needed it,
> which is why I had it earlier.  But now that we have removed those we should be
> able to remove this.
>
> That said, I think some of the architecture includes could also be removed.  On
> OpenRISC we are able to get away with only having the global asm-generic/pci.h
> so we don't need a wrapper pci.h header at all.
>
> However, I don't have everything setup to build all of those architectures so I
> was being a bit conservative to remove headers.  I'll see what I can do in the
> next version.

No need to worry about linux/types.h, this is pretty much included everywhere
already and neither the risk of extraneous includes or missing ones is
something to worry about. I'd just remove it if you do another respin, or
we can leave it in if Bjorn wants to just apply the v5 version.

       Arnd
