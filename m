Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6157B2523
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjI1SUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjI1SUg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 14:20:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988B99;
        Thu, 28 Sep 2023 11:20:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6567DC433C8;
        Thu, 28 Sep 2023 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695925234;
        bh=06cCvMMCi+VQpc1y5Q1jIAw/i/bl0gy7Xcth6+QaJPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KyLgWJacdX6u4Q+dIqZ0o1u3r6T5lspDHUDJqLnc0s1KNH6MQyRQQ2aEZg0ZJQJNN
         eLwH26I6P/XqWBxRoLh+yIwy3UXtKus3O1C5KhJ2LkLHUP5KfwSKMWVHIOhzrts/6I
         ktKHvtCEGFD9O/U+7glICGDF3pjyC66XxHQ3EgN8GrIbDg/KAYPMU87L+qcIw12au2
         GfNPZBpqKwD773K4jbQAZu+OGXHy1ULZPlp4eGxlMyq0Zj8wV5wSWD2HugOUeJe9sz
         BEDRxQq9n3cFhPKzgEKmmUWEHRkI9Ar5fijGbpvSKPtvPYJn63P9FyxkMDsg4/pANS
         gjlQpK3rXhRvQ==
Date:   Thu, 28 Sep 2023 13:20:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Sanpe <sanpeqf@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, xuwei5@hisilicon.com,
        lorenzo.pieralisi@arm.com, jiaxun.yang@flygoat.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH] logic_pio: remove duplicate declarations of function
Message-ID: <20230928182032.GA492809@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915140650.3562504-1-sanpeqf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 10:06:50PM +0800, John Sanpe wrote:
> Remove duplicate declarations of logic_out* functions.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>

Applied to pci/misc for v6.7, thanks.

> ---
>  include/linux/logic_pio.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> index 54945aa824b4..babf4e3c28ba 100644
> --- a/include/linux/logic_pio.h
> +++ b/include/linux/logic_pio.h
> @@ -39,9 +39,6 @@ struct logic_pio_host_ops {
>  
>  #ifdef CONFIG_INDIRECT_PIO
>  u8 logic_inb(unsigned long addr);
> -void logic_outb(u8 value, unsigned long addr);
> -void logic_outw(u16 value, unsigned long addr);
> -void logic_outl(u32 value, unsigned long addr);
>  u16 logic_inw(unsigned long addr);
>  u32 logic_inl(unsigned long addr);
>  void logic_outb(u8 value, unsigned long addr);
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
