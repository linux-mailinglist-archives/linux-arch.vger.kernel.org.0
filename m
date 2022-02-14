Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7D14B57F7
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356875AbiBNRGT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 12:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356876AbiBNRGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 12:06:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7465176;
        Mon, 14 Feb 2022 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0CqmZAPRvnTQjgxBDbgMZYquENsTA/VPZyRN6//m2xw=; b=A3sA4gEo4nM3H7a0dm/JzGaUgV
        QIajZXmGp6ANWQ7bYVPcoCtAlCwsaPV2mcLSTAMkTtOvct+SPoXoviqH9efT8NLhfT4S3LRw6YQXd
        op4oq2yv8hzQnJjEyzM3+ydZNTbB02+bfC5eJ50MyESjem8R8c2VVjXeHHcWxOdarSNfzvCwtBQpI
        InHc/8TWyFNrwCcTQldIWT4TQ5FyAGciNKaQWRRlcxgPeWZKydhmkMkbIzvof2xUER3lSjyAJ9oA3
        03ZxL6nD2oE4+Za+YPHuF/EueN4CdELKexFzVobCRN7YS+wtQRgWFdzsDIrcKnFVoJEqcho3LJJfk
        H411B1+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJenc-00GHV7-F2; Mon, 14 Feb 2022 17:06:04 +0000
Date:   Mon, 14 Feb 2022 09:06:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dalias@libc.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org, jcmvbkbc@gmail.com,
        guoren@kernel.org, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        will@kernel.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        bcain@codeaurora.org, deller@gmx.de, x86@kernel.org,
        linux@armlinux.org.uk, linux-csky@vger.kernel.org,
        mingo@redhat.com, geert@linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        hca@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, green.hu@gmail.com,
        shorne@gmail.com, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, tsbogend@alpha.franken.de,
        linux-parisc@vger.kernel.org, nickhu@andestech.com,
        linux-mips@vger.kernel.org, dinguyen@kernel.org,
        ebiederm@xmission.com, richard@nod.at, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [PATCH 10/14] uaccess: remove most CONFIG_SET_FS users
Message-ID: <YgqL/NJ3YHEAhj4i@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-11-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-11-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On almost all architectures, there are no remaining callers
> of set_fs(), so CONFIG_SET_FS can be disabled, along with
> removing the thread_info field and any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.

Wouldn't it make more sense to just merge this into the last patch?
