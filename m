Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA437715C38
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjE3Ksv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjE3KsU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 06:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DAF3;
        Tue, 30 May 2023 03:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06A7562D99;
        Tue, 30 May 2023 10:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEA8C433EF;
        Tue, 30 May 2023 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685443697;
        bh=5BJct49nufUgpK5E0nq6xb69TeZ85NsUtXyny1OILQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghnJmwg8gzre1flGL6i+xKaSs738kaFL3FhVf6qRw7S00RAof0EdqzsswjMTmNBPW
         PtR9VBDBxdtktXObLlvxZb2UlvCfrbAh51gswdZ3WaQOEkn+lxTJVwwrHLRv07Co94
         DGOUnQTzYz78GGCsXrl2975B0G1WgU6j6//P9j9o=
Date:   Tue, 30 May 2023 11:48:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
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
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 33/41] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <2023053059-self-mangle-30b6@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-34-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516110038.2413224-34-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 01:00:29PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them unconditionally. For 8250 based drivers some
> support MMIO only use so fence only the parts requiring I/O ports.

Why can't you have dummy inb()/outb() so we don't need these #ifdefs all
over the place in .c files?  Was that documented somewhere?  We do that
for other driver/hardware apis, why are these so special they don't
deserve that?

Otherwise this makes old drivers really messy with these additional
#ifdefs, something we never wanted to do in .c files.

thanks,

greg k-h
