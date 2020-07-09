Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0934E21A25A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGIOnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 10:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOnx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 10:43:53 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58752073A;
        Thu,  9 Jul 2020 14:43:50 +0000 (UTC)
Date:   Thu, 9 Jul 2020 15:43:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org, nd@arm.com
Subject: Re: [PATCH v6 26/26] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200709144347.GA7758@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-27-catalin.marinas@arm.com>
 <20200709093253.GI32219@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709093253.GI32219@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 10:32:54AM +0100, Szabolcs Nagy wrote:
> The 07/03/2020 16:37, Catalin Marinas wrote:
> > +    /*
> > +     * To be compiled with -march=armv8.5-a+memtag
> > +     */
> > +    #include <errno.h>
> > +    #include <stdio.h>
> > +    #include <stdlib.h>
> > +    #include <unistd.h>
> > +    #include <sys/auxv.h>
> > +    #include <sys/mman.h>
> > +    #include <sys/prctl.h>
> 
> the example should now include stdint.h

Thanks. I should write user-space stuff more often ;)

-- 
Catalin
