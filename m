Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48CB8FBA3
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfHPHDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 03:03:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHDx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 03:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RiKMgeFFBMknWAE5Nu1DMr6YvjPNtVHyNTev2PNm+yw=; b=lHz/ftXALZz1au8/ITd1rigxY
        Wb1Fol8/WiW9eKEENJu5jAcC9TpHvsBPzscJAhfuSSqIb+t68bGQShJohuQ7ITj/7qJaX3FpuG1y8
        2UtWm++Xs6WVNYVof/Wn/mQW+bnnjqowpiDExca6WxuYbWdiwWeVyXuQaTzUuucsY/cPxPD+dhhm/
        M3qtRkv5Q7XOTlq1CRvPP/BCNuri+TEnaGI2q/9fbWcXYIj3jPymWLw9pa/ER+vYUG9I2owBEwcdk
        75nP00P8Xa56jwJXjOdoz4//Ih9HKLn3stGTWuHkGQG5OWsgIP6TMPX4xB290rsqYeLwJB4Y+vWN2
        v1MMS/2Og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyWH6-0003f7-95; Fri, 16 Aug 2019 07:03:48 +0000
Date:   Fri, 16 Aug 2019 00:03:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Message-ID: <20190816070348.GA13766@infradead.org>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565868537-17753-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 07:28:57PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> Implement the following apis to meet usage in different scenarios.
> 
>  - ioremap          (NonCache + StrongOrder)
>  - ioremap_nocache  (NonCache + StrongOrder)
>  - ioremap_wc       (NonCache + WeakOrder  )
>  - ioremap_cache    (   Cache + WeakOrder  )
> 
> Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.

Looks generally fine, but two comments:

 - do you have a need for ioremap_cache?  We are generally try to
   phase it out in favour of memremap, and it is generally only used
   by arch specific code.
 - I have a big series pending to clean up the mess with our
   ioremap_* functions, including adding a generic implementation
   that csky should be able to use.  Unless this patch is urgent it
   might make sense to rebase it on top.  Here is my current tree, I
   plan to post it soon:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
