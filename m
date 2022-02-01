Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736BD4A57EA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 08:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiBAHkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 02:40:55 -0500
Received: from verein.lst.de ([213.95.11.211]:57773 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234901AbiBAHkw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Feb 2022 02:40:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2105168AA6; Tue,  1 Feb 2022 08:40:48 +0100 (CET)
Date:   Tue, 1 Feb 2022 08:40:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: consolidate the compat fcntl definitions v2
Message-ID: <20220201074047.GA29119@lst.de>
References: <20220131064933.3780271-1-hch@lst.de> <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 11:19:32PM +0100, Arnd Bergmann wrote:
> I think it would be best to merge this through the risc-v tree along
> with the coming compat support
> that depends on it.

Sounds perfect to me!
