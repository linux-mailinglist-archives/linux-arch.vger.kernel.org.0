Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7244A21E9B8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNHMP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 03:12:15 -0400
Received: from verein.lst.de ([213.95.11.211]:53045 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNHMP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 03:12:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB14B68CFE; Tue, 14 Jul 2020 09:12:11 +0200 (CEST)
Date:   Tue, 14 Jul 2020 09:12:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Message-ID: <20200714071211.GC776@lst.de>
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de> <20200713122148.GA51007@lakrids.cambridge.arm.com> <CAMuHMdUCmEeU0G9wkUxZKm5tC9YoB-KXSSCLKwpSia746Myebw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUCmEeU0G9wkUxZKm5tC9YoB-KXSSCLKwpSia746Myebw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 13, 2020 at 03:19:42PM +0200, Geert Uytterhoeven wrote:
> > This used to set KERNEL_DS, and now it sets USER_DS, which looks wrong
> > superficially.
> 
> Thanks for noticing, and sorry for missing that myself.
> 
> The same issue is present for SuperH:
> 
>     -               set_fs(KERNEL_DS);
>     +               oldfs = force_uaccess_begin();
> 
> So the patch description should be:
> 
>     "Add helpers to wraper the get_fs/set_fs magic for undoing any damage
>      done by set_fs(USER_DS)."
> 
> and leave alone users setting KERNEL_DS?

Yes, this was broken.  Fixed for the next version.

> > If the new behaviour is fine it suggests that the old behaviour was
> > wrong, or that this is superfluous and could go entirely.
> >
> > Geert?
> 
> Nope, on m68k, TLB cache operations operate on the current address space.
> Hence to flush a kernel TLB entry, you have to switch to KERNEL_DS first.
> 
> If we're guaranteed to be already using KERNEL_DS, I guess the
> address space handling can be removed.  But can we be sure?

We can't be sure yet.  But with a lot of my pending work we should be
able to get there in the not too far future.
