Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0A36844A
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDVP7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVP7P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 11:59:15 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5209FC06138B;
        Thu, 22 Apr 2021 08:58:40 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2B2B292009C; Thu, 22 Apr 2021 17:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1D0D592009B;
        Thu, 22 Apr 2021 17:58:37 +0200 (CEST)
Date:   Thu, 22 Apr 2021 17:58:37 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
In-Reply-To: <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com>
Message-ID: <alpine.DEB.2.21.2104221755400.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com> <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk> <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com>
 <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021, Jiaxun Yang wrote:

> > Please can you point me to some download/pull/gitweb? It seems as if the series
> > also did not appear at https://patchwork.kernel.org/project/linux-mips/list/
> > 
> 
> You may try download raw from:
> 
> https://lore.kernel.org/linux-mips/E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com/T/#t

 Or you can cherry-pick the commits directly from mips-next: 
<git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git>.

  Maciej
