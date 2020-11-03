Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD22A3F06
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCIhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 03:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCIhH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 03:37:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8CC0613D1;
        Tue,  3 Nov 2020 00:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p51eC8N7fCjbs3UOKmLERJ0rOtLko+yV5VDqRGWwjR4=; b=jSKhXR7Pj/ofKeYkogHVU0L3z8
        a+OY+4EFS+iwjY7MBw2RpzYUycpw8KkORE1OknTKWjxflQqHVMo74MWIZOUxpHtllpFGr1Pne/g17
        +PunXEUy0Hd60o5phBFSl3MpPC6YSnvFYCX5oy+qUAQ9YXKLj5DWZvP8AIHobdEjm/LFnSh2uzHVE
        ps66eSA3CWWAbp1LDf8hoTL55Lkk3p8CKhVfGosVzUXeZjs4UGdstQAHYUd3g5WFGQAoAAADeiRJN
        cSLH7GLhWnAKKCSjDuTiA8IuDMYNknGPo7XF2ftPFqFBzHyTFr8WcwH+HOnUUwr418rfbjPUswyt3
        oNnVluvg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZroN-0002gS-Vs; Tue, 03 Nov 2020 08:37:04 +0000
Date:   Tue, 3 Nov 2020 08:37:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
Message-ID: <20201103083703.GD9092@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102123151.2860165-5-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 02, 2020 at 01:31:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These are all handled correctly when calling the native
> system call entry point, so remove the special cases.

Ok, this is where you do it.  I think this belongs into the main
patches.
