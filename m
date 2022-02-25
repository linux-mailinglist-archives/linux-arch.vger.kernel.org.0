Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E04C3D2B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 05:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiBYEbO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 23:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYEbM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 23:31:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6D1E2FC2;
        Thu, 24 Feb 2022 20:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 175D1B829D0;
        Fri, 25 Feb 2022 04:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC6C340E7;
        Fri, 25 Feb 2022 04:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645763438;
        bh=K1RaOpayOFOl9YrWjbFso6AxJRaB7d/hqz1cXZ69p68=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JQKxpsomaZBRaWmc5cvV6ib4A8rCg4TPitG6KtMN/3RrAcjKVTJT4yK2eDFUJ+cMs
         GGe2lQ0KwF+iTYeA1pEDWDB2RtmKuBiOhrq1UD43RSIKmGPeCxSvHgFkEuaxQ4Olvr
         2eAzhesO8mAMjdIVrsZ1nZFTt4sdpEeKUGFwUAwfuxPbqH/Wkgj8BdxrL7OB3VWTTd
         G6bo95wROzxmQJyLOX4tRd/qfCxU6mfLup3kLD3UTh5ardnvCDEhsvub+4i3ykdyNs
         K3IteETxgQ/sIy9c1oYc4VbyW0VV1YzXNoLx5Km6wu9MsETEo+EXnMVoPFvUjaAbVy
         MOmcxBoXdOugg==
Message-ID: <824a2d98-e992-0406-518f-adcde2a1372a@kernel.org>
Date:   Thu, 24 Feb 2022 22:30:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 12/18] uaccess: fix type mismatch warnings from
 access_ok()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, shorne@gmail.com, deller@gmx.de,
        mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org,
        davem@davemloft.net, richard@nod.at, x86@kernel.org,
        jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        kernel test robot <lkp@intel.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-13-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220216131332.1489939-13-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On some architectures, access_ok() does not do any argument type
> checking, so replacing the definition with a generic one causes
> a few warnings for harmless issues that were never caught before.
> 
> Fix the ones that I found either through my own test builds or
> that were reported by the 0-day bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arc/kernel/process.c           |  2 +-
>   arch/arm/kernel/swp_emulate.c       |  2 +-
>   arch/arm/kernel/traps.c             |  2 +-
>   arch/csky/kernel/signal.c           |  2 +-
>   arch/mips/sibyte/common/sb_tbprof.c |  6 +++---
>   arch/nios2/kernel/signal.c          | 20 +++++++++++---------

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
