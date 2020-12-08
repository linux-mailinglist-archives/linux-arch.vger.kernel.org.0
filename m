Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B62D2DDB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgLHPG6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 10:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgLHPG6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 10:06:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EDCC061749;
        Tue,  8 Dec 2020 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZRmhmgEF/TcsYjF7PHfRY1rYRCJzgiLD1ANpoijTRHU=; b=YTZ22eP1y/U39k5EjOPcP23dsX
        s0u0LuA/NUs94Nadg2wSduAoLYtxisvyLyjcKIcCyCJND1f76ZaL+OS3iryGMckxkQ6fQXFPTXmd6
        D8y39O/QCdDZlVASb+hoxpo30E0ZF1G9UI9jodaPhGkBiaOnGWABVkH3e4Jy7Oh/5Xay5ZTCttY/Q
        lzW42siy9EHTox/lWI9VlbWVVRmZG7qvBLm8CrAKRHVbh5WgkhzQdKFdaJ38BQTjHBaF1X1I0mknB
        vDSKZH19hO06U6Cb+GNPaWXEZk9wIOfIhuFU+5erJAtzsWS4MYtTaBdv2Fl7a0BL/RWaN6aBb8f8j
        TMp1IdMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmeZC-0004Ee-AH; Tue, 08 Dec 2020 15:06:14 +0000
Date:   Tue, 8 Dec 2020 15:06:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
Message-ID: <20201208150614.GA15765@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-5-arnd@kernel.org>
 <20201103083703.GD9092@infradead.org>
 <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 03, 2020 at 10:45:54AM +0100, Arnd Bergmann wrote:
> I had it there originally, I guess I should have left it there ;-)
> 
> When I changed it, I was considering to do the same for additional
> syscalls that have very small differences now (timer_create,
> rt_sigqueueinfo, rt_sigpending, recvmsg, sendmsg) and use
> in_compat_syscall() there, but then I decided against that.
> 
> In the end, I did like the split, as I found the smaller three
> patches that contain the real change easier to review, and
> it turns the larger patch at the end into a more obvious
> transformation.

Oh well, let's just keep the split as-is then.
