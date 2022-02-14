Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2614B57DF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 18:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbiBNRE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 12:04:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiBNRE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 12:04:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26AA6516E;
        Mon, 14 Feb 2022 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OlcD6KOOWFSvNNMH9HkunbQnlb
        k0WmgaXslk8xjDiinERW8mKuODH3Y/sL+AEnQjvuNdF9E7+deN8/0QuyVJC0pC0uTAkss9efdM0Q1
        YpXwEnEEjOpFgF4dezZgvN+uzl2jTg18YL5dzOu49nB1tu6P2JwOxlWHaraaMbu9YT5tuGdfBy2Qm
        bDionjSPLl28VBHNh2XNm8ijhZL+PnI/DuV51jJOyrzR4iVslxDixmxoRib5l6TmxEqVpGplfHz4/
        TAOGEbSCn0Cp3jM2lu9exXhYWRImVREJ+jG2peBx7sosg5m5ZW+t10j9rdxx7wYgxdwh1WgJgfRWb
        o4OD/nUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJemK-00GH0i-Nf; Mon, 14 Feb 2022 17:04:44 +0000
Date:   Mon, 14 Feb 2022 09:04:44 -0800
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
Subject: Re: [PATCH 07/14] uaccess: generalize access_ok()
Message-ID: <YgqLrB5LttWFIScK@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-8-arnd@kernel.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
