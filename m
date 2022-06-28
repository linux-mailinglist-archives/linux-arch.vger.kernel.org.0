Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844A55D6C3
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiF1IFb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiF1IFb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 04:05:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE81A3B2
        for <linux-arch@vger.kernel.org>; Tue, 28 Jun 2022 01:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A1DB81D18
        for <linux-arch@vger.kernel.org>; Tue, 28 Jun 2022 08:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B8AC3411D;
        Tue, 28 Jun 2022 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656403525;
        bh=pfGu3NZqNHlgO09DwPsoGwibPSDfqThutgFbNEFRD18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKpCYVNriO0IodBgeaGIc2gAm8HYzXjn0BoIJ5pCl5rRTS2+5lA3OMNUP927abMTX
         HgozZCx/M/jaFjgy1yWAp/G0fsn8DefO/3/iaZjSLwL9223N/+K75g4+luePuV1L9x
         7nYYxxEhfSyzqMgwvuM2sKnXcFyIA9oEyTpCSDo9Tpj16fIxR4WmeirvfE10Np/Zzf
         /AI7FCyZeLpZiJN+C3W+KLIXU92uk0ygnLH8pMiIH5C7MeklWWRwtKDvY5xv98YXPv
         +dzVEGacQjnnq8HjVTtkB/BhXONMdISq6Y8Xq7Lgbc2xqrRhnZ+lZH5SS8V5LEnM1b
         9NF8iiJ9OSScQ==
Date:   Tue, 28 Jun 2022 11:05:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [ANNOUNCE] linux/arch Microconference Accepted to 2022 Linux
 Plumbers Conference
Message-ID: <Yrq2OD8W6Lcaxx/4@kernel.org>
References: <YnvSR52cbIUHJjtV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvSR52cbIUHJjtV@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

This is a reminder that deadline is approaching but there is still time to
submit your proposals.

And of course thanks a lot for those who already submitted their topics.

On Wed, May 11, 2022 at 06:12:07PM +0300, Mike Rapoport wrote:
> Hi all,
> 
> This year we'll hold linux/arch micro-conference at Linux Plumbers [1] to
> discuss how can we improve architecture specific code and its integration
> with the generic kernel. 
> 
> Possible topics for the discussion could be:
> 
> * Reducing code duplication and generalizing the common code in arch/
> * Making headers in include/asm consistent
> * On-boarding more architectures to use common entry code
> * Devicetree
> * Future of highmem
> * Identifying old machine support:
>   - Still in active use
>   - Only in hobbyist/retro-computing
>   - Completely obsolete and broken
> 
> Please send your topic proposals to the Linux Plumber's website using the
> linux/arch as the Track you're submitting at:
> 
> https://lpc.events/event/16/abstracts/
> 
> The deadline for the submissions is 10th of July, 2022.
> 
> Mike and Arnd.
> 
> [1] https://lpc.events

-- 
Sincerely yours,
Mike.
