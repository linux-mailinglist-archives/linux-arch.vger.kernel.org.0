Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9D710AC6
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbjEYLV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjEYLVZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 07:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDF1B0;
        Thu, 25 May 2023 04:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F1406409B;
        Thu, 25 May 2023 11:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD548C433D2;
        Thu, 25 May 2023 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685013675;
        bh=ni3fv1TAGwhAduvkHrW+xcXeUTzxm+PZZUqb8TFrHOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GteQeC5wbJh/zN16M68svm+KDqi1k6O18ph0ng76OdPPVwKzrGcxwze3Xrm8G2Mg/
         dSyw6ehK6SEaNtASJIy/6BImXVtKVTdlSbTs8UORW4tltSaJQAWtyYJHYvHUleYObv
         sqi/Qe8phG2eSEei2GzsWrTBNZcJRo4claI7xnUvZRNEm7nrB/9Xp8+3/UZ8lB6UN0
         bbnRZXMSMYjM5OgeImTln8DU2ZSkoFS9fZJy0ayfBXzXFy/R+RksF/aCmrc3H2ZXk+
         rbeuI8klZIm9A9+c4vG/Tth0Vk0NQXXMkJXH0x9pRlVUmOCRua/KDKHzFDR6ZHVVZP
         OQNbmNqIfZy2g==
Date:   Thu, 25 May 2023 12:21:08 +0100
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
Subject: Re: [PATCH v5 17/44] leds: add HAS_IOPORT dependencies
Message-ID: <20230525112108.GE411262@google.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-18-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522105049.1467313-18-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 May 2023, Niklas Schnelle wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/leds/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
