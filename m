Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC59E9B16A
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405745AbfHWNzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 09:55:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41098 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405737AbfHWNzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 09:55:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so5833674pgg.8;
        Fri, 23 Aug 2019 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BUAiw1OCmJxcFhDfFwk6vJ4atOusYa0enlexPK5RdcM=;
        b=p1kpl17yQ70OZJjj0Ex1dhmfo2/01ZSY1fOdxj+J/0LKK1tvqbyWGApNp+RopSCBU9
         F4JDgPHlcLiS1iW8iLa6+Oz3hvJ93YLeeZOw8VI/PWR7yXZkQ2Y3BWj/9xw0zvYm8PgM
         xCORxywfStYr2iObddDIvw4uxyyFDzJ4nH8mOJxihZGgGGvOFtqX5rLKfVLumbHnUiDf
         cp+XG0kMNbLUq5HT5W+hUh/PxuwaBDz2hVRJ6ISjeckQ/denHk7F5JHtEBhHBSkgw5OY
         5pVQ0XdibEupNYaM8DhPTT4HkPLbYUHv2fszhaDZIjemQ/II2oo6OpoSBdKla1hplbzS
         Zchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BUAiw1OCmJxcFhDfFwk6vJ4atOusYa0enlexPK5RdcM=;
        b=kyI8hKE6xwD1miMcxQhJ+N6et5/it34fgxP+jY87dG79FVgNdi8fLjDi8QmZ4nkgoB
         nTlFliEP5SQru9OKHzP1546LxcoHXp4i/4N/teJS+UaIrQWg3WPH3Ha/FUWe7iVAm3v0
         6yjysqqcNmD0HLU2M1fPUPVt9/qjZOR+K52iE5AxC8IC8OOXMIiRVWfd4GiIamKRXl6I
         aRxY7WXrurlWubMc2/CPVtGv3kNKf6uTUmZnrY9G+Ovu+Bgdp6+7q1tiUunPwfdOlq2m
         Bd0wESKEBDk7kKmgmAsIFO97Bo2oCy2tD+MIrL0Kmd9y3+ZdTDvvxRV49T61ScieMkM6
         DgRg==
X-Gm-Message-State: APjAAAWm7fM6AeWfFuDb7obirUbcPCSNWq4rH4Ahk3rv3VD6ytxpY1Za
        6f//agm1SwXBtjp37K7cDJST23+sS8w=
X-Google-Smtp-Source: APXvYqzeZA+QEa5Xq4+pVCPW2H7vItZxat4J0/SQ1XBxiBF3Po4TqLpUuSgHOh67wlOMVyJ/4CHLaQ==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr5454982pjq.73.1566568541762;
        Fri, 23 Aug 2019 06:55:41 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
        by smtp.gmail.com with ESMTPSA id z13sm2477619pjn.32.2019.08.23.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 06:55:41 -0700 (PDT)
Date:   Fri, 23 Aug 2019 22:55:39 +0900
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
Message-ID: <20190823135539.GC24874@lianli.shorne-pla.net>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-6-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> Openrisc is the only architecture not mapping ioremap as uncached,
> which has been the default since the Linux 2.6.x days.  Switch it
> over to implement uncached semantics by default.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/include/asm/io.h      | 20 +++-----------------
>  arch/openrisc/include/asm/pgtable.h |  2 +-
>  arch/openrisc/mm/ioremap.c          |  8 ++++----
>  3 files changed, 8 insertions(+), 22 deletions(-)

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks,
 -Stafford 
