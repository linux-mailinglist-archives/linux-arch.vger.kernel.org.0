Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4808113745A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAJRGm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 12:06:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56710 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgAJRGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 12:06:42 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00AH5xC3031814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 12:06:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E7ED4207DF; Fri, 10 Jan 2020 12:05:59 -0500 (EST)
Date:   Fri, 10 Jan 2020 12:05:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200110170559.GA304349@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155153.GG19453@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 04:51:53PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 02:54:12PM +0000, Mark Brown wrote:
> > This is a resend of a series from Richard Henderson last posted back in
> > November:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/
> > 
> > Back then Borislav said they looked good and asked if he should take
> > them through the tip tree but things seem to have got lost since then.
> 
> Or, alternatively, akpm could take them. In any case, if someone else
> ends up doing that, for the x86 bits:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Or I can take them through the random.git tree, since we have a lot of
changes this cycle going to Linus anyway.  Any objections?

	     	   	    	  	   - Ted
