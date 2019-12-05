Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C911498B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfLEW4M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Dec 2019 17:56:12 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42348 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEW4M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 17:56:12 -0500
Received: by mail-pj1-f67.google.com with SMTP id o11so1876677pjp.9;
        Thu, 05 Dec 2019 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IDeK7oOW0B9CNYnGbhlUWhfaYDqmeePr7B16rf7vuug=;
        b=TcJxvXpsivxWne6OpmZopXg+nQiC+1jQ/foJ47anY56k0POIuLQce7VaiLsrSG+Rdq
         yiKg63sLTxBwMA2qld4SudrloQ8suHPXRFYdyYhCP6fL1h948ENgH/kMwxUJ7onxe3eD
         TcOsmz0CywRwGQCzD1y/ybQ7TPUQcxtQ9eyvgGu8EyAKqpn80rP+5xlsBe5+pWXowMsg
         MHQS4RzIXQu15CB4NOjusttvAW38VyS3y5uJbevX0UvFXRmfP46FZj6JocHsPQzA3tAo
         lGAHWYrodz1yA0XU8UNcwBLMzNZUUjNcgFRcjhyIzJ7gMjXTng8XW24Ecp3T+jOtUcnG
         IvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IDeK7oOW0B9CNYnGbhlUWhfaYDqmeePr7B16rf7vuug=;
        b=diyfIMvXR5Oqn8Da42y2jwdBHYOu+oO9wJyiroD+jIi8twJN0l8Q5nLL1v5za1Jfvv
         zLnzfn4QD3ySmqV6zNEMsr2uN6CF8KiFwHfsQeUs03oEuTZnSuvRAZAp73J3ZdxS3Mz4
         ByKvXV2E4pDCBxKkYeT1fHlsJPpU2Jil+rfqHixswfdyDxdlyPnCNcWG7nJBzjdIril5
         ZRXJdZ6zSvUNTyLwdw+ZFAWvnKo4AyDbUdxYWJ3ffAwl6QzP9gdvEhYVnuzvQCQ4S5zw
         kxTwylTRuEFqbp4DJQNyQlJNJPxLKX7kM2xt8S9bdI59byLypLMsJsQjutHWjVFmPMJL
         0Ldw==
X-Gm-Message-State: APjAAAU43IzGKM8Q7vFpD+lwBr6o06TQRC1nVUBGQ6fUzJ7BVjnuNsWO
        pfzIz2DKgyPgzE094EQJas0=
X-Google-Smtp-Source: APXvYqxHzb65lDkdIjAVkQB89RP4XhIHPS1Szd01E5+eADPQbmpWTvCZzqaJVF3j5vmxirtTRjda4w==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr12140247pjn.60.1575586571954;
        Thu, 05 Dec 2019 14:56:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm3746371pgc.3.2019.12.05.14.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2019 14:56:11 -0800 (PST)
Date:   Thu, 5 Dec 2019 14:56:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191205225610.GB2532@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 05, 2019 at 08:30:17PM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 12/4/19 11:47 AM, Peter Zijlstra wrote:
> >> I got remote access to an SH7722-based Migo-R again, which spews a long
> >> sequence of BUGs during userspace startup.  I've bisected this to commit
> >> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> > 
> > Whoopsy.. also, is this really the first time anybody booted an SH
> > kernel in over a year ?!?
> 
> I have to admit, I have been very lazy with kernel updates. I have been
> planning to upgrade to a much more recent release on my boards for a while
> now, I have just been postponing it since the machines run very stable
> with the current kernel I am using.
> 

Hey, if you write a qemu emulation, I'll be happy to run it on a regular
basis :-)

Problem is really that the architecture doesn't get as much attention as
it needs. The backtrace pointed to by Rob has been seen for a long time,
but either there is no one with the knowledge to fix it, or they are all
busy with other stuff.

Guenter

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
