Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE670EA8E
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 03:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjEXBJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 21:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXBJZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 21:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52366BB;
        Tue, 23 May 2023 18:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E44DD60DBD;
        Wed, 24 May 2023 01:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C25C433A0;
        Wed, 24 May 2023 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684890563;
        bh=AF+3f2cjLJFdCl9806/bunQ4+1zQ80GdB7HbBdr/Ytw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=etOwzS1HsaZVoqup0adWbjYyDWxorOjSeqm2a0AeGM36MRQr46aZWsGxNmi6SOS25
         rkOuykDbmW41l2Y9knmjasxxTjYPAlJvYMma6FyOSirhwLV9w14LNX/A3NSzigbMby
         cxY9Yf5AXpP9llHFMrAB1fDvFTX9RI3X0vnriuePfanKUYtiqdT+x4HqkyVoqDcoab
         T1dEZ7614D0T0YwB+4M7F5gJpbiUsQkAlWzC0AqjxnLI03+vqeIKioHzU3Gwb7wbo3
         tlot5ouk7gnksk+SHks/e0eKnaLD5HjNNVFi/xZ0P9kS+o/YRMst4zUzqL/AhNKfwl
         37yDbbgYFhWNQ==
Message-ID: <963614dff17f71f50018f5ba2dfcd82a63d6d5fa.camel@kernel.org>
Subject: Re: [PATCH v5 05/44] char: tpm: handle HAS_IOPORT dependencies
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
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
        linux-integrity@vger.kernel.org
Date:   Wed, 24 May 2023 04:09:20 +0300
In-Reply-To: <20230522105049.1467313-6-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <20230522105049.1467313-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-05-22 at 12:50 +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add this dependency and ifdef
> sections of code using inb()/outb() as alternative access methods.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
