Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7864DA3FCF
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfH3VpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 17:45:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfH3VpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 17:45:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so3930569pls.8;
        Fri, 30 Aug 2019 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CyAnPYKlnqoE6HYrk4XrrLs/lfWC1furlwMXZwIbdJM=;
        b=Ey9XQvoj8H/Rnwv8NzD/KreDQNAtk/Y1mAfNtWWSPWRvpRHkSG3qzrkTUiyqzLyy8y
         FhYeM7nvgl239YS8plycKvLT74pvzlcX8njCo82d73vUDrqGOQIz8oARAkP7UKilrwM5
         NDqVYaJdxQw5YtmBNy2VGaqetGKnvddyuLZTFzzrXm1WRH2hh5P7VzQIaPjNRzRh/cM8
         +iOgz2nm0iGcnxDUVyloWrKJlS93KDGv8twzcGSeFsCL8uqXFf9uQEZtHNVy3yjgG/aD
         DEMAEjrPTZxgLBaKb3rpS25bBzOjAWuXx/Z+kiRAvu2tepHCjzQrK3HOb0q7by4MMmYW
         wmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyAnPYKlnqoE6HYrk4XrrLs/lfWC1furlwMXZwIbdJM=;
        b=EIOO/dpI+2pUY4aPFL8ZvpQPyrNVpIj6HE8Cdu5W0ZRr3evJH+4Wcp4LtYcT1T/V8D
         wMyHsWm1eSyvdxDmeYzjFZPLEv1+J29G5ldl+mx8F6xKG6etI1QKO2KxM0oVE41nRNeP
         QobTKQ+ZNZRregfPzseXgLrriY+wK+IMfefZr8EcdZy2gPAX6iYLci/PCwFyLofl2Hqf
         0kJs/VvNA38d3qR3b3YQz09KsPvspGGedvbJm5CShNdmiT1Y4YBzq3oA5tFVUWKBxmN6
         HF6WzibRQRHI5DUWOtgCfbiakI9RFSYAq3YtohDMnkquqOPQxgJMSkQvOBQE166LwScl
         b0HA==
X-Gm-Message-State: APjAAAUI1QI8ePr7mY+ERjQxKNIzcol2ok3K8624tlRNypLxNJobmsiy
        JDaxLfrJn4w8oTC31xZvHHoLCd8cqRQ=
X-Google-Smtp-Source: APXvYqzQSc6jNbxZKUcovD9FZLciwfGuo7Kt2wn5aZSHSDm6zSKrBIeIlpBZCEWXRcfFUHXs7Afe6Q==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr18714988plp.194.1567201515169;
        Fri, 30 Aug 2019 14:45:15 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
        by smtp.gmail.com with ESMTPSA id q69sm5777108pjb.0.2019.08.30.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:45:14 -0700 (PDT)
Date:   Sat, 31 Aug 2019 06:45:12 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] openrisc: map as uncached in ioremap
Message-ID: <20190830214512.GX24874@lianli.shorne-pla.net>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-6-hch@lst.de>
 <20190823135539.GC24874@lianli.shorne-pla.net>
 <20190830160705.GF26887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830160705.GF26887@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 30, 2019 at 06:07:05PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 23, 2019 at 10:55:39PM +0900, Stafford Horne wrote:
> > On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> > > Openrisc is the only architecture not mapping ioremap as uncached,
> > > which has been the default since the Linux 2.6.x days.  Switch it
> > > over to implement uncached semantics by default.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/openrisc/include/asm/io.h      | 20 +++-----------------
> > >  arch/openrisc/include/asm/pgtable.h |  2 +-
> > >  arch/openrisc/mm/ioremap.c          |  8 ++++----
> > >  3 files changed, 8 insertions(+), 22 deletions(-)
> > 
> > Acked-by: Stafford Horne <shorne@gmail.com>
> 
> Can you send this one to Linus for 5.4?  That would help with the
> possibility to remove ioremap_nocache after that.

Sure, I will pick this up.

-Stafford
