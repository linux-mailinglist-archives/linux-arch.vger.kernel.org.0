Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5543AEB5C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFUOfx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 10:35:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA1C061574;
        Mon, 21 Jun 2021 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F3lPpurYTOvRvGy/EiNGokDSGvWu9C8CkAKgxWdkptM=; b=JRnJ3IO25Hmq7DYoX2Vbx5GJm/
        fDNcGjm1ieffO6U3KLc98dBSlQTRtTQ55x31pSFyxfAokhhQ7vE9nvyCIZq++aGdo5NHtr+n+2I0i
        R8FFBBgrXDEYyZ640A7gujeZp5dOrWbOEms1BoBpDdhou3eFSJr+UXl89qzJpgktHjV6NuMYOKJkt
        njOkvD7wY+nCYNleInQdLfRLXttQBOFxsd06kH/mBaLzcV+W8ptJj8LXokD4oLFFp76KSmBG2g46P
        DW/6g4w2xjDTU1InXc44QYx67lRJUR0CE6oARRzs4WBaAMxwRgSvs4UV3FBAtJE2e9XmGtsW7g0En
        RD3lS9WQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKym-00DBQ8-RJ; Mon, 21 Jun 2021 14:33:08 +0000
Date:   Mon, 21 Jun 2021 15:32:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 3/3] riscv: optimized memset
Message-ID: <YNCjEGQa1UMf2P+X@infradead.org>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617152754.17960-4-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks nice, except IS_ENABLED would be useful here again, as well as
a placement in lib/.
