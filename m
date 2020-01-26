Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82074149BAE
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jan 2020 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAZPwI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jan 2020 10:52:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33483 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgAZPwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jan 2020 10:52:08 -0500
Received: by mail-yw1-f65.google.com with SMTP id 192so3579217ywy.0;
        Sun, 26 Jan 2020 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xPQePlZh39eyKR7YsKEWuSikwFjI98oXqirYgx30KXE=;
        b=HNRIG9gVkQ3HUI1aPRe0Ivt5iFSUUZFFylghPFPTkVk2EbRf19u2ShlE9/wu5pBwiN
         nnLK9198pwYtX+EyZs4aN66WVjIgyvGGXcCa/DSAuUC4SrsnozONNhVL+vvCOv5BaE23
         urdIWh7Ris7cyshQDk/G2CFEXaViQgIVHoWNLr6mnSjIDVraPpkNy0mnPVwvC+c9MeLY
         VH6U2f6qn5522b0SbKQxxawcy15GO9rOnuyFVxebv/oELdanZErlbZlKgThLcSoabekU
         +9/gaKn4ndfK9uTcww9m5dYeoG+Oy7NA2gFe6eCTOpXM7l4rYY7bt0AtgkycAxY/fKBp
         XfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPQePlZh39eyKR7YsKEWuSikwFjI98oXqirYgx30KXE=;
        b=SOwG2Qvuw6s/MOeqQW4wWeKVjDBVhRDgUSLoZ7FY++ZN6wloHdVtSaPCkLgfwkl+35
         UsPHQHK5H25vdXKXd58Cp6QLI8V7lYVSCtk8YtLJjDGqqCYo2RaqW5KAUwrrAln6lXau
         BjIk0a0f9RNJ0CPkZHAH+lX9rxyyxIg3QwcR9pYeuyqOR/0ncAjXa9Y0lB2Xj4qbU7bM
         tl6mY+DhG2XZSmVLbfh2dI8uzumxsa4hx2TVmiDhR3epVCsI7eXJtATghdGTEGqOUrnF
         rhAOks63VRcXDbrUU4jF2G0uZGvo4SIAsiQoJppHq1bEep6+xVCUWhCiVQsdmqFs+JYI
         6/0g==
X-Gm-Message-State: APjAAAWA83LpTPy3z+FSx0sgnbv0aG6wcPxuxdj86NP+7uOwCha+SfSY
        IgfqKiiukNDUFtFLTXkgJYQ=
X-Google-Smtp-Source: APXvYqzQYT+W6XCbUawf7R1JSNBQ+6MKFwmNzKeWZ41jpyb77P5GUPE3Qx4ZKz13C1trK05wq5bseA==
X-Received: by 2002:a0d:c905:: with SMTP id l5mr8579692ywd.44.1580053927628;
        Sun, 26 Jan 2020 07:52:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17sm5364260ywg.66.2020.01.26.07.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 07:52:07 -0800 (PST)
Date:   Sun, 26 Jan 2020 07:52:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Message-ID: <20200126155205.GA19169@roeck-us.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212093205.GU2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 10:32:05AM +0100, Peter Zijlstra wrote:
> As described in the comment, the correct order for freeing pages is:
> 
>  1) unhook page
>  2) TLB invalidate page
>  3) free page
> 
> This order equally applies to page directories.
> 
> Currently there are two correct options:
> 
>  - use tlb_remove_page(), when all page directores are full pages and
>    there are no futher contraints placed by things like software
>    walkers (HAVE_FAST_GUP).
> 
>  - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
>    architecture does not do IPI based TLB invalidate and has
>    HAVE_FAST_GUP (or software TLB fill).
> 
> This however leaves architectures that don't have page based
> directories but don't need RCU in a bind. For those, provide
> MMU_GATHER_TABLE_FREE, which provides the independent batching for
> directories without the additional RCU freeing.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Various sparc64 builds (allnoconfig, tinyconfig, as well as builds
with SMP disabled):

mm/mmu_gather.c: In function '__tlb_remove_table_free':
mm/mmu_gather.c:101:3: error: implicit declaration of function '__tlb_remove_table'; did you mean 'tlb_remove_table'?

Guenter
