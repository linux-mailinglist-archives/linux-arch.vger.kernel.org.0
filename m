Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408FB6BD4E0
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCPQPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCPQP3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F73BCFDC;
        Thu, 16 Mar 2023 09:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2786208A;
        Thu, 16 Mar 2023 16:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEEFC433EF;
        Thu, 16 Mar 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983288;
        bh=EOXfKepqJpZwzmeOGEP1BTpleS1yi4Np/zjGOVg7PSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=br1IST8dPXD9G7kObn2KAcLdH0b9SZO3d8DFiv+vHmkA+k3HKpPdBTSP0Ten3MVWw
         9vflVgqVZEvOSR1BHOPmiqB1c2usmYA9BsHALPpAQc8NwFWy3D0xqQcw+irTvfwphF
         SPs/t6YS+7WQrADW1QSWj4FtPf/gyXNZCK6udQqAYfxE7LY4b0UMnWx43ffWNcM4nv
         eUpNEGpwO8BS41gQ09hkJywTrUhADY92tkDyoR8WSr/b7MvviIaxmfz86XF0t3GxkZ
         AZAvXGM2bHuSfU3/kh5btYtMSPnOnnUjKecumr1IlI7Pka9uk/5PRDeBnY6fwtK/lN
         ZS93MWA0G3PzQ==
Date:   Thu, 16 Mar 2023 16:14:42 +0000
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
Message-ID: <20230316161442.GV9667@google.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314121216.413434-16-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Mar 2023, Niklas Schnelle wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/leds/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
