Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE025E869
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIEOl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEOlz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 10:41:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA6C061244;
        Sat,  5 Sep 2020 07:41:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEZNo-00AviF-NY; Sat, 05 Sep 2020 14:41:36 +0000
Date:   Sat, 5 Sep 2020 15:41:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from,to}_user
Message-ID: <20200905144136.GA2604093@ZenIV.linux.org.uk>
References: <20200904165216.1799796-1-hch@lst.de>
 <20200904165216.1799796-4-hch@lst.de>
 <20200904180617.GQ1236603@ZenIV.linux.org.uk>
 <20200904223518.GR1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904223518.GR1236603@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 11:35:18PM +0100, Al Viro wrote:

> 	Now, if you look at raw_copy_from_user() you'll see an interesting
> picture: some architectures special-case the handling of small constant sizes.
> Namely,
> 	arc (any size; inlining in there is obscene, constant size or not),
> 	c6x (1,4,8),
> 	m68k/MMU (1,2,3,4,5,6,7,8,9,10,12)
> 	ppc (1,2,4,8),
> 	h8300 (1,2,4),
> 	riscv (with your series)(1,2,4, 8 if 64bit).

FWIW, on the raw_copy_to_user() side the same set of constant sizes is
recongized by the same architectures and we have
	* __put_user/put_user in asm-generic/uaccess.h make use of that
	* arc, c6x, ppc and riscv using it to store sigset_t on sigframe
	* 3 odd callers:
		* arc stash_usr_regs(), inlined and unrolled large copy_to_user()
		* ppc kvm_htab_read(), 64bit store.
		* i915_gem_execbuffer_ioctl():
                        if (__copy_to_user(&user_exec_list[i].offset,
                                           &exec2_list[i].offset,
                                           sizeof(user_exec_list[i].offset)))
		in a loop.  'offset' here is __u64.

That's it.  IOW, asm-generic put_user() is the only real cause to have those 
magic sizes recognized on raw_copy_to_user() side.
