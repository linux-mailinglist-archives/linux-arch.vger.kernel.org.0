Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1E34EF79
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhC3R1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 13:27:45 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:12754 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhC3R1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 13:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1640; q=dns/txt; s=iport;
  t=1617125240; x=1618334840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DLlq6Eg2HUUvE9Fdg0Ebob6Tw5pX5R4uRXQoNV4sDwc=;
  b=S3AM+TL3QruYfqeMp+6vgY8hAlMuc26v6MTPbQoBaVTtuaYcQUDMTLtv
   YMIx4slyUxrVeNQY1bYf3KcYQpt5MAzNiBdGmrhqo2w3IxuaehFXbZdkp
   RLSQAvV0NrNp3mH+o+VcmM/VXEAvjt8lzHELqAzH8H/BMLD98MoPApiLd
   w=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AoTmckqE8NgKcaaN3pLqEVceALOonbusQ8z?=
 =?us-ascii?q?AX/mp6ICY7TuWzkceykPMHkTL1ki8WQnE8mdaGUZPwJE/035hz/IUXIPOeTB?=
 =?us-ascii?q?Dr0VHYTr1KwIP+z1TbcRHW2fVa0c5bHpRWKNq1NlRiiNa/3Q/QKadF/PCi0I?=
 =?us-ascii?q?SFwdjT1G1sSwYCUdAC0y5cBhyAGkN7AClqbKBZKLOm6sBKpyWtdB0sB6zROl?=
 =?us-ascii?q?A/U+fOvNHNnp79CCRnOzcc9AKMgTm0gYSVLzGk2H4lPw9n8PMF7XXPlRD/6+?=
 =?us-ascii?q?GFtfy2oyWssVP73tBxhMbrzMdFCYi3rvUtbh/oigquee1aKtq/gAw=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BhAABKXmNg/4UNJK1aHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTwHAQELAYIqgUwBOTGMZYkukAgWikWBfAsBAQENAQE0BAE?=
 =?us-ascii?q?BhFACgXoCJTQJDgIDAQEMAQEFAQEBAgEGBHGFboZFAQU6PxALGC48GwYThXi?=
 =?us-ascii?q?rInWBNIkLgUQigRcBjUkmHIFJQoESgm4uPoo2BIJHgQ6CMCyeTZwigxGBI5s?=
 =?us-ascii?q?2MRCkQrgSAgQGBQIWgVQ6gVkzGggbFYMkUBkNnQchAy84AgYKAQEDCYkfAQE?=
X-IronPort-AV: E=Sophos;i="5.81,291,1610409600"; 
   d="scan'208";a="880406225"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Mar 2021 17:27:19 +0000
Received: from zorba ([10.24.8.123])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 12UHREPN013894
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Mar 2021 17:27:16 GMT
Date:   Tue, 30 Mar 2021 10:27:14 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     will@kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Message-ID: <20210330172714.GR109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
X-Outbound-SMTP-Client: 10.24.8.123, [10.24.8.123]
X-Outbound-Node: alln-core-11.cisco.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Addressed comments from Will
> - Added capability to have src == dst
> ---
>  include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 include/linux/cmdline.h
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..dea87edd41be
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +#include <linux/string.h>
> +
> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> +#ifndef cmdline_strlcat
> +#define cmdline_strlcat strlcat
> +#endif
> +
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dst: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one.
> + * @len: the length of dest buffer.
> + */

Append or prepend ? Cisco requires both at the same time. This is why my
implementation provides both. I can't use this with both at once.

Daniel
