Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C819100E
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHQKeK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 06:34:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36695 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfHQKeJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 06:34:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so6023108wme.1;
        Sat, 17 Aug 2019 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39YvwnXSLPYPPS8HyY6xQ0pEYqQsaSVOcIZxY6QaSy0=;
        b=HaU5j73Xl18SPfWIKR/l5s1id63iaB7lpk2eLE9Cv93RaSr0QygCeb8VtdrjK/DFoH
         BzanBzeDzwH/CfWIayA254C8bK/pzQhAr1B+Cx1TRlWNSkT4XCzZLK+D58uxuJj/Z6c8
         1+jn+z+dU7Ewi0li9IwJ7jmFgqXABsf3p+TxQXzA7fHIgWlPmx739auC7j/bqLC+8NoU
         C3XDYz8eetWLerWT9nDLSd3eyiPofE72zfZEgyCEmcNmd7KEx0oxertXb8lLCukZQpFv
         6wFercfLlPzs2ZP2Iysl6A4A+S9cPkEPkEAEiZMttS1pDBUiq7OyBBL/XEMk2UGfKSWg
         tAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=39YvwnXSLPYPPS8HyY6xQ0pEYqQsaSVOcIZxY6QaSy0=;
        b=YlyDnqzp/aXsF5I1ibSIfDJeQqZPLczBp3smnIgBj4mYbK81lMo8hkhTnrAJb8rgqG
         cMzMZamZ3VwhqtXnvfq0pts+ZrNFxInv8fQO7xWXqGP19gabrUnPUgxfKAu8QaEc/Sle
         B+3ArTgh++CFuZNdxRAm5E7kcvCfkj/C4R+TL6VbaIeNWxJ/MGagRDWAMaZ8SAzKvvVG
         x7fkfizvMpLUFVdSJ+z5OVqiONuh060E5DAJjhmH5yHwRKAKqKD6ax2V4tEHXEtwVLyx
         cWuJT+irlAI3bqzepSKQ3NEcTX9KbOxOK9V7tAV/aaeqPijlpHGmZk1CWojcS4lq6Bo3
         IgQg==
X-Gm-Message-State: APjAAAXHlZwj8UpncqJsZZdiPXqcYLCtLyRWXCTB8rBgi9BuK8fzoS7x
        YWVr52MTgvhROZCV7dQJ0pM=
X-Google-Smtp-Source: APXvYqx+skxBDSiX8lI2gwUVvrx6yD5s1jqeJ+6VF/JmtojW+ENXyX4cQUxihmaZEwvtXGQA8HaHqg==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr11130163wmf.84.1566038046300;
        Sat, 17 Aug 2019 03:34:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 4sm14396946wro.78.2019.08.17.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 03:34:05 -0700 (PDT)
Date:   Sat, 17 Aug 2019 12:34:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
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
Subject: Re: [PATCH 12/26] x86: clean up ioremap
Message-ID: <20190817103402.GA7602@gmail.com>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-13-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Use ioremap as the main implemented function, and defined
> ioremap_nocache to it as a deprecated alias.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/io.h | 8 ++------
>  arch/x86/mm/ioremap.c     | 8 ++++----
>  arch/x86/mm/pageattr.c    | 4 ++--
>  3 files changed, 8 insertions(+), 12 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
