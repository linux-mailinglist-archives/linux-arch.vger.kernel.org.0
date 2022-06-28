Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7D55CF91
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiF1Lbv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 07:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbiF1Lbu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 07:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E12E0AE;
        Tue, 28 Jun 2022 04:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE80D619E0;
        Tue, 28 Jun 2022 11:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28448C341CF;
        Tue, 28 Jun 2022 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656415908;
        bh=mGQ17FxEruXP1Se/YhPh1NXTTafvPHopAQxVYAQOAng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S9ev2a8N8YQmk0FkOdWFCB7fzksaF3TDIqbfcHvGcwSqAPQBjVarw4vw9M3l6HHmL
         ssCxgmsI8FHt9fG0XtnHdMUgr0QiYRCSQ79IVVpF+/C1G6eLSjq//dde0lc2VRCRaS
         1FOEBaNxnclo7b2FYkWs82psE+DIlzk94a+i0CS0kc4yOVpaZiit6FGLCMgT4MtfTp
         CwGZaSPgvhkEFi/ozVYkEbtrBOACwSSrasTZCqcPAk1+8mx2bwdjGw8Jo6F9FVGxwT
         aWToqKSq2ntJ+svOn8tdm9iL+aJ6hyyGwGM/YXBZrhOMDyTMuQVPNXGFsy/i9skP/1
         Bv9FMX2w5oSmA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-317710edb9dso114159217b3.0;
        Tue, 28 Jun 2022 04:31:48 -0700 (PDT)
X-Gm-Message-State: AJIora+iybG3t5gkqGZrISZYUTybV83miCxeleqE7Txioro+in7vQYIK
        fw0Hn7xXkk96tikS8j2GfZ36ANKai9j5fT1lQtk=
X-Google-Smtp-Source: AGRyM1u6alRW6DNpLAw2CjiZONF/08UESoBCXDxfJxZHbJGIZ8WIqxSBVa0RkxHHh4KQrTbwBfw484vqcSO7R67ID6s=
X-Received: by 2002:a81:230c:0:b0:31b:f368:d0b0 with SMTP id
 j12-20020a81230c000000b0031bf368d0b0mr4904055ywj.249.1656415907046; Tue, 28
 Jun 2022 04:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220624155226.2889613-1-arnd@kernel.org> <yq1bkudh4va.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1bkudh4va.fsf@ca-mkp.ca.oracle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Jun 2022 13:31:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-D_Ct1jBpKzv7OPZ3Mfkx4iD1QG8ELuib02aGXUAS6A@mail.gmail.com>
Message-ID: <CAK8P3a3-D_Ct1jBpKzv7OPZ3Mfkx4iD1QG8ELuib02aGXUAS6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
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
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 28, 2022 at 4:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> Hi Arnd!
>
> > If there are no more issues identified with this series, I'll merge it
> > through the asm-generic tree. The SCSI patches can also get merged
> > separately through the SCSI maintainers' tree if they prefer.
>
> I put patches 1 and 2 in scsi-staging to see if anything breaks...

Ok, thanks!

I have just the third patch in the asm-generic tree now. As long as it all
make it into the merge window, this should work out fine without build
issues, though there is a small bisection window during which the buslogic
driver becomes hidden. I think that's ok here.

       Arnd
