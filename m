Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E970EF90
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjEXHiM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbjEXHiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 03:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA3AA;
        Wed, 24 May 2023 00:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D31A63A1D;
        Wed, 24 May 2023 07:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38090C433D2;
        Wed, 24 May 2023 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684913887;
        bh=Hbz8LEfGaSM02H3iNlB0mthVRySAG3og3BSuDmEKWfQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RsujwDTA38sOCzbP6mo9BclpTmK6Ngysw2u951NSNd9DsKSy2KQ91nstwobR/85HK
         EBQklxmOxubaVti2y3WGG+Dyra4GxlLKjNpd5JspoYf7pGt9Da25qdGegQtqUYvaAN
         tabXzpnW6s56sBxjY9NPD1AjoAQI7LqPpyzwfu3QILxMgdHYD2VjIbbJQnabtyv3Nx
         eFe6D2UuGMYyzh+wCBAAJtGDH/f880TuJgbLfjPFBx4hGD5slX+uvZP39ScVJ8ZB7e
         TGZkCb6e9DxzdAr6PN4n2GaLtHsWTBja9NPnqPskYNrW0K1hlbBuu2BL7RMC4/c1ei
         jWG9gvoUkZ9Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 43/44] wireless: add HAS_IOPORT dependencies
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230522105049.1467313-44-schnelle@linux.ibm.com>
References: <20230522105049.1467313-44-schnelle@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jouni Malinen <j@w1.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168491387892.8984.13248048073287184221.kvalo@kernel.org>
Date:   Wed, 24 May 2023 07:38:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Now that the dependencies are in v6.4-rc1 my plan is to take this to
wireless-next, is that ok for everyone?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230522105049.1467313-44-schnelle@linux.ibm.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

