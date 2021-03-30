Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67AF34F0F8
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhC3SX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 14:23:59 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:38405 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhC3SXp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 14:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2604; q=dns/txt; s=iport;
  t=1617128625; x=1618338225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMStwoujyvRVt+OuzbkoYXvA32+qhvWOh/uecqwPFaM=;
  b=HOKvwhRGp1THDDrVjcq0hqrsPhQf9jhzOj6t2M25Zty6l28YVrQm/gpt
   yEjqgSvQ1fHwc6HMYoJ8rWqfIz1F4I/3xbaSxUEGMuMTZViAfhyEPNDEs
   sX/53oxhy3KC+CbX1f4inK0aPjnmsHsBhVaQsNHEjsybZUlVbG6IzTgc6
   U=;
X-IPAS-Result: =?us-ascii?q?A0ADAAC0a2NgmJldJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BQEBAQELAYN2ATkxjGWJLpAIFopFgXwLAQEBDQEBNAQBA?=
 =?us-ascii?q?YRQAoF6AiU0CQ4CAwEBAQMCAwEBAQEBBQEBAQIBBgQUAQEBAQEBAQGGQ4ZFA?=
 =?us-ascii?q?QIDOj8QCxguPBsGE4JwgwirOXWBNIkLgUQigRcBjUkmHIFJQoESgm4uPoo2B?=
 =?us-ascii?q?IJHgQ6CMCyUAYpMmw6BFIMRgSObNjEQpEK4EgIEBgUCFoFUOIFbMxoIGxWDJ?=
 =?us-ascii?q?FAZDY44jk8hAy84AgYKAQEDCYZaLIIZAQE?=
IronPort-HdrOrdr: A9a23:OGIYBqgWvJdablCjWRAu+Iu5lnBQXmcji2hD6mlwRA09T+Wzna
 mV88gz/xnylToXRTUMmcqYPrOBXHPb8vdOkOwsFJ2lWxTrv3btEZF64eLZsl/dMgD36+I178
 1dWodkDtmYNzVHpOb8pDK1CtMxhOSAmZrY4dv261dIYUVUZ7p77wF/YzzrcXFeYAVdH5I2GN
 69y6N8xgaIQngcYsSlCnRtZYGqzOHjr57obQULABQq8mC17Q+A0qLwEBSTw34lPQ9n/LFKyw
 T4uj28wLm/uPemzRKZ8Gnf4/1t6b3c4+oGItCQgc4ILTipsCKUXcBKXr2Puy1dmpDJ1GoX
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,291,1610409600"; 
   d="scan'208";a="689174954"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Mar 2021 18:23:43 +0000
Received: from zorba ([10.24.8.123])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 12UINdP0017615
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Mar 2021 18:23:41 GMT
Date:   Tue, 30 Mar 2021 11:23:39 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, will@kernel.org,
        Rob Herring <robh@kernel.org>,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        linux-mips <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Message-ID: <20210330182339.GU109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
 <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
X-Outbound-SMTP-Client: 10.24.8.123, [10.24.8.123]
X-Outbound-Node: rcdn-core-2.cisco.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 08:07:30PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 30.03.2021 um 19:27 schrieb Daniel Walker <danielwa@cisco.com>:
> > 
> > On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> >> This code provides architectures with a way to build command line
> >> based on what is built in the kernel and what is handed over by the
> >> bootloader, based on selected compile-time options.
> >> 
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >> v3:
> >> - Addressed comments from Will
> >> - Added capability to have src == dst
> >> ---
> >> include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 57 insertions(+)
> >> create mode 100644 include/linux/cmdline.h
> >> 
> >> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> >> new file mode 100644
> >> index 000000000000..dea87edd41be
> >> --- /dev/null
> >> +++ b/include/linux/cmdline.h
> >> @@ -0,0 +1,57 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_CMDLINE_H
> >> +#define _LINUX_CMDLINE_H
> >> +
> >> +#include <linux/string.h>
> >> +
> >> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> >> +#ifndef cmdline_strlcat
> >> +#define cmdline_strlcat strlcat
> >> +#endif
> >> +
> >> +/*
> >> + * This function will append or prepend a builtin command line to the command
> >> + * line provided by the bootloader. Kconfig options can be used to alter
> >> + * the behavior of this builtin command line.
> >> + * @dst: The destination of the final appended/prepended string.
> >> + * @src: The starting string or NULL if there isn't one.
> >> + * @len: the length of dest buffer.
> >> + */
> > 
> > Append or prepend ? Cisco requires both at the same time. This is why my
> > implementation provides both. I can't use this with both at once.
> 
> Just an idea: what about defining CMDLINE as a pattern where e.g. "$$" or "%%"
> is replaced by the boot loader command line?
> 
> Then you can formulate replace, prepend, append, prepend+append with a single
> CONFIG setting.
> 
> It may be a little more complex in code (scanning for the pattern and replacing
> it and take care to temporary memory) but IMHO it could be worth to consider.

In some cases this code could be used extremely early in boot up. For example in the
prom_init.c powerpc code, or in efi changes. The flexibility to find and replace
like that is not always an option due to the nature of the environment. It's not
impossible of course.

Daniel
