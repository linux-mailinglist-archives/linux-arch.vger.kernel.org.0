Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D6359155
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 03:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhDIBYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 21:24:12 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:29249 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 21:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1925; q=dns/txt; s=iport;
  t=1617931440; x=1619141040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkzLqPqjAxF6Ch0t2FT084suyCe7GM/KMpezthHSR4s=;
  b=Gap38DrgAFYo7ZYtYj3EvA00VRAvBXaTMJHcOvwkNJVDT4HPXjse3J2D
   Wam4qRi03A5ot7Rf2AqNJn295G4c85LGxBe56kFeO3V2wvq1mgqITfilJ
   drIjp9AFnBn0GO22oASshvs+nTKSZIL5IUvC5aRimTMSDO6kDRejFhvAH
   w=;
X-IPAS-Result: =?us-ascii?q?A0ABAAAUrG9gmIENJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+BQEBAQELAYN3ATmNF4k1kA2KXIF8CwEBAQ0BATQEAQGEU?=
 =?us-ascii?q?AKBdwIlNAkOAgMBAQEDAgMBAQEBAQUBAQECAQYEFAEBAQEBAQEBaIVdhkUBA?=
 =?us-ascii?q?gM6OgUQCxIGLjwNDgaDBIMIqjx1gTSBAYgUgUQigRcBjUwnHIFJQoETgyI+i?=
 =?us-ascii?q?jkEgkeCNaAbikiRYYMVgSabRzIQpGEtszuEVgIEBgUCFoFUOIFbMxoIGxWDJ?=
 =?us-ascii?q?U8ZDo44jlAhA2cCBgoBAQMJjDRdAQE?=
IronPort-HdrOrdr: A9a23:QdBVtK4Vqwy1Ov3XkQPXwHXXdLJzesId70hD6mlaQ3VuHfCwvc
 aogfgdyFvYiCwJXmshhNCHP8C7MBbh3LRy5pQcOqrnYRn+tAKTXeNfxKbr3jGIIUfD38FH06
 MIScVDIf32SWN3lMPrpDS/euxQpOWv1ICNqaPgw2x2TQdsApsQjDtRLgqACEV5SE1nKPMCda
 a03cZMqzq+dXl/VK3SbUUtZOTNq8bGk5jre3c9ZyIP0hWEjj+j9dfBfSSw4xF2aV9y6IZn13
 TZmArk4ajmlPe3xnbnpgnuxqUTvsf9wd1eA8HJsOwpE3HHjwalY5kJYczkgAwI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,208,1613433600"; 
   d="scan'208";a="717254170"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Apr 2021 01:23:53 +0000
Received: from zorba ([10.24.9.242])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 1391Nnm8027721
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Apr 2021 01:23:51 GMT
Date:   Thu, 8 Apr 2021 18:23:49 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, will@kernel.org,
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
Subject: Re: [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
Message-ID: <20210409012349.GG3981976@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
 <20210406173836.GW2469518@zorba>
 <20210408190408.GA1724284@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408190408.GA1724284@robh.at.kernel.org>
X-Outbound-SMTP-Client: 10.24.9.242, [10.24.9.242]
X-Outbound-Node: alln-core-9.cisco.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 08, 2021 at 02:04:08PM -0500, Rob Herring wrote:
> On Tue, Apr 06, 2021 at 10:38:36AM -0700, Daniel Walker wrote:
> > On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> > > -config CMDLINE_BOOL
> > > -	bool "Built-in kernel command line"
> > > -	help
> > > -	  For most systems, it is firmware or second stage bootloader that
> > > -	  by default specifies the kernel command line options.  However,
> > > -	  it might be necessary or advantageous to either override the
> > > -	  default kernel command line or add a few extra options to it.
> > > -	  For such cases, this option allows you to hardcode your own
> > > -	  command line options directly into the kernel.  For that, you
> > > -	  should choose 'Y' here, and fill in the extra boot arguments
> > > -	  in CONFIG_CMDLINE.
> > > -
> > > -	  The built-in options will be concatenated to the default command
> > > -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> > > -	  command line will be ignored and replaced by the built-in string.
> > > -
> > > -	  Most MIPS systems will normally expect 'N' here and rely upon
> > > -	  the command line from the firmware or the second-stage bootloader.
> > > -
> > 
> > 
> > See how you complained that I have CMDLINE_BOOL in my changed, and you think it
> > shouldn't exist.
> > 
> > Yet here mips has it, and you just deleted it with no feature parity in your
> > changes for this.
> 
> AFAICT, CMDLINE_BOOL equates to a non-empty or empty CONFIG_CMDLINE. You 
> seem to need it just because you have CMDLINE_PREPEND and 
> CMDLINE_APPEND. If that's not it, what feature is missing? CMDLINE_BOOL 
> is not a feature, but an implementation detail.

Not true.

It makes it easier to turn it all off inside the Kconfig , so it's for usability
and multiple architecture have it even with just CMDLINE as I was commenting
here.

Daniel
