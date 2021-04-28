Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3F36D7AC
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhD1Mur (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhD1Mur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 08:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706CAC061574;
        Wed, 28 Apr 2021 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=352/lgOwUkMwD9iQddxtMDN0ioz58bz5rwYjNmwVsLg=; b=ThQ1R+bu1jlRN4CBDTXlPRSiBB
        Im7+XUv4tbT84Nq8pHPlrVK21IqwldG3jSqVsC0/vak1Rfo31p/Q4huE10skEY6eKtt2ncUbG9u49
        VDURGTOVAud7akyVmGymqunXCrecN+WEcM/zL8fs6OHkUbHAG11sTsxUoFT3WmxKMHP6R5r6/Y57s
        /tS1KXTrSWrYpN0pH25R1XtMehHR86Ocf7xdw3GDgcbyrbFW5NuA9kDY297gsERzS3DmzuTQN1Ibj
        YC8V2U1e2bFFmTFOyugZW/N3jRsffPc9OdrjavccbtUJ5FJoI0dXNdCup93iA82HDcqQ0WoZ1S/yn
        StV88iSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbjdS-008IOe-4O; Wed, 28 Apr 2021 12:49:47 +0000
Date:   Wed, 28 Apr 2021 13:49:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
Message-ID: <20210428124946.GA1976154@infradead.org>
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
 <20210428031807.GA27619@roeck-us.net>
 <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
 <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 11:25:29AM +0200, Arnd Bergmann wrote:
> Actually, please don't use the asm-generic __put_user version based
> on copy_to_user, we probably have killed it off long ago.

Yes, they are horrible.  

> We might want to come up with a new version of asm-generic/uaccess.h
> that actually makes it easier to have a sane per-architecture
> implementation of the low-level accessors without set_fs().
> 
> I've added Christoph to Cc here, he probably has some ideas
> on where we should be heading.

I think asm-generic/uaccess.h pretty much only makes sense for
nommu.  For that case we can just kill the __{get,put}_user_fn
indirection.  I actually have work for that in an old branch.

Trying to use any of asm-generic/uaccess.h for MMU based kernel is
just asking for trouble.

> One noteworthy aspect is that almost nothing users the low-level
> __get_user()/__put_user() helpers any more outside of architecture
> specific code, so we may not need to have separate versions
> for much longer.

Al has been trying to kill them off entirely for a while, and I hope
he'll eventually succeed.  That being said the difference should be
that the __ versions just skip the access_ok, so having both is
fairly trivial to implement.
