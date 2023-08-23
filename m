Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11877863C0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjHWWzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbjHWWyk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 18:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F210C1;
        Wed, 23 Aug 2023 15:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6902165B04;
        Wed, 23 Aug 2023 22:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7428FC433CC;
        Wed, 23 Aug 2023 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831276;
        bh=Za+r7k8kNmKfD+jB1gV4EVeEhZ5OQ+xqB0xO5nRoNGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HrQJpQMFG8z4Pd+cnV17RBTVU3kL43S/rZkcN6RIotCKi6UP/J1NRFFhQ2RWJTGQo
         5IuTKoaJgK8stu8UeAGu7WDUSVmcdIg9yzVIQ7eeaiPLId3n82NCL10NE0/qvZvKHu
         vmnh4mUv4clyjYC04MfmF8EV8UveyIfhgMlLFLgvH+H/37yIkjYlWPt0BnDDTEGWiG
         5tfdb2aV7Yar2QPvV47ceAaWs7SlHgGSJ5kO++W1oI2tWfqBwtzobm9Fh0QBvm4OK9
         g8pdfJtHvBGcLBddj+qM8JcYxKC/uls6YeOwsRpyoX2KdGbNKjmXNTWL8xBv0GR0dg
         +1V5A9r7dzEIw==
Message-ID: <f8080469-a5e5-5345-3454-a697ee7ae120@kernel.org>
Date:   Thu, 24 Aug 2023 07:54:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH treewide 0/9] Remove obsolete IDE headers
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1692288018.git.geert@linux-m68k.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cover.1692288018.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/18/23 01:07, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series removes all unused <asm/ide.h> headers and
> <asm-generic/ide_iops.h>.  <asm/ide.h> was still included by 3 PATA
> drivers for m68k platforms, but without any real need.
> 
> The first 5 patches have no dependencies.
> The last patch depends on the 3 pata patches.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (9):
>   ARM: Remove <asm/ide.h>
>   parisc: Remove <asm/ide.h>
>   powerpc: Remove <asm/ide.h>
>   sparc: Remove <asm/ide.h>
>   asm-generic: Remove ide_iops.h
>   ata: pata_buddha: Remove #include <asm/ide.h>
>   ata: pata_falcon: Remove #include <asm/ide.h>
>   ata: pata_gayle: Remove #include <asm/ide.h>
>   m68k: Remove <asm/ide.h>

Applied to libata for-6.6. Thanks !

-- 
Damien Le Moal
Western Digital Research

