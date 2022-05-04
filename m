Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876E51AE8A
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbiEDUCB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377809AbiEDUB7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 16:01:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717C4ECFD;
        Wed,  4 May 2022 12:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 217C1B828AE;
        Wed,  4 May 2022 19:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9228FC385C5;
        Wed,  4 May 2022 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651694299;
        bh=wg/hwHaSxHe1LkHbSod1h6BsaaYPOvKGNxiNFQApSN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEei63mRJ/spdJbRpHfqvFWnMNbGcCWPZq4aMcUy9xZDioyB7DPeTnBolTr7GDAr8
         C4LTJXx5isZCuT0TjBbhqGsNmATm7lB95IA5GJDwlpKr2AuahZwWWeCqNqeqydylU9
         3Pnh6htK1fYB0OVT5wtmV1wuy45rWhpYQ0TDn375MkIp7XeoqEZRwjj+tPpsIJgBR5
         J2TJtPxqYWEEjBoZh0YOKWUFWouKBb14qMpPnOeBa+DyiLRWb5wYJ8oTNLo79j5cNl
         hRGQOcyMwN3dxVyTtNEw2fitX8zpBXaHACycN6Wv3XSUlV7PplpbXJUuTT56T73qNH
         AX/VBcZEHLx+A==
Received: by mail-wm1-f48.google.com with SMTP id 129so1471683wmz.0;
        Wed, 04 May 2022 12:58:19 -0700 (PDT)
X-Gm-Message-State: AOAM5319wfJvZKMa79arLzruEBVNN//aYKmX2yf7k022xp4tb5BnEpJJ
        Y8jeMsWNfowFcjWUpoDqe+FlNbMmeSfxN3+Vnxo=
X-Google-Smtp-Source: ABdhPJxReb27gItIiCiA4/nx0PiFQ0K4TTLKwACwm/x2zamtFQpbVBUb2l7ouPrVta/3hUoysKWZ7+dVKwiJwvHyjRY=
X-Received: by 2002:a7b:cf04:0:b0:394:27c8:d28a with SMTP id
 l4-20020a7bcf04000000b0039427c8d28amr948038wmg.94.1651694297479; Wed, 04 May
 2022 12:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-3-schnelle@linux.ibm.com> <20220504175352.GA456913@bhelgaas>
In-Reply-To: <20220504175352.GA456913@bhelgaas>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 May 2022 21:58:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AddBGnBV=6wK+LZDjZD05k=9tBBWd7LWm6smXLcfREQ@mail.gmail.com>
Message-ID: <CAK8P3a3AddBGnBV=6wK+LZDjZD05k=9tBBWd7LWm6smXLcfREQ@mail.gmail.com>
Subject: Re: [RFC v2 02/39] ACPI: add dependency on HAS_IOPORT
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
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

On Wed, May 4, 2022 at 7:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 29, 2022 at 03:50:00PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. As ACPI always uses I/O port access we simply depend
> > on HAS_IOPORT.
>
> CONFIG_ACPI depends on ARCH_SUPPORTS_ACPI, which is only set by arm64,
> ia64, and x86, all of which support I/O port access.  So does this
> actually solve a problem?  I wouldn't think you'd be able to build
> ACPI on s390 even without this patch.
> "ACPI always uses I/O port access" is a pretty broad brush, and it
> would be useful to know specifically what the dependencies are.
>
> Many ACPI hardware accesses use acpi_hw_read()/acpi_hw_write(), which
> use either MMIO or I/O port accesses depending on what the firmware
> told us.

I think this came from my original prototype of the series where I tested it
out on arm64 with HAS_IOPORT disabled. I would like to hide the definition
of inb()/outb() from include/asm-generic/io.h whenever CONFIG_HAS_IOPORT
is not set, and I was prototyping this on arm64.

There are uses of inb()/outb() in drivers/acpi/ec.c and drivers/acpi/osl.c,
which in turn are not optional in ACPI, so it seems that those are
required.

If we want to allow building arm64 without HAS_IOPORT for some reason,
that means either force-disabling ACPI as well, or changin ACPI to not
rely on port I/O. I think it's fine to leave that as a problem for whoever
wants to make HAS_IOPORT optional in the future, and drop the
dependency here.

       Arnd
