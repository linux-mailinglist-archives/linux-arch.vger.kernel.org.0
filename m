Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3711355E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 20:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLDTDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 14:03:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfLDTDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 14:03:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id q16so99089plr.10;
        Wed, 04 Dec 2019 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+2HrNLTVWalIHUdX8QP/0YhRSnO47+yfuy7Xa7RxbV8=;
        b=YRWQO5g4rLkC0MblwqJ+tUEXDF2+/MiYU+xHjLTAS03SfnEYtgh/M/DTb3eYvIoMZB
         JDR0KdSxhfC0/W2Db0d9wuz8uTQGbe65wHS0QZbtAD9+L3ih542dTM3oD+6o/W6aWWv0
         2hqDJ8xVqp3Jc1hvFyz6MU8HmgZnJ1SmLVOzeKVg7lJi/qzW+953JWN8vQBVkkiPu7lw
         sWaHIkuuWaLRl8PKGoxCY5RFipxX5KQp6Z4p+zL+GhYHahssE99KMrEf/SQCDoM/+qYT
         D/3SjMcFeLXmL9GQvObKurlXju9QNEl4dZrU9QYQwhWXqoQtofODXRTIlPRPKAkMkN0m
         Zqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+2HrNLTVWalIHUdX8QP/0YhRSnO47+yfuy7Xa7RxbV8=;
        b=XbeVAt4IUgIDssmcbZ8pncKd+dKHV3LsdhLn9rBVHQt6C+FNelKem1MepIrrSXg5F9
         Jk3kmvtHxdqI51Zxbg4O66v2byhMlx2WEZo5miVwgaaubsXWSu5zZy7HMx1th93GxBWS
         RW1xtzLQauo+q+utfjgjw5MmJBhvQCaxLsTvOCu91kw2JG7ZncwZ3T7GW/afl89VbHqf
         aM5bt8cOAf94lCJ/izv+inekbsLkmAoy9it5hY0TJYhbi2ZN8cNUWo/WSYhk3hDXCU3P
         p8lXahwlrQa8qZVAr+E0uyu4GLsMA0J39QuI9/4R7rlI4kGLW3bHBITDZceXDmLo4cUj
         pkmg==
X-Gm-Message-State: APjAAAVArcNDFcpg9Ifi3W3ZWqTwVq5o1f9gaYwbQZJ5ipUXlYgLKsA3
        7MUbIMjXT0BRd7New/qCzR2NAsx2
X-Google-Smtp-Source: APXvYqz6lJM0e4EEbZp8mRchegTfRf+2Kjkl5gI2q0pdvDqiaIXymUCQ7kv2L298qRyBZbdnKrQ7Cg==
X-Received: by 2002:a17:902:d902:: with SMTP id c2mr4592247plz.188.1575486224402;
        Wed, 04 Dec 2019 11:03:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm8487714pgh.54.2019.12.04.11.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 11:03:43 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:03:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20191204190341.GA11419@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <156fa92f-4c5a-08bd-bcda-20029724c0de@roeck-us.net>
 <CAMuHMdVKcTum5vMmT1TdttVnGnhnQihGU1jrguF26TW7ZeOJPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVKcTum5vMmT1TdttVnGnhnQihGU1jrguF26TW7ZeOJPg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 04, 2019 at 04:17:26PM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> > > Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
> > > CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.
> > >
> >
> > Guess that explains why I do not see the problem with my qemu boots.
> > I use rts7751r2dplus_defconfig. Is it possible to reproduce the problem
> > with qemu ? I don't think so, but maybe I am missing something.
> 
> Qemu seems to support r2d and shix only.
> For the latter, the website pointed to by the qemu sources no longer exists.
> But according to those sources, it's also sh7750-based, so no luck.
> 
Oh, well, worth asking. Thanks for the feedback.

Guenter
