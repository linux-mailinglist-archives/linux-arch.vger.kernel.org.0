Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19EC1B3FE9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 12:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgDVKlq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 06:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbgDVKlp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 06:41:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DB920656;
        Wed, 22 Apr 2020 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587552104;
        bh=RaH8GmcCaHjF24H4jq5aU+IOTvZCTVKwCvJaJZS2Pvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEiD4PFlGQoID5iAv2BZy14zXuBWGKiqGD5MAuQwu5nFF6X3qjHwUAOz0Nvwtl0Vh
         GQsSF8v8sH3AOBfat8LL2JQk0Y1UqLD6sPIUlO0x/WFoCX+8VHyZarb+pjEj4rEx5n
         2ti1AHupvnAf7NH1ZQb64NDOzzAIgqeIWbtLvoM8=
Date:   Wed, 22 Apr 2020 11:41:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200422104138.GA30265@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
 <20200422094951.GA54428@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422094951.GA54428@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 10:49:52AM +0100, Mark Rutland wrote:
> On Tue, Apr 21, 2020 at 04:15:31PM +0100, Will Deacon wrote:
> > do_csum() over-reads the source buffer and therefore abuses
> > READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> > READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> > '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> > and fall back to normal loads.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> From a functional perspective:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks.

> I know that Robin had a concern w.r.t. how this would affect the
> codegen, but I think we can follow that up after the series as a whole
> is merged.

Makes sense. I did look at the codegen, fwiw, and it didn't seem especially
bad. One of the LDP's gets cracked in the unlikely() path, but it didn't
look like it would be a disaster (and sprinkling barrier() around to force
the LDP felt really fragile!).

Will
