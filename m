Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB7358D30
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhDHTEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 15:04:24 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44555 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhDHTEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 15:04:23 -0400
Received: by mail-oi1-f171.google.com with SMTP id a8so3252017oic.11;
        Thu, 08 Apr 2021 12:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DUrGxOBRGKnSQEqHR05dYQldYxqAXJweo2+bFsG+WpA=;
        b=X56XCd+UzmF2lh1xts3CLdO7hFz8v7Vy+NegtIsYO2MAsmhIMSnZ0J/AaBxxRdap++
         0aSoQkTg3F70U/hY+/1DLD06fqvuYnOzG0yC2JOCDInKeWFeU1O2GaGpZXva5ihVImmo
         w79fe5bVC5ExbteJ2R+JapSNHeY2+j8hPwq1PhN8Zn0nlev66Z9exVRdroPFfqdQ/xOb
         +Lm2PWjkngRiwLJjeWrUcU7Lm7SVVw1yZ7Jbkfg9INQnyqth6qMyTbNgmBVbn+7ustYN
         MSJg2WFQiSC/jt6dv7tYqcuFwsyaXbdC8niofYhCWy+tGh849p7qXwA/dsokXpaGksUz
         jedQ==
X-Gm-Message-State: AOAM531ZBsTOdcM73WxLRaevEggHNKsXQt7kngpFIjKN2cyRhMdniiqf
        HrU8D6bhFZ6nS1rIX1BCBA==
X-Google-Smtp-Source: ABdhPJzc/ezUgVYn/c2gVo9JEsyTGvBA4ZkkApktnBVPpB6CFT0oT9dS88OzEW8tCbInDt8Gjv+2IA==
X-Received: by 2002:a05:6808:138a:: with SMTP id c10mr7276133oiw.117.1617908650345;
        Thu, 08 Apr 2021 12:04:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g9sm56746otk.6.2021.04.08.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:04:09 -0700 (PDT)
Received: (nullmailer pid 1795497 invoked by uid 1000);
        Thu, 08 Apr 2021 19:04:08 -0000
Date:   Thu, 8 Apr 2021 14:04:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
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
Message-ID: <20210408190408.GA1724284@robh.at.kernel.org>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
 <20210406173836.GW2469518@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406173836.GW2469518@zorba>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 10:38:36AM -0700, Daniel Walker wrote:
> On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> > -config CMDLINE_BOOL
> > -	bool "Built-in kernel command line"
> > -	help
> > -	  For most systems, it is firmware or second stage bootloader that
> > -	  by default specifies the kernel command line options.  However,
> > -	  it might be necessary or advantageous to either override the
> > -	  default kernel command line or add a few extra options to it.
> > -	  For such cases, this option allows you to hardcode your own
> > -	  command line options directly into the kernel.  For that, you
> > -	  should choose 'Y' here, and fill in the extra boot arguments
> > -	  in CONFIG_CMDLINE.
> > -
> > -	  The built-in options will be concatenated to the default command
> > -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> > -	  command line will be ignored and replaced by the built-in string.
> > -
> > -	  Most MIPS systems will normally expect 'N' here and rely upon
> > -	  the command line from the firmware or the second-stage bootloader.
> > -
> 
> 
> See how you complained that I have CMDLINE_BOOL in my changed, and you think it
> shouldn't exist.
> 
> Yet here mips has it, and you just deleted it with no feature parity in your
> changes for this.

AFAICT, CMDLINE_BOOL equates to a non-empty or empty CONFIG_CMDLINE. You 
seem to need it just because you have CMDLINE_PREPEND and 
CMDLINE_APPEND. If that's not it, what feature is missing? CMDLINE_BOOL 
is not a feature, but an implementation detail.

Rob
