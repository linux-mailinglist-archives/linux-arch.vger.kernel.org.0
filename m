Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B151F91D
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiEIJvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiEIJYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 05:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90486102BB3;
        Mon,  9 May 2022 02:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41DC6B80D3A;
        Mon,  9 May 2022 09:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1730C385B1;
        Mon,  9 May 2022 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652088050;
        bh=34I44iElGDvsO9vc/1qouhwKhN0J+6JwjUlz5LWtXAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eno68cp5BdLmo+JTajkGm38tQmu+Eu/sq4rus3H3PeZDczMGh25dLxlkSQhTCYwgQ
         bRSLqPg8rs4UxHU6e7yF1XLfcomJY4t0M7NMNiC9YtBbODRwVUTlx6SW6lDf0enn7E
         9T9hamdgtefEwrz8+kx7empoAncF4wZJu/I5T1Hjl1mb2ZQEe72n8XmzgBvOAR4FsF
         4QojwyHucRdJFVdQrU9P2vZjh98K5479MIIg8a5HnWmlKqwdDQVV0uS/nEg6JHs7sL
         SWvP2H4iaApf/cjEfM2MMVxMergCCfxcFrfDgR/c+QhRf9pO7X20IS+nIspNDiA9e7
         v1X+v2ctmzR9A==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f83983782fso137203507b3.6;
        Mon, 09 May 2022 02:20:50 -0700 (PDT)
X-Gm-Message-State: AOAM530tFO+0vMwt+MVACNPqL1sy1PK48sBbQlPhguw4jkOm/w7HXEqg
        kZFEHVNCQdAMD/nBxzAFJIE4+T1V8+jV1dsq9vA=
X-Google-Smtp-Source: ABdhPJypbDFv1BZy0AnqQqgdzqwp622v39ahPgaEWut11CbwJXiKPfgoUvAUkAv6K8MS2PyK6H3dw0atDtfrf+Gmhno=
X-Received: by 2002:a0d:cd06:0:b0:2f8:f39c:4cfc with SMTP id
 p6-20020a0dcd06000000b002f8f39c4cfcmr11712705ywd.495.1652088049944; Mon, 09
 May 2022 02:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-57-schnelle@linux.ibm.com> <s5hczgnm6ia.wl-tiwai@suse.de>
In-Reply-To: <s5hczgnm6ia.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 9 May 2022 11:20:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_ppFRY7y4TL21kXfthcbFJmjMivfmH2r4Cqy_vAiesA@mail.gmail.com>
Message-ID: <CAK8P3a3_ppFRY7y4TL21kXfthcbFJmjMivfmH2r4Cqy_vAiesA@mail.gmail.com>
Subject: Re: [RFC v2 31/39] sound: add HAS_IOPORT dependencies
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 9, 2022 at 10:53 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 29 Apr 2022 15:50:54 +0200, Niklas Schnelle wrote:

> >
> >  config SND_OPL3_LIB
> >       tristate
> > +     depends on HAS_IOPPORT
> >       select SND_TIMER
> >       select SND_HWDEP
> >       select SND_SEQ_DEVICE if SND_SEQUENCER != n
>
> Both of those are the items to be reverse-selected, so cannot fulfill
> the dependency with depends-on.  That is, the items that select those
> should have the dependency on HAS_IOPORT instead.
>
> That is, a change like below:
>
> > --- a/sound/isa/Kconfig
> > +++ b/sound/isa/Kconfig
> > @@ -31,7 +31,7 @@ if SND_ISA
> >
> >  config SND_ADLIB
> >       tristate "AdLib FM card"
> > -     select SND_OPL3_LIB
> > +     depends on SND_OPL3_LIB
>
> ... won't work.  CONFIG_SND_OPL3_LIB is not enabled by itself but only
> to be selected.

Right, I missed that in my review. Not sure if this was a mistake in
my original patch or if it started in a later version.

I think for the ISA drivers, I would still add 'depends on HAS_IOPORT'
to both CONFIG_SND_ISA and CONFIG_SND_OPL3_LIB if only to
make it easier to understand, even though CONFIG_ISA requires
HAS_IOPORT already, and CONFIG_SND_OPL3_LIB cannot be
selected by itself.

For the PCI drivers, I think we need to add the same dependency
on anything that either selects SND_OPL3_LIB or calls inb()/outb()
directly.

       Arnd
