Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9495B270AD9
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISF1t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISF1t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:27:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C938C0613CE;
        Fri, 18 Sep 2020 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JUeG2dqbaHdKowqeP15/7T7efjP+aGqq3V/awNZ2MV0=; b=HYIAMttNNTlX0fOvNkBm47uUVZ
        Kb1YdFIrA86VJO7ChdMMI/5lItCp4KsY7Ou51+H+dyQfPZRoa0XRgydYAS9GuZZzERNFktzljDqog
        RFf0EpIdMN8t7SJeQdSZjq9sHja7H3TvX+QUxXJ0IRBFWi2erv+CzMVIqJKEbL0Xpa4J2xhN9qpU/
        ee9jlBfQYAECp1odxOGv9wf3vfRR8jdiSIt7DxjZXT24oOdlpb89k0lmgmLLW8gJgIxDRuWLWZsE2
        usVR142K1GG1M3JhmAv+ZqVZH0ADZj3e4kbg9HXghbXpUQZ2oNYX0ajiCkI8Am1xpCUXJvX38d4VM
        6fhc93gw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVPW-0000NO-DG; Sat, 19 Sep 2020 05:27:46 +0000
Date:   Sat, 19 Sep 2020 06:27:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/9] ARM: traps: use get_kernel_nofault instead of
 set_fs()
Message-ID: <20200919052746.GG30063@infradead.org>
References: <20200918124624.1469673-1-arnd@arndb.de>
 <20200918124624.1469673-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918124624.1469673-3-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 02:46:17PM +0200, Arnd Bergmann wrote:
> ARM uses set_fs() and __get_user() to allow the stack dumping code to
> access possibly invalid pointers carefully. These can be changed to the
> simpler get_kernel_nofault(), and allow the eventual removal of set_fs().
> 
> dump_instr() will print either kernel or user space pointers,
> depending on how it was called. For dump_mem(), I assume we are only
> interested in kernel pointers, and the only time that this is called
> with user_mode(regs)==true is when the regs themselves are unreliable
> as a result of the condition that caused the trap.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
