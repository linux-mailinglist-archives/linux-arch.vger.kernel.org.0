Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290767010CB
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbjELVQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjELVQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 17:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ADFD2D3;
        Fri, 12 May 2023 14:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30D1658C2;
        Fri, 12 May 2023 21:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBB7C433D2;
        Fri, 12 May 2023 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683926112;
        bh=tK/i+sli1Qx6hi7lAgqjt19/P/qmplAKgc7mqzvPIK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=axXGw573Ua/pYEsjK9DTEp81AR36GlN/Ei1OYz7L+p3Xa2y5J71aAVy/MjHfvCaZX
         5kFFxkdHKE/ySOFoh0g6rh0qu02pC2aQY4ujsJmpJzzF7I0Bok3K0i9mGVPWvFFR+S
         vkuig7T1usTBxcGHcQraC7mKcIGTja/w5yTqpRG8=
Date:   Fri, 12 May 2023 14:15:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-api@vger.kernel.org,
        kernel-team@meta.com, linux-arch@vger.kernel.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: wire up cachestat for arm64
Message-Id: <20230512141510.20075825899e3c869c5358ca@linux-foundation.org>
In-Reply-To: <ZF4YEjiTOeu3jx+5@arm.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
        <20230511092843.3896327-1-nphamcs@gmail.com>
        <ZF4YEjiTOeu3jx+5@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 12 May 2023 11:42:26 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Thu, May 11, 2023 at 02:28:43AM -0700, Nhat Pham wrote:
> > cachestat is a new syscall that was previously wired in for most
> > architectures:
> > 
> > https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
> > https://lore.kernel.org/linux-mm/20230510195806.2902878-1-nphamcs@gmail.com/
> > 
> > However, those patches miss arm64, which has its own syscall table in arch/arm64.
> > This patch wires cachestat in for arm64.
> 
> You may want to clarify that this is for compat support on arm64,
> otherwise native support uses the generic syscall numbers already.

Thanks, I updated the changelog thusly.  Note that this patch is
transitory - it will be squashed into "cachestat: wire up cachestat for
other architectures".

