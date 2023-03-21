Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404346C337A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 14:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCUN4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 21 Mar 2023 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUN4q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 09:56:46 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A55590;
        Tue, 21 Mar 2023 06:56:44 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id h8so59994636ede.8;
        Tue, 21 Mar 2023 06:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGKyyYu0r/T+bSCiaFmZ4I80Q/b6usA2+yHs/LvdWnM=;
        b=AUPFeS+yPQGJabeAXGIkHfAPgQH6CUdtfAVROCK60OYYVvYu6hCVmMJz4dJx5pZaLD
         dvPoO8rTnyQ/DS8yNiJLoiC4f/GMuwIG1vmbQ1rQV5tiQGRnf1cKPVGeE3V/mcJ+biV/
         sok95Eah5pfGc8EgGS492bgl1kMnTF2nJNazorTZ2+j3o5k8FYx88mnlAyNkP66o/c3i
         IJjd3mGr6bD0SbSvga/cMz4RWaz57dz2hBRb5PN8mIdmYNv6rXF+gwJYfit7Ldf89AN0
         3PItQvHDY2Qm/bt8JZxI7AE78RBK6OV6QByN+HNLHmNJ9EdPRaEU7vSIF4idwdVrvZ5k
         Hmbw==
X-Gm-Message-State: AO0yUKVq3yOJU3y69Ixev5sQW7nieNJQIqdDjj9qWwaOe6j8+Tv7xTz1
        4zpw59f6oZKQ7RhlUDGPtLFwux5H8jZs6XjKzog=
X-Google-Smtp-Source: AK7set/k6WoORjORHs6M4iK+1Hc2u+78bc+7pEGYc2plMIKbgMU60VSzGqDxYz89I1KDD29963CkwTnmIMIcsrJDH1A=
X-Received: by 2002:a50:c389:0:b0:4fb:f19:881 with SMTP id h9-20020a50c389000000b004fb0f190881mr1689546edf.3.1679407003328;
 Tue, 21 Mar 2023 06:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-27-schnelle@linux.ibm.com> <CAJZ5v0gYGkbUk4uFXgidMaRBniwiXpizZWwMGixeNNejeZjPzg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gYGkbUk4uFXgidMaRBniwiXpizZWwMGixeNNejeZjPzg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Mar 2023 14:56:32 +0100
Message-ID: <CAJZ5v0gHFA_BgLuCx=Eb3J5D7f7j8kV3Pthqy3jAfpavY6UMuQ@mail.gmail.com>
Subject: Re: [PATCH v3 26/38] pnp: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 6:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> >
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to depend on HAS_IOPORT even when
> > compile testing only.
> >
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/pnp/isapnp/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> > index d0479a563123..79bd48f1dd94 100644
> > --- a/drivers/pnp/isapnp/Kconfig
> > +++ b/drivers/pnp/isapnp/Kconfig
> > @@ -4,7 +4,7 @@
> >  #
> >  config ISAPNP
> >         bool "ISA Plug and Play support"
> > -       depends on ISA || COMPILE_TEST
> > +       depends on ISA || (HAS_IOPORT && COMPILE_TEST)

This breaks code selecting ISAPNP and not depending on it.  See
https://lore.kernel.org/linux-acpi/202303211932.5gtCVHCz-lkp@intel.com/T/#u
for example.

I'm dropping the patch now, please fix and resend.

> >         help
> >           Say Y here if you would like support for ISA Plug and Play devices.
> >           Some information is in <file:Documentation/driver-api/isapnp.rst>.
> > --
>
> Applied as 6.4 material, thanks!
