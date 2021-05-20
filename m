Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7D389D03
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETFVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 01:21:15 -0400
Received: from verein.lst.de ([213.95.11.211]:40710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhETFVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 01:21:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6CAC67373; Thu, 20 May 2021 07:19:51 +0200 (CEST)
Date:   Thu, 20 May 2021 07:19:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [asm-generic:compat-alloc-user-space-9 6/41]
 net/ethtool/ioctl.c:815:9: error: implicit declaration of function
 'in_ia32_syscall'; did you mean 'in_compat_syscall'?
Message-ID: <20210520051951.GA21165@lst.de>
References: <202105200456.B8lcITGX-lkp@intel.com> <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 10:33:08PM +0200, Arnd Bergmann wrote:
>  static bool ethtool_translate_compat(void)
>  {
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>         /* On x86, translation is needed for i386 but not x32 */
>         return in_ia32_syscall();
>  #else

Please just use compat_need_64bit_alignment_fixup() instead.
