Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D58279752
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 08:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZGtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 02:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIZGtg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 02:49:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06466C0613CE;
        Fri, 25 Sep 2020 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aTmPQByiK3Dad9AlQsnkLV9SwcyuoNOVQ6jzJtjBKH4=; b=IMatPm5aCrgXrA4rb6yxmeRmFQ
        1bVSiL8zpsFGSiKnKB2+O+IEUEncH2aPSkY/b36bBc4sBQU1OXGm7vN/jLrKUFMF/nvEdwJa4cTZS
        jOXHS8nr4+iQXCRu85W4D6HalhgRsdN0nOcuG+IYfh20Z2C8VfOXsRSUZ8rmnXqlB5Tzz2nnrmnOB
        rx2fr8QZYJmqKRlqVLxVEU0c8m2Daq90rGBeuG/3JrtF0yDDGYP6hDb8V2ucc/0UYql6HE0NHs14a
        /CNI99RAj4ODcR94JP6oYA86qkzrIjEynqz1J8Eb84dpA/fwbTLiR2GZjppN3+wfuaRaUijxtR6r9
        SyLAEedw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM41R-00037D-7B; Sat, 26 Sep 2020 06:49:29 +0000
Date:   Sat, 26 Sep 2020 07:49:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
Message-ID: <20200926064929.GA10837@infradead.org>
References: <20200918124624.1469673-1-arnd@arndb.de>
 <20200919052715.GF30063@infradead.org>
 <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 25, 2020 at 03:40:06PM +0200, Arnd Bergmann wrote:
> e0d17576790e quota: simplify the quotactl compat handling
> b0f8a0c4046f compat: add a compat_need_64bit_alignment_fixup() helper
> ed8af9335e19 compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
> ce526c75bbe2 uaccess: provide a generic TASK_SIZE_MAX definition
> 
> I think I only actually needed the last one of those for the Arm
> patches, the other ones are dependencies for my other patches
> I have on the same branch.

I still haven't gotten anyone to pick up the TASK_SIZE_MAX one.
So if you want to minimize dependencies just define TASK_SIZE_MAX
in the arm code for now, and we can remove redundant definitions later.
