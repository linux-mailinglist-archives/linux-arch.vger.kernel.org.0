Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851D53559B9
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhDFQ4Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:56:24 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:48647 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDFQ4X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2543; q=dns/txt; s=iport;
  t=1617728176; x=1618937776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cZx99TFaCLts0bYspySXDfTAZA7sX1ryp1fo4EAJaBw=;
  b=R4llpUe0760jIGN8ajhuGiyQ7AjZYDFP/5B615OEasNtvWFmppzuIAW3
   VrXjn6ragzVpRW3qx6K7svEY9uYFl6mkjVVBmPY7xNyWJyQ+e3/gxLyR4
   wdkyvt9igNCdF816s3S5UUiZ40gU303G8bibEWdCEFcS/weFez4fK01RN
   g=;
X-IPAS-Result: =?us-ascii?q?A0AWAgAIkmxgmIMNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VKDeAE5lkYDkAwWilqBaAsBAQENAQE0BAEBhFACgXYCJTgTAgMBAQEDAgMBA?=
 =?us-ascii?q?QEBAQUBAQECAQYEFAEBAQEBAQEBaIVdhkUBBTo/EAsSBhUZPA0OBoMEgwirV?=
 =?us-ascii?q?HWBNIEBiB+BRCKBF41NJxyBSUKENT6DeYEGhTgEggRCAS0Qg3GQQo1gnCmDF?=
 =?us-ascii?q?YEmm0cyEKRhLbgRAgQGBQIWgWshgVszGggbFYMlTxkOjjiOUCEDZwIGCgEBA?=
 =?us-ascii?q?wmNRAEB?=
IronPort-HdrOrdr: A9a23:az4voqCHQftEAsTlHekR55DYdL4zR+YMi2QD/UoZc3NoW+afkN
 2jm+le+B/vkTAKWGwhn9foAtjkfVr385lp7Y4NeYqzRQWOghrLEKhO5ZbvqgeLJwTQ7ehYvJ
 0MT4FfD5nKAUF+nYLG5mCDYrId6f2m1IztuuvE1XdqSmhRGsJdxiN0EBySHEEzZCQuP/sEPa
 GR7MZGuDasEE5/Bq+GL0IIUOTZq9rAmIiOW347LiQ64wqDhy7A0tDHOiWfty1zbxp/hZE/7G
 PCjwv1ooKkvv3T8G6760bjq7JLhdDm1txPQPapt/FQADDthgG0Db4RPIG/gA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,201,1613433600"; 
   d="scan'208";a="693085054"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2021 16:56:13 +0000
Received: from zorba ([10.24.14.212])
        by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 136GuAm7015894
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Apr 2021 16:56:12 GMT
Date:   Tue, 6 Apr 2021 09:56:10 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     will@kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
        akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 00/20] Implement GENERIC_CMDLINE
Message-ID: <20210406165610.GV2469518@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
X-Outbound-SMTP-Client: 10.24.14.212, [10.24.14.212]
X-Outbound-Node: alln-core-1.cisco.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 02, 2021 at 03:18:01PM +0000, Christophe Leroy wrote:
> The purpose of this series is to improve and enhance the
> handling of kernel boot arguments.
> 
> Current situation is that most if not all architectures are using
> similar options to do some manupulation on command line arguments:
> - Prepend built-in arguments in front of bootloader provided arguments
> - Append built-in arguments after bootloader provided arguments
> - Replace bootloader provided arguments by built-in arguments
> - Use built-in arguments when none is provided by bootloader.
> 
> On some architectures, all the options are possible. On other ones,
> only a subset are available.
> 
> The purpose of this series is to refactor and enhance the
> handling of kernel boot arguments so that every architecture can
> benefit from all possibilities.
> 
> It is first focussed on powerpc but also extends the capability
> for other arches.
> 
> The work has been focussed on minimising the churn in architectures
> by keeping the most commonly used namings.
> 
> Main changes in V4:
> - Included patch from Daniel to replace powerpc's strcpy() by strlcpy()
> - Using strlcpy() instead of zeroing first char + strlcat() (idea taken frm Daniel's series)
> - Reworked the convertion of EFI which was wrong in V3
> - Added "too long" command line handling
> - Changed cmdline macro into a function
> - Done a few fixes in arch (NIOS2, SH, ARM)
> - Taken comments into account (see individual responses for details)
> - Tested on powerpc, build tested on ARM64, X86_64.
> 

Why submit your changes ? My changes have been around for almost 10 years, and
are more widely used. Your changes are very new and unstable, but don't really
solve the needs of people using my series.

I've tried to work with you and I take comments from you, but yet you insist to
submit your own series.

I would suggest this isn't going to go anyplace unless we work together.

I can't really support your changes because, honestly, your changes are really
ugly and they just look more and more like my changes with every passing
iteration .. As the maturity of your changes continue they will just become my
change set.

I've been thru every iteration of these changes, and I see those attempts in
your changes. Everything different in your changes I've tried, and found not to
be useful, then it falls away in later iterations.

When you give me comments on something which I haven't tried I typically
incorporate it.

Daniel
