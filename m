Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FAB6B2B42
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCIQzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCIQym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 11:54:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB256360A5;
        Thu,  9 Mar 2023 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O06NXR+UHvYx/lElqCqrRFhF5ehPGyQ2puyAkUI53Is=; b=Ifgp0TzxpPd/XkQ5gdtUAo8OMM
        7Xq+uSdI086Pb8iGYYOyS8ip3B669AHxb9Aud2hqLwiYtLt4/Hd7LumujuxUYOsmcpF5VjGv4zshX
        E61xVEqp+D4kU1pVnOTP1gQYLkbiqsHPIknYuUcJp2DxnmFEODKgsKjQ9fnKNTny51oXScut4doIU
        CvunYx1Xv69UNX1G85qQaVwLGU0DMVZS7Ob318lusFZBCJp99kfr03NbS1HZsv0RPr4hshRVPbLja
        AlEW11D7UCmYh0xD/w6T03mBtJ7M/4+eaX9K5SMaBYaBXAR22OhLfJjLfr/iBak4ROM/dtxx/PSZE
        qrV2ev+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paJOo-00BJg8-AP; Thu, 09 Mar 2023 16:45:50 +0000
Date:   Thu, 9 Mar 2023 08:45:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
Message-ID: <ZAoNPuyHQTqucYxn@infradead.org>
References: <20230306031258.99230-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306031258.99230-1-chenhuacai@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

NAK, this needs to be an EXPORT_SYMBOL_GPL.

Also no way we're going to merge this without an actual user.
