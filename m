Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D11223359
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQGGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 02:06:23 -0400
Received: from verein.lst.de ([213.95.11.211]:37283 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGGW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 02:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E319668BEB; Fri, 17 Jul 2020 08:06:18 +0200 (CEST)
Date:   Fri, 17 Jul 2020 08:06:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up address limit helpers v2
Message-ID: <20200717060618.GA9842@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 04:49:24PM -0700, Andrew Morton wrote:
> On Tue, 14 Jul 2020 12:54:59 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Hi all,
> > 
> > in preparation for eventually phasing out direct use of set_fs(), this
> > series removes the segment_eq() arch helper that is only used to
> > implement or duplicate the uaccess_kernel() API, and then adds
> > descriptive helpers to force the kernel address limit.
> > 
> > 
> > Changes since v1:
> >  - drop to incorrect hunks
> >  - fix a commit log typo
> 
> I think this *is* v1.  I can't find any differences in the patches and I
> was unable to eyeball any changelog alterations?

No, this actuall is v2.

"[PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers" dropped
two incorrect hunks in the m68k and sh arch code, and lost and "er"
in the commit log.
