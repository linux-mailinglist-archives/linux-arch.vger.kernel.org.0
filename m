Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8C6BA52F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 03:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCOCXa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 22:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCOCXY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 22:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A4311C7;
        Tue, 14 Mar 2023 19:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77614B81C20;
        Wed, 15 Mar 2023 02:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90616C433D2;
        Wed, 15 Mar 2023 02:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678846924;
        bh=TJt3p8kdF///bmxtvCW+twzNwd9TEhsbHYb4KFNNSOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QR6PqaXwHsCwlksQtwbHu2JiPGXEtXXg63ZBq8Y8F2yK6zmHeZ1Ze9mBX56anjLB1
         /O1YLHeUJvLlKTgv843w9emTfr2Gi6UrmLsMP48ZeQ+LJ2H16CRZ0d7cW7MBqAsKsF
         JwvcCcUzYmQGZDk77qcrMfTzokLb7Z56lGpjfFJbOFoXgoa8F07cQ3OXamFNZtm95d
         pFrmIDRmWzmyvZfCKMzbDaICgnc/fwXQiLqZexqAUEeQSLVK+6TQSQx63VE5y8ds8q
         oUMgx/FkFvU1NvMNsgYThEQ868T9mTi5lICadQ5SrC+zgS+mGNkCRlKNkHqY0AExNd
         J5J1A5Dho9o5A==
Date:   Wed, 15 Mar 2023 10:21:59 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>,
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
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 25/38] platform: add HAS_IOPORT dependencies
Message-ID: <ZBErx5zoE1tFlrhx@google.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-26-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-26-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 01:12:03PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
