Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2EB6C6B96
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCWOxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCWOxj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 10:53:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10051633E;
        Thu, 23 Mar 2023 07:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C6F1B8215D;
        Thu, 23 Mar 2023 14:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5CBC433D2;
        Thu, 23 Mar 2023 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679583215;
        bh=Fbc5lblfr5vwI/xmJ8hOyjrQuPwaaW8Tal29nn1TDoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjKNupO1HB787aNYEXWIWNmy9QTnlX5T54S70BYryxPuXaWGZE4tLs23eJRHcpLiF
         hmvRMQ7fjZpW43E8MqAhVNjLmbmmkDGIh1285/R6bts5yelQ+g0ZWrFPmxIjGeUxON
         Cl+a4aPUmGZCtj8K3JXxDtG5cgEt4SlldB7fXbcHi6w/8XinSD4Amu+CGQkpwqStpV
         MUg3jA9Ens4sdRIDU+YpYNWuNfrmC80TqSGOvt8Af07+j/O4wSIlEI9QR5AJkSQalr
         Ds0p67+T7Ke0DhIhilgo1rnMBjiOeFDN9mNXS9v7dqLwlmOkOJ2hfzvuFa7lfZc2+u
         7AmvRVchsGTWg==
Date:   Thu, 23 Mar 2023 14:53:28 +0000
From:   Lee Jones <lee@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
Message-ID: <20230323145328.GM2673958@google.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com>
 <20230316161442.GV9667@google.com>
 <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 23 Mar 2023, Niklas Schnelle wrote:

> On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
> > On Tue, 14 Mar 2023, Niklas Schnelle wrote:
> >
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > >
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/leds/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied, thanks
>
> Sorry should have maybe been more clear, without patch 1 of this series
> this won't work as the HAS_IOPORT config option is new and will be
> missing otherwise. There's currently two options of merging this,
> either all at once or first only patch 1 and then the additional
> patches per subsystem until finally the last patch can remove
> inb()/outb() and friends when HAS_IOPORT is unset.

You only sent me this patch.

If there are in-set dependencies, you need to send everyone the whole
set so that we can organise a suitable merge strategy between us.

I'll revert the patch for now.

--
Lee Jones [李琼斯]
