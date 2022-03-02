Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E334C9D19
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 06:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiCBFXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Mar 2022 00:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiCBFXw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2022 00:23:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BD5F4C0;
        Tue,  1 Mar 2022 21:23:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7jF46rSmz4xRC;
        Wed,  2 Mar 2022 16:23:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646198587;
        bh=EW7h6GpdaDNbwZGHiZAaI3MdXFwBu2xEgtf+Ok1PZlA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lWhC32dAUg9E3iB13asSEl3IGZdK/c28/Ypzl2ddkzEYQ3djbYgWlSP3RyJhpm5Na
         6qopH8SJWhUAcDxKZHVagvJoSIHYAL4wLxhu95pHGQSKM9mi+uqCLIDS48jN2SCDr8
         3hW1xyBgxsMtocUFA6uizbi9419Ant/1MjMx8tlYLZfUCZ6xeurWURO+6ZM4F85NEb
         XIbzne9+sy6yQbCkbNp0yFSeKJEoh6kBSZkPqvm9y4RngtUzavUWU8gPBqd3K3fTkW
         Seaz2Wd9JXTkWB5MzPd1wTj1GT7JiQk11vWz+fU7pXT7m04tdpff9zfHDEBHGpyTac
         +s8dkQbww3zeg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V3 04/30] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
In-Reply-To: <1646045273-9343-5-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-5-git-send-email-anshuman.khandual@arm.com>
Date:   Wed, 02 Mar 2022 16:23:02 +1100
Message-ID: <87k0ddnd1l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed. While here, this also
> localizes arch_vm_get_page_prot() as powerpc_vm_get_page_prot() and moves
> it near vm_get_page_prot().
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/powerpc/Kconfig               |  1 +
>  arch/powerpc/include/asm/mman.h    | 12 ------
>  arch/powerpc/include/asm/pgtable.h | 19 ----------
>  arch/powerpc/mm/mmap.c             | 59 ++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 31 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
