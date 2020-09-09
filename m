Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD3262771
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgIIGzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 02:55:19 -0400
Received: from verein.lst.de ([213.95.11.211]:55983 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIGzT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Sep 2020 02:55:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B53AA6736F; Wed,  9 Sep 2020 08:55:15 +0200 (CEST)
Date:   Wed, 9 Sep 2020 08:55:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: remove set_fs for riscv v2
Message-ID: <20200909065515.GA9618@lst.de>
References: <20200907055825.1917151-1-hch@lst.de> <mhng-5fa86587-c404-420e-a4c0-43d197d1cd27@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-5fa86587-c404-420e-a4c0-43d197d1cd27@palmerdabbelt-glaptop1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 09:59:29PM -0700, Palmer Dabbelt wrote:
>>
>> The first four patches are general improvements and enablement for all nommu
>> ports, and might make sense to merge through the above base branch.
>
> Seems like it to me.  These won't work without the SET_FS code so I'm OK if you
> guys want to keep them all together.  Otherwise I think I'd need to wait until
> the SET_FS stuff gets merged before taking any of these, which would be a bit
> of a headache.

now that we've sorted out a remaining issue base.set_fs should not
be rebased any more, so you could pull it into the riscv tree or a topic
branch.

The first four patch should go into base.set_fs, though.  Arnd, can you
re-review the updated patches?
