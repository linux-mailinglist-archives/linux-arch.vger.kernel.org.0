Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A616B2B39
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCIQxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 11:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIQxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 11:53:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D6F8F2F;
        Thu,  9 Mar 2023 08:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8WqHG1tF5PTwG2ipK1afkhH8fVnCeGYxdGXBPNUWDLY=; b=cGcGdmlQVjslM6qa5YfmT4/k4K
        wAGrnU+s+VtHxBYn2lTOCCGyBGlv4V+v3A4CFCPruynb5kA4n/EYcL9hZJ5OXRt08MnBzNEmXjOns
        srPGMSxZMQNCqN/VKDOItWUz304WbYq2IAOVZYDE4L8qKmybNJIFhQBnZKGEP5bZsD3TDfMt57e/j
        FMzm7nI2wGKYMHg6HiiIyMeJbW6b1WNqz9Xb5Gp943p2kXgnky+umJl0vc/KbvQ1aO6gLxNPgYV4g
        PvzoO7EUOczwxmbOkshrOln3zS+Wkb2zKpWN8Zj7IgVIREGSsKGjrWqDMXvPYSRbhGjSS0wh4fVLN
        GzOMtiEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paJMg-00BJAR-EH; Thu, 09 Mar 2023 16:43:38 +0000
Date:   Thu, 9 Mar 2023 08:43:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
Message-ID: <ZAoMunXRR+kM7thg@infradead.org>
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
 <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
 <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
 <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
 <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 06, 2023 at 09:55:27AM +0800, Huacai Chen wrote:
> On Sun, Mar 5, 2023 at 9:28 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > On Sun, 2023-03-05 at 20:18 +0800, Huacai Chen wrote:
> > > > Might be good to provide some explanation in the commit message as to
> > > > why the pair of helpers should be GPL-only. Do they touch state buried
> > > > deep enough to make any downstream user a "derivative work"? Or are the
> > > > annotation inspired by arch/x86?
> > > Yes, just inspired by arch/x86, and I don't think these symbols should
> > > be used by non-GPL modules.
> >
> > Hmm, what if one of your partners wish to provide a proprietary GPU
> > driver using the FPU like this way?  As a FLOSS developer I'd say "don't
> > do that, make your driver GPL".  But for Loongson there may be a
> > commercial issue.
> So use EXPORT_SYMBOL can make life easier?

No.  All in-kernel FPU helpers must be EXPORT_SYMBOL_GPL.
