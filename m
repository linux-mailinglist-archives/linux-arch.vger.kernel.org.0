Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D601A25A7
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgDHPkk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 11:40:40 -0400
Received: from verein.lst.de ([213.95.11.211]:42916 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgDHPkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 11:40:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0BEE968C65; Wed,  8 Apr 2020 17:40:34 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:40:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] staging: android: ion: use vmap instead of
 vm_map_ram
Message-ID: <20200408154033.GA28499@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408124833.13032-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408124833.13032-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 08:48:33PM +0800, Hillf Danton wrote:
> > -	void *addr = vm_map_ram(pages, num, -1, pgprot);
> > +	void *addr = vmap(pages, num, VM_MAP);
> 
> A merge glitch?
> 
> void *vmap(struct page **pages, unsigned int count,
> 	   unsigned long flags, pgprot_t prot)

Yes, thanks for the headsup, you were as fast as the build bot :)

Fixed now.
