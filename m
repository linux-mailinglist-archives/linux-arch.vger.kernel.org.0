Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C37005CD
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjELKme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjELKmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5810C9;
        Fri, 12 May 2023 03:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCC7654A9;
        Fri, 12 May 2023 10:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D80C433D2;
        Fri, 12 May 2023 10:42:29 +0000 (UTC)
Date:   Fri, 12 May 2023 11:42:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, linux-arch@vger.kernel.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: wire up cachestat for arm64
Message-ID: <ZF4YEjiTOeu3jx+5@arm.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
 <20230511092843.3896327-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511092843.3896327-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023 at 02:28:43AM -0700, Nhat Pham wrote:
> cachestat is a new syscall that was previously wired in for most
> architectures:
> 
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
> https://lore.kernel.org/linux-mm/20230510195806.2902878-1-nphamcs@gmail.com/
> 
> However, those patches miss arm64, which has its own syscall table in arch/arm64.
> This patch wires cachestat in for arm64.

You may want to clarify that this is for compat support on arm64,
otherwise native support uses the generic syscall numbers already.

> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
