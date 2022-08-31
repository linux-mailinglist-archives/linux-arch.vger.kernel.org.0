Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE95A83F2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 19:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaRCk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiHaRCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 13:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14969DDB50;
        Wed, 31 Aug 2022 10:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D789B61A28;
        Wed, 31 Aug 2022 17:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8DC433C1;
        Wed, 31 Aug 2022 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661965274;
        bh=dOA0/fqv4z/2mKxLBdj3JvcbCnvXdrvHEIGpE11dFoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdcbLZahiwzegKE3gIobMMpUEurOe4nxH8S7jwXHFtLK1W809TCR4iTSz8KAEtZZs
         PWkoycNudCpiC7PCQqI6HCkLMJ+m6QUzACGD/L5AXSMuxUuwCyLFzl8+hwBa6bX6i4
         MtFrksZqCvqcAIb6O6DEGckbVyn2DEGS8QpKC42cxi+Mecd+yl9EqjejALKOmdwnZq
         MB8jz8gVNeAm3cnRYDrMhjyeOvGrLubR8aq1HSWSvEzsUhRtMvllW6ruoseGFS35rm
         BnuDByGftwrRzOeog5x2O9xSQGegEsrA8/yxx5cuQ6+1Pv9PGDJMTw+xhYXSCJ5VT1
         cLiy8+yd/MElg==
Date:   Wed, 31 Aug 2022 11:01:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND][PATCH v1 1/1] asm-generic: Make parameter types
 consisten in _unaligned_be48()
Message-ID: <Yw+T12PFGYXy52Ie@kbusch-mbp.dhcp.thefacebook.com>
References: <20220830172713.43686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830172713.43686-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 08:27:13PM +0300, Andy Shevchenko wrote:
> There is a convention to use internal kernel types, hence replace
> __u8 by u8.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry for the delay, looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
