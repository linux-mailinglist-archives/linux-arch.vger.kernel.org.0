Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4725236C3
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiEKPMS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbiEKPMR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 11:12:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CD62111
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 08:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7571B8214A
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 15:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61633C340EE;
        Wed, 11 May 2022 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652281933;
        bh=G0IuxfquW0K17bGNrcOnWcEb5/RoJxU/PeGwic2H9/c=;
        h=Date:From:To:Cc:Subject:From;
        b=A//0TbAeLSEodak5MoSMGvNRaZwwfATIPZuZPShF/v1ilGd//QTAoeTeltOVj3clu
         mGf45ZMUIGXx57u1qTpDp0LiULx0Bo8IwcUFGx46C/rJd7Uhef/bF7qUH5SU5Ik0rL
         THeJOWVWWZ+gRX/aPqm1Vr/cSmqIPOktY2vkktsGzML2UtbsPzcJYh3C+Pf1EET9gc
         sk2un7d/Jjl9P5+K/RJe/WYA6hA2d5HCaBXrun+rp8542JH3Y7+t4rwqdG0DdzOWOY
         wwwjnp7x/KZkVQXUFtHWoO/Q3fzxLftgOZIrANgzi/GgSmOE8Wp31WcTS8s6n6NaV8
         TxeDhl3f4xy9g==
Date:   Wed, 11 May 2022 18:12:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [ANNOUNCE] linux/arch Microconference Accepted to 2022 Linux
 Plumbers Conference
Message-ID: <YnvSR52cbIUHJjtV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

This year we'll hold linux/arch micro-conference at Linux Plumbers [1] to
discuss how can we improve architecture specific code and its integration
with the generic kernel. 

Possible topics for the discussion could be:

* Reducing code duplication and generalizing the common code in arch/
* Making headers in include/asm consistent
* On-boarding more architectures to use common entry code
* Devicetree
* Future of highmem
* Identifying old machine support:
  - Still in active use
  - Only in hobbyist/retro-computing
  - Completely obsolete and broken

Please send your topic proposals to the Linux Plumber's website using the
linux/arch as the Track you're submitting at:

https://lpc.events/event/16/abstracts/

The deadline for the submissions is 10th of July, 2022.

Mike and Arnd.

[1] https://lpc.events
