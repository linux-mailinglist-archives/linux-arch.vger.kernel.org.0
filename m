Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C364BE6DE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355443AbiBULRB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 06:17:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiBULPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 06:15:23 -0500
X-Greylist: delayed 3173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 02:54:12 PST
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96805F38;
        Mon, 21 Feb 2022 02:54:12 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nM5V6-0006mq-00; Mon, 21 Feb 2022 11:01:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2EAEEC254E; Mon, 21 Feb 2022 10:55:16 +0100 (CET)
Date:   Mon, 21 Feb 2022 10:55:16 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH V2 07/30] mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <20220221095516.GA6314@alpha.franken.de>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-8-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645425519-9034-8-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 21, 2022 at 12:08:16PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/mips/Kconfig               |  1 +
>  arch/mips/include/asm/pgtable.h | 22 ------------
>  arch/mips/mm/cache.c            | 60 +++++++++++++++++++--------------
>  3 files changed, 36 insertions(+), 47 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
